//
//  ViewController.m
//  LocationInformation
//
/*
 
 iOS 8对定位进行了一些修改，其中包括定位授权的方法，CLLocationManager增加了以下两个方法：
 
 Added -[CLLocationManager requestAlwaysAuthorization]
 
 Added -[CLLocationManager requestWhenInUseAuthorization]
 
 在使用定位服务前需要通过上面两个方法申请授权：
 
 [CLLocationManager requestAlwaysAuthorization] 授权使应用在前台后台都能使用定位服务
 
 -[CLLocationManager requestWhenInUseAuthorization] 授权则与之前的一样
 
 另外，在使用这两个方法授权前，必须在info.plist中增加相应的键值（
 */
//  Created by china on 15/10/28.
//  Copyright © 2015年 china. All rights reserved.
//

#import "ViewController.h"
#import <CoreLocation/CoreLocation.h>
#import "Region.h"
@interface ViewController ()<CLLocationManagerDelegate>
{
    CLLocationManager* _locationManager;
    
}

@property (strong, nonatomic) CLLocationManager* locationManager;
@end

@implementation ViewController



- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
//    CCLOG("country code:%s;language code=%s",
//          [RootViewController getCountryCode].UTF8String,[RootViewController getLanguageCode].UTF8String);
    
    NSLog(@"getCountryCode----%@",[Region getCountryCode]);
    
    NSLog(@"getLanguageCode----%@",[Region getLanguageCode]);
    NSLog(@"getLanguageCollatorIdentifierCode----%@",[Region getLanguageCollatorIdentifierCode]);
    NSLog(@"getNSLocaleCurrencyCode----%@",[Region getNSLocaleCurrencyCode]);
    NSLog(@"getNSLocaleCurrencySymbol----%@",[Region getNSLocaleCurrencySymbol]);

//    3.1 获得所支持的语言
    
    
    NSUserDefaults *defaults = [ NSUserDefaults standardUserDefaults ];
    NSArray *languages = [defaults objectForKey : @"AppleLanguages" ];
    
    NSLog(@"languages---%@",languages);
    
    // 取得 iPhone 支持的所有语言设置 NSArray *languages = [defaults objectForKey : @"AppleLanguages" ]; NSLog ( @"%@" , languages); 运行，打印结果： ( en, "zh-Hant", "zh-Hans", fr, de, ja, nl, it, es, pt, "pt-PT", da, fi, nb, sv, ko, ru, pl, tr, uk, ar, hr, cs, el, he, ro, sk, th, id, "en-GB", ca, hu, vi ) "zh-Hant" 繁体中文 "zh-Hans", 简体中文 这段代码获取当前系统支持的语言。
    
}



- (void)locationManager:(CLLocationManager *)manager

       didFailWithError:(NSError *)error {
    
    
    
    if (error.code == kCLErrorDenied) {
        
        NSLog(@"访问被拒绝");
        // 提示用户出错原因，可按住Option键点击 KCLErrorDenied的查看更多出错信息，可打印error.code值查找原因所在
        
    }
    if ([error code] == kCLErrorLocationUnknown) {
        //无法获取位置信息
        NSLog(@"无法获取位置信息");

    }
    
}


//开始定位
-(void)startLocation{
    
//    if(![CLLocationManager locationServicesEnabled]) {
//        //......
//        
//        UIAlertView *alert=[[UIAlertView alloc]initWithTitle:nil message:nil delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:@"无法进行定位操作",nil];
//        [alert show];
//        
//        return;
//      
//    }
    
    self.locationManager = [[CLLocationManager alloc] init];
    self.locationManager.delegate = self;
    
    if ([[[UIDevice currentDevice] systemVersion] floatValue]  >= 8.0) {
        //使用期间
        [self.locationManager requestWhenInUseAuthorization];
        //始终
        //or [self.locationManage requestAlwaysAuthorization]
    }
    self.locationManager.desiredAccuracy = kCLLocationAccuracyBest;
    self.locationManager.distanceFilter = 10.0f;
    [self.locationManager startUpdatingLocation];
}

//定位代理经纬度回调
-(void)locationManager:(CLLocationManager *)manager didUpdateToLocation:(CLLocation *)newLocation fromLocation:(CLLocation *)oldLocation {
    
    [_locationManager stopUpdatingLocation];
    
    
//    // 保存 Device 的现语言 (英语 法语 ，，，)
//    NSMutableArray *userDefaultLanguages = [[NSUserDefaults standardUserDefaults]
//                                            objectForKey:@"AppleLanguages"];
//    // 强制 成 简体中文
//    [[NSUserDefaults standardUserDefaults] setObject:[NSArray arrayWithObjects:@"zh-hans",nil]
//                                              forKey:@"AppleLanguages"];

    
    
    
    
    NSLog(@"location ok");
    
    NSLog(@"%@",[NSString stringWithFormat:@"经度:%3.5f\n纬度:%3.5f",newLocation.coordinate.latitude,newLocation.coordinate.longitude]);
    
    CLGeocoder * geoCoder = [[CLGeocoder alloc] init];
    
    [geoCoder reverseGeocodeLocation:newLocation completionHandler:^(NSArray *placemarks, NSError *error) {
        for (CLPlacemark * placemark in placemarks) {
            
            NSDictionary *test = [placemark addressDictionary];
            //  Country(国家)  State(城市)  SubLocality(区)
            
            UIAlertView *alert=[[UIAlertView alloc]initWithTitle:nil message:nil delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:[test objectForKey:@"Country"],[test objectForKey:@"State"], [test objectForKey:@"SubLocality"],nil];
            
            
            
            [alert show];
            
            
            NSLog(@"Country--%@", [test objectForKey:@"Country"]);

            NSLog(@"State---%@", [test objectForKey:@"State"]);
            
            NSLog(@"SubLocality---%@", [test objectForKey:@"SubLocality"]);
            
            
            NSLog(@"test---%@",test);
            
            
            
            
//            NSLog(@"name---%@", [test objectForKey:@"Name"]);
//            NSLog(@"thoroughfare---%@", [test objectForKey:@"Thoroughfare"]);
//            NSLog(@"subThoroughfare---%@", [test objectForKey:@"SubThoroughfare"]);
//            NSLog(@"locality---%@", [test objectForKey:@"Locality"]);
//            NSLog(@"subLocality---%@", [test objectForKey:@"SubLocality"]);
//            NSLog(@"administrativeArea---%@", [test objectForKey:@"AdministrativeArea"]);
//            NSLog(@"subAdministrativeArea---%@", [test objectForKey:@"SubAdministrativeArea"]);
//            NSLog(@"postalCode---%@", [test objectForKey:@"PostalCode"]);
//            NSLog(@"ISOcountryCode---%@", [test objectForKey:@"ISOcountryCode"]);
//            NSLog(@"country---%@", [test objectForKey:@"Country"]);
//            NSLog(@"inlandWater---%@", [test objectForKey:@"InlandWater"]);
//            NSLog(@"ocean---%@", [test objectForKey:@"Ocean"]);
//            NSLog(@"areasOfInterest---%@", [test objectForKey:@"AreasOfInterest"]);

            
            // address dictionary properties
//            @property (nonatomic, readonly, copy, nullable) NSString *name; // eg. Apple Inc.
//            @property (nonatomic, readonly, copy, nullable) NSString *thoroughfare; // street name, eg. Infinite Loop
//            @property (nonatomic, readonly, copy, nullable) NSString *subThoroughfare; // eg. 1
//            @property (nonatomic, readonly, copy, nullable) NSString *locality; // city, eg. Cupertino
//            @property (nonatomic, readonly, copy, nullable) NSString *subLocality; // neighborhood, common name, eg. Mission District
//            @property (nonatomic, readonly, copy, nullable) NSString *administrativeArea; // state, eg. CA
//            @property (nonatomic, readonly, copy, nullable) NSString *subAdministrativeArea; // county, eg. Santa Clara
//            @property (nonatomic, readonly, copy, nullable) NSString *postalCode; // zip code, eg. 95014
//            @property (nonatomic, readonly, copy, nullable) NSString *ISOcountryCode; // eg. US
//            @property (nonatomic, readonly, copy, nullable) NSString *country; // eg. United States
//            @property (nonatomic, readonly, copy, nullable) NSString *inlandWater; // eg. Lake Tahoe
//            @property (nonatomic, readonly, copy, nullable) NSString *ocean; // eg. Pacific Ocean
//            @property (nonatomic, readonly, copy, nullable) NSArray<NSString *> *areasOfInterest; // eg. Golden
            
        }
        
        // 还原Device 的语言
//        [[NSUserDefaults standardUserDefaults] setObject:userDefaultLanguages forKey:@"AppleLanguages"];

        
    }];
    


}

//在viewWillDisappear关闭定位
- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [_locationManager stopUpdatingLocation];


}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)click:(id)sender {
    [self startLocation];

}
@end
