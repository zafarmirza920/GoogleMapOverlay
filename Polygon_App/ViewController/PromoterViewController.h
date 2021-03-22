//
//  PromoterViewController.h
//  Polygon_App
//
//  Created by admin on 11/10/15.
//  Copyright (c) 2015 admin. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface PromoterViewController : UIViewController<UITableViewDataSource,UITableViewDelegate , UIAlertViewDelegate>
{
    
}

@property (nonatomic ,strong) NSDictionary *dataDictionary;

@property (nonatomic ,strong) IBOutlet UIView *photoView;
@property (nonatomic ,strong) IBOutlet UIView *sharedView;
@property (nonatomic ,strong) IBOutlet UIView *calinderView;
@property (nonatomic ,strong) IBOutlet UIView *musicView;
@property (nonatomic ,strong) IBOutlet UIView *groupView;
@property (nonatomic ,strong) IBOutlet UIView *bottomView;

@property (nonatomic ,strong) IBOutlet UILabel *lblBusinessTime;
@property (nonatomic ,strong) IBOutlet UILabel *lblPosition;
@property (nonatomic ,strong) IBOutlet UILabel *lblPromoterName;
@property (strong, nonatomic) IBOutlet UILabel *lblPolygonName;

@property (nonatomic ,strong) IBOutlet UIButton *btnFavorite;
@property (nonatomic ,strong) IBOutlet UIImageView *promoterImageView;

@property (strong, nonatomic) IBOutlet UIView *chartView;
@property (strong, nonatomic) NSString *strPolygonName;
@property (strong, nonatomic) IBOutlet UITableView *tableCommentView;
@property (strong, nonatomic) IBOutlet UIView *setCrowdView;
@property (strong, nonatomic) IBOutlet UIView *crowdLowView;
@property (strong, nonatomic) IBOutlet UIView *crowdMediumView;
@property (strong, nonatomic) IBOutlet UIView *crowdHighView;
@property (strong, nonatomic) IBOutlet UIView *crowdVeryHighView;
@property (nonatomic, strong) NSMutableArray *commentArray;

- (IBAction)btnFavoritClicked:(id)sender;
- (IBAction)onbtnFiveItemClicked:(UIButton *)sender;
- (IBAction)onbtnSetCrowdClicked:(UIButton *)sender;


- (IBAction)onbtnBackClicked:(id)sender;

- (void) bottomViewSetup;
- (void) inviteShow;
- (void) getComment;
@end
