//
//  SecondViewController.h
//  rdv
//
//  Created by Vincent Prioul on 10/12/2013.
//  Copyright (c) 2013 Vincent Prioul. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MessageUI/MessageUI.h>
#import <AddressBook/AddressBook.h>
#import <AddressBookUI/AddressBookUI.h>

#import "FirstViewController.h"

@interface SecondViewController : UIViewController <MFMessageComposeViewControllerDelegate,ABPeoplePickerNavigationControllerDelegate,MKMapViewDelegate/*,UIImagePickerControllerDelegate*/>
{
    NSArray *number;
}

@property(strong, nonatomic)IBOutlet MKMapView *mapView;
@property (weak, nonatomic) IBOutlet UITextView *text;
@property (weak, nonatomic) IBOutlet UITextField *contact;
@property (weak, nonatomic) IBOutlet UIView *camera;
@property (strong, nonatomic) IBOutlet UIImageView *imageView;

- (IBAction)sendMsg:(id)sender;
- (IBAction)takePhoto:(id)sender;
- (IBAction)Photo:(id)sender;
- (IBAction)addCont:(id)sender;

@end
