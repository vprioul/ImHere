//
//  FirstViewController.m
//  rdv
//
//  Created by Vincent Prioul on 10/12/2013.
//  Copyright (c) 2013 Vincent Prioul. All rights reserved.
//

#import "FirstViewController.h"

@interface FirstViewController ()

@end

@implementation FirstViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    self.mapView.showsUserLocation=NO;
    self.mapView.showsUserLocation=YES;
    self.mapView.delegate=self;
    
    self.viewSearch.layer.borderWidth=0.5;
    self.viewSearch.layer.cornerRadius=8;
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(dismissKeyboard)];
    
    [self.view addGestureRecognizer:tap];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)sendMsg:(id)sender {
    [self.viewSearch setHidden:NO];
}


- (IBAction)latEnable:(id)sender {
    //latE=1;
    NSLog(@"latitude");
    /*if (latE==1 && lonE==1) {
        NSLog(@"latitude2");
        [self.buttonOk setEnabled:TRUE];
    }*/
}
- (IBAction)lonEnable:(id)sender {
    /*lonE=1;
    if (latE==1 && lonE==1) {
        [self.buttonOk setEnabled:TRUE];
    }*/
}

- (IBAction)ok:(id)sender{
    if([self.lat.text length]!=0 && [self.lon.text length]!=0) {
        CLLocationCoordinate2D coordonnees;
        NSString *latstring=self.lat.text;
        double latdouble = [latstring doubleValue];
        NSString *lonstring=self.lon.text;
        double londouble = [lonstring doubleValue];
        if (latdouble<90 && latdouble>-90 && londouble<90 && londouble>-90) {
            coordonnees.latitude=latdouble;
            coordonnees.longitude=londouble;
            NSLog(@"latitude : %f",coordonnees.latitude);
            NSLog(@"longitude : %f",coordonnees.longitude);
            MKCoordinateSpan span;
            span.latitudeDelta=0.01;
            span.longitudeDelta=0.01;
            MKCoordinateRegion localisation;
            localisation.span=span;
            localisation.center=coordonnees;
            
            // Centrer la carte sur la localisation
            [self.mapView setRegion:localisation animated:TRUE];
            
            Annotation *newAnnotation=[[Annotation alloc] initWithTitle:@"Je suis ici!!" andCoordinate:localisation.center];
            [self.mapView addAnnotation:newAnnotation];
            [self.mapView selectAnnotation:newAnnotation animated:YES];
            
            [self.viewSearch setHidden:YES];
            self.lat.text=@"";
            self.lon.text=@"";
            [self.lat resignFirstResponder];
            [self.lon resignFirstResponder];
        }else{
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Erreur" message:@"Erreur dans les coordonnées gps. Compris entre -90.00000 et 90.00000 ." delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
            [alert show];
        }
    }else{
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Erreur" message:@"Erreur remplir les champs Latitude et Longitude." delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [alert show];
    }
    
    
}

- (IBAction)cancel:(id)sender{
    [self.viewSearch setHidden:YES];
    self.lat.text=@"";
    self.lon.text=@"";
    [self.lat resignFirstResponder];
    [self.lon resignFirstResponder];
}


- (void)mapView:(MKMapView *)mapView didUpdateUserLocation:(MKUserLocation *)userLocation
{
    CLLocationCoordinate2D location;
    location=userLocation.location.coordinate;
    MKCoordinateSpan span;
    span.latitudeDelta=0.01;
    span.longitudeDelta=0.01;
    MKCoordinateRegion localisation;
    localisation.span=span;
    localisation.center=location;
    [self.mapView setRegion:localisation animated:TRUE];
}


-(void)dismissKeyboard {
    [self.lat resignFirstResponder];
    [self.lon resignFirstResponder];
}
@end
