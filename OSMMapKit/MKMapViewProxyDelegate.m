//
//  MKMapViewProxyDelegate.m
//  OSMMapKit
//
//  Created by Timothy Wu on 2013/11/2.
//  Copyright (c) 2013年 Timothy Wu. All rights reserved.
//

#import "MKMapViewProxyDelegate.h"
#import "OSMMapView.h"
#import "mkgeometry_additions.h"
#import "math.h"
#import "MBTilesOverlay.h"

@interface MKMapViewProxyDelegate()

@property (nonatomic, assign) BOOL manuallyChangingMapRect;
@property (nonatomic, assign) MKMapRect lastGoodMapRect;

@end

@implementation MKMapViewProxyDelegate

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
    return [NSString stringWithFormat:@"<MKMapViewProxyDelegate: %p, realDelegate: %p>", self, self.realDelegate];
}

- (id)initWithRealDelegate:(id<MKMapViewDelegate>) realDelegate
{
    // Could be nil, in which case we still want to control map region change
    self.realDelegate = realDelegate;
    return self;
}


- (NSMethodSignature *)methodSignatureForSelector:(SEL)selector
{
    NSMethodSignature *methodSignature;
    if ((methodSignature = [[self class] methodSignatureForSelector:selector])) {
        return methodSignature;
    }
    
    if ((methodSignature = [[self.realDelegate class] methodSignatureForSelector:selector])) {
        return methodSignature;
    }
 
    // Junk we're going to ignore. If we return nil it's a runtime error
    // on selector not found
    return [NSMethodSignature signatureWithObjCTypes:"@^v^c"];
}

- (void)forwardInvocation:(NSInvocation *)invocation
{
    // This has the added benefit of never having to check if delegate
    // responds to selector because we check it here
    if (invocation.selector == @selector(respondsToSelector:))
    {
        [invocation invokeWithTarget:self];
    } else if ([self.realDelegate respondsToSelector:invocation.selector]) {
        [invocation invokeWithTarget:self.realDelegate];
    }
    // That junk signature is just going to be ignored here
}

- (BOOL)respondsToSelector:(SEL)aSelector
{
    if (aSelector == @selector(mapView:regionDidChangeAnimated:) ||
        aSelector == @selector(mapView:rendererForOverlay:)) {
        return YES;
    }
    return NO;
}


#pragma mark - MKMapViewDelegate
//http://stackoverflow.com/questions/4119117/restrict-mkmapview-scrolling (better)
- (void)mapView:(OSMMapView *)mapView regionDidChangeAnimated:(BOOL)animated
{
    NSParameterAssert([mapView isKindOfClass:[OSMMapView class]] || mapView == nil); // is nil in unit-test
    
    if (self.constraintMap) {    
        // prevents possible infinite recursion when we call setVisibleMapRect below
        if (self.manuallyChangingMapRect) {
            return;
        }
        
        MKMapRect boundingMapRect = MKMapRectForCoordinateRegion(mapView.constraintRegion);
        
        BOOL mapContainsOverlay = MKMapRectContainsRect(mapView.visibleMapRect, boundingMapRect);
        
        if (mapContainsOverlay) {
            // The overlay is entirely inside the map view but adjust if user is zoomed out too much...
//            double widthRatio = boundingMapRect.size.width / mapView.visibleMapRect.size.width;
//            double heightRatio = boundingMapRect.size.height / mapView.visibleMapRect.size.height;
            // adjust ratios as needed
            if (mapView.zoomLevel <= mapView.minZoom - 1) {
//            if ((widthRatio < 0.6) || (heightRatio < 0.6)) {
                self.manuallyChangingMapRect = YES;
                [mapView setRegion:mapView.constraintRegion animated:YES];
                //[mapView setVisibleMapRect:boundingMapRect animated:NO];
//                CLLocationCoordinate2D currentCenter = mapView.region.center;
//                [mapView setCenterCoordinate:currentCenter zoomLevel:mapView.minZoom-1 animated:YES];
                self.manuallyChangingMapRect = NO;
            }
        } else if (!MKMapRectContainsRect(boundingMapRect, mapView.visibleMapRect)) {
            // Some part of uncovered region is shown.
            // Reset to last "good" map rect...
            self.manuallyChangingMapRect = YES;
            [mapView setVisibleMapRect:self.lastGoodMapRect animated:YES];
            self.manuallyChangingMapRect = NO;
        } else if (mapView.zoomLevel > mapView.maxZoom + 1) {
            // Zoom in too much, re-adjust to maximum zoom + 1 (which still shows)
            self.manuallyChangingMapRect = YES;
            CLLocationCoordinate2D currentCenter = mapView.region.center;
            [mapView setCenterCoordinate:currentCenter zoomLevel:mapView.maxZoom+1 animated:YES];
            self.manuallyChangingMapRect = NO;
        } else {
            self.lastGoodMapRect = mapView.visibleMapRect;
        }
    } else {
        self.lastGoodMapRect = mapView.visibleMapRect;
    }
    
    if ([self.realDelegate respondsToSelector:@selector(mapView:regionDidChangeAnimated:)]) {
        [self.realDelegate mapView:mapView regionDidChangeAnimated:animated];
    }
}


- (MKOverlayRenderer *)mapView:(MKMapView *)mapView rendererForOverlay:(id<MKOverlay>)overlay
{
    if ([overlay isKindOfClass:[MBTilesOverlay class]]) {
        MKTileOverlayRenderer *renderer = [[MKTileOverlayRenderer alloc] initWithOverlay:overlay];
        return renderer;
    }
    if ([self.realDelegate respondsToSelector:@selector(mapView:rendererForOverlay:)]) {
        return [self.realDelegate mapView:mapView rendererForOverlay:overlay];
    }
    return nil;
}

#pragma mark - Others

@end
