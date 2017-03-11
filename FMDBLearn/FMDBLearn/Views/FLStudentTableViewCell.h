//
//  FLStudentTableViewCell.h
//  FMDBLearn
//
//  Created by Metallic  on 17/3/11.
//  Copyright © 2017年 xiaowei. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FLStudentTableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *uidLabel;

@property (weak, nonatomic) IBOutlet UILabel *nameLabel;

@property (weak, nonatomic) IBOutlet UILabel *genderLabel;

@property (weak, nonatomic) IBOutlet UILabel *ageLabel;

@end
