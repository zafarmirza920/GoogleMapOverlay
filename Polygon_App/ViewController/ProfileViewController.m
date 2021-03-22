//
//  ProfileViewController.m
//  Polygon_App
//
//  Created by admin on 11/10/15.
//  Copyright (c) 2015 admin. All rights reserved.
//

#import "ProfileViewController.h"
#import "MapViewController.h"
#import "SelectIamgeViewController.h"
#import "AppDelegate.h"

@interface ProfileViewController ()
{
    
    
    
}

@end

@implementation ProfileViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    CGSize size = self.profilePhotoView.frame.size;
    size.width = MIN(self.profilePhotoView.frame.size.width, self.profilePhotoView.frame.size.height);
    size.height = size.width;
    CGRect frame = CGRectMake(self.view.layer.frame.size.width/2-size.width/2, self.profilePhotoView.frame.origin.y, size.width, size.height);
    self.profilePhotoView.frame = frame;
    self.profilePhotoView.layer.borderWidth = 3;
    self.profilePhotoView.layer.borderColor = [UIColor colorWithRed:0.1 green:0.6 blue:0.7 alpha:1].CGColor;
    self.profilePhotoView.layer.cornerRadius = self.profilePhotoView.frame.size.height/2;
    
    UIImage *img = [UIImage imageNamed:@"Polygon_App"];
    self.profileImage = img;
    self.alertCamera = [[UIActionSheet alloc] initWithTitle:nil
                                                   delegate:self
                                          cancelButtonTitle:@"Cancel"
                                     destructiveButtonTitle:nil
                                          otherButtonTitles:@"Take a picture",
                                                            @"Select photos from camera roll", nil];
    self.alertCamera.tag = 1;
    
    self.picker = [[UIImagePickerController alloc] init];
    self.picker.allowsEditing = YES;
    self.picker.delegate = self;
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)onbtnChangePhotoClicked:(id)sender {
    
    [self.alertCamera showInView:[UIApplication sharedApplication].keyWindow];
    //[self performSegueWithIdentifier:@"ImageSelect" sender:self];
    [self.txtFirstName resignFirstResponder];
    [self.txtLastName resignFirstResponder];
    [self.txtProfileTag resignFirstResponder];
}
- (IBAction)onbtnSettingClicked:(id)sender {
    
    
}

- (IBAction)onbtnDetailClicked:(id)sender {



}

- (IBAction)onbtnContinueClicked:(id)sender {
    
    if ([self.txtProfileTag.text  isEqual: @""]) {
       
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:nil
                                                        message:@"Etnter your profile tag"
                                                       delegate:self
                                              cancelButtonTitle:@"OK"
                                              otherButtonTitles:nil, nil];
        [alert show];

    }
    
    else if ([self.txtFirstName.text  isEqual: @""] || [self.txtLastName.text  isEqual: @""]) {
        
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:nil
                                                        message:@"Etnter your name"
                                                       delegate:self
                                              cancelButtonTitle:@"OK"
                                              otherButtonTitles:nil, nil];
        [alert show];
        
    }
    else
    {
         MapViewController *mapViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"MapViewController"];
    
        [self.navigationController pushViewController:mapViewController animated:YES];
    }
    
   
    
}

- (void) sendUploadProfile
{
    
    
}



- (BOOL) textFieldShouldReturn:(UITextField *)textField
{
    if (textField == self.txtProfileTag) {
        [self.txtFirstName becomeFirstResponder];
    } else if (textField == self.txtFirstName){
        [self.txtLastName becomeFirstResponder];
    } else {
        [textField resignFirstResponder];
    }
    return YES;
}

- (void) actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    
    
    switch (buttonIndex) {
            
        case 0:
            self.picker.sourceType = UIImagePickerControllerSourceTypeCamera;
            [self presentViewController:self.picker animated:YES completion:nil];
            break;
                    
        case 1:
            self.picker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
            [self presentViewController:self.picker animated:YES completion:nil];
            break;
       
        default:
            break;
        }
            
    NSLog(@"%ld , %ld", (long)actionSheet.tag , (long)buttonIndex);
    
    

}

- (void) imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    [picker dismissViewControllerAnimated:YES completion:nil];
    UIImage *imageSEL = info[UIImagePickerControllerEditedImage];
    AppDelegate *app = [[UIApplication sharedApplication] delegate];
    app.imageprofile = imageSEL;
    app.signUpFlag = 1;
    self.profileImage = imageSEL;
    [self.ImgViewProfile setImage:self.profileImage];
    
}

- (void) imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
    [picker dismissViewControllerAnimated:YES completion:NULL];
    
}


- (void) prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier  isEqual: @"ImageSelect"]) {
        
        SelectIamgeViewController *controller = segue.destinationViewController;
        
        controller.firstImage = self.profileImage;
        
    }
}

- (IBAction) unwindFromCrop:(UIStoryboardSegue *) segue
{
    SelectIamgeViewController *controller = segue.sourceViewController;
    self.ImgViewProfile.image = controller.firstImage;
}

@end
