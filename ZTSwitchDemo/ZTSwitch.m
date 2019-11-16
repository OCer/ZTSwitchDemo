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
@property(nonatomic, strong) UIImpactFeedbackGenerator *feedBackGenertor;
@property(nonatomic, copy) ZTSwitchBlock block;
@property(nonatomic, assign, getter=isNeedVibration) BOOL needVibration;

@end

@implementation ZTSwitch

- (void)awakeFromNib
{
    [super awakeFromNib];
    [self create];
    
    return;
}

- (instancetype)init
{
    if (self = [super init])
    {
        [self create];
    }
    
    return self;
}

- (void)create
{
    [self setBackgroundColor:[UIColor clearColor]];
    
    UIView *view = [[UIView alloc] init];
    [view setBackgroundColor:[UIColor clearColor]];
    [self addSubview:view];
    [self setView:view];
    
    UITapGestureRecognizer *gestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(changeState:)];
    [view addGestureRecognizer:gestureRecognizer];
    
    UIImpactFeedbackGenerator *feedBackGenertor = [[UIImpactFeedbackGenerator alloc] initWithStyle:UIImpactFeedbackStyleHeavy];
    [self setFeedBackGenertor:feedBackGenertor];
    
    return;
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
        block(self, ^(BOOL isOriginal) {
            if (isOriginal == NO)
            {
                BOOL isOn = ![weakSelf isOn];
                [weakSelf setOn:isOn animated:YES];
            }
            
            [weakSelf setNeedVibration:NO];
        });
    }
    
    return;
}

- (void)vibration
{
    if ([self isNeedVibration])
    {
        [[self feedBackGenertor] prepare];
        [[self feedBackGenertor] impactOccurred];
        [self setNeedVibration:NO];
    }
    
    return;
}

+ (BOOL)accessInstanceVariablesDirectly
{
    return NO;
}

@end
