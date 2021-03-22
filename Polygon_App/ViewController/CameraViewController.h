//
//  CameraViewController.h
//  Polygon_App
//
//  Created by admin on 11/10/15.
//  Copyright (c) 2015 admin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PromoterViewController.h"

@interface CameraViewController : UIViewController
{
    
    IBOutlet UIView *frameforcapture;
}



@property (strong, nonatomic) IBOutlet UIButton *btnCamera;

@property (nonatomic , strong) UIImage *imgCapture;
@property (nonatomic , strong) PromoterViewController *parentVC;

- (IBAction)onbtnCameraClicked:(id)sender;
- (IBAction)onbtnCancelClicked:(id)sender;

@end
