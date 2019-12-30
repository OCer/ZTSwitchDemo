//
//  ViewController.m
//  ZTSwitchDemo
//
//  Created by Cer on 2019/1/26.
//  Copyright © 2019 Cer. All rights reserved.
//

#import "ViewController.h"
#import "ZTSwitch.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    ZTSwitch *sw = [[ZTSwitch alloc] init]; // 控件的显示与设置的宽高无关
    [[self view] addSubview:sw];
    [sw setFrame:CGRectMake(100, 100, 51, 31)];
    [sw addBlock:^(ZTSwitch *sw, ZTSwitchCompletionHandler completionHandler) {
        [self changeState:sw completionHandler:completionHandler];
    }];
    
    return;
}

- (void)changeState:(ZTSwitch *)sw completionHandler:(ZTSwitchCompletionHandler)completionHandler
{
    int i = arc4random() % 2;
    if (i == 1)
    {
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
            NSLog(@"模拟异步回调");
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                // 模拟异步回调
                completionHandler(NO);
            });
        });
    }
    else
    {
        // 模拟条件不达成，不设置开关状态
        NSLog(@"模拟条件不达成，不设置开关状态");
        completionHandler(YES);
    }
    
    return;
}

@end
