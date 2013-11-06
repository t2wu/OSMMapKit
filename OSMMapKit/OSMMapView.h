//
//  OSMMapView.h
//  OSMMapKit
//
//  Created by Timothy Wu on 2013/11/2.
//  Copyright (c) 2013年 Timothy Wu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>
#import "OSMMapView.h"

@class MBTilesDB;

@interface OSMMapView : MKMapView

@property (nonatomic, strong) MBTilesDB *mbTilesDB; //< MBTilsDB, nil if not set.

@property (nonatomic, assign) NSUInteger maxZoom; //< Maximum zoom default from MBTiles unless overridden. If data not from MBTiles, default not set.
@property (nonatomic, assign) NSUInteger minZoom; //< Minimum zoom default from MBTIles unless overridden.  If data not from MBTiles, default not set.

@property (nonatomic, assign, readonly) MKCoordinateRegion constraintRegion; //< map region if constraints set (or default to region of tiles from from MBTiles if MBTiles is provided.)

@property (nonatomic, assign) BOOL scaleNonRetinaTilesOnRetinaDisplay;

/* To use MBTIles */
- (id)initWithMBTilesDB:(MBTilesDB *)mbTilesDB;
- (id)initWithFrame:(CGRect)frame andMBTiles:(MBTilesDB *)mbTilesDB;

/* Don't use MBTiles, such as opting to use MKTileOverlay to show tiles */
- (id)init;
- (id)initWithFrame:(CGRect)frame;

#pragma mark - Constraint map
- (void)setConstraintsSouthWest:(CLLocationCoordinate2D)southWest
                      northEast:(CLLocationCoordinate2D)northEast;
- (void)setConstraintRegion:(MKCoordinateRegion)constraintRegion;
@end
