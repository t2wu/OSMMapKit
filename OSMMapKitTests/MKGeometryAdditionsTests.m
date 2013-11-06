//
//  MKGeometryAdditionsTests.m
//  OSMMapKit
//
//  Created by Timothy Wu on 2013/11/4.
//  Copyright (c) 2013年 Timothy Wu. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "mkgeometry_additions.h"

@interface MKGeometryAdditionsTests : XCTestCase

@end

@implementation MKGeometryAdditionsTests

- (void)setUp
{
    [super setUp];
    // Put setup code here; it will be run once, before the first test case.
}

- (void)tearDown
{
    // Put teardown code here; it will be run once, after the last test case.
    [super tearDown];
}

- (void)testMKMapRectForCoordinateRegionAfterReverseConversion
{
    CLLocationCoordinate2D fremont = CLLocationCoordinate2DMake(37.54827, -121.98857);
    MKCoordinateRegion region = MKCoordinateRegionMake(fremont, MKCoordinateSpanMake(0.05, 0.05));
    MKMapRect mapRect = MKMapRectForCoordinateRegion(region);
    MKCoordinateRegion derivedRegion = MKCoordinateRegionForMapRect(mapRect);
    
    double accuracy = 0.0001;
    
    XCTAssertEqualWithAccuracy(region.center.latitude, derivedRegion.center.latitude,
                               accuracy, @"Latitude is equal");
    XCTAssertEqualWithAccuracy(region.center.longitude, derivedRegion.center.longitude,
                               accuracy, @"Longitude is equal");
    XCTAssertEqualWithAccuracy(region.span.latitudeDelta, derivedRegion.span.latitudeDelta,
                               accuracy, @"Latitude delta is equal");
    XCTAssertEqualWithAccuracy(region.span.longitudeDelta, derivedRegion.span.longitudeDelta,
                               accuracy, @"Longitude delta is equal");
}

- (void)testMKCoordinateRegionForSouthWestAndNorthEast
{
    CLLocationCoordinate2D taipeiWanHua = CLLocationCoordinate2DMake(25.02946, 121.49652);
    CLLocationCoordinate2D taipeiSongShan = CLLocationCoordinate2DMake(25.06640, 121.56166);

    MKCoordinateRegion region = MKCoordinateRegionForSouthWestAndNorthEast(taipeiWanHua, taipeiSongShan);
    CLLocationCoordinate2D center = region.center;
    MKCoordinateSpan span = region.span;
    double accuracy = 0.0001;
    
    XCTAssertEqualWithAccuracy(center.latitude,
                               taipeiWanHua.latitude + (taipeiSongShan.latitude - taipeiWanHua.latitude) * 0.5,
                               accuracy,
                               @"MKCoordinateRegionForSouthWestAndNorthEast fails when midpoint is not mid point");
    
    XCTAssertEqualWithAccuracy(center.longitude,
                               taipeiWanHua.longitude + (taipeiSongShan.longitude - taipeiWanHua.longitude) * 0.5,
                               accuracy,
                               @"MKCoordinateRegionForSouthWestAndNorthEast fails when midpoint is not mid point");
    
    XCTAssertEqualWithAccuracy(span.latitudeDelta,
                               taipeiSongShan.latitude - taipeiWanHua.latitude, accuracy,
                               @"Latitude delta is not correct");
    
    XCTAssertEqualWithAccuracy(span.longitudeDelta,
                               taipeiSongShan.longitude - taipeiWanHua.longitude, accuracy,
                               @"Latitude delta is not correct");
}

@end
