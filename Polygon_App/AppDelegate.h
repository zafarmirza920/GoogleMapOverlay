//
//  AppDelegate.h
//  Polygon_App
//
//  Created by admin on 11/10/15.
//  Copyright (c) 2015 admin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreLocation/CoreLocation.h>

@protocol LocalityDelegate

-(void)didGetLocality:(NSDictionary *)locality;
-(void)didCancelLocality;
-(void)didGetLocation:(CLLocation*)location;

@end


@interface AppDelegate : UIResponder <UIApplicationDelegate, CLLocationManagerDelegate , UIAlertViewDelegate>

@property (strong, nonatomic) UIWindow *window;
@property (strong, nonatomic) NSData *imageCapture;
@property (strong, nonatomic) NSString *strMessage;
@property (strong, nonatomic) UIImage *imageprofile;
@property (nonatomic ,strong) NSString *latitude;
@property (nonatomic, strong) NSString *longitude;
@property (nonatomic) int signUpFlag;

+ (AppDelegate *)appDelegate;

// Location Manager
@property(nonatomic,strong) CLLocationManager* locationManager;
@property (nonatomic, strong) id<LocalityDelegate> localityDelegate;
@property(nonatomic,assign) BOOL needGetLocation;

// Get GPS Location
- (void)setLocalityDelegate:(id<LocalityDelegate>)localityDelegate;
- (void)getLocality:(NSString*)message;
- (CLLocation*) getLocation;

@end

