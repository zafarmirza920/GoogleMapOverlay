//
//  SelectIamgeViewController.h
//  Polygon_App
//
//  Created by admin on 11/12/15.
//  Copyright (c) 2015 admin. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface SelectIamgeViewController : UIViewController <UIImagePickerControllerDelegate , UINavigationControllerDelegate>

{
    
    IBOutlet UIButton *btnTake;
    IBOutlet UIButton *btnChange;
}


@property (nonatomic ,strong) UIImage *firstImage;


@property (strong, nonatomic) IBOutlet UIImageView *selectImageView;

- (IBAction)getImage:(id)sender;

@end
