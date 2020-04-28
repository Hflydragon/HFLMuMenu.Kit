//
//  XYCloudShopMutFlexRowBasic.m
//  XingYunGlobalMall
//
//  Created by fly on 2020/3/31.
//  Copyright © 2020 xyb2b. All rights reserved.
//

#import "HFLMutFlexRowBasic.h"
#import "HFLBasicModel.h"
#import <Masonry/Masonry.h>

@interface XYMutFlexRowBasicItem : UIView
//item两个label之间的间距,default distance is 10
@property (nonatomic , assign) CGFloat paddingleading;
//字体
@property (nonatomic , strong) UIFont *font;
//子标题字体,default font size is 12
@property (nonatomic , strong) UIFont *subFont;
//标题字体颜色,default color is whiteColor
@property (nonatomic , strong) UIColor *textColor;
//子标题字体颜色 ,default color is whiteColor
@property (nonatomic , strong) UIColor *subTextColor;
//是否显示中间线,default 'YES'
@property (nonatomic , assign) BOOL showGapLine;
@property (nonatomic , strong) UIColor *lineColor;
@property (nonatomic , assign) NSInteger aligment;

@end


@implementation XYMutFlexRowBasicItem
{
    UILabel *_titleLabel;
    UILabel *_subTileLabel;
    UIImageView *_imageV;
    UIView *_lineView;
}

-(instancetype)initWithData:(HFLBasicModel *)basicModel paddingleading:(CGFloat)leading
{
    if(self = [super init]){
        self.paddingleading = leading;
        if(basicModel.XYBasicItemType == XYBasicItemTypeTopImage || basicModel.XYBasicItemType == XYBasicItemTypeLeftImage){
            [self imageViewWithImageName:basicModel.valueData type:basicModel.XYBasicItemType supView:self];
        }else{
            [self labelWithText:basicModel.valueData isSub:NO type:basicModel.XYBasicItemType supView:self];
        }
        [self labelWithText:basicModel.titleData isSub:YES type:basicModel.XYBasicItemType supView:self];
        [self viewForLastlineFromView:self];
    }
    return self;
}

- (void)loadDatas:(HFLBasicModel *)basicModel
{
    if(basicModel.XYBasicItemType == XYBasicItemTypeTopImage || basicModel.XYBasicItemType == XYBasicItemTypeLeftImage){
        _imageV.image = [UIImage imageNamed:basicModel.valueData];
    }else{
       _titleLabel.text = basicModel.valueData;
    }
    _subTileLabel.text = basicModel.titleData;
}

- (void)loadConfig
{
    _titleLabel.font = self.font;
    _subTileLabel.font = self.subFont;
    _titleLabel.textColor = self.textColor;
    _subTileLabel.textColor = self.subTextColor;
    _titleLabel.textAlignment = self.aligment;
    _subTileLabel.textAlignment = self.aligment;
    _lineView.backgroundColor = self.lineColor;
    _lineView.hidden = !self.showGapLine;
}

- (UILabel *)labelWithText:(NSString *)text isSub:(BOOL)sub type:(XYBasicItemType)itemType supView:(UIView *)supv
{
    UILabel *label = [[UILabel alloc] init];
    label.text = text;
    [supv addSubview:label];
    [label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(supv).offset(-12);
        if(itemType == XYBasicItemTypeLeftImage && sub){
            make.left.equalTo(supv.mas_centerX).offset(self.paddingleading/2);
            make.centerY.equalTo(supv);
        }else{
            make.left.equalTo(supv).offset(12);
        }
        if(itemType != XYBasicItemTypeLeftImage){
            if(sub){
                make.top.equalTo(supv.mas_centerY).offset(self.paddingleading/2);
            }else{
                make.bottom.equalTo(supv.mas_centerY).offset(-self.paddingleading/2);
            }
        }
    }];
    if(sub){
        _subTileLabel = label;
    }else{
        _titleLabel = label;
    }
    return label;
}

- (UIImageView *)imageViewWithImageName:(NSString *)imageName type:(XYBasicItemType)itemType supView:(UIView *)supv
{
    UIImageView *imageV = [[UIImageView alloc] init];
    imageV.contentMode = UIViewContentModeScaleAspectFit;
    imageV.image = [UIImage imageNamed:imageName];
    _imageV = imageV;
    [supv addSubview:imageV];
    [imageV mas_makeConstraints:^(MASConstraintMaker *make) {
        if(itemType == XYBasicItemTypeLeftImage){
            make.right.equalTo(supv.mas_centerX).offset(-(self.paddingleading/2));
            make.centerY.equalTo(supv);
            make.width.height.equalTo(@20);
        }else{
            make.centerX.equalTo(supv);
            make.centerY.equalTo(supv).offset(-(self.paddingleading/2));
            make.width.height.equalTo(@40);
        }
        
    }];
    return imageV;
}

- (UIView *)viewForLastlineFromView:(UIView *)baseView
{
    UIView *lineView = [[UIView alloc] init];
    lineView.backgroundColor = [UIColor whiteColor];
    _lineView = lineView;
    [baseView addSubview:lineView];
    [lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.centerY.equalTo(baseView);
        make.height.equalTo(@24);
        make.width.equalTo(@1);
    }];
    return lineView;
}

@end


@interface HFLMutFlexRowBasic ()

@property (nonatomic , strong) NSMutableArray *dataArray;
@property (nonatomic , strong) NSMutableArray *eventArray;

@property (nonatomic , assign) NSInteger aligment;

@property (nonatomic , strong) UIView *previousView;

@end

@implementation HFLMutFlexRowBasic

+ (instancetype)flexRowBasic
{
    return [self flexRowBasicForAligment:NSTextAlignmentCenter];
}

+ (instancetype)flexRowBasicForAligment:(NSTextAlignment)aligment
{
    HFLMutFlexRowBasic *rowBasic = [[HFLMutFlexRowBasic alloc] init];
    rowBasic.aligment = aligment;
    return rowBasic;
}

- (instancetype)init{
    if(self = [super init])
    {
        self.showGapLine = YES;
        self.paddingCenter = 0;
        self.paddingleading = 10;
        self.corssAligmentCount = 0;
        self.supBounds     = UIScreen.mainScreen.bounds.size.width;
        self.font          = [UIFont fontWithName:@"Verdana" size:18];
        self.subFont       = [UIFont systemFontOfSize:12];
        self.textColor     = [UIColor blackColor];
        self.subTextColor  = [UIColor blackColor];
        self.lineColor     = [[UIColor whiteColor] colorWithAlphaComponent:0.1];
        self.dataArray     = [NSMutableArray arrayWithCapacity:3];
        self.eventArray = [NSMutableArray arrayWithCapacity:3];
    }
    return self;
}


- (void)xy_bindBuildDatas:(NSArray *(^)(void))complent bindEventActions:(void(^)(NSArray *))events
{
    if(complent){
        [self.dataArray removeAllObjects];
        [self.dataArray addObjectsFromArray:complent()];
        [self buildSubviews];
    }
    if(events){
        events([self.eventArray mutableCopy]);
    }
}

- (void)xy_bindUpdateDatas:(NSArray *)dataArray
{
    [self.dataArray removeAllObjects];
    [self.dataArray addObjectsFromArray:[dataArray copy]];
    for (UITapGestureRecognizer *sender in self.eventArray) {
        XYMutFlexRowBasicItem *item = (XYMutFlexRowBasicItem *)sender.view;
        [item loadDatas:self.dataArray[item.tag - MAX_CANON]];
    }
}

- (void)buildSubviews
{
    [self.eventArray removeAllObjects];
    
    self.corssAligmentCount = self.corssAligmentCount > 0 ? self.corssAligmentCount : self.dataArray.count;
    
    if(self.paddingCenter <= 0){
        self.paddingCenter =  self.supBounds/ self.corssAligmentCount;
    }
    
    for (HFLBasicModel *model in self.dataArray) {
        NSUInteger index = [self.dataArray indexOfObject:model];
        
        XYMutFlexRowBasicItem *contentV = [[XYMutFlexRowBasicItem alloc] initWithData:model paddingleading:self.paddingleading];
        contentV.tag                    = index + MAX_CANON;
        contentV.font                   = self.font;
        contentV.subFont                = self.subFont;
        contentV.textColor              = self.textColor;
        contentV.subTextColor           = self.subTextColor;
        contentV.aligment               = self.aligment;
        contentV.showGapLine            = self.showGapLine && index != self.dataArray.count -1;
        contentV.lineColor              = self.lineColor;
        [contentV loadConfig];
        [self addSubview:contentV];
        
        [self setFrames:contentV previous:self.previousView index:index];
        self.previousView = contentV;

        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] init];
        [contentV addGestureRecognizer:tap];
        [self.eventArray addObject:tap];
    }
}

- (void)setFrames:(UIView *)view previous:(UIView *)previousView index:(NSUInteger)indexObject
{
    long i = indexObject % self.corssAligmentCount;//行
    long j = indexObject / self.corssAligmentCount;//列
    if(!previousView){
        [view mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self);
            make.top.equalTo(self);
            make.width.equalTo(@(self.paddingCenter));
            make.height.equalTo(self).dividedBy((MAX(1, self.dataArray.count) - 1)/self.corssAligmentCount + 1);
        }];
    }else{
        [view mas_makeConstraints:^(MASConstraintMaker *make) {
            if(i == 0){
                make.left.equalTo(self);
                make.top.equalTo(previousView.mas_bottom);
            }else{
                make.centerX.equalTo(previousView).offset(self.paddingCenter);
                make.top.equalTo(previousView);
            }
            if(j == 0){
               make.width.equalTo(@(self.paddingCenter));
            }else{
               make.width.equalTo(previousView);
            }
            make.height.equalTo(previousView);
        }];
    }
}


- (void)layoutSubviews
{
    [super layoutSubviews];
}

@end















@implementation HFLMutFlexRowTitleBasic
{
    UIView *_headView;
    NSString *_title;
    UIView *_lineView;
}

+ (instancetype _Nullable )flexRowTitleBasic:(NSString *_Nullable)title
{
    return [[self alloc] initWithTitleString:title];
}
+ (instancetype _Nullable )flexRowTitleBasicSepcialHead:(UIView *_Nullable)specialHead
{
    return [[self alloc] initWithSepcial:specialHead];
}
-(instancetype)initWithSepcial:(UIView *_Nullable)specialHead
{
    if(self = [super init]){
        _basicView = [HFLMutFlexRowBasic flexRowBasic];
        [self addSubview:_basicView];

        _headView = specialHead;
        [self addSubview:specialHead];
        
        _lineView = [[UIView alloc] init];
        [self addSubview:_lineView];
        
        self.headLineColor = [UIColor colorWithRed:241 / 255.0 green:241 / 255.0 blue:241 / 255.0 alpha:1.0 / 1.0];
        self.headerHeight = 48;
    }
    return self;
}

-(instancetype)initWithTitleString:(NSString *)title
{
    if(self = [super init]){
        _title = title;
        _basicView = [HFLMutFlexRowBasic flexRowBasic];
        [self addSubview:_basicView];
        
        UILabel *headTitleL        = [[UILabel alloc] init];
        headTitleL.textColor = [UIColor colorWithRed:46 / 255.0 green:48 / 255.0 blue:51 / 255.0 alpha:1.0 / 1.0];
        headTitleL.font      = [UIFont systemFontOfSize:16 weight:UIFontWeightMedium];
        headTitleL.text      = title;
        _headView = headTitleL;
        [self addSubview:headTitleL];
        
        _lineView = [[UIView alloc] init];
        [self addSubview:_lineView];
        
        self.headLineColor = [UIColor colorWithRed:241 / 255.0 green:241 / 255.0 blue:241 / 255.0 alpha:1.0 / 1.0];
        self.headerHeight = 48;
    }
    return self;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    [_headView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).offset(12);
        make.right.lessThanOrEqualTo(self).offset(-12);
        make.top.equalTo(self);
        make.height.equalTo(@(self.headerHeight));
    }];
    [_lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).offset(12);
        make.right.equalTo(self).offset(-12);
        make.top.equalTo(_headView.mas_bottom);
        make.height.equalTo(@1);
    }];
    [_basicView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.equalTo(self);
        make.top.equalTo(_lineView.mas_bottom);
    }];
}


- (void)setBasicView:(HFLMutFlexRowBasic *)basicView
{
    [_basicView removeFromSuperview];
    _basicView = basicView;
    [self addSubview:_basicView];
    [self layoutIfNeeded];
}

- (void)setHeadLineColor:(UIColor *)headLineColor
{
    _headLineColor = headLineColor;
    _lineView.backgroundColor = _headLineColor;
}

@end
