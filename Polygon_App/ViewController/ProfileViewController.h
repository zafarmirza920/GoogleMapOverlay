//
//  ProfileViewController.h
//  Polygon_App
//
//  Created by admin on 11/10/15.
//  Copyright (c) 2015 admin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TPKeyboardAvoidingScrollView.h"

@interface ProfileViewController : UIViewController<UITextFieldDelegate , UIGestureRecognizerDelegate ,UIActionSheetDelegate , UIImagePickerControllerDelegate ,UINavigationControllerDelegate>

{
    
}

@property (nonatomic, strong) UIActionSheet *alertCamera;
@property (strong, nonatomic) NSString *userFirstName;
@property (strong, nonatomic) NSString *userLastName;
@property (strong, nonatomic) NSString *profileTag;
@property (nonatomic) BOOL notification;
@property (nonatomic , strong) UIImage *profileImage;

@property(nonatomic ,strong) IBOutlet UIView *profilePhotoView;

@property(nonatomic ,strong) IBOutlet UIImageView *ImgViewProfile;

@property (strong, nonatomic) IBOutlet UISwitch *btnSwich;
@property (strong, nonatomic) IBOutlet UITextField *txtProfileTag;
@property (strong, nonatomic) IBOutlet UITextField *txtLastName;
@property (strong, nonatomic) IBOutlet UITextField *txtFirstName;
@property (nonatomic, strong) UITapGestureRecognizer *tapGestureRecognizer;
@property (strong, nonatomic) IBOutlet UIView *TapGestureView;
@property (strong, nonatomic) IBOutlet UIView *viewBack;
@property (strong, nonatomic) UIImagePickerController *picker;


- (IBAction)onbtnChangePhotoClicked:(id)sender;
- (IBAction)onbtnSettingClicked:(id)sender;
- (IBAction)onbtnDetailClicked:(id)sender;
- (IBAction)onbtnContinueClicked:(id)sender;

@end
