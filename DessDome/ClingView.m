//
//  ClingView.m
//  HDEMO
//
//  Created by Jack on 15/2/9.
//  Copyright (c) 2015年 qida. All rights reserved.
//

#import "ClingView.h"
#import "UIScrollView+Plus.h"

#define kScrollViewObserverKeyPath @"contentOffset"

@interface ClingView(){
    BOOL _isAnimating;
}

@property (assign, nonatomic)CGRect selfOriginalRect;
@property (assign, nonatomic)CGRect scrollViewOriginRect;

@end

@implementation ClingView

- (instancetype)initWithFrame:(CGRect)frame ClingScrollView:(UIScrollView *)aScrollView{
    self = [super init];
    if (self) {
        self.frame = frame;
        
        self.clingScrollView = aScrollView;
        self.maxShowHeight = self.frame.size.height;
        self.minShowHeight = self.frame.size.height/4;
        self.selfOriginalRect = frame;
        self.scrollViewOriginRect = aScrollView.frame;
        
        CGRect baseRect = self.frame;
        baseRect.origin.x = 0;
        baseRect.origin.y = 0;
        UIView *scrollviewSuperView = _clingScrollView.superview;
        [scrollviewSuperView addSubview:self];
        
        [self expand];
        
        [_clingScrollView addObserver:self forKeyPath:kScrollViewObserverKeyPath options:NSKeyValueObservingOptionNew|NSKeyValueObservingOptionOld context:nil];
    }
    return self;
}

- (void)awakeFromNib{
    self.maxShowHeight = self.frame.size.height;
    self.minShowHeight = self.frame.size.height/4;
    self.selfOriginalRect = self.frame;
}

- (void)setClingScrollView:(UIScrollView *)clingScrollView{
    if (_clingScrollView) {
        [_clingScrollView removeObserver:self forKeyPath:kScrollViewObserverKeyPath];
    }
    _clingScrollView = clingScrollView;
    self.scrollViewOriginRect = clingScrollView.frame;
    
    CGRect baseRect = self.frame;
    baseRect.origin.x = 0;
    baseRect.origin.y = 0;
    UIView *scrollviewSuperView = _clingScrollView.superview;
    [scrollviewSuperView addSubview:self];
    
    [self expand];
    
    [_clingScrollView addObserver:self forKeyPath:kScrollViewObserverKeyPath options:NSKeyValueObservingOptionNew|NSKeyValueObservingOptionOld context:nil];
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context{
    if(object == _clingScrollView && [keyPath isEqualToString:kScrollViewObserverKeyPath]){
        if (_isAnimating) {
            return;
        }
        CGPoint oldContentOffSet = [change[@"old"] CGPointValue];
        CGPoint newContentOffSet = [change[@"new"] CGPointValue];
        if (_clingScrollView.contentOffset.y <= 0) {
            if (newContentOffSet.y == 0) {
                return;
            }
            [self showExpand];
        }else{
            if (oldContentOffSet.y > 0 && newContentOffSet.y > 0 && !CGRectEqualToRect(self.frame, _selfOriginalRect)) {
                return;
            }
            [self showShrink];
        }
    }
}

- (void)showExpand{
    __weak typeof(self) weakSelf = self;
    if (!CGRectEqualToRect(self.frame, _selfOriginalRect)) {
        [UIView animateWithDuration:CLAnimationDuration animations:^{
            _isAnimating = YES;
            [weakSelf expand];
        } completion:^(BOOL finished) {
            
        }];
    }
}

- (void)expand{
    [_clingScrollView killScroll];
    self.frame = _selfOriginalRect;
    CGRect rect = _scrollViewOriginRect;
    rect.origin.y = rect.origin.y + _maxShowHeight;
    _clingScrollView.frame = rect;
    rect.size.height = rect.size.height - _maxShowHeight;
  //  [CommonTool executeRunloop:^{
        _clingScrollView.frame = rect;
        _isAnimating = NO;
   // } afterDelay:CLAnimationDuration];
}

- (void)showShrink{
    __weak typeof(self) weakSelf = self;
    if (CGRectEqualToRect(self.frame, _selfOriginalRect)) {
        [UIView animateWithDuration:CLAnimationDuration animations:^{
            _isAnimating = YES;
            [weakSelf shrink];
        } completion:^(BOOL finished) {
            
        }];
    }
}

- (void)shrink{
    [_clingScrollView killScroll];
    CGRect newSelfRect = _selfOriginalRect;
    newSelfRect.origin.y = newSelfRect.origin.y - (newSelfRect.size.height - _minShowHeight);
    self.frame = newSelfRect;
    
    __block CGRect newClingRect = _scrollViewOriginRect;
    newClingRect.origin.y = CGRectGetMaxY(newSelfRect);
    _clingScrollView.frame = newClingRect;
    //[CommonTool executeRunloop:^{
        newClingRect.size.height -= _minShowHeight;
        _clingScrollView.frame = newClingRect;
        _isAnimating = NO;
   // } afterDelay:CLAnimationDuration];
}

- (void)dealloc{
    [_clingScrollView removeObserver:self forKeyPath:kScrollViewObserverKeyPath];
#warning 暂时隐藏
    //[self removeObserver:self forKeyPath:@"frame"];
    [kAppDelegate.managedObjectContext undo];
}


@end
