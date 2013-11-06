//
//  MKMapView+ZoomLevel.m
//  OSMMapKit
//
//  Created by Timothy Wu on 2013/11/4.
//  Copyright (c) 2013年 Timothy Wu. All rights reserved.
//

#import "MKMapView+ZoomLevel.h"
#import "mkgeometry_additions.h"

#define MERCATOR_RADIUS 85445659.44705395

@implementation MKMapView (ZoomLevel)


#pragma mark - ZoomLevel

- (void)setCenterCoordinate:(CLLocationCoordinate2D)centerCoordinate
                  zoomLevel:(NSUInteger)zoomLevel
                   animated:(BOOL)animated
{
    NSAssert(self.frame.size.width != 0, @"Otherwise no tiles");
    float pixelPerTile = 256.0;
    float degreePerTile = 360.0 / pow(2, zoomLevel);
    float numTilesThisScreen = self.frame.size.width / pixelPerTile;
    MKCoordinateRegion region = MKCoordinateRegionMake(centerCoordinate, MKCoordinateSpanMake(0, degreePerTile * numTilesThisScreen));

    [self setRegion:region animated:animated];
}


// Walty's code
// http://troybrant.net/blog/2010/01/set-the-zoom-level-of-an-mkmapview/
- (NSInteger)zoomLevel
{
//    float pixelPerTile = 256.0;
//    float numTilesThisScreen = self.frame.size.width / pixelPerTile;
//    float spanPerTile = self.region.span.longitudeDelta / numTilesThisScreen;
//    int totalNumberOfTiles = (int)floor((360.0 / spanPerTile) + 0.5);
//    int z = (int)floor(log(totalNumberOfTiles)/log(2) + 0.5);
//    NSLog(@"z is? %d", z);
    return 21 - round(log2(self.region.span.longitudeDelta * MERCATOR_RADIUS * M_PI / (180.0*self.bounds.size.width)));
}

@end
