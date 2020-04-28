//
//  XYMuFlexBasicVM.m
//  XingYunGlobalMall
//
//  Created by fly on 2020/3/31.
//  Copyright © 2020 xyb2b. All rights reserved.
//

#import "HFLMuFlexBasicVM.h"
#import "HFLMutFlexRowBasic.h"

@implementation HFLMuFlexBasicVM
{
    HFLMutFlexRowBasic *_basicView;
    NSArray <HFLBasicModel *> *_basicModel;
    NSArray <UITapGestureRecognizer *> *_events;
}

- (void)xy_managerFlexRowView:(HFLMutFlexRowBasic *)vm
{
    _basicView = vm;
}

- (void)xy_managerFlexRowModel:(NSArray <HFLBasicModel *> *)modelArray
{
    _basicModel = modelArray;
    
    __weak typeof(self) weakSelf = self;
    [_basicView xy_bindBuildDatas:^NSArray * _Nonnull{
        __strong typeof(weakSelf) strongSelf = weakSelf;
        return strongSelf->_basicModel;
    } bindEventActions:^(NSArray * events) {
        __strong typeof(weakSelf) strongSelf = weakSelf;
        strongSelf->_events = [events copy];
        [strongSelf dealForEvents];
    }];
}

- (void)xy_managerFlexRowUpdateModel:(NSArray *(^)(NSArray <HFLBasicModel *> *modelData))modelArray
{
    if(modelArray){
        _basicModel = modelArray(_basicModel);
        [_basicView xy_bindUpdateDatas:_basicModel];
    }
}

- (void)dealForEvents
{
    for (UITapGestureRecognizer *tap in _events) {
        [tap addTarget:self action:@selector(actionForTouchItems:)];
    }
}

- (void)actionForTouchItems:(UITapGestureRecognizer *)sender
{
    NSInteger index = sender.view.tag - MAX_CANON;
    //这里是可以子类重写的数据
    [self xy_managerFlexRowItemActions:index];
}

- (void)xy_managerFlexRowItemActions:(NSInteger)index
{
    
}

@end
