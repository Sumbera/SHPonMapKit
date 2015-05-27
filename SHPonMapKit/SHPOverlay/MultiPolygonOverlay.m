//
//  MultiPolygon.m
//  SHPonMapKit
//
//  Created by Stanislav Sumbera on 27/05/15.
//  code taken from http://stackoverflow.com/questions/17673410/mkmapview-with-multiple-overlays-memory-issue


#import "MultiPolygonOverlay.h"
#import "shpPolygons.h"

@implementation MultiPolygonOverlay

@synthesize polygons = _polygons;

//------------------------------------------------------
- (id)initWithLocalShpFile:(NSString *)filePath{
   if (self = [super init]) {
   
       _polygons = getPolygonsFromShapeFile(filePath);
       NSUInteger polyCount = [_polygons count];
       if (polyCount) {
           _boundingMapRect = [[_polygons objectAtIndex:0] boundingMapRect];
           NSUInteger i;
           for (i = 1; i < polyCount; i++) {
               _boundingMapRect = MKMapRectUnion(_boundingMapRect, [[_polygons objectAtIndex:i] boundingMapRect]);
           }
       }
       
       
    }
    return self;
 
}
//------------------------------------------------------
- (id)initWithPolygons:(NSArray *)polygons {
    if (self = [super init]) {
        _polygons = [polygons copy];
        
        NSUInteger polyCount = [_polygons count];
        if (polyCount) {
            _boundingMapRect = [[_polygons objectAtIndex:0] boundingMapRect];
            NSUInteger i;
            for (i = 1; i < polyCount; i++) {
                _boundingMapRect = MKMapRectUnion(_boundingMapRect, [[_polygons objectAtIndex:i] boundingMapRect]);
            }
        }
    }
    return self;
}
//-----------------------------------------------------------
- (MKMapRect)boundingMapRect
{
    return _boundingMapRect;
}

- (CLLocationCoordinate2D)coordinate
{
    return MKCoordinateForMapPoint(MKMapPointMake(MKMapRectGetMidX(_boundingMapRect), MKMapRectGetMidY(_boundingMapRect)));
}

@end