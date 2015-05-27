//
//  MapViewController.m
//  MapView
//
//  Created by Stanislav Sumbera on 6/20/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "MapViewController.h"
#import "MultiPolygonOverlay.h"
#import "MultiPolygonRenderer.h"


@implementation MapViewController

//----------------------------------------------------------------------------
- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

//---------------------------------------------------
- (void)dealloc {
    self.mkMapView.delegate = nil;
    
    
}
//----------------------------------------------------------------------------
// Implement loadView to create a view hierarchy programmatically, without using a nib.
- (void)loadView
{
    CGRect initFrame = CGRectMake(0, 0, 380, 460);
    MKMapView *mkMapView = [[MKMapView alloc] initWithFrame:initFrame];
    self.view = mkMapView;
    
    mkMapView.mapType = MKMapTypeStandard;
    mkMapView.pitchEnabled = YES;
    mkMapView.delegate = self;
    
 
    MKMapCamera *camera1 = [MKMapCamera
                            cameraLookingAtCenterCoordinate:   (CLLocationCoordinate2D){ .latitude = 50.1, .longitude = 14.6}
                            fromEyeCoordinate: (CLLocationCoordinate2D){ .latitude = 50.12, .longitude = 14.62}
                            eyeAltitude:80.0];
    
    [mkMapView setCamera:camera1 animated:YES];

    
    
    

    
    NSString *resourcePath = [[NSBundle mainBundle] resourcePath];
    MultiPolygonOverlay *shpPolygonsOverlay =  [[MultiPolygonOverlay alloc]
                                                initWithLocalShpFile:[resourcePath stringByAppendingPathComponent:@"DOKMPARCELA_P"]];
    
    
    [mkMapView  addOverlay:shpPolygonsOverlay];
}



//----------------------------------------------------------------------------
-(MKMapView*) mkMapView {
    return (MKMapView *) self.view;
    
}

//----------------------------------------------------------------------------------------
-(MKOverlayRenderer *)mapView:(MKMapView *)mapView rendererForOverlay:(id<MKOverlay>)overlay
{
    
    if ([overlay isKindOfClass:[MultiPolygonOverlay class]]) {
        MultiPolygonRenderer *polygonsView = [[MultiPolygonRenderer alloc] initWithOverlay:(MultiPolygonOverlay*)overlay];
        polygonsView.fillColor = [UIColor clearColor];//s[[UIColor magentaColor] colorWithAlphaComponent:0.8];
        polygonsView.strokeColor = [[UIColor blueColor] colorWithAlphaComponent:0.8];
        polygonsView.lineWidth = 1;
        return polygonsView;
    }
    else {
        return nil;
    }
    
}

/*
 // Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
 - (void)viewDidLoad
 {
 [super viewDidLoad];
 }
 */

//----------------------------------------------------------------------------
- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

//---------------------------------------------------------
- (void)viewWillAppear:(BOOL)animated
{
    self.navigationController.navigationBarHidden = YES;
    [super viewWillAppear:animated];
}
//---------------------------------------------------------
- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
}
//---------------------------------------------------------
- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
}
//---------------------------------------------------------
- (void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
}

//----------------------------------------------------------------------------
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return YES;
}




@end
