//
//  MBXMapViewDelegate.m
//  OSMMapKit
//
//  Created by Timothy Wu on 2013/11/5.
//  Copyright (c) 2013年 Timothy Wu. All rights reserved.
//

#import "MBXMapViewDelegate.h"

@implementation MBXMapViewDelegate

+ (id)new
{
    return [[self alloc] init];
}

- (id)init
{
    return self;
}

- (NSString *)description
{
    return [NSString stringWithFormat:@"<MBXMapViewDelegate: %p, realDelegate: %p>", self, self.realDelegate];
}

- (NSMethodSignature *)methodSignatureForSelector:(SEL)selector
{
    if (selector == @selector(mapView:rendererForOverlay:))
        return [[MBXMapViewDelegate class] methodSignatureForSelector:selector];
    
    if ([self.realDelegate respondsToSelector:selector])
        return [(NSObject *)self.realDelegate methodSignatureForSelector:selector];
    
    return [[NSObject class] methodSignatureForSelector:selector];
}

- (void)forwardInvocation:(NSInvocation *)invocation
{
    if (invocation.selector == @selector(respondsToSelector:))
    {
        [invocation invokeWithTarget:self];
    }
    else if ([self.realDelegate respondsToSelector:invocation.selector])
    {
        [invocation invokeWithTarget:self.realDelegate];
    }
}

- (BOOL)respondsToSelector:(SEL)selector
{
    if (selector == @selector(mapView:rendererForOverlay:))
        return YES;
    
    return ([self.realDelegate respondsToSelector:selector]);
}

- (MKOverlayRenderer *)mapView:(MKMapView *)mapView rendererForOverlay:(id <MKOverlay>)overlay
{
//    if ([self.realDelegate respondsToSelector:@selector(mapView:rendererForOverlay:)])
//    {
//        // If user-set delegate wants to provide a tile renderer, let it.
//        //
//        if ([overlay isKindOfClass:[MBXMapViewTileOverlay class]])
//        {
//            // If it fails at providing a renderer for our managed overlay, step in.
//            //
//            MKOverlayRenderer *renderer = [self.realDelegate mapView:mapView rendererForOverlay:overlay];
//            
//            return (renderer ? renderer : [[MKTileOverlayRenderer alloc] initWithTileOverlay:overlay]);
//        }
//        else
//        {
//            // Let it provide a renderer for all user-set overlays.
//            //
//            return [self.realDelegate mapView:mapView rendererForOverlay:overlay];
//        }
//    }
//    else if ([overlay isKindOfClass:[MBXMapViewTileOverlay class]])
//    {
//        // Step in if the user-set delegate doens't try to provide a renderer.
//        //
//        return [[MKTileOverlayRenderer alloc] initWithTileOverlay:overlay];
//    }
//    
//    // We're not in the general renderer-providing business.
//    //
    return nil;
}

@end
