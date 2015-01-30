//
//  ChangeWeightAndHeightVC.m
//  iSwim
//
//  Created by MagicBeans2 on 15/1/30.
//  Copyright (c) 2015年 Magic Beans. All rights reserved.
//
#define SLIDERWEIGHT _heightSlider.bounds.size.width
#import "ChangeWeightAndHeightVC.h"

@interface ChangeWeightAndHeightVC ()
{
    BOOL _sex;
}
@property (weak, nonatomic) IBOutlet UISlider               *heightSlider;
@property (weak, nonatomic) IBOutlet UISlider               *weightSlider;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint     *heightConstraint;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint     *weightConstraint;
@property (weak, nonatomic) IBOutlet UILabel                *heightLab;
@property (weak, nonatomic) IBOutlet UILabel                *weightLab;
@property (weak, nonatomic) IBOutlet UIButton               *sexBtn;
@end

@implementation ChangeWeightAndHeightVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [_heightSlider addTarget:self action:@selector(valueChange:) forControlEvents:UIControlEventValueChanged];
    [_weightSlider addTarget:self action:@selector(valueChange:) forControlEvents:UIControlEventValueChanged];
    
    [_heightSlider setThumbImage:[UIImage imageNamed:@"身高"] forState:UIControlStateNormal];
    [_heightSlider setMinimumTrackImage:[UIImage imageNamed:@"SliderMin"] forState:UIControlStateNormal];
    [_heightSlider setMaximumTrackImage:[UIImage imageNamed:@"SliderMax"] forState:UIControlStateNormal];
    
    [_weightSlider setThumbImage:[UIImage imageNamed:@"体重"] forState:UIControlStateNormal];
    [_weightSlider setMinimumTrackImage:[UIImage imageNamed:@"SliderMin"] forState:UIControlStateNormal];
    [_weightSlider setMaximumTrackImage:[UIImage imageNamed:@"SliderMax"] forState:UIControlStateNormal];
    
}
-(void)valueChange:(UISlider*)slider
{
    if (slider==_heightSlider) {
        _heightLab.text=[NSString stringWithFormat:@"%dcm",120+(int)(slider.value*100)];
        _heightConstraint.constant=slider.value*(SLIDERWEIGHT - 36.0 )-9.0;
    }
    else{
        _weightLab.text=[NSString stringWithFormat:@"%dkg",50+(int)(slider.value*100)];
        _weightConstraint.constant=slider.value*(SLIDERWEIGHT - 36.0 )-9.0;
    }
}
- (IBAction)btnClick:(UIButton *)sender {
    if (!_sex) {
        [sender setBackgroundImage:[UIImage imageNamed:@"女"] forState:UIControlStateNormal];
    }else{
        [sender setBackgroundImage:[UIImage imageNamed:@"男"] forState:UIControlStateNormal];
    }
    _sex=!_sex;
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
