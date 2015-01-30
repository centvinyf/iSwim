//
//  PersonInfoVC.m
//  iSwim
//
//  Created by MagicBeans2 on 15/1/26.
//  Copyright (c) 2015年 Magic Beans. All rights reserved.
//

#import "PersonInfoVC.h"

@interface PersonInfoVC ()<UITableViewDataSource,UITableViewDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate>
{
    
    __weak IBOutlet UITableView *_table;
    NSArray*_titleArray;
}
@property (weak, nonatomic) IBOutlet UIButton *sureBtn;
@property (strong,nonatomic)UIImageView*headerImageView;
@end

@implementation PersonInfoVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    _sureBtn.layer.masksToBounds=YES;
    _sureBtn.layer.cornerRadius=10;
    _sureBtn.layer.borderWidth=2;
    _sureBtn.layer.borderColor=[[UIColor orangeColor]CGColor];
    _titleArray=@[@[@"头像",@"姓名"],@[@"性别",@"身高",@"体重"],@[@"邮箱",@"所属场馆"],@[@"使用训练计划"],@[@"修改密码"]];

//    UIView*view=[[UIView alloc]initWithFrame:CGRectMake(0, 0, 1, 1)];
//    view.backgroundColor=[UIColor clearColor];
//    _table.tableHeaderView=view;
    
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section==0) {
        return 2;
    }
    else if (section==1){
        return 3;
    }
    else if (section==2){
        return 2;
    }
    else{
        return 1;
    }
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 5;
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 5;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section==0&&indexPath.row==0) {
        return 100;
    }
    return 44;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell*cell;
    if (indexPath.section==0&&indexPath.row==0) {
        cell=[_table dequeueReusableCellWithIdentifier:@"headerCell"];
        if (!cell) {
            cell=[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"headerCell"];
        }
    }
    else{
        cell=[_table dequeueReusableCellWithIdentifier:@"cell"];
        if (!cell) {
            cell=[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"cell"];
        }
    }
    cell.selectionStyle=UITableViewCellSelectionStyleNone;
    if (indexPath.section==0||indexPath.section==2||(indexPath.section==1&&indexPath.row==1)||(indexPath.section==4&&indexPath.row==0)) {
        cell.accessoryType=UITableViewCellAccessoryDisclosureIndicator;
    }

    if(indexPath.section==3){
        UISwitch*swt=[[UISwitch alloc]init];
        cell.accessoryView=swt;
    }
    
    else if (indexPath.section==0&&indexPath.row==0) {
        _headerImageView=[[UIImageView alloc]initWithFrame:CGRectMake(0, 10, 80, 80)];
        _headerImageView.backgroundColor=[UIColor cyanColor];
        _headerImageView.layer.masksToBounds=YES;
        _headerImageView.layer.cornerRadius=40;
        cell.accessoryView=_headerImageView;
    }
#warning line
    if (indexPath.section==1){
        
    }
    cell.textLabel.text=[[_titleArray objectAtIndex:indexPath.section] objectAtIndex:indexPath.row];
    
    NSMutableDictionary*dic=[NSMutableDictionary dictionaryWithDictionary:[[NSUserDefaults standardUserDefaults]objectForKey:@"personInfoDic"]];
    
    if (indexPath.section==0&&indexPath.row==1) {
        cell.detailTextLabel.text=[dic objectForKey:@"name"];
    }else if (indexPath.section==1&&indexPath.row==0){
        cell.detailTextLabel.text=[[dic objectForKey:@"sex"]boolValue]?@"女":@"男";
    }else if (indexPath.section==1&&indexPath.row==1){
        cell.detailTextLabel.text=[dic objectForKey:@"height"];
    }else if (indexPath.section==1&&indexPath.row==2){
        cell.detailTextLabel.text=[dic objectForKey:@"weight"];
    }else if (indexPath.section==2&&indexPath.row==0){
        cell.detailTextLabel.text=[dic objectForKey:@"email"];
    }else if (indexPath.section==2&&indexPath.row==1){
        cell.detailTextLabel.text=[dic objectForKey:@"venue"];
    }
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (0==indexPath.section&&0==indexPath.row) {
       [self performSegueWithIdentifier:@"CropImageViewController" sender:nil];
//        [self changeHeadImage];
    }else if (0==indexPath.section&&1==indexPath.row){
        [self performSegueWithIdentifier:@"changeNameVC" sender:nil];
    }else if (1==indexPath.section){
        [self performSegueWithIdentifier:@"changeInfoVC" sender:nil];
    }else if (2==indexPath.section&&0==indexPath.row){
        [self performSegueWithIdentifier:@"changeEmailVC" sender:nil];
    }else if (2==indexPath.section&&1==indexPath.row){
        [self performSegueWithIdentifier:@"changeVenueVC" sender:nil];
    }else if (4==indexPath.section){
        [self performSegueWithIdentifier:@"changePasswordVC" sender:nil];
    }
}
#pragma mark image

- (void)changeHeadImage{
    
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        UIImagePickerController *picker = [[UIImagePickerController alloc] init];
        picker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
        picker.allowsEditing = YES;
        picker.delegate = self;
        [self presentViewController:picker animated:YES completion:nil];
        
        //[[UIApplication sharedApplication] setStatusBarStyle:0];
    });
}
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingImage:(UIImage *)image editingInfo:(NSDictionary *)editingInfo{
    
    dispatch_async(dispatch_get_main_queue(), ^{
        _headerImageView.image = image;
        [self dismissViewControllerAnimated:YES completion:nil];
        //[[UIApplication sharedApplication] setStatusBarStyle:1];
    });
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
