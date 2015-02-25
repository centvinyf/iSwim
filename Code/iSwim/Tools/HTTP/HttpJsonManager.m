//
//  HttpJsonManager.m
//  123123
//
//  Created by 范宇 on 14-9-4.
//  Copyright (c) 2014年 XiaoMi. All rights reserved.
//

#import "HttpJsonManager.h"
#import "XMProgressHUD.h"

static HttpJsonManager *sharedInstance;
@implementation HttpJsonManager
/**
 *  类方法Json Post
 *
 *  @param params     Json字典
 *  @param porn       接口后缀
 *  @param completion 网络请求完成后执行的block
 */

+ (void)load
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedInstance = [HttpJsonManager manager];
    });
}

+(void)postWithParameters:(NSDictionary *)params
                   sender:(UIViewController *)viewController
                                 url:(NSString *)url
                    completionHandler:(void (^)(BOOL, id))completion
{
    
    //开始网络请求
    
    HttpJsonManager *manager = sharedInstance;
    
    NSLog(@"request URL:%@",url);
    NSMutableDictionary *vParams = [NSMutableDictionary dictionaryWithDictionary:params];
    if (manager.mToken) {
        [vParams setObject:manager.mToken forKey:@"id"];
    }
    NSLog(@"token:%@",manager.mToken);
    //Post
    [manager POST:url parameters:vParams sender:viewController success:^(AFHTTPRequestOperation *operation, id responseObject){
        [manager hideWaitView:viewController];
        //判断是否成功
        BOOL sucess = [responseObject[@"Status"] integerValue] != -1 ? YES : NO;
        
        //根据成功与否，返回相应值
        if (sucess)
        {
            completion(sucess, responseObject);
        }else
        {
            completion(sucess, responseObject[@"info"]);
        }
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        [manager hideWaitView:viewController];
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"网络错误" message:error.localizedDescription delegate:nil cancelButtonTitle:@"好" otherButtonTitles:nil];
        [alert show];
        completion(NO, @"网络请求失败");
    }];
    
}

+(void)postWithParameters:(NSDictionary *)params
                   sender:(UIViewController *)viewController
                      url:(NSString *)url
constructingBodyWithBlock:(void (^)(id <AFMultipartFormData> formData))block
        completionHandler:(void (^)(BOOL sucess, id content))completion
{
    
    //开始网络请求
    
    HttpJsonManager *manager = sharedInstance;
    
    NSLog(@"request URL:%@",url);
    NSMutableDictionary *vParams = [NSMutableDictionary dictionaryWithDictionary:params];
    if (manager.mToken) {
        [vParams setObject:manager.mToken forKey:@"authToken"];
    }
    //Post
    [manager POST:url parameters:vParams sender:viewController constructingBodyWithBlock:block success:^(AFHTTPRequestOperation *operation, id responseObject) {
        [manager hideWaitView:viewController];
        //判断是否成功
        BOOL sucess = [responseObject[@"Status"] integerValue] != -1 ? YES : NO;
        
        //根据成功与否，返回相应值
        if (sucess)
        {
            completion(sucess, responseObject);
        }else
        {
            completion(sucess, responseObject[@"info"]);
        }
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        [manager hideWaitView:viewController];
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"网络错误" message:error.localizedDescription delegate:nil cancelButtonTitle:@"好" otherButtonTitles:nil];
        [alert show];
        completion(NO, @"网络请求失败");
    }];
}

+(AFHTTPRequestOperation *)getWithParameters:(NSDictionary *)params
                  sender:(UIViewController *)viewController
                     url:(NSString *)url
       completionHandler:(void (^)(BOOL sucess, id content))completion
{
    
    //开始网络请求
    
    HttpJsonManager *manager = sharedInstance;
    
    NSLog(@"request URL:%@",url);
    NSMutableDictionary *vParams = [NSMutableDictionary dictionaryWithDictionary:params];
    if (manager.mToken) {
        [vParams setObject:manager.mToken forKey:@"id"];
    }
    //Get
    AFHTTPRequestOperation *operation = [manager GET:url parameters:vParams sender:viewController success:^(AFHTTPRequestOperation *operation, id responseObject){
        [manager hideWaitView:viewController];
        //判断是否成功
        //BOOL sucess = [responseObject[@"rs"] integerValue] == 1 ? YES : NO;
        
        //根据成功与否，返回相应值
        if (YES)
        {
            completion(YES, responseObject);
        }
        else
        {
            completion(YES, responseObject[@"info"]);
        }
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        if(!operation.isCancelled)
        {
            [manager hideWaitView:viewController];
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"网络错误" message:error.localizedDescription delegate:nil cancelButtonTitle:@"好" otherButtonTitles:nil];
            [alert show];
           // completion(NO, @"网络请求失败");
        }
    }];

    return operation;
}

- (AFHTTPRequestOperation *)GET:(NSString *)URLString
                     parameters:(id)parameters
                         sender:(UIViewController *)viewController
                        success:(void (^)(AFHTTPRequestOperation *operation, id responseObject))success
                        failure:(void (^)(AFHTTPRequestOperation *operation, NSError *error))failure
{
    if ([viewController isKindOfClass:[UINavigationController class]]) {
        [self showWaitView:((UINavigationController *)viewController).topViewController.view withUrl:URLString];
    }
    else
    {
        [self showWaitView:viewController.view withUrl:URLString];
    }
    NSMutableURLRequest *request = [self.requestSerializer requestWithMethod:@"GET" URLString:[[NSURL URLWithString:URLString relativeToURL:self.baseURL] absoluteString] parameters:parameters error:nil];
    AFHTTPRequestOperation *operation = [self HTTPRequestOperationWithRequest:request success:success failure:failure];
    
    [self.operationQueue addOperation:operation];
    
    return operation;
}

- (AFHTTPRequestOperation *)POST:(NSString *)URLString
                      parameters:(id)parameters
                          sender:(UIViewController *)viewController
                         success:(void (^)(AFHTTPRequestOperation *operation, id responseObject))success
                         failure:(void (^)(AFHTTPRequestOperation *operation, NSError *error))failure
{
    if ([viewController isKindOfClass:[UINavigationController class]]) {
        [self showWaitView:((UINavigationController *)viewController).topViewController.view withUrl:URLString];
    }
    else
    {
        [self showWaitView:viewController.view withUrl:URLString];
    }
    NSMutableURLRequest *request = [self.requestSerializer requestWithMethod:@"POST" URLString:[[NSURL URLWithString:URLString relativeToURL:self.baseURL] absoluteString] parameters:parameters error:nil];
    AFHTTPRequestOperation *operation = [self HTTPRequestOperationWithRequest:request success:success failure:failure];
    [self.operationQueue addOperation:operation];
    
    return operation;
}

- (AFHTTPRequestOperation *)POST:(NSString *)URLString
                      parameters:(id)parameters
                            sender:(UIViewController *)viewController
       constructingBodyWithBlock:(void (^)(id <AFMultipartFormData> formData))block
                         success:(void (^)(AFHTTPRequestOperation *operation, id responseObject))success
                         failure:(void (^)(AFHTTPRequestOperation *operation, NSError *error))failure
{
    if ([viewController isKindOfClass:[UINavigationController class]]) {
        [self showWaitView:((UINavigationController *)viewController).topViewController.view withUrl:URLString];
    }
    else
    {
        [self showWaitView:viewController.view withUrl:URLString];
    }
    NSMutableURLRequest *request = [self.requestSerializer multipartFormRequestWithMethod:@"POST" URLString:[[NSURL URLWithString:URLString relativeToURL:self.baseURL] absoluteString] parameters:parameters constructingBodyWithBlock:block error:nil];
    AFHTTPRequestOperation *operation = [self HTTPRequestOperationWithRequest:request success:success failure:failure];
    [self.operationQueue addOperation:operation];
    
    return operation;
}

- (void)showWaitView:(UIView *)view withUrl:(NSString *)url
{
    if (!hud)
    {
        hud = [XMProgressHUD showHUDAddedTo:view animated:NO];
        hud.dimBackground = YES;
    }
}

- (void)hideWaitView:(UIViewController *)viewController
{
    if ([viewController isKindOfClass:[UINavigationController class]]) {
        [MBProgressHUD hideAllHUDsForView:((UINavigationController *)viewController).topViewController.view animated:NO];
    }
    else
    {
        [MBProgressHUD hideAllHUDsForView:viewController.view animated:NO];
    }
    hud = nil;
}

+ (void)setToken:(NSString *)token
{
    sharedInstance.mToken = token;
}

+ (void)setDictionary:(NSMutableDictionary *)dictionary
{
    sharedInstance.mDictionary = dictionary;
    NSLog(@"%@",sharedInstance.mDictionary);
}

@end
