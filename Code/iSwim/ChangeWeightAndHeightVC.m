//
//  ChangeWeightAndHeightVC.m
//  iSwim
//
//  Created by MagicBeans2 on 15/1/30.
//  Copyright (c) 2015年 Magic Beans. All rights reserved.
//
#define kSLIDERWEIGHT _mHeightSlider.bounds.size.width
#import "ChangeWeightAndHeightVC.h"

@interface ChangeWeightAndHeightVC ()
{
    BOOL _mSex;
}
@property (weak, nonatomic) IBOutlet UISlider               *mHeightSlider;
@property (weak, nonatomic) IBOutlet UISlider               *mWeightSlider;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint     *mHeightConstraint;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint     *mWeightConstraint;
@property (weak, nonatomic) IBOutlet UILabel                *mHeightLab;
@property (weak, nonatomic) IBOutlet UILabel                *mWeightLab;
@property (weak, nonatomic) IBOutlet UIButton               *mSexBtn;
@end

@implementation ChangeWeightAndHeightVC

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
- (IBAction)btnClick:(UIButton *)sender
{
    if (!_mSex)
    {
        [sender setBackgroundImage:[UIImage imageNamed:@"woman"] forState:UIControlStateNormal];
    }
    else
    {
        [sender setBackgroundImage:[UIImage imageNamed:@"man"] forState:UIControlStateNormal];
    }
    _mSex=!_mSex;
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
