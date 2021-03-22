//
//  InviteViewController.m
//  Polygon_App
//
//  Created by admin on 11/10/15.
//  Copyright (c) 2015 admin. All rights reserved.
//

#import "InviteViewController.h"
#import "AppDelegate.h"
#import "PromoterViewController.h"
//#import "PolygonAPI.h"
//#import <MBProgressHUD.h>

@interface InviteViewController ()
{
    NSData *imgData;
//    MBProgressHUD *progressHUD;
    UIImage *image;
}


@end

@implementation InviteViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setImageCapture];
    
//    progressHUD = [[MBProgressHUD alloc] initWithView:self.view];
//    progressHUD.labelText = @"Loading...";
//    progressHUD.mode = MBProgressHUDModeIndeterminate;
    self.viewBack.hidden = NO;
//    [self.view addSubview:progressHUD];
}

- (void) setImageCapture
{
    
    AppDelegate *app = [[UIApplication sharedApplication] delegate];
    image = [UIImage imageWithData:app.imageCapture];
    imgData = app.imageCapture;
    [imageView setImage:image];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (IBAction)onbtnCancelClicked:(id)sender {
    
    [self.presentingViewController dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)btnPostClicked:(id)sender {
    
    NSString *message = self.txtMessageField.text;
    imgData = UIImageJPEGRepresentation(image, 0.9);
//    [self postComment:message];
    [self.presentingViewController dismissViewControllerAnimated:NO completion:nil];
}

//- (void) postComment : (NSString *) comment
//{
////    [progressHUD show:YES];
//    [[PolygonAPI sharedManager] SetComment:self.DistrictID comment:comment commenterID:@"5" image:imgData onSuccess:^(id json) {
//        
//        [progressHUD hide:YES];
//        [self.promoterViewController getComment];
//        
//    } onFailure:^(NSInteger statusCode, id json) {
//        [progressHUD hide:YES];
//    }];
//}


- (BOOL) textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}

//- (IBAction)getImage:(id)sender {
//    
//    UIImagePickerController *picker = [[UIImagePickerController alloc] init];
//    picker.allowsEditing = YES;
//    picker.delegate = self;
//    picker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
//    [self presentViewController:picker animated:YES completion:nil];
//    
//}
//
//- (void) imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
//{
//    [picker dismissViewControllerAnimated:YES completion:nil];
//    UIImage *imageSEL = info[UIImagePickerControllerEditedImage];
//    image = imageSEL;
//    imageView.image = image;
//}
//
//- (void) imagePickerControllerDidCancel:(UIImagePickerController *)picker
//{
//    [picker dismissViewControllerAnimated:YES completion:NULL];
//}

@end
