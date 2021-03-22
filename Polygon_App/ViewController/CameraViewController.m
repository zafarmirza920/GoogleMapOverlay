//
//  CameraViewController.m
//  Polygon_App
//
//  Created by admin on 11/10/15.
//  Copyright (c) 2015 admin. All rights reserved.
//

#import "CameraViewController.h"
#import "InviteViewController.h"
#import <AVFoundation/AVFoundation.h>
#import "AppDelegate.h"

@interface CameraViewController ()

@end

@implementation CameraViewController

AVCaptureSession *session;
AVCaptureStillImageOutput *StillImageOutput;

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.btnCamera.layer.cornerRadius = self.btnCamera.frame.size.width/2;
}

- (void) viewWillAppear:(BOOL)animated
{
    
    session = [[AVCaptureSession alloc] init];
    [session setSessionPreset:AVCaptureSessionPresetPhoto];
    
    AVCaptureDevice *inputDevice = [AVCaptureDevice defaultDeviceWithMediaType:AVMediaTypeVideo];
    NSError *error;
    AVCaptureDeviceInput *deviceInput = [AVCaptureDeviceInput deviceInputWithDevice:inputDevice error:&error];
    if ([session canAddInput:deviceInput]) {
        
        [session addInput:deviceInput];
    }
    
    AVCaptureVideoPreviewLayer *previewLayer = [[AVCaptureVideoPreviewLayer alloc] initWithSession:session];
    [previewLayer setVideoGravity:AVLayerVideoGravityResizeAspectFill];
    
    CALayer *rootLayer = [[self view] layer];
    //CALayer *rootLayer = [frameforcapture layer];
    [rootLayer setMasksToBounds:YES];
    CGRect frame = frameforcapture.frame;
    
    [previewLayer setFrame:frame];
    
    [rootLayer insertSublayer:previewLayer atIndex:0];
    
    StillImageOutput = [[AVCaptureStillImageOutput alloc] init];
    NSDictionary *outputSettings = [[NSDictionary alloc] initWithObjectsAndKeys:AVVideoCodecJPEG, AVVideoCodecKey , nil];
    [StillImageOutput setOutputSettings:outputSettings];
    
    [session addOutput:StillImageOutput];
    [session startRunning];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)onbtnCameraClicked:(id)sender {
    
    AVCaptureConnection *videoConnection = nil;
    for (AVCaptureConnection *connection in StillImageOutput.connections) {
        for (AVCaptureInputPort *port in [connection inputPorts]) {
            if ([[port mediaType] isEqual:AVMediaTypeVideo]) {
                
                videoConnection = connection;
                break;
            }
        }
    }
    
    [StillImageOutput captureStillImageAsynchronouslyFromConnection:videoConnection completionHandler:^(CMSampleBufferRef imageDataSampleBuffer, NSError *error) {
        
        if (imageDataSampleBuffer != NULL) {
            
            NSData *imageData = [AVCaptureStillImageOutput jpegStillImageNSDataRepresentation:imageDataSampleBuffer];
            
            UIImage *image = [UIImage imageWithData:imageData];
            AppDelegate *app = [[UIApplication sharedApplication] delegate];
            app.imageCapture = imageData;
            self.imgCapture = image;

            [self.presentingViewController dismissViewControllerAnimated:NO completion:nil];
            [self.parentVC inviteShow];
        }
    }];
}

- (IBAction)onbtnCancelClicked:(id)sender {
    
    [self.presentingViewController dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark - Navigation


- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    
//    if ([segue.identifier  isEqual: @"inviteSegue"]) {
//        
//        InviteViewController *controller = segue.destinationViewController;
//        controller.imgSend = self.imgCapture;
//        
//    }
//    
}



@end
