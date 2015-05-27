//
//  shpPolygons.h
//  Mapkit_ShapeFile
//
//  Created by Stanislav Sumbera on 27/05/15.
//
#import <Foundation/Foundation.h>
#import "shapefil.h"
#import <MapKit/MapKit.h>



//------------------------------------------------------------
NS_INLINE NSArray *getPolygonsFromShapeFile(NSString *shpFilePath){
   
    const char *path = [shpFilePath cStringUsingEncoding:NSUTF8StringEncoding];
    SHPHandle shp = SHPOpen(path, "rb");
    int numEntities;
    int shapeType;
    
    SHPGetInfo(shp, &numEntities, &shapeType, NULL, NULL);
    
    NSMutableArray *allPolygons = [[NSMutableArray alloc]init];
    for (int i=0; i<numEntities; i++){
       SHPObject *shpObject = SHPReadObject(shp, i);
       if (shpObject->nSHPType == SHPT_POLYGON ||
           shpObject->nSHPType == SHPT_POLYGONZ ||
           shpObject->nSHPType == SHPT_POLYGONM){

        
            int numParts = shpObject->nParts;
            int totalVertexCount = shpObject->nVertices;

            for (int n=0; n<numParts; n++)
            {
                int startVertex = shpObject->panPartStart[n];
                int partVertexCount = (n == numParts - 1) ? totalVertexCount - startVertex : shpObject->panPartStart[n+1] - startVertex;
                int endIndex = startVertex + partVertexCount;
                
                CLLocationCoordinate2D coords[partVertexCount];
                for (int pv = startVertex, i = 0; pv < endIndex; pv++,i++) {
                    coords[i] =CLLocationCoordinate2DMake(shpObject->padfY[pv],
                                                          shpObject->padfX[pv]);
                }
                MKPolygon *singlePolygon = [MKPolygon polygonWithCoordinates:coords count:partVertexCount];
                [allPolygons addObject:singlePolygon];
            }
       }
       
     SHPDestroyObject(shpObject);
       
  }
    SHPClose(shp);
    
    return [allPolygons copy];
}

    



