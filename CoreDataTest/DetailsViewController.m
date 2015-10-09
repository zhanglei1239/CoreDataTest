//
//  DetailsViewController.m
//  CoreDataTest
//
//  Created by zhanglei on 15/10/8.
//  Copyright © 2015年 lei.zhang. All rights reserved.
//

#import "DetailsViewController.h"
#import "Person+CoreDataProperties.h"
#import "Person.h"
#import "Card+CoreDataProperties.h"
#import "Card.h"
@interface DetailsViewController ()
{
    UITextField * utfName;
    UITextField * utfGender;
    UITextField * utfAge;
    UITextField * utfNo;
    UIButton * btnSave;
    UIButton * btnDelete;
}
@end

@implementation DetailsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self.view setBackgroundColor:[UIColor whiteColor]];
    
    utfName = [[UITextField alloc] initWithFrame:CGRectMake(0, 100, 200, 30)];
    utfName.font = [UIFont systemFontOfSize:18];
    [utfName setBackgroundColor:[UIColor redColor]];
    utfName.placeholder = @"姓名";
    utfName.text = self.p.name;
    [self.view addSubview:utfName];
    
    utfGender = [[UITextField alloc] initWithFrame:CGRectMake(0, 150, 200, 30)];
    utfGender.font = [UIFont systemFontOfSize:18];
    [utfGender setBackgroundColor:[UIColor redColor]];
    utfGender.placeholder = @"性别";
    utfGender.text = [NSString stringWithFormat:@"%@",self.p.gender];
    [self.view addSubview:utfGender];
    
    utfAge = [[UITextField alloc] initWithFrame:CGRectMake(0, 200, 200, 30)];
    utfAge.font = [UIFont systemFontOfSize:18];
    [utfAge setBackgroundColor:[UIColor redColor]];
    utfAge.placeholder = @"年龄";
    utfAge.text = [NSString stringWithFormat:@"%@",self.p.age];
    [self.view addSubview:utfAge];
    
    utfNo = [[UITextField alloc] initWithFrame:CGRectMake(0, 250, 200, 30)];
    utfNo.font = [UIFont systemFontOfSize:18];
    [utfNo setBackgroundColor:[UIColor redColor]];
    utfNo.text = [NSString stringWithFormat:@"%@",self.p.card.no];
    utfNo.placeholder = @"身份证号";
    [self.view addSubview:utfNo];
    
    btnSave = [[UIButton alloc] initWithFrame:CGRectMake(0, 300, 200, 30)];
    [btnSave setBackgroundColor:[UIColor redColor]];
    [btnSave setTitle:@"修改" forState:UIControlStateNormal];
    [btnSave addTarget:self action:@selector(savePerson:) forControlEvents:UIControlEventTouchUpInside];
    [btnSave.titleLabel setFont:[UIFont systemFontOfSize:18]];
    [self.view addSubview:btnSave];
    
    btnDelete = [[UIButton alloc] initWithFrame:CGRectMake(0, 350, 200, 30)];
    [btnDelete setBackgroundColor:[UIColor redColor]];
    [btnDelete setTitle:@"删除" forState:UIControlStateNormal];
    [btnDelete addTarget:self action:@selector(deletePerson:) forControlEvents:UIControlEventTouchUpInside];
    [btnDelete.titleLabel setFont:[UIFont systemFontOfSize:18]];
    [self.view addSubview:btnDelete];
}

-(void)savePerson:(id)sender{
    
    self.p.name = utfName.text;
    self.p.age = [NSNumber numberWithInt:[utfAge.text intValue]];
    self.p.gender = [NSNumber numberWithInt:[utfGender.text intValue]];
    self.p.card.no = utfNo.text;
    NSError *error = nil;
    BOOL success = [self.con save:&error];
    if (!success) {
        [NSException raise:@"访问数据库错误" format:@"%@", [error localizedDescription]];
    }else{
        [self dismissViewControllerAnimated:NO completion:^{
            
        }];
    }
}

-(void)deletePerson:(id)sender{
    [self.con deleteObject:self.p];
    NSError *error = nil;
    BOOL success = [self.con save:&error];
    if (!success) {
        [NSException raise:@"访问数据库错误" format:@"%@", [error localizedDescription]];
    }else{
        [self dismissViewControllerAnimated:NO completion:^{
            
        }];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
