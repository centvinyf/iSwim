//
//  PersonInfoVC.m
//  iSwim
//
//  Created by MagicBeans2 on 15/1/26.
//  Copyright (c) 2015年 Magic Beans. All rights reserved.
//

#import "PersonInfoVC.h"
#import "Header.h"
#import "ChangeWeightAndHeightVC.h"
#import "ChangeNameVC.h"
#import "ChangeEmailVC.h"
#import "PersonInfoBaseClass.h"
#import "UIImageView+AFNetworking.h"
@interface PersonInfoVC ()<UITableViewDataSource,UITableViewDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate>
{
    
    __weak IBOutlet UITableView                     *_mTable;
    NSArray                                         *_mTitleArray;
    PersonInfoBaseClass                             *_mPersonInfo;
}
@property (weak, nonatomic) IBOutlet UIView         *mCoverView;
@property (strong,nonatomic)UIImageView             *mHeaderImageView;
@property (weak, nonatomic) IBOutlet UIButton       *mPhotographBtn;
@property (weak, nonatomic) IBOutlet UIButton       *mPhotoAlbumBtn;
@property (weak, nonatomic) IBOutlet UIButton       *mPhotoCancelBtn;

@end

@implementation PersonInfoVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    NSLog(@"------%@",[UserProfile manager].mPersonInfo);
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

    
    UITapGestureRecognizer *vTapGestureRecognizer = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(handleTap:)];
    [_mCoverView addGestureRecognizer:vTapGestureRecognizer];
    _mTitleArray=@[@[@"头像",@"姓名"],@[@"性别",@"身高",@"体重"],@[@"邮箱",@"所属场馆"],@[@"使用训练计划",@"设置训练计划"],@[@"修改密码"]];
    
    _mHeaderImageView=[[UIImageView alloc]initWithFrame:CGRectMake(0, 10, 80, 80)];
    _mHeaderImageView.backgroundColor=[UIColor cyanColor];
    _mHeaderImageView.layer.masksToBounds=YES;
    _mHeaderImageView.layer.cornerRadius=40;
    [HttpJsonManager getWithParameters:nil sender:self url:[NSString stringWithFormat:@"%@/swimming_app/app/client/profile.do",SERVERADDRESS] completionHandler:^(BOOL sucess, id content) {
        _mPersonInfo=[[PersonInfoBaseClass alloc]initWithDictionary:content];
        NSLog(@"%s---%@",__FUNCTION__,content);
        [_mTable reloadData];
    }];
}
-(void)handleTap:(UITapGestureRecognizer*)tap
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
- (IBAction)sureBtnClick:(id)sender {
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
    else if (section == 3)
    {
#warning 屏蔽计划
        return 0;
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
            cell.accessoryView=_mHeaderImageView;
        }
    }
    else{
        cell=[tableView dequeueReusableCellWithIdentifier:@"cell"];
        if (!cell)
        {
            cell=[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"cell"];
        }
    }
    if (
        (indexPath.section==2&&indexPath.row==0)||
        (indexPath.section==1&&indexPath.row==1)||
        (indexPath.section==4&&indexPath.row==0)||
        (indexPath.section==3&&indexPath.row==1)
       )
    {
        cell.accessoryType=UITableViewCellAccessoryDisclosureIndicator;
    }
    else
    {
        cell.selectionStyle=UITableViewCellSelectionStyleNone;
    }
    if(indexPath.section==3&&indexPath.row==0)
    {
        UISwitch*swt=[[UISwitch alloc]init];
        cell.accessoryView=swt;
    }
    
    else if (indexPath.section==0&&indexPath.row==0)
    {
        NSURL *url = [NSURL URLWithString:_mPersonInfo.path];
        NSLog(@"url==%@",url);
        [_mHeaderImageView setImageWithURL:url];
    }
    cell.textLabel.text=[[_mTitleArray objectAtIndex:indexPath.section] objectAtIndex:indexPath.row];
    if (indexPath.section==2&&indexPath.row==1)
    {
        cell.detailTextLabel.text=_mPersonInfo.poolName;
    }
    if (indexPath.section==0&&indexPath.row==1)
    {
        cell.detailTextLabel.text=_mPersonInfo.name;
    }
    else if (indexPath.section==1&&indexPath.row==0)
    {
        cell.detailTextLabel.text=_mPersonInfo.gender;
    }
    else if (indexPath.section==1&&indexPath.row==1)
    {
        NSLog(@"%@",_mPersonInfo);
        cell.detailTextLabel.text=[NSString stringWithFormat:@"%.0fcm",_mPersonInfo.height];
        cell.selectionStyle=UITableViewCellSelectionStyleNone;
    }
    else if (indexPath.section==1&&indexPath.row==2)
    {
        cell.detailTextLabel.text=[NSString stringWithFormat:@"%.0fkg",_mPersonInfo.weight];    }
    else if (indexPath.section==2&&indexPath.row==0)
    {
        cell.detailTextLabel.text=_mPersonInfo.email;
        cell.selectionStyle=UITableViewCellSelectionStyleNone;
    }
    cell.selectionStyle=UITableViewCellSelectionStyleNone;
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (0==indexPath.section&&0==indexPath.row)
    {
        _mCoverView.hidden=NO;
    }
//    else if (0==indexPath.section&&1==indexPath.row)
//    {
//        [self performSegueWithIdentifier:@"changeNameVC" sender:nil];
//    }
    else if (1==indexPath.section)
    {
        [self performSegueWithIdentifier:@"changeInfoVC" sender:nil];
    }
    else if (2==indexPath.section&&0==indexPath.row)
    {
        [self performSegueWithIdentifier:@"changeEmailVC" sender:nil];
    }
    else if (3==indexPath.section&&1==indexPath.row)
    {
        //修改计划
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
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingImage:(UIImage *)image editingInfo:(NSDictionary *)editingInfo
{
    NSData *data = UIImagePNGRepresentation(image);
    NSString* encodeResult = [data base64EncodedStringWithOptions:NSDataBase64EncodingEndLineWithLineFeed];

//    [HttpJsonManager postWithParameters:@{@"imageFile":st} sender:self url:[NSString stringWithFormat:@"%@/swimming_app/app/client/uploadImg.do",SERVERADDRESS]
//                      completionHandler:^(BOOL sucess, id content)
//     {
//         if (sucess)
//         {
//             dispatch_async(dispatch_get_main_queue(), ^{
//                 _mHeaderImageView.image = image;
//                 _mCoverView.hidden=YES;
//                 [self dismissViewControllerAnimated:YES completion:nil];
//             });
//         }
//     }];
    
    [HttpJsonManager postWithParameters:@{@"id":@"123"}
                                 sender:self
                                    url:[NSString stringWithFormat:@"%@/swimming_app/app/client/uploadImg.do",SERVERADDRESS]
              constructingBodyWithBlock:^(id<AFMultipartFormData> formData)
    {
//        [formData appendPartWithFormData:data name:@"imageFile"];
        [formData appendPartWithFileData:data name:@"imageFile" fileName:@"imageFile" mimeType:@"image/png"];
    } completionHandler:^(BOOL sucess, id content) {
        if (sucess)
        {
            dispatch_async(dispatch_get_main_queue(), ^{
                _mHeaderImageView.image = image;
                _mCoverView.hidden=YES;
                [self dismissViewControllerAnimated:YES completion:nil];
            });
        }
    }];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    
    if ([segue.identifier isEqualToString:@"changeNameVC"])
    {
        ChangeNameVC*vc=segue.destinationViewController;
        vc.mName=_mPersonInfo.name;
        vc.block=^(NSDictionary*vDic){
            _mPersonInfo.name=[vDic objectForKey:@"name"];
            [_mTable reloadData];
        };
    }
    else if ([segue.identifier isEqualToString:@"changeInfoVC"])
    {
        ChangeWeightAndHeightVC*vc=segue.destinationViewController;
        vc.mHeight=_mPersonInfo.height;
        vc.mWeight=_mPersonInfo.weight;
        vc.mSex=_mPersonInfo.gender;
        vc.block=^(NSDictionary*vDic){
            _mPersonInfo.height=[[vDic objectForKey:@"height"] doubleValue];
            _mPersonInfo.weight=[[vDic objectForKey:@"weight"] doubleValue];
            [_mTable reloadData];
        };
    }
    else if ([segue.identifier isEqualToString:@"changeEmailVC"])
    {
        ChangeEmailVC*vc=segue.destinationViewController;
        vc.mEmail=_mPersonInfo.email;
        vc.block=^(NSDictionary*vDic){
            _mPersonInfo.email=[vDic objectForKey:@"email"];
            [_mTable reloadData];
        };
    }
}

@end
