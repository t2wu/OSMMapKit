//
//  MockMKMapViewDelegate.m
//  OSMMapKit
//
//  Created by Timothy Wu on 2013/11/2.
//  Copyright (c) 2013年 Timothy Wu. All rights reserved.
//

#import "MockRealDelegateWithRegionDidChange.h"

@implementation MockRealDelegateWithRegionDidChange

- (id)init
{
    self = [super init];
    if (self) {
        self.regionDidChangeCalled = NO; // Not necessary but explicit
        self.regionWillChangeCalled = NO;
    }
    return self;
}

- (void)mapView:(MKMapView *)mapView regionDidChangeAnimated:(BOOL)animated
{
    self.regionDidChangeCalled = YES;
}

- (void)mapView:(MKMapView *)mapView regionWillChangeAnimated:(BOOL)animated
{
    self.regionWillChangeCalled = YES;
}

@end
