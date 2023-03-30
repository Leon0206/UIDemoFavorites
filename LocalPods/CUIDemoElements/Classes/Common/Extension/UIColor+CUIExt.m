//
//  UIColor+Ext.m
//  Pods
//
//  Created by zitao on 03/30/2021.
//  Copyright (c) 2021 zitao. All rights reserved.
//

#import "UIColor+CUIExt.h"

@implementation UIColor (CUIExt)

+ (UIColor *)cui_colorWithHexString:(NSString *)hexString
{
    return [UIColor cui_colorWithHexString:hexString alpha:1.0];
}

+ (UIColor *)cui_colorWithHexString:(NSString *)hexString alpha:(CGFloat)alpha
{
    if ([hexString hasPrefix:@"#"]) {
        hexString = [hexString stringByReplacingOccurrencesOfString:@"#" withString:@""];
    }
    
    if (hexString.length == 3) {
        NSUInteger value = 0;
        if (sscanf(hexString.UTF8String, "%tx", &value)) {
            NSUInteger r, g, b;
            r = (value & 0x0f00) >> 8;
            g = (value & 0x00f0) >> 4;
            b = (value & 0x000f) >> 0;
            return [UIColor colorWithRed:1.f * (r) / 0x0f
                                   green:1.f * (g) / 0x0f
                                    blue:1.f * (b) / 0x0f
                                   alpha:alpha];
        }
        return nil;
    }
    else if (hexString.length == 6) {
        NSUInteger value = 0;
        if (sscanf(hexString.UTF8String, "%tx", &value)) {
            return [self cui_colorWithHex:value alpha:alpha];
        }
        return nil;
    }
    else {
        return nil;
    }
}

+ (UIColor *)cui_colorWithHex:(NSUInteger)hexColor
{
    return [self cui_colorWithHex:hexColor alpha:1.f];
}

+ (UIColor *)cui_colorWithHex:(NSUInteger)hexColor alpha:(CGFloat)alpha
{
    return [UIColor colorWithRed:1.f * (hexColor >> 16 & 0xff) / 0xff
                           green:1.f * (hexColor >>  8 & 0xff) / 0xff
                            blue:1.f * (hexColor >>  0 & 0xff) / 0xff
                           alpha:alpha];
}

@end
