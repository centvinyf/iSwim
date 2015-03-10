//
//  BirthdayDateVC.m
//  iSwim
//
//  Created by MagicBeans2 on 15/1/27.
//  Copyright (c) 2015年 Magic Beans. All rights reserved.
//

#import "BirthdayDateVC.h"
#import "Header.h"
@interface BirthdayDateVC ()
@property (weak, nonatomic) IBOutlet UILabel        *mYearLab;
@property (weak, nonatomic) IBOutlet UILabel        *mMonthLab;
@property (weak, nonatomic) IBOutlet UILabel        *mDayLab;
@property (weak, nonatomic) IBOutlet UIView         *mVenueView;
@property (weak, nonatomic) IBOutlet UITextField    *mVenueTextField;

@end

@implementation BirthdayDateVC

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    _mVenueView.layer.masksToBounds=YES;
    _mVenueView.layer.cornerRadius=5;
    [_mVenueTextField addTarget:self action:@selector(touchesBegan:withEvent:) forControlEvents:UIControlEventEditingDidEndOnExit];

}
- (IBAction)btnClick:(UIButton *)sender
{
    switch (sender.tag)
    {
        case 1:
        {
            _mYearLab.text=[NSString stringWithFormat:@"%ld",[_mYearLab.text integerValue]+1];
        }
            break;
        case 4:
        {
            _mYearLab.text=[NSString stringWithFormat:@"%ld",[_mYearLab.text integerValue]-1];
        }
            break;
        case 2:
        {
            _mMonthLab.text=[NSString stringWithFormat:@"%ld",[_mMonthLab.text integerValue]%12+1];
            if (_mMonthLab.text.intValue<10)
            {
                _mMonthLab.text=[NSString stringWithFormat:@"0%d",_mMonthLab.text.intValue];
            }
        }
            break;
        case 5:
        {
            _mMonthLab.text=[NSString stringWithFormat:@"%ld",([_mMonthLab.text integerValue]-1)];
            if (_mMonthLab.text.intValue==0)
            {
                _mMonthLab.text=@"12";
            }
            if (_mMonthLab.text.intValue<10)
            {
                _mMonthLab.text=[NSString stringWithFormat:@"0%d",_mMonthLab.text.intValue];
            }
        }
            break;
        case 3:
        {
            _mDayLab.text=[NSString stringWithFormat:@"%ld",[_mDayLab.text integerValue]%31+1];
            if (_mDayLab.text.intValue<10)
            {
                _mDayLab.text=[NSString stringWithFormat:@"0%d",_mDayLab.text.intValue];
            }
        }
            break;
        case 6:
        {
            _mDayLab.text=[NSString stringWithFormat:@"%d",([_mDayLab.text integerValue]-1)];
            if (_mDayLab.text.intValue==0)
            {
                _mDayLab.text=@"31";
            }
            if (_mDayLab.text.intValue<10)
            {
                _mDayLab.text=[NSString stringWithFormat:@"0%d",_mDayLab.text.intValue];
            }
        }
            break;
        default:
            break;
    }
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self.view endEditing:YES];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Navigation

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // save birthday,venue
    if ([segue.identifier isEqualToString:@"MainNav"])
    {
        NSMutableDictionary*vPersonInfoDic=[NSMutableDictionary dictionaryWithDictionary:[[NSUserDefaults standardUserDefaults] objectForKey:@"personInfoDic"]];
        if (!vPersonInfoDic)
        {
            vPersonInfoDic=[[NSMutableDictionary alloc]initWithCapacity:0];
        }
        //NSDateFormatter*formatter=[[NSDateFormatter alloc]init];
        //[formatter setDateFormat:@"yyyy-MM-dd"];
        //NSString*str=[NSString stringWithFormat:@"%@-%@-%@",_mYearLab.text,_mMonthLab.text,_mDayLab.text];
        //NSDate*date=[formatter dateFromString:str];
        //double interval=[date timeIntervalSince1970];
        //[vPersonInfoDic setObject:str forKey:@"birthday"];
        [[NSUserDefaults standardUserDefaults]setObject:vPersonInfoDic forKey:@"personInfoDic"];
        [[NSUserDefaults standardUserDefaults]synchronize];
        
        [HttpJsonManager getWithParameters:vPersonInfoDic sender:self url:[NSString stringWithFormat:@"%@/swimming_app/app/client/profile/info.do",SERVERADDRESS] completionHandler:^(BOOL sucess, id content) {
            NSLog(@"%s---%@",__FUNCTION__,content);
           [UserProfile manager].mPersonInfo = [[PersonInfoBaseClass alloc]initWithDictionary:content];
        }];
    }
    
}

@end
