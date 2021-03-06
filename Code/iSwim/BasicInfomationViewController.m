//
//  BasicInfomationViewController.m
//  iSwim
//
//  Created by Sylar-MagicBeans on 15/1/26.
//  Copyright (c) 2015年 Magic Beans. All rights reserved.
//

#import "BasicInfomationViewController.h"
#import "BasicInfoViewCell.h"
#import "HttpJsonManager.h"
#import <ShareSDK/ShareSDK.h>
#import "UserProfile.h"

@interface BasicInfomationViewController ()
@property (weak, nonatomic) IBOutlet UITableView *mTableView;
@property (weak,nonatomic) NSArray * mPicName;
@property (weak, nonatomic) NSArray *mTitleName;
@property (weak,nonatomic) NSMutableArray * mData;
@property (retain,nonatomic) NSDictionary * mInitData;
@property (retain,nonatomic) NSString *mCurrentEventId;
@end

@implementation BasicInfomationViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    UIBarButtonItem *vReturnButtonItem = [[UIBarButtonItem alloc] init];
    vReturnButtonItem.title = @" ";
    self.navigationItem.backBarButtonItem = vReturnButtonItem;
    [self initStructure];
    [self loadData:@"http://192.168.1.113:8080/swimming_app/app/client/events/info.do"];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)initStructure
{
    NSArray *vPicName = [[NSArray alloc] initWithObjects:@"training_date",@"Training_changci",@"training_distance",@"training_time",@"energy",@"single",@"in",@"out",@"in",@"out",@"place", nil];
    NSArray *vTitleNamePRO = [[NSArray alloc] initWithObjects:@"训练日期",@"训练场次",@"训练距离",@"训练时长",@"热量消耗",@"单边数",@"入场时间",@"离场时间",@"入水时间",@"上岸时间",@"训练场馆", nil];
    NSArray *vTitleName = [[NSArray alloc] initWithObjects:@"游泳日期",@"游泳场次",@"游泳距离",@"游泳时长",@"热量消耗",@"单边数",@"入场时间",@"离场时间",@"入水时间",@"上岸时间",@"游泳场馆", nil];
    NSUserDefaults *defaults=  [NSUserDefaults  standardUserDefaults];
    if ([defaults boolForKey:@"isPro"])
    {
        self.mTitleName=vTitleNamePRO;
    }else
    {
        self.mTitleName=vTitleName;
    }
    self.mPicName = vPicName;
    
    
}

- (IBAction)mShareBtnPressed:(id)sender
{
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"" message:@"您需要拍一张自拍照吗？" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"拍照分享",@"直接分享", nil];
    [alert show];
}

- (void)alertView:(UIAlertView *)alertView didDismissWithButtonIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == 1) {
        [self shareWithPhoto];
    }
    else if (buttonIndex == 2)
    {
        [self shareWithUserIcon];
    }
}

- (void)shareWithUserIcon
{
    NSUserDefaults  *defaults =  [NSUserDefaults standardUserDefaults];
    BOOL isPro = [defaults boolForKey:@"isPro"];
    
    [HttpJsonManager postWithParameters:@{@"eventId":self.mCurrentEventId,
                                          @"isProfession":[NSNumber numberWithBool:isPro]}
                                    url:@"http://192.168.1.113:8080/swimming_app/app/client/uploadShowPhone.do"
                      completionHandler:^(BOOL sucess, id content)
     {
         
         //构造分享内容
         id<ISSContent> publishContent = [ShareSDK content:@"分享内容"
                                            defaultContent:@""
                                                     image:[ShareSDK imageWithUrl:@"http://192.168.1.113:8080/swimming_app/TP/swim-icon.jpg"]
                                                     title:@"游泳去"
                                                       url:content[@"path"]
                                               description:@""
                                                 mediaType:SSPublishContentMediaTypeNews];
         
         //弹出分享菜单
         [ShareSDK showShareActionSheet:nil
                              shareList:nil
                                content:publishContent
                          statusBarTips:YES
                            authOptions:nil
                           shareOptions:nil
                                 result:^(ShareType type, SSResponseState state, id<ISSPlatformShareInfo> statusInfo, id<ICMErrorInfo> error, BOOL end) {
                                     
                                     if (state == SSResponseStateSuccess)
                                     {
                                         NSLog(NSLocalizedString(@"TEXT_ShARE_SUC", @"分享成功"));
                                     }
                                     else if (state == SSResponseStateFail)
                                     {
                                         UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"错误" message:@"您并未安装相应应用" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
                                         [alert show];
                                         NSLog(NSLocalizedString(@"TEXT_ShARE_FAI", @"分享失败,错误码:%d,错误描述:%@"), [error errorCode], [error errorDescription]);
                                     }
                                 }];
         
     }];
}


- (void)shareWithPhoto
{
    UIImagePickerController *vPicker = [[UIImagePickerController alloc] init];
    vPicker.sourceType = UIImagePickerControllerSourceTypeCamera;
    vPicker.videoQuality = UIImagePickerControllerQualityType640x480;
    vPicker.allowsEditing = YES;
    vPicker.delegate = self;
    
    [self presentViewController:vPicker animated:YES completion:nil];

}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingImage:(UIImage *)image editingInfo:(NSDictionary *)editingInfo
{
    [picker dismissViewControllerAnimated:YES completion:^{
        NSData *data = UIImagePNGRepresentation(image);

        NSUserDefaults  *defaults =  [NSUserDefaults standardUserDefaults];
        BOOL isPro = [defaults boolForKey:@"isPro"];

        [HttpJsonManager postWithParameters:@{@"eventId":self.mCurrentEventId,
                                              @"isProfession":[NSNumber numberWithBool:isPro]}
                                        url:@"http://192.168.1.113:8080/swimming_app/app/client/uploadShow.do"
                  constructingBodyWithBlock:^(id<AFMultipartFormData> formData){
            [formData appendPartWithFileData:data name:@"imageFile" fileName:@"imageFile" mimeType:@"image/png"];
        }
                          completionHandler:^(BOOL sucess, id content)
        {
            //构造分享内容
            id<ISSContent> publishContent = [ShareSDK content:@"分享内容"
                                               defaultContent:@""
                                                        image:[ShareSDK imageWithData:data fileName:@"pic.png" mimeType:@"image/png"]
                                                        title:@"游泳去"
                                                          url:content[@"path"]
                                                  description:@""
                                                    mediaType:SSPublishContentMediaTypeNews];
            
            //弹出分享菜单
            [ShareSDK showShareActionSheet:nil
                                 shareList:nil
                                   content:publishContent
                             statusBarTips:YES
                               authOptions:nil
                              shareOptions:nil
                                    result:^(ShareType type, SSResponseState state, id<ISSPlatformShareInfo> statusInfo, id<ICMErrorInfo> error, BOOL end) {
                                        
                                        if (state == SSResponseStateSuccess)
                                        {
                                            NSLog(NSLocalizedString(@"TEXT_ShARE_SUC", @"分享成功"));
                                        }
                                        else if (state == SSResponseStateFail)
                                        {
                                            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"错误" message:@"您并未安装相应应用" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
                                            [alert show];

                                            NSLog(NSLocalizedString(@"TEXT_ShARE_FAI", @"分享失败,错误码:%d,错误描述:%@"), [error errorCode], [error errorDescription]);
                                            
                                        }
                                    }];
        }];

    }];
}
#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 11;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSArray *vTitleNamePRO = [[NSArray alloc] initWithObjects:@"训练日期",@"训练场次",@"训练距离",@"训练时长",@"热量消耗",@"单边数",@"入场时间",@"离场时间",@"入水时间",@"上岸时间",@"训练场馆", nil];
    NSArray *vTitleName = [[NSArray alloc] initWithObjects:@"游泳日期",@"游泳场次",@"游泳距离",@"游泳时长",@"热量消耗",@"单边数",@"入场时间",@"离场时间",@"入水时间",@"上岸时间",@"游泳场馆", nil];
    NSUserDefaults *defaults=  [NSUserDefaults  standardUserDefaults];
    if ([defaults boolForKey:@"isPro"])
    {
        self.mTitleName=vTitleNamePRO;
    }else
    {
        self.mTitleName=vTitleName;
    }
    NSArray *vPicName1 = [[NSArray alloc] initWithObjects:@"training_date",@"Training_changci",@"training_distance",@"training_time",@"energy",@"single",@"in",@"out",@"in",@"out",@"place", nil];
    static NSString *vIdentifiller = @"BasicInfoViewCell";
    BasicInfoViewCell *vCell = [tableView dequeueReusableCellWithIdentifier:vIdentifiller];
    if (!vCell)
    {
        vCell = [[BasicInfoViewCell alloc]
                initWithStyle:UITableViewCellStyleDefault
                reuseIdentifier: vIdentifiller];
    }
    //icon
    [vCell.mImage setImage:[UIImage imageNamed:vPicName1[indexPath.row]] ];
    //titile
    vCell.mTitle.text = self.mTitleName[indexPath.row];
    //value
    switch (indexPath.row)
    {
        case 0:
            vCell.mData.text = self.mInitData[@"endTime"];
            break;
        case 1:
            vCell.mData.text = [self.mInitData[@"eventId"] stringValue];
            break;
        case 2:
            vCell.mData.text = self.mInitData[@"totalDistance"];
            break;
        case 3:
            vCell.mData.text = self.mInitData[@"totalTime"];
            break;
        case 4:
            vCell.mData.text = self.mInitData[@"totalCalorie"];
            break;
        case 5:
            vCell.mData.text = [self.mInitData[@"numOfSplit"] stringValue];
            break;
        case 6:
            vCell.mData.text = self.mInitData[@"entryTime"];
            break;
        case 7:
            vCell.mData.text = self.mInitData[@"exitTime"];
            break;
        case 8:
            vCell.mData.text = self.mInitData[@"startTime"];
            break;
        case 9:
            vCell.mData.text = self.mInitData[@"end_time"];
            break;
        case 10:
            vCell.mData.text = self.mInitData[@"swimmingPoolName"];
            break;
        default:
            break;
    }

    return vCell;
}

#pragma mark--

- (void)loadData:(NSString *)url
{
    NSDictionary *parameters = @{@"eventId": self.mCurrentEventId};
    [HttpJsonManager getWithParameters:parameters
                                   url:url
                     completionHandler:^(BOOL sucess, id content)
     {
         if (sucess)
         {
             self.mInitData = content;
             [self.mTableView reloadData];
         }
     }];
}

#pragma mark - Navigation
-(void) initWithEventId : (NSString *)EventId
{
    self.mCurrentEventId = EventId;
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
