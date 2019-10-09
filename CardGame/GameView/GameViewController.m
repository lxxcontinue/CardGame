//
//  GameViewController.m
//  CardGame
//
//  Created by LXX on 2019/9/22.
//  Copyright © 2019年 LXX. All rights reserved.
//

#import "GameViewController.h"
#import "ScoreViewController.h"

#import "LxxInterfaceConnection.h"
#import "UserInfo.h"

@interface GameViewController ()

@property (nonatomic) NSString * token ;
@property (nonatomic) NSMutableArray *cardArr;

@end

static const CGFloat kTimeOutTime = 10.f;

@implementation GameViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.cardLabel.text = self.cardStr;
    
    NSLog(@"id:%@  card:%@",self.gameID,self.cardStr);
    
    [self creatCard];
}

-(void)creatCard{
    self.cardArr = [[NSMutableArray alloc]init];
    [self.cardArr addObject:[NSString stringWithFormat:@"*2 *3 *4"]];
    [self.cardArr addObject:[NSString stringWithFormat:@"*5 *6 *7 *8 *9"]];
    [self.cardArr addObject:[NSString stringWithFormat:@"*10 *J *Q *K *A"]];
}

- (IBAction)popAction:(UIButton *)sender {
//    [self.navigationController popViewControllerAnimated:YES];
    [self dismissViewControllerAnimated:YES completion:nil];
}
- (IBAction)commitAction:(UIButton *)sender {
//    ScoreViewController *svc = [[ScoreViewController alloc]init];
//    [self presentViewController:svc animated:YES completion:nil];
    
    // 1.创建请求
    NSURL *url = [NSURL URLWithString:@"https://api.shisanshui.rtxux.xyz/game/submit"];
    
    NSMutableURLRequest *request=[NSMutableURLRequest requestWithURL:url cachePolicy:NSURLRequestReloadIgnoringLocalCacheData timeoutInterval:kTimeOutTime];
    request.HTTPMethod = @"POST";
    // 2.设置请求头
    [request setValue:self.token forHTTPHeaderField:@"X-Auth-Token"];
    // 3.设置请求体
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    [dic setObject:self.cardArr forKey:@"card"];
    [dic setObject:self.gameID forKey:@"id"];
    
    NSData *data = [NSJSONSerialization dataWithJSONObject:dic options:0 error:nil];
    request.HTTPBody = data;
    
    // 4.发送请求
    NSURLSession *session = [NSURLSession sessionWithConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration] delegate:nil delegateQueue:[[NSOperationQueue alloc]init]];
    
    //__block  NSString *result = @"";
    NSURLSessionDataTask *dataTask = [session dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        
        if (!error) {
            NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
            
            NSDictionary *dataDic = [[NSDictionary alloc]initWithDictionary:[dict objectForKey:@"data"]];
            NSLog(@"msg: %@",[dataDic objectForKey:@"msg"]);
            
            NSArray *arr = [NSJSONSerialization JSONObjectWithData:data options:0 error:NULL];
            NSLog(@"返回正确：%@",arr);
            
            dispatch_async(dispatch_get_main_queue(), ^{
                
                [self dismissViewControllerAnimated:YES completion:nil];
            });
            
        }else{
            NSLog(@"错误信息：%@",error);
        }
    }];
    [dataTask resume];
    

}

-(void)yjn{
    NSMutableArray * arr = [[NSMutableArray alloc]init];
    for (int i=1; i<=4; i++){
        NSMutableDictionary *dic = [[NSMutableDictionary alloc]init];
        [dic setObject:[NSString stringWithFormat:@"%d",i]  forKey:@"type"];
        [dic setObject:[NSString stringWithFormat:@"13"] forKey:@"rank"];
        [arr addObject:dic];
    }
    for (int i=1; i<=2; i++){
        NSMutableDictionary *dic = [[NSMutableDictionary alloc]init];
        [dic setObject:[NSString stringWithFormat:@"%d",i]  forKey:@"type"];
        [dic setObject:[NSString stringWithFormat:@"3"] forKey:@"rank"];
        [arr addObject:dic];
    }
    for (int i=1; i<=2; i++){
        NSMutableDictionary *dic = [[NSMutableDictionary alloc]init];
        [dic setObject:[NSString stringWithFormat:@"%d",i]  forKey:@"type"];
        [dic setObject:[NSString stringWithFormat:@"5"] forKey:@"rank"];
        [arr addObject:dic];
    }
    for (int i=1; i<=2; i++){
        NSMutableDictionary *dic = [[NSMutableDictionary alloc]init];
        [dic setObject:[NSString stringWithFormat:@"%d",i]  forKey:@"type"];
        [dic setObject:[NSString stringWithFormat:@"8"] forKey:@"rank"];
        [arr addObject:dic];
    }
    for (int i=1; i<=2; i++){
        NSMutableDictionary *dic = [[NSMutableDictionary alloc]init];
        [dic setObject:[NSString stringWithFormat:@"%d",i]  forKey:@"type"];
        [dic setObject:[NSString stringWithFormat:@"9"] forKey:@"rank"];
        [arr addObject:dic];
    }
    NSMutableDictionary *dic = [[NSMutableDictionary alloc]init];
    [dic setObject:[NSString stringWithFormat:@"2"]  forKey:@"type"];
    [dic setObject:[NSString stringWithFormat:@"4"] forKey:@"rank"];
    [arr addObject:dic];
    
    
    // 1.创建请求
    NSURL *url = [NSURL URLWithString:@"http://122.51.19.148:8080/Card13SpringBoot-1.0-SNAPSHOT/hello"];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
    request.HTTPMethod = @"POST";
    // 2.设置请求头
    [request setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    // 3.设置请求体
    NSData *data = [NSJSONSerialization dataWithJSONObject:arr options:NSJSONWritingPrettyPrinted error:nil];
    request.HTTPBody = data;
    // 4.发送请求
    NSURLSession *session = [NSURLSession sharedSession];
    __block  NSString *result = @"";
    NSURLSessionDataTask *dataTask = [session dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        if (!error) {
            //没有错误，返回正确；
            result = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
            NSLog(@"返回正确：%@",result);
            NSArray *arr = [NSJSONSerialization JSONObjectWithData:data options:0 error:NULL];
            NSLog(@"返回正确：%@",arr);
        }else{
            //出现错误；
            NSLog(@"错误信息：%@",error);
        }
    }];
    [dataTask resume];
}

//数组转json
- (NSString*)ArrToJSONString:(NSArray  *)arr{
    NSError*error =nil;
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:arr options:kNilOptions error:&error];

    NSString *jsonString = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
    return jsonString;
}

@end