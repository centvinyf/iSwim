//
//  CropImageViewController.m
//  iSwim
//
//  Created by Magic Beans on 15/1/27.
//  Copyright (c) 2015年 Magic Beans. All rights reserved.
//

#import "CropImageViewController.h"
#import "KICropImageView.h"

@interface CropImageViewController ()
{
    UIImage *_cropImage;
    KICropImageView *_cropImageView;
    __weak IBOutlet UIView *CropView;
}
/**
 *  完成裁剪
 */
- (IBAction)onclick_CropImage;
@end

@implementation CropImageViewController

-(void)setCorpImage:(UIImage *)_image
{
    _cropImage=_image;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self setCorpImage:[UIImage imageNamed:@"蓝底"]];
}
-(void)viewDidLayoutSubviews
{
    [super viewDidLayoutSubviews];
    
    if (!_cropImageView)
    {
        _cropImageView = [[KICropImageView alloc] initWithFrame:CropView.frame];
        [_cropImageView setCropSize:CGSizeMake(200, 200)];
        [_cropImageView setImage:_cropImage];
        [self.view addSubview:_cropImageView];
        [self.view sendSubviewToBack:_cropImageView];
        
        [CropView removeFromSuperview];
        CropView=nil;
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

- (IBAction)onclick_CropImage {
//    NSData *data = UIImagePNGRepresentation([_cropImageView cropImage]);
//    
//    [[NSNotificationCenter defaultCenter] postNotificationName:@"selectImageOkNotif" object:data];
//    
//    [self dismissViewControllerAnimated:YES completion:nil];
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"" message:@"头像设置成功" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil];
    [alertView show];
}
@end
