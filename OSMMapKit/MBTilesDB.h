//
//  MBTilesDB.h
//  OSMMapKit
//
//  Created by Timothy Wu on 2013/11/4.
//  Copyright (c) 2013年 Timothy Wu. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MapKit/MapKit.h>
@class FMDatabase;

/**
 * Interface to mbtiles database
 */
@interface MBTilesDB : NSObject

@property (nonatomic, strong, readonly) FMDatabase *db;

@property (nonatomic, strong, readonly) NSString *name; //< Name of the tiles (such as OSM Bright)
@property (nonatomic, strong, readonly) NSString *databaseVersion; //< MBtiles version (such as 1.0.0)

@property (nonatomic, assign, readonly) MKCoordinateRegion region; //< Region covered by the tiles
@property (nonatomic, assign, readonly) CLLocationCoordinate2D center; //< Center of the region covered by the tiles
@property (nonatomic, assign, readonly) NSUInteger minZoom; //< minimum zoom range allowed by the tiles available
@property (nonatomic, assign, readonly) NSUInteger maxZoom; //< maximum zoom range allowed by the tiles available



- (id)initWithDBURL:(NSURL *)dbURL;

/*
 * @param zoom The tile for the zoom level
 * @param x The column of the map at this zoom level
 * @param y The row of the map at this zoom level
 * @return A tile image in NSData specified by the given area, nil if no such tile exists in the database
 */
- (NSData *)tileForZoomLevel:(short)zoom
                  tileColumn:(NSInteger)x
                     tileRow:(NSInteger) y;



@end
