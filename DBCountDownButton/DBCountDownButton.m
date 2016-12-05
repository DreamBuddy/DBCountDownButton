//
//  DBCountDownButton.m
//  OneLucky
//
//  Created by Xu Mengtong on 19/11/16.
//  Copyright © 2016年 imakejoy. All rights reserved.
//

#import "DBCountDownButton.h"
#import "ReactiveObjC.h"

@interface DBCountDownButton ()

@property (nonatomic ,assign) NSInteger second;
@property (nonatomic ,assign) NSUInteger totalSecond;
@property (nonatomic ,assign) BOOL canTouch;

@property (nonatomic ,strong) RACDisposable *signal;

@property (nonatomic ,copy) DBCountDownChanging countDownChanging;
@property (nonatomic ,copy) DBCountDownFinished countDownFinished;

@end

@implementation DBCountDownButton

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self _commonInit];
    }
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)coder
{
    self = [super initWithCoder:coder];
    if (self) {
        [self _commonInit];
    }
    return self;
}

-(void)_commonInit{
    self.canTouch = YES;
    
    @weakify(self)
    RAC(self ,userInteractionEnabled) = [RACSignal combineLatest:@[RACObserve(self, autoControlButtonEnable) ,RACObserve(self, canTouch)] reduce:^id _Nonnull{
        @strongify(self)
        
        if (!self.autoControlButtonEnable) {
            return @(self.userInteractionEnabled);
        }
        
        return @(self.canTouch);
    }];
}

-(void)startCountDownWithSecond:(NSUInteger)totalSecond{
    _totalSecond = totalSecond;
    _second = totalSecond;
    
    self.canTouch = NO;
    
    if (_signal && !_signal.isDisposed) [_signal dispose];
    
    @weakify(self)
    
    self.signal = [[[RACSignal interval:1.0 onScheduler:[RACScheduler mainThreadScheduler]] take:totalSecond] subscribeNext:^(id  _Nullable x) {
        @strongify(self) if (!self) return ;
        
        self.second --;
        if (self.second <= 0.0){
            [self stopCountDown];
        }else{
            if (self.countDownChanging){
                [self setTitle:self.countDownChanging(self,self.second) forState:UIControlStateNormal];
                [self setTitle:self.countDownChanging(self,self.second) forState:UIControlStateDisabled];
            }else{
                NSString *title = [NSString stringWithFormat:@"%zd秒",self.second];
                [self setTitle:title forState:UIControlStateNormal];
                [self setTitle:title forState:UIControlStateDisabled];
            }
        }
    }];
}

- (void)stopCountDown{
    self.canTouch = YES;
    
    if (!self.signal.isDisposed) [self.signal dispose];
    _second = _totalSecond;
    if (_countDownFinished){
        [self setTitle:_countDownFinished(self,_totalSecond)forState:UIControlStateNormal];
        [self setTitle:_countDownFinished(self,_totalSecond)forState:UIControlStateDisabled];
    }else{
        [self setTitle:@"重新获取" forState:UIControlStateNormal];
        [self setTitle:@"重新获取" forState:UIControlStateDisabled];
    }
}

#pragma mark -- copy & save block
-(void)countDownChanging:(DBCountDownChanging)countDownChanging{
    _countDownChanging = [countDownChanging copy];
}
-(void)countDownFinished:(DBCountDownFinished)countDownFinished{
    _countDownFinished = [countDownFinished copy];
}

@end
