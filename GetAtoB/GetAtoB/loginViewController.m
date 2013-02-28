//
//  loginViewController.m
//  GetAtoB
//
//  Created by Vinoth on 18/02/2013.
//  Copyright (c) 2013 Vinoth's iMac. All rights reserved.
//

#import "loginViewController.h"
#import "RootViewController.h"
#import "MapDirectionsViewController.h"

@interface loginViewController ()

@end

@implementation loginViewController{
    CLLocationManager *locationManager;
    CLGeocoder *geocoder;
    CLPlacemark *placemark;
}
@synthesize longituuu,latituuuu,CurAdd;
- (void)viewDidLoad
{
    [super viewDidLoad];
    locationManager = [[CLLocationManager alloc] init];
    geocoder = [[CLGeocoder alloc] init];
    locationManager.delegate = self;
    locationManager.desiredAccuracy = kCLLocationAccuracyBest;
    [locationManager startUpdatingLocation];
    CurAdd = [[NSMutableString alloc]init];


	// Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(IBAction)nxt:(id)sender{
//    RootViewController *root = [[RootViewController alloc]initWithNibName:@"RootViewController" bundle:nil];
//    [[self navigationController]pushViewController:root animated:YES];
    MapDirectionsViewController *controller = [[MapDirectionsViewController alloc] init];
    
    controller.startPoint = CurAdd;
    controller.endPoint = endField.text;
    [[self navigationController]pushViewController:controller animated:YES];
}
-(BOOL)textFieldShouldReturn:(UITextField *)textField{
    [textField resignFirstResponder];
    return YES;
}
- (void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error
{
    NSLog(@"didFailWithError: %@", error);
    UIAlertView *errorAlert = [[UIAlertView alloc]initWithTitle:@"Failed to Get Your Location" message:@"Check Your Location Settings " delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
    [errorAlert show];
    
}

- (void)locationManager:(CLLocationManager *)manager didUpdateToLocation:(CLLocation *)newLocation fromLocation:(CLLocation *)oldLocation
{
    NSLog(@"didUpdateToLocation: %@", newLocation);
    
    CLLocation *currentLocation = newLocation;
    if (currentLocation != nil) {
        latituuuu = [NSString stringWithFormat:@"%.8f", currentLocation.coordinate.longitude];
        longituuu = [NSString stringWithFormat:@"%.8f", currentLocation.coordinate.latitude];
        [CurAdd appendString:longituuu];
        [CurAdd appendString:@","];
        [CurAdd appendString:latituuuu];
        NSLog(CurAdd);
        
    }
    NSLog(@"Resolving the Address");
    [geocoder reverseGeocodeLocation:currentLocation completionHandler:^(NSArray *placemarks, NSError *error) {
        NSLog(@"Found placemarks: %@, error: %@", placemarks, error);
        if ([placemarks count]>0) {
        }
        if (error == nil && [placemarks count] > 0) {
            placemark = [placemarks lastObject];
            startField.text = [NSString stringWithFormat:@"%@,%@,%@,%@.",
                      
                                   placemark.thoroughfare,
                                   placemark.locality,
                                   placemark.administrativeArea,
                                   placemark.country];

            
        } else {
            NSLog(@"%@", error.debugDescription);
        }
    } ];
        [locationManager stopUpdatingLocation];
}


@end
