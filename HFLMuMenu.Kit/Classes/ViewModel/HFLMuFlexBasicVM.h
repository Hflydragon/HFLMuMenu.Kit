//
//  XYMuFlexBasicVM.h
//  XingYunGlobalMall
//
//  Created by fly on 2020/3/31.
//  Copyright © 2020 xyb2b. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "HFLBasicModel.h"

#pragma mark --封装的item与model的管理类，这里最好继承类，使用子类进行一些定制化
@class HFLMutFlexRowBasic;


NS_ASSUME_NONNULL_BEGIN

@interface HFLMuFlexBasicVM : NSObject

/// 绑定view
/// @param vm  绑定的view
- (void)xy_managerFlexRowView:(HFLMutFlexRowBasic *)vm;

/// 数据源加载初始化
/// @param modelArray 数据
- (void)xy_managerFlexRowModel:(NSArray <HFLBasicModel *> *)modelArray;

/// 数据源更新
- (void)xy_managerFlexRowUpdateModel:(NSArray *(^)(NSArray <HFLBasicModel *> *modelData))modelArray;

/// item的点击事件，这里子类重写，不要主动调用
/// @param index 点击的item
- (void)xy_managerFlexRowItemActions:(NSInteger)index;

@end

NS_ASSUME_NONNULL_END
