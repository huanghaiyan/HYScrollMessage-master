//
//  HYScrollMessageView.m
//  HYScrollMessage-master
//
//  Created by 黄海燕 on 16/8/3.
//  Copyright © 2016年 huanghy. All rights reserved.
//

#import "HYScrollMessageView.h"

@interface HYScrollMessageView()

@property (nonatomic,strong) UILabel *messageLabel;
@property (nonatomic,strong) UIButton *messageBtn;
@property (nonatomic, strong) NSTimer *animationTimer;

@end

static int countInt=0;
@implementation HYScrollMessageView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        _messageLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, frame.size.width, frame.size.height)
        ];
        _messageLabel.textColor = [UIColor blackColor];
        _messageLabel.backgroundColor = [UIColor clearColor];
        _messageLabel.font = [UIFont systemFontOfSize:14];
        _messageLabel.lineBreakMode = NSLineBreakByTruncatingTail;
        _messageLabel.numberOfLines = 1;
        [self addSubview:_messageLabel];
        
        _messageBtn = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, frame.size.width, frame.size.height)];
        [_messageBtn addTarget:self action:@selector(messageBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:_messageBtn];
    }
    return self;
}

- (void)messageBtnClicked:(UIButton *)sender
{
    if (self.messageClickBlock) {
        self.messageClickBlock();
    }
}

- (void)makeMsgArr:(NSArray *)rssArray
{
    if (rssArray.count == 0 || rssArray == nil || rssArray == NULL) {
        return;
    }

    self.rssArray = rssArray;
    [self.messageLabel setText:[self.rssArray objectAtIndex:countInt] ];
    //设置定时器
    [self startTimer];
}

//信息的轮播
-(void)displayNews
{
    countInt ++;
    if (countInt >= [_rssArray count]) {
        countInt = 0;
    }
    CATransition *animation = [CATransition animation];
    animation.delegate = self;
    animation.duration = 1;
    animation.timingFunction = UIViewAnimationCurveEaseInOut;
    animation.subtype = kCATransitionFromTop;
    animation.fillMode = kCAFillModeBackwards;
    animation.removedOnCompletion = YES;
    animation.type = @"push";
    
    [self.messageLabel setText:[self.rssArray objectAtIndex:countInt] ];
    [self.messageLabel.layer addAnimation:animation forKey:@"animationID"];
}

- (void)startTimer
{
    if (!_animationTimer) {
        self.animationTimer = [NSTimer scheduledTimerWithTimeInterval:2
                                    target:self
                                  selector:@selector(displayNews)
                                  userInfo:nil
                                   repeats:YES];
        [[NSRunLoop currentRunLoop] addTimer:self.animationTimer forMode:NSRunLoopCommonModes];
    }
}

- (void)stopTimer
{
    if ([self.animationTimer isValid] == YES)
        [self.animationTimer invalidate];
        self.animationTimer = nil;
    NSLog(@"系统消息定时器停止");
}

@end
