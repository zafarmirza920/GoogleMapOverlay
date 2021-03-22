//
//  SelectIamgeViewController.m
//  Polygon_App
//
//  Created by admin on 11/12/15.
//  Copyright (c) 2015 admin. All rights reserved.
//

#import "SelectIamgeViewController.h"


#define Min_IMG_SIZE 80


@interface SelectIamgeViewController ()

@end

@implementation SelectIamgeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.selectImageView setImage:self.firstImage];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (IBAction)getImage:(id)sender {
    
    UIImagePickerController *picker = [[UIImagePickerController alloc] init];
    picker.allowsEditing = YES;
    picker.delegate = self;
    
    if ((UIButton *) sender == btnChange) {
        
        picker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
        
    }
    else{
        
        picker.sourceType = UIImagePickerControllerSourceTypeCamera;
    }
    
    [self presentViewController:picker animated:YES completion:nil];
}

- (void) imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    [picker dismissViewControllerAnimated:YES completion:nil];
    UIImage *imageSEL = info[UIImagePickerControllerEditedImage];
    //self.selectImageView.image = [info objectForKey:@"UIImagePickerControllerOriginalImage"];
    self.firstImage = imageSEL;
    self.selectImageView.image = imageSEL;
    
    
}

- (void) imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
     [picker dismissViewControllerAnimated:YES completion:NULL];
    
}
@end
