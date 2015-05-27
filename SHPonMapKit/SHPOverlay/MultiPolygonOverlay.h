//
//  MultiPolygon.h
//  SHPonMapKit
//
//  Created by Stanislav Sumbera on 27/05/15.
//
//

#import <MapKit/MapKit.h> //Add import MapKit

@interface MultiPolygonOverlay : NSObject <MKOverlay> {
    NSArray *_polygons;
    MKMapRect _boundingMapRect;
}

- (id)initWithPolygons:(NSArray *)polygons;

- (id)initWithLocalShpFile:(NSString *)filePath;


@property (nonatomic, readonly) NSArray *polygons;

@end
