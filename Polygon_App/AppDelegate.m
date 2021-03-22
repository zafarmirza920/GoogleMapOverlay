//
//  AppDelegate.m
//  Polygon_App
//
//  Created by admin on 11/10/15.
//  Copyright (c) 2015 admin. All rights reserved.
//

#import "AppDelegate.h"
#import "ViewController.h"

//@import GoogleMaps;

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    
    self.imageCapture = [[NSData alloc] init];
    self.imageprofile = [UIImage imageNamed:@"Polygon_App"];
    self.strMessage = [[NSString alloc] init];
    self.latitude = [[NSString alloc] init];
    self.longitude = [[NSString alloc] init];
    self.signUpFlag = 0;
//    [GMSServices provideAPIKey:@"AIzaSyDShCXIsJhQwT9p50WpICswCK3jO5dMAgk"];

    // Set LocationManager

    _locationManager = [[CLLocationManager alloc] init];
    if ([_locationManager respondsToSelector:@selector(requestWhenInUseAuthorization)]) {
        [_locationManager requestWhenInUseAuthorization];
    }
    _locationManager.desiredAccuracy = kCLLocationAccuracyBest;
    _locationManager.distanceFilter = 500; // meters
    _locationManager.delegate = self;
    [_locationManager requestWhenInUseAuthorization];
    [_locationManager startUpdatingLocation];
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
    
    // Stop LocationManager
    [_locationManager stopUpdatingLocation];

}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
    
    // Start LocationManager
    [_locationManager requestWhenInUseAuthorization];
    [_locationManager startUpdatingLocation];

}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

+ (AppDelegate *)appDelegate
{
    return (AppDelegate *)[[UIApplication sharedApplication] delegate];
}

#pragma mark - CLLocationManagerDelegate

- (void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error
{
    NSLog(@"didFailWithError: %@", error);
}

-(void)locationManager:(CLLocationManager *)manager didChangeAuthorizationStatus:(CLAuthorizationStatus)status
{
    NSLog(@"%hhd",[CLLocationManager locationServicesEnabled]);
    NSLog(@"LocationManagerStatus %i",[CLLocationManager authorizationStatus]);
}

- (void)locationManager:(CLLocationManager *)manager didUpdateToLocation:(CLLocation *)newLocation fromLocation:(CLLocation *)oldLocation
{
    NSLog(@"didUpdateToLocation: %@", newLocation);
    CLLocation* location = newLocation;
    
    // saving new location in nsuserdefaults
    NSUserDefaults* defaults = [NSUserDefaults standardUserDefaults];
    [defaults setObject:[NSNumber numberWithDouble:location.coordinate.latitude] forKey:@"latitude"];
    [defaults setObject:[NSNumber numberWithDouble:location.coordinate.longitude] forKey:@"longitude"];
    [defaults synchronize];
    
}

- (CLLocation*) getLocation {
    
    CLLocation* location = nil;
    NSNumber* latitude = [[NSUserDefaults standardUserDefaults] objectForKey:@"latitude"];
    NSNumber* longitude = [[NSUserDefaults standardUserDefaults] objectForKey:@"longitude"];
    if (latitude && longitude) {
        location = [[CLLocation alloc] initWithLatitude:[latitude doubleValue]
                                              longitude:[longitude doubleValue]];
    } else {
        if ([CLLocationManager 	locationServicesEnabled]) {
            location = [_locationManager location];
            if (!location) {
                [_locationManager requestWhenInUseAuthorization];
                [_locationManager startUpdatingLocation];
            }
        }
    }
#ifdef DEVELOP_MODE
    location = [[CLLocation alloc] initWithLatitude:37.337955
                                          longitude:-121.889616];
#endif
    return location;
}

- (void)setLocalityDelegate:(id<LocalityDelegate>)localityDelegate {
    _localityDelegate = localityDelegate;
    _needGetLocation = NO;
}

- (void)getLocality:(NSString*)message {
    if (_localityDelegate == nil) {
        NSLog(@"getLocality method is called without initializing LocalityDelegate.");
        return;
    }
    
    CLLocation* location = _locationManager.location;
#ifdef DEVELOP_MODE
    location = [[CLLocation alloc] initWithLatitude:37.337955
                                          longitude:-121.889616];
#endif
    if (location != nil) {
        [self locationToLocality:location];
    } else {
        if (message) {
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@""
                                                            message:message
                                                           delegate:self
                                                  cancelButtonTitle:@"Cancel"
                                                  otherButtonTitles:@"Settings", nil];
            [alert setTag: 100];
            [alert show];
            _needGetLocation = YES;
        } else {
            [_localityDelegate didCancelLocality];
        }
    }
}

- (void) locationToLocality:(CLLocation*) location {
    
    CLGeocoder *geocoder = [[CLGeocoder alloc] init];
    
    [geocoder reverseGeocodeLocation:location completionHandler:^(NSArray *placemarks, NSError *error) {
        
        NSLog(@"Found placemarks: %@, error: %@", placemarks, error);
        if (error == nil && [placemarks count] > 0) {
            CLPlacemark* placemark = [placemarks lastObject];
            
            NSString* address = [NSString stringWithFormat:@"SubThoroughfare %@\nThoroughfare %@\nPostalCode %@\nSubLocality %@\nLocality %@\nSubAdministrativeArea %@\nAdministrativeArea %@\nCountry %@",
                                 MAX(placemark.subThoroughfare,@""),
                                 MAX( placemark.thoroughfare,@""),
                                 MAX(placemark.postalCode,@""),
                                 MAX(placemark.subLocality,@""),
                                 MAX(placemark.locality,@""),
                                 MAX(placemark.subAdministrativeArea,@""),
                                 MAX(placemark.administrativeArea,@""),
                                 MAX(placemark.country,@"")];
            NSLog(@"\nRetrieved Location Info \n%@", address);
            NSLog(@"\nRetrieved Location Name \n%@", MAX(placemark.name,@""));
            
            NSString *locality = @"", *country = @"";
            if (placemark.locality && placemark.locality.length > 0) {
                locality = placemark.locality;
            } else if (placemark.subLocality && placemark.subLocality.length > 0) {
                locality = placemark.subLocality;
            } else if (placemark.name && placemark.name.length > 0) {
                locality = placemark.name;
            } else if (placemark.subAdministrativeArea && placemark.subAdministrativeArea.length > 0) {
                locality = placemark.subAdministrativeArea;
            } else if (placemark.administrativeArea && placemark.administrativeArea.length > 0) {
                locality = placemark.administrativeArea;
            }
            country = placemark.country;
            
            NSMutableDictionary* dic = [[NSMutableDictionary alloc] init];
            [dic setObject:[NSNumber numberWithDouble:location.coordinate.latitude] forKey:@"latitude"];
            [dic setObject:[NSNumber numberWithDouble:location.coordinate.longitude] forKey:@"longitude"];
            [dic setObject: locality forKey:@"locality"];
            [dic setObject: country forKey:@"country"];
            if (_localityDelegate) {
                [_localityDelegate didGetLocality:dic];
            }
        } else {
            
            NSLog(@"Reverse geo-coding error\n%@", error.debugDescription);
            
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:nil
                                                            message:@"Unable to retrieve your current location at this time. Please try again later."
                                                           delegate:nil
                                                  cancelButtonTitle:@"OK"
                                                  otherButtonTitles: nil];
            [alert show];
            if (_localityDelegate) {
                [_localityDelegate didCancelLocality];
            }
        }
    }];
}

#pragma mark - UIAlertViewDelegate
-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    // AlertView for location service disabled
    [alertView dismissWithClickedButtonIndex:buttonIndex animated:YES];
    if (buttonIndex == 0) {
        NSLog(@"Canceling location service setting");
        if (_needGetLocation && _localityDelegate != nil) {
            [_localityDelegate didCancelLocality];
        }
        _needGetLocation = NO;
    } else {
        NSLog(@"Opening location service setting");
        NSURL *settings = [NSURL URLWithString:UIApplicationOpenSettingsURLString];
        // Open Setting to enable location service
        if ([[UIApplication sharedApplication] canOpenURL:settings])
            [[UIApplication sharedApplication] openURL:settings];
    }
}



@end
