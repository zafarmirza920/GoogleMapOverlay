//
//  SignUPViewController.h
//  Polygon_App
//
//  Created by admin on 11/10/15.
//  Copyright (c) 2015 admin. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SignUPViewController : UIViewController <UITextFieldDelegate , UIAlertViewDelegate >

{
    
    IBOutlet UIButton *btnCountryList;
    IBOutlet UIView *phoneNumView;
    
}


@property (strong, nonatomic) IBOutlet UILabel *txtCountryNumber;
@property (strong, nonatomic) IBOutlet UITextField *txtPhoneNumber;
@property (strong, nonatomic) UIAlertView *alertView;

@property (nonatomic , strong) NSArray *countryList;
@property (nonatomic , strong) NSString *countryName;
@property (nonatomic , strong) NSString *numPhoneCode;
@property (nonatomic , strong) NSString *numCountryCode;


- (IBAction)onbtnCountryClicked:(id)sender;
- (IBAction)onbtnBackClicked:(id)sender;
- (IBAction)onbtnContinueClicked:(id)sender;

@end
