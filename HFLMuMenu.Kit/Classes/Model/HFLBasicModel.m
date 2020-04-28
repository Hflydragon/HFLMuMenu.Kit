//
//  XYBasicModel.m
//  XingYunGlobalMall
//
//  Created by fly on 2020/3/31.
//  Copyright © 2020 xyb2b. All rights reserved.
//

#import "HFLBasicModel.h"

@implementation HFLBasicModel

+ (instancetype)itemModelTitle:(NSString *)title value:(NSString *)value
{
    return [self itemModelTitle:title value:value type:XYBasicItemTypeAllTitle];
}

+ (instancetype)itemModelTitle:(NSString *)title value:(NSString *)value type:(XYBasicItemType)type
{
    HFLBasicModel *basicModel = [[HFLBasicModel alloc] init];
    basicModel.titleData = title;
    basicModel.valueData = value;
    basicModel.XYBasicItemType = type;
    return basicModel;
}

@end
