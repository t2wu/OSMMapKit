//
//  MKMapViewProxyDelegateTests.m
//  OSMMapKit
//
//  Created by Timothy Wu on 2013/11/2.
//  Copyright (c) 2013年 Timothy Wu. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "MKMapViewProxyDelegate.h"
#import "MockRealDelegateWithRegionDidChange.h"
#import "MockRealDelegateWithoutRegionDidChange.h"

@interface MKMapViewProxyDelegateTests : XCTestCase

@end

@implementation MKMapViewProxyDelegateTests {
    MKMapViewProxyDelegate *proxyDelegate;
    MockRealDelegateWithRegionDidChange *mockRealDelegate;
}

- (void)setUp
{
    [super setUp];
    
    
    // Put setup code here; it will be run once, before the first test case.
    mockRealDelegate = [[MockRealDelegateWithRegionDidChange alloc] init];
    proxyDelegate = [[MKMapViewProxyDelegate alloc] initWithRealDelegate: mockRealDelegate];
}

- (void)tearDown
{
    // Put teardown code here; it will be run once, after the last test case.
    [super tearDown];
}

- (void)testAllowInitWithNilRealDelegate
{
    XCTAssertNoThrow([[MKMapViewProxyDelegate alloc] initWithRealDelegate: nil],
                    @"Allow nil delegate when no delegate is given");
}

- (void)testProxyShouldDefineRegionDidChangeEvenWhenProxyIsNotDefind
{
    MockRealDelegateWithoutRegionDidChange * realDelegate = [[MockRealDelegateWithoutRegionDidChange alloc] init];
    proxyDelegate = [[MKMapViewProxyDelegate alloc] initWithRealDelegate: realDelegate];
    BOOL response = [proxyDelegate respondsToSelector:@selector(mapView:regionDidChangeAnimated:)];
    XCTAssertEqual(response, YES, @"proxyDelegate should have regionDidChange by itself");
}

- (void)testShouldFowardToMethodInRealDelegate
{
    [proxyDelegate mapView:nil regionDidChangeAnimated:YES];
    XCTAssertEqual(mockRealDelegate.regionDidChangeCalled, YES,
                   @"Should forward to real delegate when proxy method does exist");
}

- (void)testShouldFowardToMethodInRealDelegateWhenProxyDoesNotHaveIt
{
    [proxyDelegate mapView:nil regionWillChangeAnimated:YES];
    XCTAssertEqual(mockRealDelegate.regionWillChangeCalled, YES,
                   @"Should foward to real delegate when proxy method does not exist");
}



@end
