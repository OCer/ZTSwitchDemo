//
//  ZTSwitch.h
//  ZTSwitchDemo
//
//  Created by Cer on 2019/1/26.
//  Copyright © 2019 Cer. All rights reserved.
//

#import <UIKit/UIKit.h>
@class ZTSwitch;

typedef void (^ZTSwitchCompletionHandler)(void);
typedef void (^ZTSwitchBlock)(ZTSwitch *sw, ZTSwitchCompletionHandler completionHandler);

@interface ZTSwitch : UISwitch

- (void)addBlock:(ZTSwitchBlock)block; // completionHandler需要在执行完成之后调用，不能在方法开始的时候就执行，不然会导致状态不对

@end
