//
//  MKMapViewProxyDelegate.h
//  OSMMapKit
//
//  Created by Timothy Wu on 2013/11/2.
//  Copyright (c) 2013年 Timothy Wu. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface MKMapViewProxyDelegate : NSProxy<MKMapViewDelegate>

@property (nonatomic, weak) id<MKMapViewDelegate> realDelegate;

//< If YES, the map is constraint according to the OSMMapView's region.
@property (nonatomic, assign) BOOL constraintMap;

+ (id)new;
- (id)init;

- (id)initWithRealDelegate:(id<MKMapViewDelegate>)realDelegate;





@end
