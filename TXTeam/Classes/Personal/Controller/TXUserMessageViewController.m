//
//  TXUserMessageViewController.m
//  TXTeam
//
//  Created by 吖银 on 15-1-18.
//  Copyright (c) 2015年 ayctey. All rights reserved.
//

#import "TXUserMessageViewController.h"
#import "Common.h"
#import "TXReviseNameViewController.h"
#import "TXMessageAuthenticationController.h"
#import "TXDataService.h"
@interface TXUserMessageViewController ()

@end

@implementation TXUserMessageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"用户资料";
    self.view.backgroundColor = kBackgroundColor;
    // [self initMainview];
    [self initTableview];
    
}
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:YES];
    //添加通知
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(modifyName:) name:@"name" object:nil];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(modifyTel:) name:@"tel" object:nil];
}
-(void)initTableview{
    
    dataArray = @[@"账号：",@"姓名:",@"性别:",@"绑定电话:",@"密码"];
    _tableview = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, (dataArray.count+2)*44) style:UITableViewStylePlain];
    _tableview.separatorStyle =UITableViewCellSeparatorStyleSingleLine;
    _tableview.separatorColor = [UIColor grayColor];
     _tableview.backgroundColor = kBackgroundColor;
    _tableview.dataSource = self;
    _tableview.delegate = self;
    _tableview.bounces = NO;
    [self. view addSubview:_tableview];
}

- (void)getUserDefaultData:(UITableViewCell *)cell indexPath:(NSIndexPath *)indepath
{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSArray *key = @[@"tel",@"name",@"sex",@"tel",@"nil"];
    cell.detailTextLabel.text = [defaults objectForKey:key[indepath.row]];
}

- (UITableViewCell *)cellForRow:(NSInteger)row
{
    return [_tableview cellForRowAtIndexPath:[NSIndexPath indexPathForRow:row inSection:0]];
}

-(void)reviseSex {
    UIActionSheet *revisesex = [[UIActionSheet alloc]initWithTitle:@"性别" delegate:self cancelButtonTitle:nil destructiveButtonTitle:@"男" otherButtonTitles:@"女", nil];
    [revisesex showInView:self.view];
}

#pragma mark - 通知 方法
-(void)modifyName:(NSNotification *)notification{
    
    UITableViewCell *cell = [_tableview cellForRowAtIndexPath:[NSIndexPath indexPathForRow:1 inSection:0]];
    cell.detailTextLabel.text = notification.object;
}

-(void)modifyTel:(NSNotification *)notification{
    UITableViewCell *cell = [_tableview cellForRowAtIndexPath:[NSIndexPath indexPathForRow:3 inSection:0]];
    cell.detailTextLabel.text = notification.object;
    UITableViewCell *cell2 = [_tableview cellForRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0]];
    cell2.detailTextLabel.text = notification.object;
    
}

#pragma mark - UIActionSheet delegate
- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex{
 
    if (buttonIndex ==0) {
        sex = @"男";
    }
    else{
    sex = @"女";
    }
     NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    if (![[defaults objectForKey:@"sex"] isEqualToString:sex]) {
        //请求修改性别
        [self reviseData_Sex:sex];
    }
}

#pragma mark -- 加载数据
-(void)reviseData_Sex:(NSString *)_sex{

    [MMProgressHUD showWithStatus:@"修改中..."];
    
    NSDictionary *param = @{@"sex":_sex};
    [TXDataService POST:updateSex param:param isCache:NO caChetime:0 completionBlock:^(id responseObject, NSError *error) {
            MyLog(@"$%@",responseObject);
        if (error) {
            [MMProgressHUD dismissWithError:@"修改失败"];
            return ;
        }
        
        if ([[responseObject objectForKey:@"success"]  isEqual: @(1)]) {

            NSLog(@"Revise Sex success: %@",[responseObject objectForKey:@"success"]);
            NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
            [defaults setValue:sex forKey:@"sex"];
            UITableViewCell *cell = [_tableview cellForRowAtIndexPath:[NSIndexPath indexPathForRow:2 inSection:0]];
            cell.detailTextLabel.text =sex;
        }
        [MMProgressHUD dismiss];
    }];
}

#pragma  mark - UItableview datasource and delegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return dataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{

    static NSString *cellidentifier = @"cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellidentifier];
    if (cell ==nil) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:cellidentifier];
    }
    if (indexPath.row !=0 && indexPath.row !=3) {
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }

    cell.textLabel.text = dataArray[indexPath.row];
    [self getUserDefaultData:cell indexPath:indexPath];
    cell.backgroundColor = kBackgroundColor;
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 44;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    //修改姓名控制器
    TXReviseNameViewController *revisename = [[TXReviseNameViewController alloc]init];
    //短信验证控制器
    TXMessageAuthenticationController *messageau = [[TXMessageAuthenticationController alloc]init];
    messageau.isLogin = YES;
    
    //获取用户手机号码
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSString *phone_num = [defaults objectForKey:@"tel"];
  //  NSLog(@"拿到:%@",phone_num);
    switch (indexPath.row) {
        case 1:
            [revisename getname:cell.detailTextLabel.text];
            [self.navigationController pushViewController:revisename animated:YES];
            break;
        case 2:
            [self reviseSex];
            break;

           case 4:
            [messageau getUserPhonenums:phone_num];
        [messageau pushTo:VCChangePasswordController];
            [self.navigationController pushViewController:messageau animated:YES];
            break;
        default:
            break;
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
