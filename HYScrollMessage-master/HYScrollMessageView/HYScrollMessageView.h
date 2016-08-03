//
//  HYScrollMessageView.h
//  HYScrollMessage-master
//
//  Created by 黄海燕 on 16/8/3.
//  Copyright © 2016年 huanghy. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HYScrollMessageView : UIView

@property (nonatomic,strong) NSArray *rssArray;
@property (nonatomic,copy) void (^messageClickBlock)();

- (void)makeMsgArr:(NSArray *)rssArray;
- (void)startTimer;
- (void)stopTimer;
@end
