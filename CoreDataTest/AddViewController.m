//
//  AddViewController.m
//  CoreDataTest
//
//  Created by zhanglei on 15/10/8.
//  Copyright © 2015年 lei.zhang. All rights reserved.
//

#import "AddViewController.h"
#import <CoreData/CoreData.h>
#import "Person.h"
#import "Card.h"
@interface AddViewController ()
{
    UITextField * utfName;
    UITextField * utfGender;
    UITextField * utfAge;
    UITextField * utfNo;
    UIButton * btnSave;
}
@end

@implementation AddViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view setBackgroundColor:[UIColor whiteColor]];
    // Do any additional setup after loading the view.
    
    utfName = [[UITextField alloc] initWithFrame:CGRectMake(0, 100, 200, 30)];
    utfName.font = [UIFont systemFontOfSize:18];
    [utfName setBackgroundColor:[UIColor redColor]];
    utfName.placeholder = @"姓名";
    [self.view addSubview:utfName];
    
    utfGender = [[UITextField alloc] initWithFrame:CGRectMake(0, 150, 200, 30)];
    utfGender.font = [UIFont systemFontOfSize:18];
    [utfGender setBackgroundColor:[UIColor redColor]];
    utfGender.placeholder = @"性别";
    [self.view addSubview:utfGender];
    
    utfAge = [[UITextField alloc] initWithFrame:CGRectMake(0, 200, 200, 30)];
    utfAge.font = [UIFont systemFontOfSize:18];
    [utfAge setBackgroundColor:[UIColor redColor]];
    utfAge.placeholder = @"年龄";
    [self.view addSubview:utfAge];
    
    utfNo = [[UITextField alloc] initWithFrame:CGRectMake(0, 250, 200, 30)];
    utfNo.font = [UIFont systemFontOfSize:18];
    [utfNo setBackgroundColor:[UIColor redColor]];
    utfNo.placeholder = @"身份证号";
    [self.view addSubview:utfNo];
    
    btnSave = [[UIButton alloc] initWithFrame:CGRectMake(0, 300, 200, 30)];
    [btnSave setBackgroundColor:[UIColor redColor]];
    [btnSave setTitle:@"保存" forState:UIControlStateNormal];
    [btnSave addTarget:self action:@selector(savePerson:) forControlEvents:UIControlEventTouchUpInside];
    [btnSave.titleLabel setFont:[UIFont systemFontOfSize:18]];
    [self.view addSubview:btnSave];
}

-(void)savePerson:(id)sender{
    Person * person = [NSEntityDescription insertNewObjectForEntityForName:@"Person" inManagedObjectContext:self.con];
    person.name = utfName.text;
    person.age = [NSNumber numberWithInt:[utfAge.text intValue]];
    person.gender = [NSNumber numberWithInt:[utfGender.text intValue]];
    
    Card * card = [NSEntityDescription insertNewObjectForEntityForName:@"Card" inManagedObjectContext:self.con];
    card.no = utfNo.text;
    person.card = card;
    card.person = person;
    
    NSError *error = nil;
   BOOL success = [self.con save:&error];
    if (!success) {
        [NSException raise:@"访问数据库错误" format:@"%@", [error localizedDescription]];
    }else{
        [self dismissViewControllerAnimated:YES completion:^{
            
        }];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
