//
//  SignUPViewController.m
//  Polygon_App
//
//  Created by admin on 11/10/15.
//  Copyright (c) 2015 admin. All rights reserved.
//

#import "SignUPViewController.h"
#import "NextSignUPViewController.h"
//#import "PolygonAPI.h"
//#import <MBProgressHUD.h>
#import "AppDelegate.h"

@interface SignUPViewController ()
{
    NSString *countrycode;
    int countryrow;
//    MBProgressHUD *progressHUD;
}

@end

@implementation SignUPViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.alertView.delegate = self;
    self.txtPhoneNumber.delegate = self;
//    progressHUD = [[MBProgressHUD alloc] initWithView:self.view];
//    progressHUD.labelText = @"Loading...";
//    progressHUD.mode = MBProgressHUDModeIndeterminate;
//    [self.view addSubview:progressHUD];
    [self initView];
    
}

- (void) initView
{
    phoneNumView.layer.borderWidth = 1;
    phoneNumView.layer.borderColor = [UIColor darkGrayColor].CGColor;

}

- (void)didReceiveMemoryWarning {
    
    [super didReceiveMemoryWarning];

}

- (IBAction)onbtnCountryClicked:(UIButton *)sender {
    
}

- (IBAction)onbtnBackClicked:(id)sender {
    
    [self.navigationController popViewControllerAnimated:YES];
}

- (IBAction)onbtnContinueClicked:(id)sender {
    
    
    self.numPhoneCode = self.txtPhoneNumber.text;
    NSLog(@"%@" ,self.numPhoneCode);
    if ([self.txtPhoneNumber.text isEqual:@""]){
        
        self.alertView = [[UIAlertView alloc] initWithTitle:nil
                                                        message:@"Please enter your Phone Number"
                                                       delegate:self
                                              cancelButtonTitle:@"OK"
                                              otherButtonTitles:nil, nil];
        [self.alertView show];
    }
    else{
        
        //[progressHUD show:YES];
        NSString *phoneNum = [NSString stringWithFormat:@"1%@",self.txtPhoneNumber.text];
        NSString *deviceID = [self getDeviceID];
     }
    
    
}

- (NSString *) getDeviceID{
    
    NSString *deviceID;
    UIDevice *device = [UIDevice currentDevice];
    if ([UIDevice instancesRespondToSelector:@selector(identifierForVendor)]) {
        NSLog(@"%s DEBUG : iOS6.0 or earlier is available" , __func__);
        deviceID = [[device identifierForVendor] UUIDString];
    }
    else{
        NSLog(@"%s DEBUG : iOS6.0 or earlier is not available" , __func__);

    }
    return deviceID;
}

#pragma TextField Delegate Methods

- (BOOL) textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    return YES;
}

- (BOOL) textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}

- (BOOL) textFieldShouldBeginEditing:(UITextField *)textField
{
    if ([textField isEqual:self.txtPhoneNumber] ) {
        
    }
    return YES;
}

// Override

- (void) prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier  isEqual: @"signUP"]) {
        
        NextSignUPViewController *controler = segue.destinationViewController;
        controler.countryName = self.countryName;
        controler.strCountryCode = self.numCountryCode;
        controler.strPhoneNumber = self.numPhoneCode;
        
    }
    
}


@end
