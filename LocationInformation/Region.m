//
//  Region.m
//  LocationInformation
//
//  Created by china on 15/10/29.
//  Copyright © 2015年 china. All rights reserved.
//

#import "Region.h"

@implementation Region

+ (NSString *)getCountryCode
{
    return [[NSLocale currentLocale] objectForKey:NSLocaleCountryCode];
}

+ (NSString *)getLanguageCode
{
    return [[NSLocale currentLocale] objectForKey:NSLocaleLanguageCode];
}



+ (NSString *)getLanguageCollatorIdentifierCode
{
    return [[NSLocale currentLocale] objectForKey:NSLocaleCollatorIdentifier];
}



+ (NSString *)getNSLocaleCurrencyCode
{
    return [[NSLocale currentLocale] objectForKey:NSLocaleCurrencyCode];
}


+ (NSString *)getNSLocaleCurrencySymbol
{
    return [[NSLocale currentLocale] objectForKey:NSLocaleCurrencySymbol];
}


@end
