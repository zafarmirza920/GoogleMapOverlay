//
//  CommenterTableViewCell.h
//  Polygon_App
//
//  Created by admin on 12/12/15.
//  Copyright © 2015 admin. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CommenterTableViewCell : UITableViewCell

@property (strong, nonatomic) IBOutlet UILabel *lblUserName;
@property (strong, nonatomic) IBOutlet UILabel *lblCommentTime;
@property (strong, nonatomic) IBOutlet UILabel *lblDistance;
@property (strong, nonatomic) IBOutlet UIImageView *imgCommenterView;
@property (strong, nonatomic) IBOutlet UIView *commenterView;
@property (strong, nonatomic) IBOutlet UIView *commentView;

@end
