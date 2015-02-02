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
    
    __weak IBOutlet UITableView                     *_mTable;
    NSArray                                         *_mTitleArray;
}
@property (weak, nonatomic) IBOutlet UIView         *mCoverView;
@property (weak, nonatomic) IBOutlet UIButton       *mSureBtn;
@property (strong,nonatomic)UIImageView             *mHeaderImageView;
@property (weak, nonatomic) IBOutlet UIButton       *mPhotographBtn;
@property (weak, nonatomic) IBOutlet UIButton       *mPhotoAlbumBtn;
@property (weak, nonatomic) IBOutlet UIButton       *mPhotoCancelBtn;

@end

@implementation PersonInfoVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    _mSureBtn.layer.masksToBounds=YES;
    _mSureBtn.layer.cornerRadius=10;
    _mSureBtn.layer.borderWidth=2;
    _mSureBtn.layer.borderColor=[[UIColor orangeColor]CGColor];
    
    _mPhotographBtn.layer.masksToBounds=YES;
    _mPhotographBtn.layer.cornerRadius=10;
    _mPhotographBtn.layer.borderWidth=1;
    _mPhotographBtn.layer.borderColor=[[UIColor colorWithRed:0x1d/255.0 green:0x7e/255.0 blue:0x9f/255.0 alpha:1] CGColor];
    
    _mPhotoAlbumBtn.layer.masksToBounds=YES;
    _mPhotoAlbumBtn.layer.cornerRadius=10;
    _mPhotoAlbumBtn.layer.borderWidth=1;
    _mPhotoAlbumBtn.layer.borderColor=[[UIColor colorWithRed:0x1d/255.0 green:0x7e/255.0 blue:0x9f/255.0 alpha:1] CGColor];
    
    _mPhotoCancelBtn.layer.masksToBounds=YES;
    _mPhotoCancelBtn.layer.cornerRadius=10;
    _mPhotoCancelBtn.layer.borderWidth=1;
    _mPhotoCancelBtn.layer.borderColor=[[UIColor colorWithRed:0xb9/255.0 green:0x74/255.0 blue:0x19/255.0 alpha:1] CGColor];

    
    UITapGestureRecognizer *vTapGestureRecognizer = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(handlePan:)];
    [_mCoverView addGestureRecognizer:vTapGestureRecognizer];
    _mTitleArray=@[@[@"头像",@"姓名"],@[@"性别",@"身高",@"体重"],@[@"邮箱",@"所属场馆"],@[@"使用训练计划"],@[@"修改密码"]];
    
    _mHeaderImageView=[[UIImageView alloc]initWithFrame:CGRectMake(0, 10, 80, 80)];
    _mHeaderImageView.backgroundColor=[UIColor cyanColor];
    _mHeaderImageView.layer.masksToBounds=YES;
    _mHeaderImageView.layer.cornerRadius=40;
}
-(void)handlePan:(UIPanGestureRecognizer*)pan
{
    _mCoverView.hidden=YES;
}
- (IBAction)coverBtnClick:(UIButton *)sender
{
    if (sender.tag==1)
    {
        //[self performSegueWithIdentifier:@"CropImageViewController" sender:nil];
        [self changeHeadImage:1];
    }
    else if (sender.tag==2)
    {
        [self changeHeadImage:2];
    }
    else if (sender.tag==3)
    {
        _mCoverView.hidden=YES;
    }
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section==0)
    {
        return 2;
    }
    else if (section==1)
    {
        return 3;
    }
    else if (section==2)
    {
        return 2;
    }
    else
    {
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
    if (indexPath.section==0&&indexPath.row==0)
    {
        return 100;
    }
    return 44;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell*cell;
    if (indexPath.section==0&&indexPath.row==0)
    {
        cell=[tableView dequeueReusableCellWithIdentifier:@"headerCell"];
        if (!cell)
        {
            cell=[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"headerCell"];
        }
    }
    else{
        cell=[tableView dequeueReusableCellWithIdentifier:@"cell"];
        if (!cell)
        {
            cell=[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"cell"];
        }
    }
    cell.selectionStyle=UITableViewCellSelectionStyleNone;
    if (indexPath.section==0||indexPath.section==2||(indexPath.section==1&&indexPath.row==1)||(indexPath.section==4&&indexPath.row==0))
    {
        cell.accessoryType=UITableViewCellAccessoryDisclosureIndicator;
    }

    if(indexPath.section==3)
    {
        UISwitch*swt=[[UISwitch alloc]init];
        cell.accessoryView=swt;
    }
    
    else if (indexPath.section==0&&indexPath.row==0)
    {
        cell.accessoryView=_mHeaderImageView;
    }
#warning line
    if (indexPath.section==1)
    {
        
    }
    cell.textLabel.text=[[_mTitleArray objectAtIndex:indexPath.section] objectAtIndex:indexPath.row];
    
    NSMutableDictionary*dic=[NSMutableDictionary dictionaryWithDictionary:[[NSUserDefaults standardUserDefaults]objectForKey:@"personInfoDic"]];
    
    if (indexPath.section==0&&indexPath.row==1)
    {
        cell.detailTextLabel.text=[dic objectForKey:@"name"];
    }
    else if (indexPath.section==1&&indexPath.row==0)
    {
        cell.detailTextLabel.text=[[dic objectForKey:@"sex"]boolValue]?@"女":@"男";
    }
    else if (indexPath.section==1&&indexPath.row==1)
    {
        cell.detailTextLabel.text=[dic objectForKey:@"height"];
    }
    else if (indexPath.section==1&&indexPath.row==2)
    {
        cell.detailTextLabel.text=[dic objectForKey:@"weight"];
    }
    else if (indexPath.section==2&&indexPath.row==0)
    {
        cell.detailTextLabel.text=[dic objectForKey:@"email"];
    }
    else if (indexPath.section==2&&indexPath.row==1)
    {
        cell.detailTextLabel.text=[dic objectForKey:@"venue"];
    }
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (0==indexPath.section&&0==indexPath.row)
    {
        _mCoverView.hidden=NO;
    }
    else if (0==indexPath.section&&1==indexPath.row)
    {
        [self performSegueWithIdentifier:@"changeNameVC" sender:nil];
    }
    else if (1==indexPath.section)
    {
        [self performSegueWithIdentifier:@"changeInfoVC" sender:nil];
    }
    else if (2==indexPath.section&&0==indexPath.row)
    {
        [self performSegueWithIdentifier:@"changeEmailVC" sender:nil];
    }
    else if (2==indexPath.section&&1==indexPath.row)
    {
        [self performSegueWithIdentifier:@"changeVenueVC" sender:nil];
    }
    else if (4==indexPath.section)
    {
        [self performSegueWithIdentifier:@"changePasswordVC" sender:nil];
    }
}
#pragma mark image

- (void)changeHeadImage:(int)index
{
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        UIImagePickerController *vPicker = [[UIImagePickerController alloc] init];
        if (index==1)
        {
            vPicker.sourceType = UIImagePickerControllerSourceTypeCamera;
        }
        else if (index==2)
        {
            vPicker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
        }
        vPicker.allowsEditing = YES;
        vPicker.delegate = self;
        [self presentViewController:vPicker animated:YES completion:nil];
        
        //[[UIApplication sharedApplication] setStatusBarStyle:0];
    });
}
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingImage:(UIImage *)image editingInfo:(NSDictionary *)editingInfo{
    
    dispatch_async(dispatch_get_main_queue(), ^{
        _mHeaderImageView.image = image;
        _mCoverView.hidden=YES;
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
