# SHPonMapKit
Drawing shape file polygons on MapKit

Simple & strightforward  test of loading shape file and drawing it on MapKit using drawMapRect. 
no storyboard, no pods, plain project using shapelib 

- draws only polygons so far
- primitive optimization, no scale optimization

polygons from shapefile are read in  MultiPolygonOverlay : NSObject <MKOverlay>

        MultiPolygonOverlay *shpPolygonsOverlay =  [[MultiPolygonOverlay alloc]
                                                initWithLocalShpFile:[resourcePath stringByAppendingPathComponent:@"DOKMPARCELA_P"]];
    
drawing of MultiPolygonOverlay is on  MultiPolygonRenderer : MKOverlayPathRenderer  -drawMapRect




credits/inspiration:

- drawing : http://stackoverflow.com/questions/17673410/mkmapview-with-multiple-overlays-memory-issue
- parsing : http://www.al-tyus.com/blog/2013/10/14/mapkit-and-esri-shapefiles 
- shapelib: http://shapelib.maptools.org
- dala: http://www.geoportalpraha.cz


