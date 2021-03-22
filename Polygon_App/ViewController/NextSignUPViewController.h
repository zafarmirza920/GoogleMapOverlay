//
//  NextSignUPViewController.h
//  Polygon_App
//
//  Created by admin on 11/10/15.
//  Copyright (c) 2015 admin. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NextSignUPViewController : UIViewController <UITextFieldDelegate>

{
    
    IBOutlet UIView *AcessView;
    
}

@property (strong, nonatomic) NSString *countryName;
@property (strong, nonatomic) NSString *strCountryCode;
@property (strong, nonatomic) NSString *strPhoneNumber;

@property (strong, nonatomic) IBOutlet UITextField *txtAccessCode;


- (IBAction)onbtnNOCodeClicked:(id)sender;
- (IBAction)onbtnEnterClicked:(id)sender;
- (IBAction)onbtnBackClicked:(id)sender;



@end
