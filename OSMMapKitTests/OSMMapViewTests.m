//
//  OSMMapViewTests.m
//  OSMMapKit
//
//  Created by Timothy Wu on 2013/11/2.
//  Copyright (c) 2013年 Timothy Wu. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "OSMMapView.h"
#import "MKMapView+ZoomLevel.h"
#import "MBTilesDB.h"

@interface OSMMapViewTests : XCTestCase

@end

@implementation OSMMapViewTests {
    OSMMapView *mapView;
    MBTilesDB *tilesDB;
}

- (void)setUp
{
    [super setUp];
    // Put setup code here; it will be run once, before the first test case.
//    mapView = [[OSMMapView alloc] initWithFrame:[UIScreen mainScreen].bounds];
    
    NSBundle *bundle = [NSBundle bundleForClass:[self class]];
    NSURL *tilesURL = [bundle URLForResource:@"tricity_13_15" withExtension:@"mbtiles"];
    tilesDB = [[MBTilesDB alloc] initWithDBURL:tilesURL];
    mapView = [[OSMMapView alloc] initWithFrame:[UIScreen mainScreen].bounds
                                      andMBTiles:tilesDB];
}

- (void)tearDown
{
    // Put teardown code here; it will be run once, after the last test case.
    [super tearDown];
}

- (void)testsMapViewZoomLevelWhatsSetIsGet
{
    [mapView setCenterCoordinate:CLLocationCoordinate2DMake(37.545305, -121.989910)
                       zoomLevel:15
                        animated:NO];
    // TODO: Need to set twice in our code because the first time it triggers mbtiles layout
    // subivews and it's going to set it to mbtiles' region, fix?
    XCTAssertEqual(mapView.zoomLevel, 15, @"Should get what's set in zoom level. But it seems that this test can't set it quite right. When added to real view it seems to work.");
}

@end
