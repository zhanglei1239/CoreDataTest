//
//  DetailsViewController.h
//  CoreDataTest
//
//  Created by zhanglei on 15/10/8.
//  Copyright © 2015年 lei.zhang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Person.h"
@interface DetailsViewController : UIViewController
@property (nonatomic,strong) NSManagedObjectContext * con;
@property (nonatomic,strong) Person * p;
@end
