//
//  HFLViewController.m
//  HFLMuMenu.Kit
//
//  Created by Hflydragon on 04/28/2020.
//  Copyright (c) 2020 Hflydragon. All rights reserved.
//

#import "HFLViewController.h"
#import "HFLMuFlexBasicVM.h"
#import "HFLMutFlexRowBasic.h"



@interface HFLCGoodsListVM : HFLMuFlexBasicVM

@end

@implementation HFLCGoodsListVM

- (void)xy_managerFlexRowItemActions:(NSInteger)index
{
    
}

@end



@interface HFLViewController ()

@end

@implementation HFLViewController


- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    self.view.backgroundColor = [UIColor grayColor];
    
    [self createNormalWithTitle];
    
    [self createNormalNoTitle];
    
    [self customTitle];
    
    [self leftImageCustom];
    
    [self platformInfo];
}

/// 带标题的常规menu
- (void)createNormalWithTitle
{
    HFLMutFlexRowTitleBasic *shopDataView = [HFLMutFlexRowTitleBasic flexRowTitleBasic:@"店铺数据"];
    shopDataView.backgroundColor = [UIColor whiteColor];
   [self.view addSubview:shopDataView];
    shopDataView.frame = CGRectMake(0, 100, UIScreen.mainScreen.bounds.size.width, 130);
    NSArray *ItemArray = @[
       [HFLBasicModel itemModelTitle:@"今日访客" value:@"5"],
       [HFLBasicModel itemModelTitle:@"今日订单数" value:@"35"],
       [HFLBasicModel itemModelTitle:@"今日订单金额(元)" value:@"135"],
    ];
    
    HFLMuFlexBasicVM *shopDataViewModel = [HFLMuFlexBasicVM new];
    [shopDataViewModel xy_managerFlexRowView:shopDataView.basicView];
    [shopDataViewModel xy_managerFlexRowModel:ItemArray];
}

/// 不带标题的常规menu
- (void)createNormalNoTitle
{
    HFLMutFlexRowBasic *shopDataView = [HFLMutFlexRowBasic flexRowBasic];
    shopDataView.textColor = [UIColor redColor];
    shopDataView.subTextColor = [UIColor blueColor];
    shopDataView.font = [UIFont systemFontOfSize:25];
    shopDataView.subFont = [UIFont systemFontOfSize:12];
    shopDataView.supBounds = UIScreen.mainScreen.bounds.size.width - 30;
    shopDataView.corssAligmentCount = 4;
    shopDataView.backgroundColor = [UIColor whiteColor];
    shopDataView.layer.cornerRadius = 10;
    [self.view addSubview:shopDataView];
     shopDataView.frame = CGRectMake(15, 260, shopDataView.supBounds, 200);
     NSArray *ItemArray = @[
        [HFLBasicModel itemModelTitle:@"今日访客" value:@"5"],
        [HFLBasicModel itemModelTitle:@"今日订单数" value:@"35"],
        [HFLBasicModel itemModelTitle:@"今日卖出(元)" value:@"135"],
        [HFLBasicModel itemModelTitle:@"明日访客" value:@"15"],
        [HFLBasicModel itemModelTitle:@"明日订单数" value:@"20"],
        [HFLBasicModel itemModelTitle:@"明日卖出(元)" value:@"无"],
     ];
     
     HFLMuFlexBasicVM *shopDataViewModel = [HFLMuFlexBasicVM new];
     [shopDataViewModel xy_managerFlexRowView:shopDataView];
     [shopDataViewModel xy_managerFlexRowModel:ItemArray];
}


/// 自定义titleView
- (void)customTitle
{
    NSString *dataString = @"店铺已累计赚取 7.8 元";
    NSMutableAttributedString *attribute = [[NSMutableAttributedString alloc] initWithString:dataString];
    [attribute setAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:12]} range:NSMakeRange(0, dataString.length)];
    [attribute setAttributes:@{NSForegroundColorAttributeName:[UIColor whiteColor]} range:NSMakeRange(0, dataString.length)];
    [attribute setAttributes:@{NSForegroundColorAttributeName:[UIColor colorWithRed:1.0 green:3/5.f blue:3/255.f alpha:1.0]} range:[dataString rangeOfString:@"7.8"]];
    
    UIButton *btn = [[UIButton alloc] init];
    btn.titleLabel.font = [UIFont systemFontOfSize:12];
    [btn setImage:[UIImage imageNamed:@"content_icon_shouyi"] forState:UIControlStateNormal];
    [btn setAttributedTitle:attribute forState:UIControlStateNormal];
    btn.titleEdgeInsets = UIEdgeInsetsMake(0, 2.5, 0, -2.5);
    btn.imageEdgeInsets = UIEdgeInsetsMake(0, -2.5, 0, 2.5);
    
    HFLMutFlexRowTitleBasic *funView = [HFLMutFlexRowTitleBasic flexRowTitleBasicSepcialHead:btn];
    funView.backgroundColor = [UIColor colorWithRed:24/255.f green:22/255.f blue:44/255.f alpha:1.0];
    funView.layer.shadowOffset = CGSizeMake(0, 0); //(0,0)时是四周都有阴影
    funView.layer.shadowRadius = 15;
    funView.layer.shadowColor = UIColor.whiteColor.CGColor;
    funView.layer.shadowOpacity = 1;
    funView.layer.cornerRadius = 10;
    funView.headLineColor = [[UIColor whiteColor] colorWithAlphaComponent:0.1];
    funView.frame = CGRectMake(15, 480, UIScreen.mainScreen.bounds.size.width - 30, 130);
    
    [self.view addSubview:funView];
    
    funView.basicView = [HFLMutFlexRowBasic flexRowBasicForAligment:NSTextAlignmentLeft];
    funView.basicView.textColor = [UIColor whiteColor];
    funView.basicView.subTextColor = [[UIColor whiteColor] colorWithAlphaComponent:0.5];
    funView.basicView.showGapLine = NO;
    
    NSArray *ItemArray = @[
       [HFLBasicModel itemModelTitle:@"今日访客" value:@"5"],
       [HFLBasicModel itemModelTitle:@"今日订单数" value:@"35"],
    ];
    
    HFLMuFlexBasicVM *manager = [HFLMuFlexBasicVM new];
    [manager xy_managerFlexRowView:funView.basicView];
    [manager xy_managerFlexRowModel:ItemArray];
}

- (void)leftImageCustom
{
    HFLMutFlexRowBasic *bottomView = [HFLMutFlexRowBasic flexRowBasicForAligment:NSTextAlignmentLeft];
    bottomView.supBounds = UIScreen.mainScreen.bounds.size.width - 2 * 24;
    bottomView.lineColor = [UIColor colorWithRed:244/255.f green:224/255.f blue:244/255.f alpha:1.0];
    bottomView.backgroundColor = UIColor.whiteColor;
    bottomView.frame = CGRectMake(12, 630, UIScreen.mainScreen.bounds.size.width - 24, 50);
    [self.view addSubview:bottomView];
    
    HFLCGoodsListVM *vm =  [HFLCGoodsListVM new];
    [vm xy_managerFlexRowView:bottomView];
    
    NSArray *ItemArray = @[
        [HFLBasicModel itemModelTitle:@"下架" value:@"icon_xiajia" type:XYBasicItemTypeLeftImage],
        [HFLBasicModel itemModelTitle:@"改价" value:@"icon_gaijia" type:XYBasicItemTypeLeftImage],
        [HFLBasicModel itemModelTitle:@"分享" value:@"icon_fenxiang" type:XYBasicItemTypeLeftImage],
    ];
    [vm xy_managerFlexRowModel:ItemArray];
}

/// 带标题的可自定义的view
- (void)platformInfo
{
    HFLMutFlexRowTitleBasic *shopDataView = [HFLMutFlexRowTitleBasic flexRowTitleBasic:@"平台管理"];
    shopDataView.basicView.corssAligmentCount = 4;
    shopDataView.basicView.paddingleading = 25;
    shopDataView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:shopDataView];
     shopDataView.frame = CGRectMake(0, 700, UIScreen.mainScreen.bounds.size.width, 130);
     NSArray *ItemArray = @[
        [HFLBasicModel itemModelTitle:@"自定义" value:@"icon_xiajia" type:XYBasicItemTypeTopImage],
        [HFLBasicModel itemModelTitle:@"每行显示" value:@"icon_gaijia" type:XYBasicItemTypeTopImage],
        [HFLBasicModel itemModelTitle:@"多少个" value:@"icon_fenxiang" type:XYBasicItemTypeTopImage],
     ];
     
     HFLMuFlexBasicVM *shopDataViewModel = [HFLMuFlexBasicVM new];
     [shopDataViewModel xy_managerFlexRowView:shopDataView.basicView];
     [shopDataViewModel xy_managerFlexRowModel:ItemArray];
}

@end





