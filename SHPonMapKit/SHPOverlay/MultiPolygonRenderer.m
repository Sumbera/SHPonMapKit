//
//  MultiPolygonView.m
//  SHPonMapKit
//
//  Created by Stanislav Sumbera on 27/05/15.
//  code taken from http://stackoverflow.com/questions/17673410/mkmapview-with-multiple-overlays-memory-issue


#import "MultiPolygonOverlay.h"
#import "MultiPolygonRenderer.h"

@implementation MultiPolygonRenderer

//-----------------------------------------------------
- (CGPathRef)polyPath:(MKPolygon *)polygon

{
    MKMapPoint *points = [polygon points];
    NSUInteger pointCount = [polygon pointCount];
    NSUInteger i;
    
    if (pointCount < 3)
        return NULL;
    
    CGMutablePathRef path = CGPathCreateMutable();
    
    for (MKPolygon *interiorPolygon in polygon.interiorPolygons) {
        CGPathRef interiorPath = [self polyPath:interiorPolygon];
        CGPathAddPath(path, NULL, interiorPath);
        CGPathRelease(interiorPath);
    }
    
    CGPoint relativePoint = [self pointForMapPoint:points[0]];
    CGPathMoveToPoint(path, NULL, relativePoint.x, relativePoint.y);
    for (i = 1; i < pointCount; i++) {
        relativePoint = [self pointForMapPoint:points[i]];
        CGPathAddLineToPoint(path, NULL, relativePoint.x, relativePoint.y);
    }
    
    return path;
}


//--------------------------------------------------------------------------
- (void)drawMapRect:(MKMapRect)mapRect
          zoomScale:(MKZoomScale)zoomScale
          inContext:(CGContextRef)context
{
    MultiPolygonOverlay *multiPolygon = (MultiPolygonOverlay *)self.overlay;
    for (MKPolygon *polygon in multiPolygon.polygons) {
        MKMapRect boundRect = [polygon boundingMapRect];
        
        if ( MKMapRectIntersectsRect (boundRect, mapRect )){
            CGPathRef path = [self polyPath:polygon];
            if (path) {
                [self applyFillPropertiesToContext:context atZoomScale:zoomScale];
                CGContextBeginPath(context);
                CGContextAddPath(context, path);
                CGContextDrawPath(context, kCGPathEOFill);
                [self applyStrokePropertiesToContext:context atZoomScale:zoomScale];
                CGContextBeginPath(context);
                CGContextAddPath(context, path);
                CGContextStrokePath(context);
                CGPathRelease(path);
            }
        }
    }
}

@end
