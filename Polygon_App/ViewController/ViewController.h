//
//  ViewController.h
//  Polygon_App
//
//  Created by admin on 11/10/15.
//  Copyright (c) 2015 admin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreLocation/CoreLocation.h>


@interface ViewController : UIViewController <CLLocationManagerDelegate , UIAlertViewDelegate>
{
    
     IBOutlet UIImageView *imgview_background;
    NSString *nameNeighborhood;
    NSString *nameArea;
    NSString *postCode;
    NSString *nameCity;
    UIAlertView *alert;
    int currenttime1;
    int currenttime2;
    CLLocation *location;
    IBOutlet UIButton *btnSignup;
    IBOutlet UIButton *btnSkip;
}

@property (nonatomic, strong) CLLocationManager *locationManager;

@property (nonatomic, strong) NSString *userPositionLong;
@property (nonatomic, strong) NSString *userPosistionLat;
@property (nonatomic, strong) NSDate *now;

- (IBAction)onbtnSignUpClicked:(id)sender;
- (IBAction)onbtnSkipCilcked:(id)sender;

- (void) checkingTime;
- (void) checkingPosition;

@end

