//
//  XYCloudShopMutFlexRowBasic.h
//  XingYunGlobalMall
//
//  Created by fly on 2020/3/31.
//  Copyright © 2020 xyb2b. All rights reserved.
//

#import <UIKit/UIKit.h>

#pragma mark --封装的普通的 item，这里最好继承类，使用子类进行一些定制化
NS_ASSUME_NONNULL_BEGIN

@interface HFLMutFlexRowBasic : UIView
//item中点之间的间隙，默认平分父控件宽度
@property (nonatomic , assign) CGFloat paddingCenter;
//item两个label之间的间距,default distance is 10
@property (nonatomic , assign) CGFloat paddingleading;
//item父控件的宽度，默认为屏幕宽度
@property (nonatomic , assign) CGFloat supBounds;
//字体
@property (nonatomic , strong) UIFont *font;
//子标题字体,default font size is 12
@property (nonatomic , strong) UIFont *subFont;
//标题字体颜色,default color is whiteColor
@property (nonatomic , strong) UIColor *textColor;
//子标题字体颜色 ,default color is whiteColor
@property (nonatomic , strong) UIColor *subTextColor;
//每一行的item个数,default count is 3
@property (nonatomic , assign) NSInteger corssAligmentCount;
//是否显示中间线,default 'YES'
@property (nonatomic , assign) BOOL showGapLine;

@property (nonatomic , strong) UIColor *lineColor;

+ (instancetype)flexRowBasic;

+ (instancetype)flexRowBasicForAligment:(NSTextAlignment)aligment;
/**
  绑定点击事件 这里用协议是否会更好些，暂定
*/
- (void)xy_bindBuildDatas:(NSArray *(^)(void))complent bindEventActions:(void(^)(NSArray *events))events;

- (void)xy_bindUpdateDatas:(NSArray *)dataArray;

@end

NS_ASSUME_NONNULL_END

#pragma mark --封装带头部的控件
//封装带有头部标题的item
@interface  HFLMutFlexRowTitleBasic : UIView
//顶部的分割线颜色
@property (nonatomic , strong , nullable) UIColor *headLineColor;
@property (nonatomic , assign) CGFloat headerHeight;

//如果没有设置，默认会进行初始化
@property (nonatomic , strong ,readwrite) HFLMutFlexRowBasic * _Nullable basicView;

+ (instancetype _Nullable )flexRowTitleBasic:(NSString *_Nullable)title;

+ (instancetype _Nullable )flexRowTitleBasicSepcialHead:(UIView *_Nullable)specialHead;

@end
