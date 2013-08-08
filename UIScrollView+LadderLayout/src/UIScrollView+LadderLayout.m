//
//  UIScrollView+LadderLayout.m
//  UIScrollView+LadderLayout
//
//  Created by Takafumi Tamura on 2013/08/08.
//  Copyright (c) 2013年 田村 孝文. All rights reserved.
//

#import "UIScrollView+LadderLayout.h"

// 便利拡張。UIViewのframe.{origin|size}へのアクセスを簡略化
@interface UIView(LadderLayout)
@property(readonly)CGFloat x;
@property(readonly)CGFloat y;
@property(readonly)CGFloat width;
@property(readonly)CGFloat height;
@end

@implementation UIView(LadderLayout)
-(CGFloat)x
{
    return self.frame.origin.x;
}
-(CGFloat)y
{
    return self.frame.origin.y;
}
-(CGFloat)width
{
    return self.frame.size.width;
}
-(CGFloat)height
{
    return self.frame.size.height;
}
@end

//梯子レイアウト本体
@implementation UIScrollView (LadderLayout)
-(void)layoutAndAddSubview:(NSArray *)views
{
    // 配列に含まれるUIViewを整列
    for(int i=0; i<views.count;i++ ){
        NSRange range={0,i};
        NSArray *layoutedViews = [views subarrayWithRange:range];
        UIView *targetView = [views objectAtIndex:i];
        
        // レイアウト済みの最後のViewの右側に、入れ込む隙間があるかどうかチェック
        CGPoint nextStartPoint = CGPointMake(0,0);
        if( i>0 ){
            UIView *lastLayoutView = layoutedViews.lastObject;
            nextStartPoint = CGPointMake(lastLayoutView.x+lastLayoutView.width,
                                         lastLayoutView.y);
            if( nextStartPoint.x + targetView.width > self.width ){
                // はみ出してるので、次の段の左端に移動
                nextStartPoint = CGPointMake(0,0);
                for (UIView *v  in layoutedViews) {
                    nextStartPoint.y = MAX(nextStartPoint.y, v.y + v.height);
                }
            }
        }
        // 移動先の場所が決まったので移動。
        targetView.frame = CGRectMake(nextStartPoint.x,
                                      nextStartPoint.y,
                                      targetView.width,
                                      targetView.height);
    }
    // 整列したUIViewをaddSubviewしていく
    for(UIView *v in views){
        [self addSubview:v];
    }
    
    // ScrollViewのcontentSizeを変更
    CGFloat contentHeight=0;
    for (UIView *v  in views) {
        contentHeight = MAX(contentHeight,v.y+v.height);
    }
    self.contentSize = CGSizeMake(self.width, contentHeight);
}

@end
