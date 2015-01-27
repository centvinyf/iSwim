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
    [_heightSlider setThumbImage:[UIImage imageNamed:@"身高体重圆钮"] forState:UIControlStateNormal];
    [_weightSlider setThumbImage:[UIImage imageNamed:@"身高体重圆钮"] forState:UIControlStateNormal];

}
-(void)valueChange:(UISlider*)slider
{
    if (slider==_heightSlider) {
        _heightLab.text=[NSString stringWithFormat:@"%dcm",120+(int)(slider.value*100)];
        if (slider.value<=0.2) {
            _heightConstraint.constant=0.2*SLIDERWEIGHT-SLIDERWEIGHT/2;
        }
        else{
            _heightConstraint.constant=slider.value*SLIDERWEIGHT-SLIDERWEIGHT/2;
        }
    }
    else{
        _weightLab.text=[NSString stringWithFormat:@"%dkg",50+(int)(slider.value*100)];
        if (slider.value<=0.2) {
            _weightConstraint.constant=0.2*SLIDERWEIGHT-SLIDERWEIGHT/2;
        }
        else{
            _weightConstraint.constant=slider.value*SLIDERWEIGHT-SLIDERWEIGHT/2;
        }
    }
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
