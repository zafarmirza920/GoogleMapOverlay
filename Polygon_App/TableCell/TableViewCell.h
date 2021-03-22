//
//  TableViewCell.h
//  Polygon_App
//
//  Created by admin on 11/11/15.
//  Copyright (c) 2015 admin. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TableViewCell : UITableViewCell


@property (weak, nonatomic) IBOutlet UIView *sharedView;
@property (weak, nonatomic) IBOutlet UIView *groupView;
@property (weak, nonatomic) IBOutlet UIView *favoriteView;
@property (weak, nonatomic) IBOutlet UIView *bottomView;
@property (strong, nonatomic) IBOutlet UIView *backgrdGroupView;
@property (strong, nonatomic) IBOutlet UIView *grouprateView;
@property (weak, nonatomic) IBOutlet UILabel *lblPromoterName;
@property (weak, nonatomic) IBOutlet UIImageView *imagePromoterView;
@property (weak, nonatomic) IBOutlet UIButton *btnFavorit;
@property (weak, nonatomic) IBOutlet UIButton *btnCategory;
@property (weak, nonatomic) IBOutlet UIButton *btnShared;

@end
