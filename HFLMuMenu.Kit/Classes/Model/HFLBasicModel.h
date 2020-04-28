//
//  XYBasicModel.h
//  XingYunGlobalMall
//
//  Created by fly on 2020/3/31.
//  Copyright © 2020 xyb2b. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN
typedef NS_ENUM(NSInteger , XYBasicItemType){
    XYBasicItemTypeAllTitle = 0,//默认为上下都是label
    XYBasicItemTypeTopImage, //上面为图片 下面为标题的类型
    XYBasicItemTypeLeftImage, //左边为图片 右边为标题
};

@interface HFLBasicModel : NSObject

@property (nonatomic , copy) NSString *valueData;
@property (nonatomic , copy) NSString *titleData;

@property (nonatomic , assign) NSInteger XYBasicItemType;

+ (instancetype)itemModelTitle:(NSString *)title value:(NSString *)value;

+ (instancetype)itemModelTitle:(NSString *)title value:(NSString *)value type:(XYBasicItemType)type;

@end

NS_ASSUME_NONNULL_END
