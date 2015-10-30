//
//  Region.h
//  LocationInformation
//
//  Created by china on 15/10/29.
//  Copyright © 2015年 china. All rights reserved.
//http://www.cnblogs.com/pengyingh/articles/2354968.html

#import <Foundation/Foundation.h>

@interface Region : NSObject
//国家代码
+ (NSString *)getCountryCode;
//语言代码
+ (NSString *)getLanguageCode;
//具体语言码不会随设备的语言改
+ (NSString *)getLanguageCollatorIdentifierCode;
//货币代码
+ (NSString *)getNSLocaleCurrencyCode;
//货币符号
+ (NSString *)getNSLocaleCurrencySymbol;



@end
