//
//  DataSourceCell.h
//  CoreDataTest
//
//  Created by zhanglei on 15/10/9.
//  Copyright © 2015年 lei.zhang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DataSourceCell : UITableViewCell
@property (nonatomic,strong) UILabel * lblName;
@property (nonatomic,strong) UILabel * lblAge;
@property (nonatomic,strong) UILabel * lblGender;
@property (nonatomic,strong) UIButton * btnDelete;
@property (nonatomic,strong) UIButton * btnChange;
@end
