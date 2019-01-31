//
//  ZTSwitch.m
//  ZTSwitchDemo
//
//  Created by Cer on 2019/1/26.
//  Copyright © 2019 Cer. All rights reserved.
//

#import "ZTSwitch.h"

@interface ZTSwitch ()

@property(nonatomic, strong) UIView *view;
@property(nonatomic, copy) ZTSwitchBlock block;
@property(nonatomic, assign, getter=isNeedVibration) BOOL needVibration;

@end

@implementation ZTSwitch

- (instancetype)init
{
    if (self = [super init])
    {
        [self setBackgroundColor:[UIColor clearColor]];
        
        UIView *view = [[UIView alloc] init];
        [view setBackgroundColor:[UIColor clearColor]];
        [self addSubview:view];
        [self setView:view];
        
        UITapGestureRecognizer *gestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(changeState:)];
        [view addGestureRecognizer:gestureRecognizer];
    }
    
    return self;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    [[self view] setFrame:[self bounds]];
    
    return;
}

- (void)setOn:(BOOL)on
{
    [self setOn:on animated:NO];
    
    return;
}

- (void)setOn:(BOOL)on animated:(BOOL)animated
{
    [self vibration];
    [super setOn:on animated:animated];
    
    return;
}

- (void)addBlock:(ZTSwitchBlock)block
{
    [self setBlock:block];
    
    return;
}

- (void)changeState:(UITapGestureRecognizer *)gestureRecognizer
{
    ZTSwitchBlock block = [self block];
    if (block)
    {
        [self setNeedVibration:YES];
        __weak typeof(self) weakSelf = self;
        block(self, ^() {
            [weakSelf setNeedVibration:NO];
        });
    }
    
    return;
}

- (void)vibration
{
    if ([self isNeedVibration])
    {
        UIImpactFeedbackGenerator *feedBackGenertor = [[UIImpactFeedbackGenerator alloc] initWithStyle:UIImpactFeedbackStyleMedium];
        [feedBackGenertor prepare];
        [feedBackGenertor impactOccurred];
        [self setNeedVibration:NO];
    }
    
    return;
}

+ (BOOL)accessInstanceVariablesDirectly
{
    return NO;
}

@end
