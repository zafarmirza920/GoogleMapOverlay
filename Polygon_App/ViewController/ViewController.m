//
//  ViewController.m
//  Polygon_App
//
//  Created by admin on 11/10/15.
//  Copyright (c) 2015 admin. All rights reserved.
//

#import "ViewController.h"
#import "SignUPViewController.h"
#import "MapViewController.h"
#import <CoreLocation/CoreLocation.h>
#import "AppDelegate.h"

@interface ViewController ()

{
    NSString *latitude;
    NSString *longtitude;
}

@property (nonatomic, strong) NSString *strPolygonName;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    alert.delegate = self;
    btnSignup.hidden = YES;
    btnSkip.hidden = YES;
    
    [self checkingTime];
}


- (void) checkingTime
{
    self.now = [NSDate date];
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setTimeZone:[NSTimeZone timeZoneWithName:@"PST"]];
    [formatter setDateFormat:@"HH"];
    NSString *time1 = [formatter stringFromDate:self.now];
    [formatter setDateFormat:@"mm"];
    NSString *time2 = [formatter stringFromDate:self.now];
    
    NSLog(@"%d %d" ,[time2 intValue],[time1 intValue]);
    
    currenttime1 = [time1 intValue];
    currenttime2 = [time2 intValue];
    
    if (currenttime1 < 19 && currenttime1 > 1 ) {
        int i , j;
        if (currenttime2 == 0) {
            i = 19 - currenttime1;
        }
        else{
            
            i = 19 - currenttime1 -1;
            j = 60 - currenttime2;
        }
        
        NSString *message = [NSString stringWithFormat:@"Can’t wait to use the app \U0001F60A. We are going live in %d : %d hours" , i , j];
        NSData *data = [message dataUsingEncoding:NSNonLossyASCIIStringEncoding];
        NSString *valueUnicode = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
        NSData *emojiData = [valueUnicode dataUsingEncoding:NSUTF8StringEncoding];
        NSString *valueEmoji = [[NSString alloc] initWithData:emojiData encoding:NSNonLossyASCIIStringEncoding];
        alert = [[UIAlertView alloc] initWithTitle:nil message:message delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alert show];
        [self checkingPosition];
    }else {
        
        [self checkingPosition];
    }
}

- (void) checkingPosition
{
    
    location = [[AppDelegate appDelegate] getLocation];
    if (location == nil) {
        [self performSelector:@selector(checkingPosition) withObject:nil afterDelay:0.5];
        return;
    }
    CLGeocoder *geoCoder = [[CLGeocoder alloc] init];
    CLLocationCoordinate2D coordinate = [location coordinate];
    latitude = [NSString stringWithFormat:@"%f", coordinate.latitude];
    longtitude = [NSString stringWithFormat:@"%f", coordinate.longitude];
    
    NSLog(@"%@ , %@" ,latitude ,longtitude);
    [geoCoder reverseGeocodeLocation:location completionHandler:^(NSArray *placemarks, NSError * error) {
        
        if (error == nil) {
            
            CLPlacemark *placeMark = [placemarks lastObject];
            postCode = placeMark.postalCode;
            nameNeighborhood = placeMark.subLocality;
            nameArea = placeMark.administrativeArea;
            nameCity = placeMark.locality;
            
            if (![nameCity isEqualToString:@"San Francisco "]) {
                
                self.strPolygonName = @"San Francisco";
                NSLog(@"%@" ,self.strPolygonName);
                alert = [[UIAlertView alloc] initWithTitle:nil
                                                   message:@"Polygon is currently not available in your city. Bring it your city by sharing your location."
                                                  delegate:self
                                         cancelButtonTitle:@"OK"
                                         otherButtonTitles:nil, nil];
                
                [alert show];
                btnSkip.hidden = NO;
                btnSignup.hidden = NO;
            }
            else{
                
                self.strPolygonName = nameNeighborhood;
                NSLog(@"%@" ,self.strPolygonName);
            }
            
            NSLog(@"%@ , %@ ,%@" , nameNeighborhood , nameArea, nameCity);
       }
        
    }];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
 }

- (IBAction) onbtnSignUpClicked:(id)sender{
    
        SignUPViewController *signUPViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"SignUPViewController"];
        [self.navigationController pushViewController:signUPViewController animated:YES];
    
}
- (IBAction)onbtnSkipCilcked:(UIButton *)sender {
    

    
    [self performSegueWithIdentifier:@"MapSegue" sender:self];
    
}

- (void) prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier  isEqual: @"MapSegue"]) {
        
        MapViewController *controller = segue.destinationViewController;
        AppDelegate *app = [UIApplication sharedApplication].delegate;
        app.latitude = latitude;
        app.longitude = longtitude;
        controller.strPolygonName = self.strPolygonName;
    }
    
}

@end
