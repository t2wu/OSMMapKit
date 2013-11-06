//
//  RegionBboxConverter.m
//  OSMMapKit
//
//  Created by Timothy Wu on 2013/11/4.
//  Copyright (c) 2013年 Timothy Wu. All rights reserved.
//

#import "RegionBBoxConverter.h"

@implementation RegionBBoxConverter

+ (MKCoordinateRegion)regionFromBBox:(OSMBoundingBox)bbox
{
    CLLocationDegrees latDelta = bbox.maxLatitude - bbox.minLatitude;
    CLLocationDegrees lonDelta = bbox.maxLongitude - bbox.minLongitude;
    CLLocationDegrees centerLat = bbox.minLatitude + latDelta / 2.0;
    CLLocationDegrees centerLon = bbox.minLongitude + lonDelta / 2.0;
    return MKCoordinateRegionMake(CLLocationCoordinate2DMake(centerLat, centerLon),
                                  MKCoordinateSpanMake(latDelta, lonDelta));
}

@end
