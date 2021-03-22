//
//  NextSignUPViewController.m
//  Polygon_App
//
//  Created by admin on 11/10/15.
//  Copyright (c) 2015 admin. All rights reserved.
//

#import "NextSignUPViewController.h"
#import "ProfileViewController.h"

@interface NextSignUPViewController ()

@end

@implementation NextSignUPViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    AcessView.layer.borderWidth = 1;
    AcessView.layer.borderColor = [UIColor darkGrayColor].CGColor;
    
    [self sendRequest];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (IBAction)onbtnNOCodeClicked:(id)sender {
    
    [self sendRequest];
    
}

- (IBAction)onbtnEnterClicked:(id)sender {
    
    
    if ([self.txtAccessCode.text isEqual:@""]) {
        
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:nil
                                                        message:@"You must enter your access code"
                                                       delegate:self
                                              cancelButtonTitle:@"OK"
                                              otherButtonTitles:nil, nil];
        [alert show];
    }
    else {
        
        [self.txtAccessCode resignFirstResponder];
    
        [self sendAccessCode];
        
        ProfileViewController *profileViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"ProfileViewController"];
        [self.navigationController pushViewController:profileViewController animated:YES];

    }
    
}

- (IBAction)onbtnBackClicked:(id)sender {
    
    [self.navigationController popViewControllerAnimated:YES];
    
}

- (void) sendRequest{
    
    
}

- (void) sendAccessCode
{
    
    
}

// UITextfield delegate Methods

- (BOOL) textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}

@end
