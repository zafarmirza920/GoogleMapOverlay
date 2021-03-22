//
//  PolygonViewController.h
//  Polygon_App
//
//  Created by admin on 11/10/15.
//  Copyright (c) 2015 admin. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PolygonViewController : UIViewController<UITableViewDataSource , UITableViewDelegate , UIAlertViewDelegate>

{
    
    IBOutlet UIView *filterView;
    IBOutlet UIView *promoterView;
    IBOutlet UIButton *btnBackPromoter;
    IBOutlet UIButton *btnBackMap;
    IBOutlet UITableView *tablePromoterView;

    
}
@property(nonatomic , strong) IBOutlet UIImageView *btnFavorites;
@property(nonatomic , strong) IBOutlet UIImageView *btnCrowd;
@property(nonatomic , strong) IBOutlet UIImageView *btnTopPromoter;
@property(nonatomic , strong) IBOutlet UIImageView *btnDistance;
@property (strong, nonatomic) IBOutlet UILabel *lblPolygonName;
@property (strong, nonatomic) IBOutlet UIView *opaqueView;

@property (nonatomic, strong) NSString *strPolygonName;
@property(nonatomic ,strong) NSArray *promoterList;
@property(nonatomic ,strong) NSDictionary *promoterData;

@property(nonatomic, strong) NSString *userlatitude;
@property(nonatomic, strong) NSString *userlongitude;
@property(nonatomic, strong) NSString *DistrictID;

- (IBAction)onbtnBackCilcked:(id)sender;
- (IBAction)onbtnFilterClicked:(id)sender;
- (IBAction)onbtnBackPormoterClicked:(id)sender;
- (IBAction)onbtnFilterItemClicked:(UIButton *)sender;
- (IBAction)onbtnFilterCloseClicked:(id)sender;
- (IBAction)onbtnFilterViewCloseClicked:(id)sender;
- (void) requestBusinessList : (NSString *) sortBy;


@end
