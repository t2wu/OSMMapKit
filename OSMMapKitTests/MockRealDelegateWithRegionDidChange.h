//
//  MockMKMapViewDelegate.h
//  OSMMapKit
//
//  Created by Timothy Wu on 2013/11/2.
//  Copyright (c) 2013年 Timothy Wu. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MockRealDelegateWithRegionDidChange : NSObject<MKMapViewDelegate>

@property (nonatomic, assign) BOOL regionDidChangeCalled;
@property (nonatomic, assign) BOOL regionWillChangeCalled;


@end
