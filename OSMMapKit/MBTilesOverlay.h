//
//  MBTilesOverlay.h
//  MBTilesRun
//
//  Created by Timothy Wu on 2013/8/17.
//
//

#import <Foundation/Foundation.h>
#import <MapKit/MapKit.h>
#import "MBTilesDB.h"

extern NSString * const MBTilesOverlayError;
enum {
    MBTilesOverlayErrorTileDoesNotExist
};

extern NSString * const MBTiles_No_Data;

@interface MBTilesOverlay : MKTileOverlay<MKOverlay>

- (id)initWithMBTilesDB:(MBTilesDB *)mbTilesDB;


@end
