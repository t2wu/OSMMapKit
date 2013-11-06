//
//  MKMapView+ZoomLevel.h
//  OSMMapKit
//
//  Created by Timothy Wu on 2013/11/4.
//  Copyright (c) 2013年 Timothy Wu. All rights reserved.
//

#import <MapKit/MapKit.h>

@interface MKMapView (ZoomLevel)


- (void)setCenterCoordinate:(CLLocationCoordinate2D)centerCoordinate
                  zoomLevel:(NSUInteger)zoomLevel
                   animated:(BOOL)animated;

- (NSInteger)zoomLevel; //< Current zoom level of the map

@end
