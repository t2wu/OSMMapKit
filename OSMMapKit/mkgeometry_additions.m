//
//  Region2MapRectConverter.m
//  OSMMapKit
//
//  Created by Timothy Wu on 2013/11/4.
//  Copyright (c) 2013年 Timothy Wu. All rights reserved.
//

#import "mkgeometry_additions.h"

MKMapRect MKMapRectForCoordinateRegion(MKCoordinateRegion region)
{
    CLLocationCoordinate2D center = region.center;
    MKCoordinateSpan span = region.span;
    CLLocationCoordinate2D topLeft =
        CLLocationCoordinate2DMake(center.latitude + span.latitudeDelta / 2.0,
                                   center.longitude - span.longitudeDelta / 2.0);
    CLLocationCoordinate2D bottomRight =
    CLLocationCoordinate2DMake(center.latitude - span.latitudeDelta / 2.0,
                               center.longitude + span.longitudeDelta / 2.0);
    MKMapPoint mapPointTopLeft = MKMapPointForCoordinate(topLeft);
    MKMapPoint mapPointBottomRight = MKMapPointForCoordinate(bottomRight);
    double width = mapPointBottomRight.x - mapPointTopLeft.x;
    double height = mapPointBottomRight.y - mapPointTopLeft.y;
    
    return MKMapRectMake(mapPointTopLeft.x, mapPointTopLeft.y, width, height);
}

MKCoordinateRegion MKCoordinateRegionForSouthWestAndNorthEast(CLLocationCoordinate2D sw, CLLocationCoordinate2D ne)
{
    MKCoordinateSpan span =
        MKCoordinateSpanMake(ne.latitude - sw.latitude, ne.longitude - sw.longitude);
    CLLocationCoordinate2D center = CLLocationCoordinate2DMake(sw.latitude + span.latitudeDelta * 0.5, sw.longitude + span.longitudeDelta * 0.5);
    return MKCoordinateRegionMake(center, span);
}
