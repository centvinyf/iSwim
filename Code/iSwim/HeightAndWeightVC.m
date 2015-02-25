//
//  HeightAndWeightVC.m
//  iSwim
//
//  Created by MagicBeans2 on 15/1/27.
//  Copyright (c) 2015年 Magic Beans. All rights reserved.
//

#define kSLIDERWEIGHT _mHeightSlider.bounds.size.width
#import "HeightAndWeightVC.h"

@interface HeightAndWeightVC ()
@property (weak, nonatomic) IBOutlet UISlider               *mHeightSlider;
@property (weak, nonatomic) IBOutlet UISlider               *mWeightSlider;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint     *mHeightConstraint;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint     *mWeightConstraint;
@property (weak, nonatomic) IBOutlet UILabel                *mHeightLab;
@property (weak, nonatomic) IBOutlet UILabel                *mWeightLab;

@end

@implementation HeightAndWeightVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [_mHeightSlider addTarget:self action:@selector(valueChange:) forControlEvents:UIControlEventValueChanged];
    [_mWeightSlider addTarget:self action:@selector(valueChange:) forControlEvents:UIControlEventValueChanged];

    [_mHeightSlider setThumbImage:[UIImage imageNamed:@"height"] forState:UIControlStateNormal];
    [_mHeightSlider setMinimumTrackImage:[UIImage imageNamed:@"SliderMin"] forState:UIControlStateNormal];
    [_mHeightSlider setMaximumTrackImage:[UIImage imageNamed:@"SliderMax"] forState:UIControlStateNormal];

    [_mWeightSlider setThumbImage:[UIImage imageNamed:@"weight"] forState:UIControlStateNormal];
    [_mWeightSlider setMinimumTrackImage:[UIImage imageNamed:@"SliderMin"] forState:UIControlStateNormal];
    [_mWeightSlider setMaximumTrackImage:[UIImage imageNamed:@"SliderMax"] forState:UIControlStateNormal];
    
}
-(void)valueChange:(UISlider*)slider
{
    if (slider==_mHeightSlider)
    {
        _mHeightLab.text=[NSString stringWithFormat:@"%dcm",120+(int)(slider.value*100)];
        _mHeightConstraint.constant=slider.value*(kSLIDERWEIGHT - 36.0 )-9.0;
    }
    else
    {
        _mWeightLab.text=[NSString stringWithFormat:@"%dkg",50+(int)(slider.value*100)];
        _mWeightConstraint.constant=slider.value*(kSLIDERWEIGHT - 36.0 )-9.0;
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // save weight,height
    if ([segue.identifier isEqualToString:@"BirthdayDateVC"])
    {
        NSMutableDictionary*vPersonInfoDic=[NSMutableDictionary dictionaryWithDictionary:[[NSUserDefaults standardUserDefaults] objectForKey:@"personInfoDic"]];
        if (!vPersonInfoDic)
        {
            vPersonInfoDic=[[NSMutableDictionary alloc]initWithCapacity:0];
        }
        [vPersonInfoDic setObject:[NSNumber numberWithInt:[_mHeightLab.text intValue]] forKey:@"height"];
        [vPersonInfoDic setObject:[NSNumber numberWithInt:[_mWeightLab.text intValue]] forKey:@"weight"];
        [[NSUserDefaults standardUserDefaults]setObject:vPersonInfoDic forKey:@"personInfoDic"];
        [[NSUserDefaults standardUserDefaults]synchronize];
    }
}

@end
