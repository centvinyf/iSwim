//
//  ChangeWeightAndHeightVC.m
//  iSwim
//
//  Created by MagicBeans2 on 15/1/30.
//  Copyright (c) 2015年 Magic Beans. All rights reserved.
//
#define kSLIDERWEIGHT _mHeightSlider.bounds.size.width
#import "ChangeWeightAndHeightVC.h"
#import "Header.h"
@interface ChangeWeightAndHeightVC ()
@property (weak, nonatomic) IBOutlet UISlider               *mHeightSlider;
@property (weak, nonatomic) IBOutlet UISlider               *mWeightSlider;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint     *mHeightConstraint;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint     *mWeightConstraint;
@property (weak, nonatomic) IBOutlet UILabel                *mHeightLab;
@property (weak, nonatomic) IBOutlet UILabel                *mWeightLab;
@property (weak, nonatomic) IBOutlet UIButton               *mSexBtn;
@end

@implementation ChangeWeightAndHeightVC

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    NSLog(@"%@",self.mSex);
    _mSexBtn.userInteractionEnabled=NO;
    [_mHeightSlider addTarget:self action:@selector(valueChange:) forControlEvents:UIControlEventValueChanged];
    [_mWeightSlider addTarget:self action:@selector(valueChange:) forControlEvents:UIControlEventValueChanged];
    
    [_mHeightSlider setThumbImage:[UIImage imageNamed:@"height"] forState:UIControlStateNormal];
    [_mHeightSlider setMinimumTrackImage:[UIImage imageNamed:@"SliderMin"] forState:UIControlStateNormal];
    [_mHeightSlider setMaximumTrackImage:[UIImage imageNamed:@"SliderMax"] forState:UIControlStateNormal];
    
    [_mWeightSlider setThumbImage:[UIImage imageNamed:@"weight"] forState:UIControlStateNormal];
    [_mWeightSlider setMinimumTrackImage:[UIImage imageNamed:@"SliderMin"] forState:UIControlStateNormal];
    [_mWeightSlider setMaximumTrackImage:[UIImage imageNamed:@"SliderMax"] forState:UIControlStateNormal];
    
    _mHeightSlider.value=_mHeight  / 100.0 - 120 / 100.0;
    _mWeightSlider.value=_mWeight / 100.0 - 50 / 100.0;
}

-(void)viewDidLayoutSubviews
{
    [self valueChange:_mHeightSlider];
    [self valueChange:_mWeightSlider];
    [self initViews:_mSexBtn];
}

-(void)valueChange:(UISlider*)slider
{
    if (slider==_mHeightSlider)
    {
        _mHeightLab.text=[NSString stringWithFormat:@"%dcm",120 + (int)(slider.value * 100)];
        _mHeight = 120 + (int)(slider.value * 100);
        NSLog(@" height = %f",_mHeight);
        _mHeightConstraint.constant=slider.value*(kSLIDERWEIGHT - 36.0 ) - 9.0;
    }
    else
    {
        _mWeightLab.text=[NSString stringWithFormat:@"%dkg",50 + (int)(slider.value * 100)];
        _mWeight = 50 + (int)(slider.value * 100);
        NSLog(@" weight = %f",_mWeight);
        _mWeightConstraint.constant=slider.value*(kSLIDERWEIGHT - 36.0 ) - 9.0;
    }
}

-(void)initViews:(UIButton*)btn
{
    if ([_mSex isEqualToString:@"女"])
    {
        [btn setBackgroundImage:[UIImage imageNamed:@"woman"] forState:UIControlStateNormal];
    }
    else
    {
        [btn setBackgroundImage:[UIImage imageNamed:@"man"] forState:UIControlStateNormal];
    }
}

- (void)didReceiveMemoryWarning
{
    
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)saveBtnClick:(id)sender
{
    _block(@{@"height":[NSNumber numberWithDouble:_mHeight],@"weight":[NSNumber numberWithDouble:_mWeight]});
    [HttpJsonManager getWithParameters:@{@"gender":_mSex,
                                         @"height":[NSNumber numberWithInt:_mHeight],
                                         @"weight":[NSNumber numberWithInt:_mWeight]}
                                sender:self url:[NSString stringWithFormat:@"%@/swimming_app/app/client/profile/info.do",SERVERADDRESS]
                     completionHandler:^(BOOL sucess, id content)
    {
        NSLog(@"%s---%@",__FUNCTION__,content);
        if (sucess)
        {
            ALERT(@"保存成功");
        }
        [HttpJsonManager getWithParameters:nil
                                    sender:self
                                       url:[NSString stringWithFormat:@"%@/swimming_app/app/client/profile.do",SERVERADDRESS]
                         completionHandler:^(BOOL sucess, id content)
        {
            NSLog(@"%@",content);
        }];
    }];
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
