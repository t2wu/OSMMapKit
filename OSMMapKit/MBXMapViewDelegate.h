//
//  MBXMapViewDelegate.h
//  OSMMapKit
//
//  Created by Timothy Wu on 2013/11/5.
//  Copyright (c) 2013年 Timothy Wu. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MBXMapViewDelegate : NSProxy <MKMapViewDelegate>

@property (nonatomic, weak) id <MKMapViewDelegate>realDelegate;
+ (id)new;

@end