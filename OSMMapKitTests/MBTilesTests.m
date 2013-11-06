//
//  MBTilesTests.m
//  OSMMapKit
//
//  Created by Timothy Wu on 2013/11/4.
//  Copyright (c) 2013年 Timothy Wu. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "MBTilesDB.h"
#import "RegionBBoxConverter.h"

@interface MBTilesTests : XCTestCase

@end

@implementation MBTilesTests {
    MBTilesDB *mbTilesDB;
}

- (void)setUp
{
    [super setUp];
    // Put setup code here; it will be run once, before the first test case.
    
    NSBundle *bundle = [NSBundle bundleForClass:[self class]];
    NSURL *tilesURL = [bundle URLForResource:@"tricity_13_15" withExtension:@"mbtiles"];
    mbTilesDB = [[MBTilesDB alloc] initWithDBURL:tilesURL];
}

- (void)tearDown
{
    // Put teardown code here; it will be run once, after the last test case.
    [super tearDown];
}

- (void)testMBTilesGetsName
{
    XCTAssertEqualObjects(mbTilesDB.name, @"OSM Bright", @"MBTiles name should be OSM Bright");
}

- (void)testMBTilesMinZoom
{
    XCTAssertEqual(mbTilesDB.minZoom, (NSUInteger)13, @"Zooming far out it's 13");
}

- (void)testMBTilesMaxZoom
{
    XCTAssertEqual(mbTilesDB.maxZoom, (NSUInteger)15, @"Zooming way in it's 15");
}

- (void)testRegionEqualsToSpecifiedBBox
{
    OSMBoundingBox boundingBox = OSMBoundingBoxMake(-122.09724, 37.45452, -121.88258, 37.63609);
    MKCoordinateRegion region = mbTilesDB.region;
    
    CLLocationCoordinate2D center = region.center;
    NSLog(@"center: %f, %f", center.latitude, center.longitude);
    MKCoordinateSpan span = region.span;
    double accuracy = 0.0001;
    
    XCTAssertEqualWithAccuracy(center.latitude - span.latitudeDelta * 0.5, boundingBox.minLatitude, accuracy, @"Min latitude is not correct");
    XCTAssertEqualWithAccuracy(center.latitude + span.latitudeDelta * 0.5, boundingBox.maxLatitude, accuracy, @"Max latitude is not correct");
    
    XCTAssertEqualWithAccuracy(center.longitude - span.longitudeDelta * 0.5, boundingBox.minLongitude, accuracy, @"Min longitude is not correct");
    XCTAssertEqualWithAccuracy(center.longitude + span.longitudeDelta * 0.5, boundingBox.maxLongitude, accuracy, @"Max longitude is not correct");
    
}

@end
