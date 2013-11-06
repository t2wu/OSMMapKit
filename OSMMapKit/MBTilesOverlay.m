//
//  MBTilesOverlay.m
//  MBTilesRun
//
//  Created by Timothy Wu on 2013/8/17.
//
//

#import "MBTilesOverlay.h"
#import <Foundation/Foundation.h>
#import "mkgeometry_additions.h"

NSString * const MBTilesOverlayError = @"MBTilesOverlayError";

@interface MBTilesOverlay()

@property (nonatomic, strong) MBTilesDB *mbTilesDB;

// Store it first, otherwise there may be database issues (The FMDatabase <FMDatabase: 0x9d6e830> is currently in use.)
@property (nonatomic, assign) MKMapRect internalBoundingMapRect;
@property (nonatomic, assign) CLLocationCoordinate2D internalCenter;
@end

@implementation MBTilesOverlay

- (id)initWithMBTilesDB:(MBTilesDB *)mbTilesDB
{
    NSParameterAssert(mbTilesDB);
    self = [super init];
    if (self) {
        self.mbTilesDB = mbTilesDB;
        self.internalBoundingMapRect = MKMapRectForCoordinateRegion(self.mbTilesDB.region);
        self.internalCenter = self.mbTilesDB.center;
    }
    return self;
}

-(void)loadTileAtPath:(MKTileOverlayPath)path result:(void (^)(NSData *, NSError *))result
{
    NSData *tile = [self.mbTilesDB tileForZoomLevel:path.z
                                         tileColumn:path.x
                                            tileRow:path.y];
    if (tile) {
        result(tile, nil);
    } else {
        result(nil, [NSError errorWithDomain: MBTilesOverlayError
                                        code: MBTilesOverlayErrorTileDoesNotExist
                                    userInfo:nil]);
    }
}

// Somehow if Apple knows cover region is this small, it'll
// still calls the Apple map underneath dispite canReplaceMapContent is set to YES
//- (MKMapRect)boundingMapRect
//{
//    return self.internalBoundingMapRect;
//}

- (CLLocationCoordinate2D)coordinate
{
    return self.internalCenter;
}


@end
