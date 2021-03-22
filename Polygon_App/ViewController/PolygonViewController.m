//
//  PolygonViewController.m
//  Polygon_App
//
//  Created by admin on 11/10/15.
//  Copyright (c) 2015 admin. All rights reserved.
//

#import "PolygonViewController.h"
#import "MapViewController.h"
#import "TableViewCell.h"
#import "PromoterViewController.h"
#import "AppDelegate.h"
//#import "PolygonAPI.h"
//#import <MBProgressHUD.h>
//#import <UIImageView+WebCache.h>
#import "SignUPViewController.h"

typedef NS_ENUM(NSInteger , CrowdGraph) {
 
    low = 1 ,
    medium = 2,
    high = 3,
    very_high = 4
};

@interface PolygonViewController (){
    
    NSArray *array;
//    MBProgressHUD *progressHUD;
    NSString *promoterID;
    int num;
    int flag;
    NSString *favorite;
    UIImage *image1;
    UIImage *image2;
}

@property (nonatomic, strong) NSMutableArray *promoterArray;

@end

@implementation PolygonViewController

@synthesize opaqueView;

- (void)viewDidLoad {
    [super viewDidLoad];
    array = @[@"#ff0000" , @"#00ff00" , @"#0000ff" , @"#ff00ff" ,@"#ffff00"];

    image1 = [UIImage imageNamed:@"Final State-32"];
    image2 = [UIImage imageNamed:@"Active State-32"];
    [self.btnTopPromoter setImage:image1];
    [self.btnDistance setImage:image2];
    [self.btnCrowd setImage:image2];
    [self.btnFavorites setImage:image2];
    self.lblPolygonName.text =  self.strPolygonName;
    
    AppDelegate *app = [[AppDelegate alloc] init];
    app = [[UIApplication sharedApplication] delegate];
    flag = app.signUpFlag;
//    progressHUD = [[MBProgressHUD alloc] initWithView:self.view];
//    progressHUD.labelText = @"loading...";
//    progressHUD.mode = MBProgressHUDModeIndeterminate;
//    [self.view addSubview:progressHUD];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}

- (IBAction)onbtnBackCilcked:(id)sender {
    
    [self.navigationController popViewControllerAnimated:YES];
}

- (IBAction)onbtnFilterClicked:(id)sender {
    
    [UIView animateWithDuration:0.3 animations:^{
        
        CGRect frame = CGRectMake(0, 0, opaqueView.frame.size.width, opaqueView.frame.size.height);
        opaqueView.frame = frame;
        
    } completion:^(BOOL finished) {
        
        btnBackMap.hidden = YES;
        tablePromoterView.allowsSelection = NO;
        
    }];
}

- (IBAction)onbtnFilterViewCloseClicked:(id)sender
{
    [UIView animateWithDuration:0.3 animations:^{
        
        CGRect frame = CGRectMake(self.view.frame.size.width, 0, opaqueView.frame.size.width, opaqueView.frame.size.height);
        opaqueView.frame = frame;
        
    } completion:^(BOOL finished) {
        
        btnBackMap.hidden = NO;
        tablePromoterView.allowsSelection = YES;
    }];
}

- (IBAction)onbtnBackPormoterClicked:(id)sender {
    
    
}

- (IBAction)onbtnFilterItemClicked:(UIButton *)sender{
    
    switch (sender.tag) {
        case 1:
            
            [self.btnTopPromoter setImage:image1];
            [self.btnDistance setImage:image2];
            [self.btnCrowd setImage:image2];
            [self.btnFavorites setImage:image2];
            [self requestBusinessList:@"rating"];
            [self filterViewDisappear];
            
            break;
            
        case 2:
            
            [self.btnTopPromoter setImage:image2];
            [self.btnDistance setImage:image1];
            [self.btnCrowd setImage:image2];
            [self.btnFavorites setImage:image2];
            [self requestBusinessList:@"distance"];
            [self filterViewDisappear];
            
            break;
            
        case 3:
            
            [self.btnTopPromoter setImage:image2];
            [self.btnDistance setImage:image2];
            [self.btnCrowd setImage:image1];
            [self.btnFavorites setImage:image2];
            [self requestBusinessList:@"crowd"];
            [self filterViewDisappear];
            
            
            break;
            
        case 4:
            
            [self.btnTopPromoter setImage:image1];
            [self.btnDistance setImage:image2];
            [self.btnCrowd setImage:image2];
            [self.btnFavorites setImage:image2];
            [self filterViewDisappear];
            
            break;
            
        default:
            break;
    }
}

//- (void) requestBusinessList : (NSString *) sortBy
//{
//    [progressHUD show:YES];
//    [[PolygonAPI sharedManager] BusinessList:self.DistrictID Sort:sortBy latitude:self.userlatitude longtitude:self.userlongitude onSuccess:^(id json) {
//        
//        self.promoterList = (NSArray *)json;
//        [progressHUD hide:YES];
//        [tablePromoterView reloadData];
//        
//    } onFailure:^(NSInteger statusCode, id json) {
//        
//        [progressHUD hide:YES];
//    }];
//}

- (IBAction)onbtnFilterCloseClicked:(id)sender {
    
    [self filterViewDisappear];
}

- (void) filterViewDisappear
{
    [UIView animateWithDuration:0.3 animations:^{
        
        CGRect frame = CGRectMake(self.view.frame.size.width, 0, opaqueView.frame.size.width, opaqueView.frame.size.height);
        opaqueView.frame = frame;
        
    } completion:^(BOOL finished) {
        
        btnBackMap.hidden = NO;
        tablePromoterView.allowsSelection = YES;
    }];

}

// TableView Delegate Method

- (NSInteger ) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.promoterList.count;
}

- (UITableViewCell *) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
   TableViewCell *promoterCell = (TableViewCell *)[tableView dequeueReusableCellWithIdentifier:@"TableCell"];
    
   if (promoterCell == nil)
    {
        NSArray *nibArray = [[NSBundle mainBundle] loadNibNamed:@"TableViewCell" owner:self options:nil];
        promoterCell = [nibArray objectAtIndex:0];
    }
    
    NSDictionary *promoterItem = (NSDictionary *)[self.promoterList objectAtIndex:indexPath.row];
    
    [self cellSetup:promoterCell Dictionary:promoterItem];
    [promoterCell.btnFavorit addTarget:self action:@selector(btnFavoriteClicked:) forControlEvents:UIControlEventTouchUpInside];
    [promoterCell.btnCategory addTarget:self action:@selector(btnFavoriteClicked:) forControlEvents:UIControlEventTouchUpInside];
    [promoterCell.btnShared addTarget:self action:@selector(btnFavoriteClicked:) forControlEvents:UIControlEventTouchUpInside];
    return promoterCell;
}

- (void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    self.promoterData = (NSDictionary *)[self.promoterList objectAtIndex:indexPath.row];
    [self performSegueWithIdentifier:@"PromoterSegue" sender:self];
}

- (TableViewCell *) cellSetup : (TableViewCell *) tableCell Dictionary : (NSDictionary *) dictionary
{
    promoterID = (NSString *)[dictionary objectForKey:@"id"];
    NSString *strName = [dictionary objectForKey:@"name"];
    NSString *strCategory = [dictionary objectForKey:@"categories"];
    NSString *strImage = [dictionary objectForKey:@"image_url"];
    //favorite = [dictionary objectForKey:@"Favorite"];
    NSString *crowd = [dictionary objectForKey:@"liveliness"];
    if ([crowd  isEqual: @"low"]) {
        num = 1;
    }else if ([crowd  isEqual: @"medium"]) {
        num = 2;
    }else if ([crowd  isEqual: @"high"]) {
        num = 3;
    }else if ([crowd  isEqual: @"very high"]) {
        num = 4;
    }
    float rate1 = (float)num/4;
    NSURL *url = [NSURL URLWithString:strImage];
//    [tableCell.imagePromoterView sd_setImageWithURL:url placeholderImage:nil];
    [tableCell.lblPromoterName setText:strName];
    
    tableCell.backgrdGroupView.layer.cornerRadius = tableCell.backgrdGroupView.frame.size.height/2;
    tableCell.backgrdGroupView.layer.borderColor = [UIColor whiteColor].CGColor;
    tableCell.backgrdGroupView.layer.borderWidth = 1.5;
    CGFloat height = tableCell.backgrdGroupView.layer.frame.size.height*rate1;
    CGFloat width = tableCell.backgrdGroupView.layer.frame.size.width;
    CGFloat pointY = tableCell.backgrdGroupView.layer.frame.size.height - height;
    
    NSLog(@"%lf , %lf , %lf" , height , width , pointY);
    
    CGRect rect = CGRectMake(0, pointY , width, height);
    tableCell.grouprateView.frame = rect;
    unsigned int hexint = 0;
    NSScanner *scanner = [NSScanner scannerWithString:array[num]];
    [scanner setCharactersToBeSkipped:[NSCharacterSet characterSetWithCharactersInString:@"#"]];
    [scanner scanHexInt:&hexint];
    UIColor *colored = [UIColor colorWithRed:((CGFloat)((hexint & 0xff0000) >> 16))/255
                                       green:((CGFloat)((hexint & 0x00ff00) >> 8))/255
                                        blue:((CGFloat)((hexint & 0x0000ff) >> 0))/255
                                       alpha:1.0f];
    tableCell.grouprateView.backgroundColor = colored;
    
    tableCell.sharedView.layer.cornerRadius = tableCell.sharedView.frame.size.width/2;
    tableCell.sharedView.layer.borderWidth = 1.5;
    tableCell.sharedView.layer.borderColor = [UIColor whiteColor].CGColor;
    
    tableCell.groupView.layer.cornerRadius = tableCell.sharedView.frame.size.width/2;
    tableCell.groupView.layer.borderWidth = 1.5;
    tableCell.groupView.layer.borderColor = [UIColor whiteColor].CGColor;
    
    tableCell.favoriteView.layer.cornerRadius = tableCell.sharedView.frame.size.width/2;
    tableCell.favoriteView.layer.borderWidth = 1.5;
    tableCell.favoriteView.layer.borderColor = [UIColor whiteColor].CGColor;
    
    NSArray *categoryItem = [strCategory componentsSeparatedByString:@","];
    if ([categoryItem[0]  isEqual: @"Bars"]) {
        
        [tableCell.btnCategory setImage:[UIImage imageNamed:@"Beer1"] forState:UIControlStateNormal];
        tableCell.groupView.backgroundColor = [UIColor greenColor];
    }else if ([categoryItem[0] isEqual: @"NightClubs"]){
        [tableCell.btnCategory setImage:[UIImage imageNamed:@"Music"] forState:UIControlStateNormal];
        tableCell.groupView.backgroundColor = [UIColor redColor];
    }else{
        [tableCell.btnCategory setImage:[UIImage imageNamed:@"Dinner1"] forState:UIControlStateNormal];
        tableCell.groupView.backgroundColor = [UIColor blueColor];
    }
    
    if ([favorite  isEqual: @"0"]) {
        
        [tableCell.btnFavorit setImage:[UIImage imageNamed:@"favorite-3"] forState:UIControlStateNormal];
        favorite =@"1";
        
    }
    else if([favorite  isEqual: @"1"])
    {
        [tableCell.btnFavorit setImage:[UIImage imageNamed:@"Favorit_1"] forState:UIControlStateNormal];
        favorite = @"0";
    }
    return tableCell;
}



- (void) btnFavoriteClicked : (UIButton *) sender
{
    
    if (flag == 0) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:nil message:@"You have to sign up" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:@"Cancel", nil];
        [alert show];
    }else{
        
        switch (sender.tag) {
            case 2:
                
                break;
                
            case 3:
                break;
            case 4:
                sender.tag = 5;
                [sender setImage:[UIImage imageNamed:@"Favorit_1"] forState:UIControlStateNormal];
                break;
            case 5:
                sender.tag = 4;
                [sender setImage:[UIImage imageNamed:@"favorite-3"] forState:UIControlStateNormal];

                break;
            default:
                break;
        }
        
    }
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
}

- (void) prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier  isEqual: @"PromoterSegue"]) {
        
        PromoterViewController *controller = segue.destinationViewController;
        controller.dataDictionary = self.promoterData;
        controller.strPolygonName = self.strPolygonName;
        controller.commentArray = self.promoterArray;
    }
    
}

- (void) unwindForSegue:(UIStoryboardSegue *)unwindSegue towardsViewController:(UIViewController *)subsequentVC
{
    
}

@end
