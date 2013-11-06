//
//  MBTilesDB.m
//  OSMMapKit
//
//  Created by Timothy Wu on 2013/11/4.
//  Copyright (c) 2013年 Timothy Wu. All rights reserved.
//

#import "MBTilesDB.h"
#import "FMDatabase.h"
#import "FMDatabaseAdditions.h"
#import "RegionBBoxConverter.h"
#import "CocoaCategory.h"

@interface MBTilesDB()

@property (nonatomic, strong, readwrite) FMDatabase *db;

@end

@implementation MBTilesDB

- (id)initWithDBURL:(NSURL *)dbURL
{
    NSParameterAssert(dbURL);
    self = [super init];
    if (self) {
        self.db = [FMDatabase databaseWithPath:dbURL.path];
        if (![self.db open]) {
            [[NSException
              exceptionWithName:@"FileNotFoundException"
              reason:@"MBTiles file Not Found"
              userInfo:nil] raise];
        }
    }
    return self;
}

- (id)init
{
    self = [super init];
    [[NSException
      exceptionWithName:@"InitShouldNotBeUsed"
      reason:@"Should not be created without MBTiles URL"
      userInfo:nil] raise];
    return self;
}

- (id)initWithURLTemplate:(NSString *)URLTemplate
{
    self = [super init];
    [[NSException
      exceptionWithName:@"InitWithURLTemplateShouldNotBeUsed"
      reason:@"Should not be created without MBTiles URL"
      userInfo:nil] raise];
    return self;
}


#pragma mark - Accessors for the database metadata

- (NSString *)name
{
    return [self metaDataValueForKey:@"name"];
}

- (NSString *)databaseVersion
{
    return [self metaDataValueForKey:@"version"];
}

- (MKCoordinateRegion)region
{
    // bbox = min Longitude , min Latitude , max Longitude , max Latitude
    NSString *bbox = [self metaDataValueForKey:@"bounds"];
    return [self regionForBBoxInString:bbox];
}

- (CLLocationCoordinate2D)center
{
    return [self region].center;
}

- (NSUInteger)minZoom
{
    return (NSUInteger)[[self metaDataValueForKey:@"minzoom"] integerValue];
}

- (NSUInteger)maxZoom
{
    return (NSUInteger)[[self metaDataValueForKey:@"maxzoom"] integerValue];
}

#pragma mark - Interface
- (NSData *)tileForZoomLevel:(short)zoom tileColumn:(NSInteger)x tileRow:(NSInteger) y
{
    FMResultSet *results = [self.db executeQuery:@"select tile_data from tiles where zoom_level = ? and tile_column = ? and tile_row = ?",
                            [NSNumber numberWithShort:zoom],
                            [NSNumber numberWithInteger:x],
                            [NSNumber numberWithInteger:y]];
    
    return [results next] ? [results dataForColumn:@"tile_data"] : nil;
}


#pragma mark - Others
- (NSString *)metaDataValueForKey:(NSString *)key
{
    return [self.db stringForQuery:@"select value from metadata where name = ?", key];
}

- (MKCoordinateRegion)regionForBBoxInString:(NSString *)bboxInString
{
    NSMutableArray *arrayOfCoords = [bboxInString tokenizeByString:@","];
    OSMBoundingBox bbox =
        OSMBoundingBoxMake([arrayOfCoords[0] doubleValue],
                           [arrayOfCoords[1] doubleValue],
                           [arrayOfCoords[2] doubleValue],
                           [arrayOfCoords[3] doubleValue]);
    return [RegionBBoxConverter regionFromBBox:bbox];
}

@end
