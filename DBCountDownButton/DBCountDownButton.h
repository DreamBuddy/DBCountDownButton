//
//  DBCountDownButton.h
//  OneLucky
//
//  Created by Xu Mengtong on 19/11/16.
//  Copyright © 2016年 imakejoy. All rights reserved.
//

#import <UIKit/UIKit.h>

@class DBCountDownButton;

typedef NSString *(^DBCountDownChanging)(DBCountDownButton *countDownButton , NSUInteger second);
typedef NSString *(^DBCountDownFinished)(DBCountDownButton *countDownButton , NSUInteger second);

@interface DBCountDownButton : UIButton

/**
 可以附加一些 数据
 */
@property (nonatomic ,strong) id userInfo;

/**
 是否开启自动控制 是否可点击 (建议开启)
 */
@property (nonatomic ,assign) BOOL autoControlButtonEnable;

-(void)countDownChanging:(DBCountDownChanging)countDownChanging;
-(void)countDownFinished:(DBCountDownFinished)countDownFinished;

-(void)startCountDownWithSecond:(NSUInteger)second;
-(void)stopCountDown;

@end
