//
//  FirstViewController.h
//  rdv
//
//  Created by Vincent Prioul on 10/12/2013.
//  Copyright (c) 2013 Vincent Prioul. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>

#import "Annotation.h"

@interface FirstViewController : UIViewController <MKMapViewDelegate>
{
    //IBOutlet MKMapView *mapView;
    //MKMapView *mapView;
}

@property(strong, nonatomic)IBOutlet MKMapView *mapView;
- (IBAction)sendMsg:(id)sender;


@property(strong, nonatomic)IBOutlet UIView *viewSearch;
@property(strong, nonatomic)IBOutlet UIButton *buttonOk;
@property(strong, nonatomic)IBOutlet UITextField *lat;
@property(strong, nonatomic)IBOutlet UITextField *lon;
- (IBAction)ok:(id)sender;
- (IBAction)cancel:(id)sender;
- (IBAction)latEnable:(id)sender;
- (IBAction)lonEnable:(id)sender;

@end
