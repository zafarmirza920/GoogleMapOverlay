//
//  InviteViewController.h
//  Polygon_App
//
//  Created by admin on 11/10/15.
//  Copyright (c) 2015 admin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TPKeyboardAvoidingScrollView.h"
#import "PromoterViewController.h"

@interface InviteViewController : UIViewController <UITextFieldDelegate>
{
    
    IBOutlet UIImageView *imageView;
}


@property (strong, nonatomic) IBOutlet TPKeyboardAvoidingScrollView *viewBack;
@property (strong, nonatomic) IBOutlet UITextField *txtMessageField;

@property (strong, nonatomic) PromoterViewController *promoterViewController;
@property (strong, nonatomic) NSString *DistrictID;

- (IBAction)onbtnCancelClicked:(id)sender;
- (IBAction)btnPostClicked:(id)sender;
- (IBAction)getImage:(id)sender;

@end
