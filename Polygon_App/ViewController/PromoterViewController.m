//
//  PromoterViewController.m
//  Polygon_App
//
//  Created by admin on 11/10/15.
//  Copyright (c) 2015 admin. All rights reserved.
//

#import "PromoterViewController.h"
#import "PolygonViewController.h"
#import "AppDelegate.h"
#import "CameraViewController.h"
#import "InviteViewController.h"
#import "ChartView.h"
//#import "PolygonAPI.h"
//#import <MBProgressHUD.h>
#import "SelectIamgeViewController.h"
#import "CommenterTableViewCell.h"
#import "MessageTableViewCell.h"
#import "ImageViewTableViewCell.h"
////#import <UIImageView+WebCache.h>
#import "SignUPViewController.h"

#define baseUrl @"http://104.237.158.58:80"
#define businessurl @"/v1/api/businesses/"
#define setcrowdurl @"/set_crowd"

@interface PromoterViewController (){
    
    int flag;
    NSString *promoterID;
//    MBProgressHUD *progressHUD;
    NSArray *graphdata;
    NSString *userID;
    UIImage *profileIamge;
    NSArray *commentList;
    NSDictionary *data;
    float height;
    float heightCommenter;
    float imageHeight;
    float heightAll;
}

@end

@implementation PromoterViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
//    progressHUD = [[MBProgressHUD alloc] initWithView:self.view];
//    progressHUD.mode = MBProgressHUDModeIndeterminate;
//    progressHUD.labelText = @"Loading...";
//    [self.view addSubview:progressHUD];
    [self bottomViewSetup];
    [self setCrowdViewSetup];
    self.chartView.hidden = YES;
    self.setCrowdView.hidden = YES;
    AppDelegate *app = [[UIApplication sharedApplication] delegate];
    self.lblPolygonName.text =  self.strPolygonName;
    flag = app.signUpFlag;
    profileIamge = app.imageprofile;
}

- (void) getComment
{
//    [progressHUD show:YES];
//    [[PolygonAPI sharedManager] GetComment:promoterID onSuccess:^(id json) {
//        
//        commentList = (NSArray *) json;
////        [progressHUD hide:YES];
//        [self.tableCommentView reloadData];
//        self.tableCommentView.hidden = NO ;
//        
//    } onFailure:^(NSInteger statusCode, id json) {
////        [progressHUD hide:YES];
//    }];
}

//  PromoterView initialize and setup //

- (void) bottomViewSetup {
    
    promoterID = [self.dataDictionary objectForKey:@"id"];
    NSString *strImage = [self.dataDictionary objectForKey:@"image_url"];
    NSString *strName = [self.dataDictionary objectForKey:@"name"];
    NSString *strAddress = [self.dataDictionary objectForKey:@"display_address"];
    NSString *favorite = @"0";  //[self.dataDictionary objectForKey:@"Favorite"];
    //NSNumber *crowdRate = [self.dataDictionary objectForKey:@"Crowd"];
    NSArray *address = [strAddress componentsSeparatedByString:@"San Francisco,"];
    NSURL *url = [NSURL URLWithString:strImage];
    NSData *imgData = [NSData dataWithContentsOfURL:url];
    UIImage *image = [UIImage imageWithData:imgData];
    
    [self.promoterImageView setImage:image];
    [self.lblPromoterName setText:strName];
    [self.lblPosition setText:[NSString stringWithFormat:@"%@ SFO" ,[address objectAtIndex:0]]];
    [self getComment];
    if ([favorite  isEqual: @"1"]) {
        [self.btnFavorite setImage:[UIImage imageNamed:@"Favorit_1"] forState:UIControlStateNormal];
        self.btnFavorite.tag = 1;
        
    }else if([favorite  isEqual: @"0"]){
        
        [self.btnFavorite setImage:[UIImage imageNamed:@"favorite-3"] forState:UIControlStateNormal];
        self.btnFavorite.tag = 2;
        [self.btnFavorite addTarget:self action:@selector(imageTap:set:) forControlEvents:UIControlEventTouchUpInside];
    }
    self.groupView.layer.cornerRadius = self.groupView.layer.frame.size.width/2;
    self.groupView.layer.borderWidth = 2;
    self.groupView.layer.borderColor = [UIColor whiteColor].CGColor;
    self.musicView.layer.cornerRadius = self.musicView.layer.frame.size.width/2;
    self.musicView.layer.borderWidth = 2;
    self.musicView.layer.borderColor = [UIColor whiteColor].CGColor;
    self.calinderView.layer.cornerRadius = self.calinderView.layer.frame.size.width/2;
    self.calinderView.layer.borderWidth = 2;
    self.calinderView.layer.borderColor = [UIColor whiteColor].CGColor;
    self.photoView.layer.cornerRadius = self.photoView.layer.frame.size.width/2;
    self.photoView.layer.borderWidth = 2;
    self.photoView.layer.borderColor = [UIColor whiteColor].CGColor;
    self.sharedView.layer.cornerRadius = self.sharedView.layer.frame.size.width/2;
    self.sharedView.layer.borderWidth = 2;
    self.sharedView.layer.borderColor = [UIColor whiteColor].CGColor;
}

// SetCrowdView set up

- (void) setCrowdViewSetup {
    
    self.crowdLowView.layer.cornerRadius = self.crowdLowView.layer.frame.size.width/2;
    self.crowdLowView.layer.borderWidth = 2;
    self.crowdLowView.layer.borderColor = [UIColor whiteColor].CGColor;
    self.crowdHighView.layer.cornerRadius = self.crowdLowView.layer.frame.size.width/2;
    self.crowdHighView.layer.borderWidth = 2;
    self.crowdHighView.layer.borderColor = [UIColor whiteColor].CGColor;
    self.crowdMediumView.layer.cornerRadius = self.crowdLowView.layer.frame.size.width/2;
    self.crowdMediumView.layer.borderWidth = 2;
    self.crowdMediumView.layer.borderColor = [UIColor whiteColor].CGColor;
    self.crowdVeryHighView.layer.cornerRadius = self.crowdLowView.layer.frame.size.width/2;
    self.crowdVeryHighView.layer.borderWidth = 2;
    self.crowdVeryHighView.layer.borderColor = [UIColor whiteColor].CGColor;
}

// ChartView make

- (void) chartViewSetUp
{
    
    ChartView *graph = [[ChartView alloc] initWithFrame:CGRectMake(40, 0, self.chartView.bounds.size.width-40, self.chartView.bounds.size.height-48)];
    graph.autoresizingMask = (UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth);
    graph.dataSource = graphdata;
    [self.chartView addSubview:graph];
    
    for (int i = 0 ; i <= 5 ; i++ ) {
        
        float scale =(float)((self.chartView.frame.size.height-80-0.05 *(self.chartView.frame.size.height-40) )/5);
        
        UILabel *lblscale = [[UILabel alloc] initWithFrame:CGRectMake(12, 21 +(i*scale), 30, 21)];
        lblscale.textColor = [UIColor blackColor];
        int axis = 100 - i * 20;
        NSString *text = [NSString stringWithFormat:@"%d",axis];
        [lblscale setFont:[UIFont systemFontOfSize:13]];
        lblscale.text = text;
        lblscale.textAlignment = UITextAlignmentRight;
        [self.chartView addSubview:lblscale];
        
    }
}

- (void) requestCrowdRate
{
//    [progressHUD show:YES];
//    [[PolygonAPI sharedManager] ActivityGraph:promoterID onSuccess:^(id json) {
//        
//        graphdata = [json objectForKey:@"graph"];
////        [progressHUD hide:YES];
//        [self chartViewSetUp];
//        self.chartView.hidden = NO;
//        
//    } onFailure:^(NSInteger statusCode, id json) {
////        [progressHUD hide:YES];
//    }];
}

- (void) imageTap : (NSString *) str set : (NSString *) strap
{
    
}

- (IBAction)btnFavoritClicked:(UIButton *)sender {
   
    if(flag == 1)
    {
        if (sender.tag == 1) {
            self.btnFavorite.tag = 2;
            UIImage *image1 = [UIImage imageNamed:@"favorite-3"];
            [self.btnFavorite setImage:image1 forState:UIControlStateNormal];
        }else if (sender.tag == 2){
            
            self.btnFavorite.tag = 1;
            UIImage *image = [UIImage imageNamed:@"Favorit_1"];
            [self.btnFavorite setImage:image forState:UIControlStateNormal];
        }
    }else {
        
        [self showAlert];
    }
}



- (IBAction)onbtnFiveItemClicked:(UIButton *)sender {
    
    if(flag == 0)
    {
        [self showAlert];
    }
    else if (flag == 1){
        
    
    switch (sender.tag) {
        case 10:
            if (self.setCrowdView.hidden == YES) {
                self.setCrowdView.hidden = NO;
                self.tableCommentView.hidden = YES;
                self.chartView.hidden = YES;
            }else{
                self.tableCommentView.hidden = NO;
                self.chartView.hidden = YES;
                self.setCrowdView.hidden = YES;
            }
            break;
            
        case 11:
                self.tableCommentView.hidden = NO;
                self.chartView.hidden = YES;
                self.setCrowdView.hidden = YES;
            break;
            
        case 12:
            if (self.chartView.hidden == YES) {
                [self requestCrowdRate];
                self.tableCommentView.hidden = YES;
                self.setCrowdView.hidden = YES;

            }else{
                self.chartView.hidden = YES;
                self.tableCommentView.hidden = NO;
                self.setCrowdView.hidden = YES;
            }
            break;
            
        case 13:
            
            [self cameraShow];
             break;
            
        case 14:
            
            break;
        default:
            break;
    }
    }
}

- (void) showAlert {
    
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:nil message:@"You have to sign up" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:@"Cancel", nil];
    [alert show];
}

- (void) alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    switch (buttonIndex) {
        case 0:
            
            [self actionView];
            
            break;
        case 1:
            break;
        default:
            break;
    }
}

- (void) actionView{
    SignUPViewController *controller = [self.storyboard instantiateViewControllerWithIdentifier:@"SignUPViewController"];
    [self.navigationController pushViewController:controller animated:YES];
    //[self presentViewController:controller animated:NO completion:nil];
}


- (IBAction)onbtnSetCrowdClicked:(UIButton *)sender {
    
    NSString *crowdRate = [NSString stringWithFormat:@"%ld",(long)sender.tag];
//    [[PolygonAPI sharedManager] SetCrowd:promoterID crowdRate:crowdRate userID:userID onSuccess:^(id json) {
//        NSLog(@"%@",json);
//        self.setCrowdView.hidden = YES;
//    } onFailure:^(NSInteger statusCode, id json) {
//        NSLog(@"%@",json);
//    }];
}

- (void) cameraShow{
    
    CameraViewController *cameraView = [self.storyboard instantiateViewControllerWithIdentifier:@"CameraViewController"];
    cameraView.parentVC = self;
    [self presentViewController:cameraView animated:YES completion:nil];

}

- (void)inviteShow {
    InviteViewController *inviteVC = [self.storyboard instantiateViewControllerWithIdentifier:@"InviteViewController"];
    inviteVC.promoterViewController = self;
    inviteVC.DistrictID = promoterID;
    [self presentViewController:inviteVC animated:YES completion:nil];
    
}

- (IBAction)onbtnBackClicked:(id)sender {
    
    [self.navigationController popViewControllerAnimated:YES];
}

//  UITableView Delegate Method ... show promoter comment list.

- (NSInteger) numberOfSectionsInTableView:(UITableView *)tableView
{
    return [commentList count];
}

- (NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    data = [commentList objectAtIndex:section];
    if ([data objectForKey:@"text"]==nil || [data objectForKey:@"picture"] ==  nil) {
        
        return 2;
    }
    return 3;
}

- (UITableViewCell *) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    CommenterTableViewCell *cell1 = [tableView dequeueReusableCellWithIdentifier:@"CommenterTableView"];
    if (cell1 == nil) {
        
        NSArray *nibArray = [[NSBundle mainBundle] loadNibNamed:@"CommenterTableViewCell" owner:self options:nil];
        cell1 = [nibArray objectAtIndex:0];
    }
    ImageViewTableViewCell *cell2 = [tableView dequeueReusableCellWithIdentifier:@"ImageViewCell"];
    if (cell2 == nil) {
        
        NSArray *nibArray = [[NSBundle mainBundle] loadNibNamed:@"ImageViewTableViewCell" owner:self options:nil];
        cell2 = [nibArray objectAtIndex:0];
    }
    MessageTableViewCell *cell3 = [tableView dequeueReusableCellWithIdentifier:@"MessageViewCell"];
    if (cell3 == nil) {
        
        NSArray *nibArray = [[NSBundle mainBundle] loadNibNamed:@"MessageTableViewCell" owner:self options:nil];
        cell3 = [nibArray objectAtIndex:0];
    }
    
    NSDictionary *baseData = [commentList objectAtIndex:indexPath.section];
    NSDictionary *strImage = [baseData objectForKey:@"picture"];
    NSDictionary *strPath = [strImage objectForKey:@"image"];
    NSString *imagePath = [strPath objectForKey:@"large"];
    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"%@%@",baseUrl,imagePath]];
    switch (indexPath.row) {
        case 0:
            
            cell1.commenterView.layer.cornerRadius = cell1.commenterView.frame.size.height/2;
            [cell1.imgCommenterView setImage:profileIamge];
            return cell1;
            
            break;
        case 1:
            if ([[data objectForKey:@"text"]  isEqual: @""]) {
//                [cell2.iamgeCommentView sd_setImageWithURL:url];
                return cell2;
            }else {
                
                NSString *strMessg = [baseData objectForKey:@"text"];
                cell3.lblMessage.numberOfLines = 20;
                cell3.lblMessage.adjustsFontSizeToFitWidth = YES;
                [cell3.lblMessage setText:strMessg];
                height = CGRectGetHeight(cell3.lblMessage.bounds);
                cell3.frame = CGRectMake(0, 0, cell3.frame.size.width, height);
                return cell3;
            }
            break;
        case 2:
            
//            [cell2.iamgeCommentView sd_setImageWithURL:url];
            return cell2;
            break;
        default:
            break;
    }

    return nil;
}

- (CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    switch (indexPath.row) {
        case 0:
            return 60;
            break;
        case 1:
            if ([[data objectForKey:@"text"]  isEqual: @""]) {
                return 420;
                
            }else{
                return height;
            }
        case 2:
            return 420;
            break;
            
        default:
            break;
    }
    return 0;
}


- (void)didReceiveMemoryWarning {
    
    [super didReceiveMemoryWarning];
}

@end
