//
//  ViewController.m
//  CoreDataTest
//
//  Created by zhanglei on 15/10/8.
//  Copyright © 2015年 lei.zhang. All rights reserved.
//
#define ScreenWitdh [UIScreen mainScreen].bounds.size.width
#define ScreenHeight [UIScreen mainScreen].bounds.size.height

#import "ViewController.h"
#import <CoreData/CoreData.h>
#import "AddViewController.h"
#import "Person+CoreDataProperties.h"
#import "DetailsViewController.h"
#import "DataSourceCell.h"
@interface ViewController ()
{
    NSManagedObjectContext *context;
    UITableView * list;
    NSMutableArray * dataArray;
    BOOL delete;
    BOOL change;
}
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    delete = NO;
    change = NO;
    dataArray = [NSMutableArray array];
    
    UIButton * btnAdd = [[UIButton alloc] initWithFrame:CGRectMake(0, 40, ScreenWitdh, 40)];
    [self.view addSubview:btnAdd];
    [btnAdd.titleLabel setFont:[UIFont systemFontOfSize:20]];
    [btnAdd addTarget:self action:@selector(showAdd:) forControlEvents:UIControlEventTouchUpInside];
    [btnAdd setBackgroundColor:[UIColor redColor]];
    [btnAdd setTitle:@"增" forState:UIControlStateNormal];
    
    UIButton * btnDelete = [[UIButton alloc] initWithFrame:CGRectMake(0, 80, ScreenWitdh, 40)];
    [self.view addSubview:btnDelete];
    [btnDelete.titleLabel setFont:[UIFont systemFontOfSize:20]];
    [btnDelete addTarget:self action:@selector(showDelete:) forControlEvents:UIControlEventTouchUpInside];
    [btnDelete setBackgroundColor:[UIColor grayColor]];
    [btnDelete setTitle:@"删" forState:UIControlStateNormal];
    
    UIButton * btnChange = [[UIButton alloc] initWithFrame:CGRectMake(0, 120, ScreenWitdh, 40)];
    [self.view addSubview:btnChange];
    [btnChange.titleLabel setFont:[UIFont systemFontOfSize:20]];
    [btnChange addTarget:self action:@selector(showChange:) forControlEvents:UIControlEventTouchUpInside];
    [btnChange setBackgroundColor:[UIColor blueColor]];
    [btnChange setTitle:@"改" forState:UIControlStateNormal];
    
    UIButton * btnSelect = [[UIButton alloc] initWithFrame:CGRectMake(0, 160, ScreenWitdh, 40)];
    [self.view addSubview:btnSelect];
    [btnSelect.titleLabel setFont:[UIFont systemFontOfSize:20]];
    [btnSelect addTarget:self action:@selector(showSelect:) forControlEvents:UIControlEventTouchUpInside];
    [btnSelect setBackgroundColor:[UIColor blackColor]];
    [btnSelect setTitle:@"查" forState:UIControlStateNormal];
    
    list = [[UITableView alloc] initWithFrame:CGRectMake(0, 250, ScreenWitdh, [UIScreen mainScreen].bounds.size.height-250)];
    [self.view addSubview:list];
    list.separatorStyle = UITableViewCellSeparatorStyleNone;
    [list setBackgroundColor:[UIColor yellowColor]];
    list.delegate = self;
    list.dataSource = self;
    
    // 从应用程序包中加载模型文件
    NSManagedObjectModel *model = [NSManagedObjectModel mergedModelFromBundles:nil];
    // 传入模型对象，初始化NSPersistentStoreCoordinator
    NSPersistentStoreCoordinator *psc = [[NSPersistentStoreCoordinator alloc] initWithManagedObjectModel:model];
    // 构建SQLite数据库文件的路径
    NSString *docs = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
    NSURL *url = [NSURL fileURLWithPath:[docs stringByAppendingPathComponent:@"person.data"]];
    // 添加持久化存储库，这里使用SQLite作为存储库
    NSError *error = nil;
    NSPersistentStore *store = [psc addPersistentStoreWithType:NSSQLiteStoreType configuration:nil URL:url options:nil error:&error];
    if (store == nil) { // 直接抛异常
        [NSException raise:@"添加数据库错误" format:@"%@", [error localizedDescription]];
    }
    // 初始化上下文，设置persistentStoreCoordinator属性
    context = [[NSManagedObjectContext alloc] initWithConcurrencyType:NSPrivateQueueConcurrencyType];
    context.persistentStoreCoordinator = psc;
    // 用完之后，记得要[context release];
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self showSelect:nil];
}

-(void)showAdd:(id)sender{
    AddViewController * add = [[AddViewController alloc] init];
    add.con = context;
    [self presentViewController:add animated:NO completion:^{
        
    }];
}

-(void)showDelete:(id)sender{
    delete = YES;
    change = NO;
    [list reloadData];
}

-(void)showChange:(id)sender{
    change = YES;
    delete = NO;
    [list reloadData];
}

-(void)showSelect:(id)sender{
    NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:@"Person"];
    dataArray = [NSMutableArray arrayWithArray:[context executeFetchRequest:request error:nil]];
    [list reloadData];
}

#pragma mark table view data source and delegate

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [dataArray count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    Person * p = [dataArray objectAtIndex:indexPath.row];
    DataSourceCell * cell = [tableView dequeueReusableCellWithIdentifier:[NSString stringWithFormat:@"dsCell%ld",indexPath.row]];
    if (cell == nil) {
        cell = [[DataSourceCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:[NSString stringWithFormat:@"dsCell%ld",indexPath.row]];
        [cell setBackgroundColor:[UIColor clearColor]];
    }else{
        if (cell.lblName) {
            [cell.lblName removeFromSuperview];
        }
        if (cell.lblAge) {
            [cell.lblAge removeFromSuperview];
        }
        if (cell.lblGender) {
            [cell.lblGender removeFromSuperview];
        }
        if (cell.btnDelete) {
            [cell.btnDelete removeFromSuperview];
        }
        if (cell.btnChange) {
            [cell.btnChange removeFromSuperview];
        }
    }
    cell.lblName = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, tableView.frame.size.width/4, 40)];
    [cell.lblName setTextColor:[UIColor blackColor]];
    [cell.lblName setTextAlignment:NSTextAlignmentCenter];
    [cell.lblName setFont:[UIFont systemFontOfSize:18]];
    [cell addSubview:cell.lblName];
    
    cell.lblAge = [[UILabel alloc] initWithFrame:CGRectMake(tableView.frame.size.width/4, 0, tableView.frame.size.width/4, 40)];
    [cell.lblAge setTextColor:[UIColor blackColor]];
    [cell.lblAge setTextAlignment:NSTextAlignmentCenter];
    [cell.lblAge setFont:[UIFont systemFontOfSize:18]];
    [cell addSubview:cell.lblAge];
    
    cell.lblGender = [[UILabel alloc] initWithFrame:CGRectMake(tableView.frame.size.width/4*2, 0, tableView.frame.size.width/4, 40)];
    [cell.lblGender setTextColor:[UIColor blackColor]];
    [cell.lblGender setTextAlignment:NSTextAlignmentCenter];
    [cell.lblGender setFont:[UIFont systemFontOfSize:18]];
    [cell addSubview:cell.lblGender];
    
    cell.btnDelete = [[UIButton alloc] initWithFrame:CGRectMake(tableView.frame.size.width/4*3, 0, tableView.frame.size.width/4, 40)];
    [cell.btnDelete setTitle:@"删除" forState:UIControlStateNormal];
    [cell.btnDelete setTag:indexPath.row];
    [cell.btnDelete setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    [cell.btnDelete.titleLabel setFont:[UIFont systemFontOfSize:18]];
    [cell.btnDelete addTarget:self action:@selector(deleteBySender:) forControlEvents:UIControlEventTouchUpInside];
    [cell addSubview:cell.btnDelete];
    
    cell.btnChange = [[UIButton alloc] initWithFrame:CGRectMake(tableView.frame.size.width/4*3, 0, tableView.frame.size.width/4, 40)];
    [cell.btnChange setTitle:@"修改" forState:UIControlStateNormal];
    [cell.btnChange setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    [cell.btnChange.titleLabel setFont:[UIFont systemFontOfSize:18]];
    [cell.btnChange setTag:indexPath.row];
    [cell.btnChange addTarget:self action:@selector(changeBySender:) forControlEvents:UIControlEventTouchUpInside];
    [cell addSubview:cell.btnChange];
    [cell.btnDelete setHidden:YES];
    [cell.btnChange setHidden:YES];
    if (indexPath.row == 0) {
        [cell.lblName setText:@"姓名"];
        [cell.lblAge setText:@"年龄"];
        [cell.lblGender setText:@"性别"];
    }else{
        [cell.lblName setText:p.name];
        [cell.lblAge setText:[NSString stringWithFormat:@"%@",p.age]];
        [cell.lblGender setText:[NSString stringWithFormat:@"%@",p.gender]];
        if (delete) {
            [cell.btnDelete setHidden:NO];
        }else{
            [cell.btnDelete setHidden:YES];
        }
        
        if (change) {
            [cell.btnChange setHidden:NO];
        }else{
            [cell.btnChange setHidden:YES];
        }
    }
    
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)sectionIndex
{
    return nil;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)sectionIndex
{
    return 0;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 40;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row == 0) {
        return;
    }
    [self change:indexPath.row];
}

-(void)changeBySender:(id)sender{
    UIButton * btn = (UIButton *)sender;
    [self change:btn.tag];
}

-(void)deleteBySender:(id)sender{
    UIButton * btn = (UIButton *)sender;
    Person * p = [dataArray objectAtIndex:btn.tag];
    
    [context deleteObject:p];
    NSError *error = nil;
    BOOL success = [context save:&error];
    if (!success) {
        [NSException raise:@"访问数据库错误" format:@"%@", [error localizedDescription]];
    }else{
        [dataArray removeObject:p];
        [list reloadData];
    }
}

-(void)change:(NSInteger)tag{
    //点击进入详情页 可删可改
    Person * p = [dataArray objectAtIndex:tag];
    DetailsViewController * detail = [[DetailsViewController alloc] init];
    detail.p = p;
    detail.con = context;
    [self presentViewController:detail animated:NO completion:^{
        
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
