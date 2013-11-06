//
//  RegionBboxConverter.h
//  OSMMapKit
//
//  Created by Timothy Wu on 2013/11/4.
//  Copyright (c) 2013年 Timothy Wu. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MapKit/MapKit.h>


typedef struct {
    CLLocationDegrees minLongitude;
    CLLocationDegrees minLatitude;
    CLLocationDegrees maxLongitude;
    CLLocationDegrees maxLatitude;
} OSMBoundingBox;

NS_INLINE OSMBoundingBox OSMBoundingBoxMake(CLLocationDegrees minLongitude, CLLocationDegrees minLatitude, CLLocationDegrees maxLongitude, CLLocationDegrees maxLatitude)
{
	OSMBoundingBox bbox;
    bbox.minLongitude = minLongitude;
    bbox.minLatitude = minLatitude;
    bbox.maxLongitude = maxLongitude;
    bbox.maxLatitude = maxLatitude;
	return bbox;
}

@interface RegionBBoxConverter : NSObject

+ (MKCoordinateRegion)regionFromBBox:(OSMBoundingBox)bbox;

@end
