//
//  OSMMapView.m
//  OSMMapKit
//
//  Created by Timothy Wu on 2013/11/2.
//  Copyright (c) 2013年 Timothy Wu. All rights reserved.
//

#import "OSMMapView.h"
#import "MKMapViewProxyDelegate.h"
#import "MBTilesOverlay.h"
#import "mkgeometry_additions.h"
#import "MBTilesDB.h"

@interface OSMMapView()

@property (nonatomic, strong) MKMapViewProxyDelegate *proxyDelegate;
@property (nonatomic, weak) id<MKMapViewDelegate> realDelegate;
@property (nonatomic, strong) MBTilesOverlay *tilesOverlay;

@property (nonatomic, assign) BOOL hasManualConstraintRegion;
@property (nonatomic, assign) MKCoordinateRegion manualRegion;

@property (nonatomic, assign) BOOL isStartingMapWithMBTiles;

@property (nonatomic, strong) NSMutableArray *overlays;

@end

@implementation OSMMapView


- (id)initWithMBTilesDB:(MBTilesDB *)mbTilesDB
{
    NSParameterAssert(mbTilesDB);
    if (self = [super init]) {
        
        [self setupWithMBTiles:mbTilesDB];
    }
    return self;
}

- (id)initWithFrame:(CGRect)frame andMBTiles:(MBTilesDB *)mbTilesDB
{
    if (self = [super initWithFrame:frame]) {
        [self setupWithMBTiles:mbTilesDB];
    }
    return self;
}

- (id)init
{
    self = [super init];
    if (self) {
        [self setupWithoutMBTiles];
    }
    return self;
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setupWithoutMBTiles];
    }
    return self;
}

- (void)setupWithMBTiles:(MBTilesDB *)mbTilesDB
{
    _mbTilesDB = mbTilesDB;
    
    // zoom level
    self.maxZoom = self.mbTilesDB.maxZoom;
    self.minZoom = self.mbTilesDB.minZoom;
    self.isStartingMapWithMBTiles = YES;
    
    [self setupOverlay];
    [self setupProxyDelegate];
}

- (void)setupWithoutMBTiles
{
    [self setupProxyDelegate];
    // force to store the last good location
    [self.proxyDelegate mapView:self regionDidChangeAnimated:NO];
}

- (void)setupOverlay
{
    self.tilesOverlay = [[MBTilesOverlay alloc] initWithMBTilesDB:self.mbTilesDB];
    self.tilesOverlay.geometryFlipped = YES;
    self.tilesOverlay.canReplaceMapContent = YES;
    [super addOverlay:self.tilesOverlay]; // calling super to bypass overlay store
}

- (void)setUpMapViewPort
{
    // Make it zoom out and center
    [self setCenterCoordinate:self.mbTilesDB.center
                    zoomLevel:self.mbTilesDB.minZoom
                     animated:NO];
//    [self setRegion:self.mbTilesDB.region animated:NO];
}

- (void)setupProxyDelegate
{
    self.realDelegate = nil;
    self.proxyDelegate = [MKMapViewProxyDelegate new];
    if (self.mbTilesDB) {
        self.proxyDelegate.constraintMap = YES;
    }
    [super setDelegate:self.proxyDelegate];
}

#pragma mark - Tricky delegate issue (NSProxy)

- (void)setDelegate:(id<MKMapViewDelegate>)delegate
{
    [super setDelegate:nil];
    if (!self.proxyDelegate) {
        self.proxyDelegate = [[MKMapViewProxyDelegate alloc] initWithRealDelegate:nil];
    }
    self.proxyDelegate.realDelegate = delegate;
    [super setDelegate:self.proxyDelegate];

    [self addOverLayAfterRealDelegateIsAdded];

}

- (void)addOverLayAfterRealDelegateIsAdded
{
    // If overlay is added before delegate is added, the forwarding
    // mechanism return nil for the overlay. (Since proxydelegate exist but
    // the real delegate isn't, and therefore no overlayrenderer is reported
    // and map kit has no chance to reload when the overlay is added.
    
    for (id<MKOverlay> overlay in self.overlays) {
        [super addOverlay:overlay];
    }
    self.overlays = [NSMutableArray new];
}

- (void)addOverlay:(id<MKOverlay>)overlay
{
    if (!self.proxyDelegate.realDelegate) {
        // If nil as of yet, don't add now, add when the real delegate is set
        [self.overlays addObject:overlay];
    } else {
        [super addOverlay:overlay];
    }
}

- (void)setScaleNonRetinaTilesOnRetinaDisplay:(BOOL)scaleNonRetinaTilesOnRetinaDisplay
{
    BOOL previously = _scaleNonRetinaTilesOnRetinaDisplay;
    _scaleNonRetinaTilesOnRetinaDisplay = scaleNonRetinaTilesOnRetinaDisplay;
    if (previously == NO && _scaleNonRetinaTilesOnRetinaDisplay) {
        // This has the side effect of enlarging the word "Legal"
        self.transform = CGAffineTransformScale(self.transform, 2, 2);
    } else if (previously == YES && !_scaleNonRetinaTilesOnRetinaDisplay){
        self.transform = CGAffineTransformScale(self.transform, 0.5, 0.5);
    }
}

#pragma mark - layout

- (void)layoutSubviews
{
    [super layoutSubviews];
    if (self.isStartingMapWithMBTiles) {
        self.isStartingMapWithMBTiles = NO;
        [self setUpMapViewPort];
    }
}

#pragma mark - Accessories
- (MKCoordinateRegion)constraintRegion
{
    if (self.hasManualConstraintRegion) {
        return self.manualRegion;
    }
    return self.mbTilesDB.region;
}

- (void)setMbTilesDB:(MBTilesDB *)mbTilesDB
{
    _mbTilesDB = mbTilesDB;
    [self setupWithMBTiles:_mbTilesDB];
}

- (NSMutableArray *)overlays
{
    if (!_overlays) {
        _overlays = [NSMutableArray new];
    }
    return _overlays;
}

#pragma mark - Interface

- (void)setConstraintsSouthWest:(CLLocationCoordinate2D)southWest
                      northEast:(CLLocationCoordinate2D)northEast
{
    MKCoordinateRegion region = MKCoordinateRegionForSouthWestAndNorthEast(southWest, northEast);
    [self setConstraintRegion:region];
}

- (void)setConstraintRegion:(MKCoordinateRegion)constraintRegion
{
    self.hasManualConstraintRegion = YES;
    self.manualRegion = constraintRegion;
    self.proxyDelegate.constraintMap = YES; // Tell the proxy to watch for region change and scorll back
}

@end
