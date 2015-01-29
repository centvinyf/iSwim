//
//  HeightAndWeightVC.m
//  iSwim
//
//  Created by MagicBeans2 on 15/1/27.
//  Copyright (c) 2015年 Magic Beans. All rights reserved.
//

#define SLIDERWEIGHT _heightSlider.bounds.size.width
#import "HeightAndWeightVC.h"

@interface HeightAndWeightVC ()
@property (weak, nonatomic) IBOutlet UISlider               *heightSlider;
@property (weak, nonatomic) IBOutlet UISlider               *weightSlider;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint     *heightConstraint;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint     *weightConstraint;
@property (weak, nonatomic) IBOutlet UILabel                *heightLab;
@property (weak, nonatomic) IBOutlet UILabel                *weightLab;

@end

@implementation HeightAndWeightVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [_heightSlider addTarget:self action:@selector(valueChange:) forControlEvents:UIControlEventValueChanged];
    [_weightSlider addTarget:self action:@selector(valueChange:) forControlEvents:UIControlEventValueChanged];

    [_heightSlider setThumbImage:[UIImage imageNamed:@"身高"] forState:UIControlStateNormal];
    //[_heightSlider setMinimumTrackImage:[UIImage imageNamed:@"SliderMin"] forState:UIControlStateNormal];
    //[_heightSlider setMaximumTrackImage:[UIImage imageNamed:@"SliderMax"] forState:UIControlStateNormal];

    [_weightSlider setThumbImage:[UIImage imageNamed:@"体重"] forState:UIControlStateNormal];
    //[_weightSlider setMinimumTrackImage:[UIImage imageNamed:@"SliderMin"] forState:UIControlStateNormal];
    //[_weightSlider setMaximumTrackImage:[UIImage imageNamed:@"SliderMax"] forState:UIControlStateNormal];
    
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

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // save weight,height
    NSLog(@"%s",__FUNCTION__);

    if ([segue.identifier isEqualToString:@"BirthdayDateVC"]) {
        NSMutableDictionary*personInfoDic=[NSMutableDictionary dictionaryWithDictionary:[[NSUserDefaults standardUserDefaults] objectForKey:@"personInfoDic"]];
        if (!personInfoDic) {
            personInfoDic=[[NSMutableDictionary alloc]initWithCapacity:0];
        }
        [personInfoDic setObject:_heightLab.text forKey:@"height"];
        [personInfoDic setObject:_weightLab.text forKey:@"weight"];
        [[NSUserDefaults standardUserDefaults]setObject:personInfoDic forKey:@"personInfoDic"];
        [[NSUserDefaults standardUserDefaults]synchronize];
    }
}

@end
