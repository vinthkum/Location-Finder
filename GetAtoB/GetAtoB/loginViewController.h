//
//  loginViewController.h
//  GetAtoB
//
//  Created by Vinoth on 18/02/2013.
//  Copyright (c) 2013 Vinoth's iMac. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreLocation/CoreLocation.h>


@interface loginViewController : UIViewController<UITextFieldDelegate,CLLocationManagerDelegate>
{
    IBOutlet UITextField *startField,*endField;
    NSString *latituuuu,*longituuu;
    NSMutableString *CurAdd;
}
@property (strong, nonatomic)     NSString *latituuuu,*longituuu;
@property (strong, nonatomic)  NSMutableString *CurAdd;

-(IBAction)nxt:(id)sender;
@end
