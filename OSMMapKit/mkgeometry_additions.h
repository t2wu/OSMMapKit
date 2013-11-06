//
//  Region2MapRectConverter.h
//  OSMMapKit
//
//  Created by Timothy Wu on 2013/11/4.
//  Copyright (c) 2013年 Timothy Wu. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MapKit/MapKit.h>

MKMapRect MKMapRectForCoordinateRegion(MKCoordinateRegion region);

MKCoordinateRegion MKCoordinateRegionForSouthWestAndNorthEast(CLLocationCoordinate2D sw, CLLocationCoordinate2D ne);



NS_INLINE NSString *MKStringFromCoordinateRegion(MKCoordinateRegion region) {
    return [NSString stringWithFormat:@"{center: %.3f, %.3f, span: %.3f, %.3f}",
     region.center.latitude, region.center.longitude, region.span.latitudeDelta, region.span.longitudeDelta];
}