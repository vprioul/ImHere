//
//  SecondViewController.m
//  rdv
//
//  Created by Vincent Prioul on 10/12/2013.
//  Copyright (c) 2013 Vincent Prioul. All rights reserved.
//

#import "SecondViewController.h"

@interface SecondViewController ()

@end

@implementation SecondViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    self.mapView.showsUserLocation=YES;/////////////////
    self.mapView.delegate=self;
    
    self.text.layer.borderWidth=2;
    self.text.layer.cornerRadius=8;
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(dismissKeyboard)];
    
    [self.view addGestureRecognizer:tap];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (IBAction)addCont:(id)sender{
    // creating the picker
	ABPeoplePickerNavigationController *picker = [[ABPeoplePickerNavigationController alloc] init];
	// place the delegate of the picker to the controll
	picker.peoplePickerDelegate = self;
    
	// showing the picker
	[self presentModalViewController:picker animated:YES];
}

- (void)peoplePickerNavigationControllerDidCancel:(ABPeoplePickerNavigationController *)peoplePicker {
    // assigning control back to the main controller
	[self dismissModalViewControllerAnimated:YES];
}

- (BOOL)peoplePickerNavigationController: (ABPeoplePickerNavigationController *)peoplePicker shouldContinueAfterSelectingPerson:(ABRecordRef)person {
    
	// setting the first name
    NSString *fname = (__bridge NSString *)ABRecordCopyValue(person, kABPersonFirstNameProperty);
    
	// setting the last name
    NSString *lname = (__bridge NSString *)ABRecordCopyValue(person, kABPersonLastNameProperty);
    
    NSString *contacts= [NSString stringWithFormat:@"%@%@%@",fname,@" ",lname];
    
    //self.contact.text=contacts;
    self.contact.text= [NSString stringWithFormat:@"%@%@%@",self.contact.text,@" ",contacts];
	// setting the number
	/*
	 this function will set the first number it finds
     
	 if you do not set a number for a contact it will probably
	 crash
	 */
	ABMultiValueRef multi = ABRecordCopyValue(person, kABPersonPhoneProperty);
	self->number = (__bridge NSString*)ABMultiValueCopyValueAtIndex(multi, 0);
    
    
    /*NSData *imgData = (__bridge NSData *)ABPersonCopyImageDataWithFormat(person, kABPersonImageFormatThumbnail);
    UIImage *image;
    if (imgData)
    {
        image = [UIImage imageWithData:imgData];//////////////
        NSLog(@"add image: %@",image);
    }*/
    
	// remove the controller
    [self dismissModalViewControllerAnimated:YES];
    
    return NO;
}

- (BOOL)peoplePickerNavigationController:(ABPeoplePickerNavigationController *)peoplePicker shouldContinueAfterSelectingPerson:(ABRecordRef)person property:(ABPropertyID)property identifier:(ABMultiValueIdentifier)identifier{
    return NO;
}

- (IBAction)sendMsg:(id)sender {
    /*CLLocationCoordinate2D localisation;/////////////////
    MKMapView *mapView=FirstViewController->mapView;
    localisation=f.mapView.userLocation.location.coordinate;
     NSLog(@"latitude : %f",localisation.latitude);
     NSLog(@"longitude : %f",localisation.longitude);*/
    NSString *msg=self.text.text;
    //NSString *msg=[NSString stringWithFormat:@"Je suis ici : latitude = 0 et longitude = 0 "];
    /*MFMessageComposeViewController *messageVC = [[MFMessageComposeViewController alloc] init];
    messageVC.body = msg;
    messageVC.recipients = self->number;
    messageVC.messageComposeDelegate = self;
    [self presentViewController:messageVC animated:NO completion:NULL];*/
}

- (void)messageComposeViewController:(MFMessageComposeViewController *)controller didFinishWithResult:(MessageComposeResult)result{
    switch (result)
    {
        case MessageComposeResultCancelled:
            NSLog(@"Message was cancelled");
            [self dismissViewControllerAnimated:YES completion:NULL];
            break;
        case MessageComposeResultFailed:
            NSLog(@"Message failed");
            [self dismissViewControllerAnimated:YES completion:NULL];
            break;
        case MessageComposeResultSent:
            NSLog(@"Message was sent");
            [self dismissViewControllerAnimated:YES completion:NULL];
            break;
        default:
            break;
    }
}

- (IBAction)takePhoto:(id)sender {
    [self.camera setHidden:NO];
}


- (IBAction)Photo:(id)sender {
    UIImagePickerController *picker = [[UIImagePickerController alloc] init];
    picker.delegate = self;
    picker.allowsEditing = YES;
    picker.sourceType = UIImagePickerControllerSourceTypeCamera;
    
    [self presentViewController:picker animated:YES completion:NULL];
    [self.camera setHidden:YES];
}


-(void)dismissKeyboard {
    [self.text resignFirstResponder];
}
@end
