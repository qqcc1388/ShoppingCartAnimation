//
//  ShoppingCartTool.m
//  ShoppingCartAnimation
//
//  Created by Tiny on 2017/7/19.
//  Copyright © 2017年 LOVEGO. All rights reserved.
//

#import "ShoppingCartTool.h"

@implementation ShoppingCartTool

/**
 添加商品到购物车动画
 
 @param image 商品的图片
 @param startPoint 动画开始点
 @param endPoint 动画结束点
 @param completion 完成回调
 */
+(void)addToShoppingCartWithImage:(UIImage *)image
                       startPoint:(CGPoint)startPoint
                         endPoint:(CGPoint)endPoint
                       completion:(void(^)(BOOL finished))completion{
//    //点击了btn   需要3个参数
//    CGPoint startPoint = self.addBtn.center;
//    CGPoint endPoint = self.cartBtn.center;
//    UIImage *image = [UIImage imageNamed:@"heheda.png"];
    
    //创建内容layer
    CAShapeLayer *shapeLayer = [[CAShapeLayer alloc] init];
    shapeLayer.frame = CGRectMake(startPoint.x - 20, startPoint.y - 20, 40, 40);
    shapeLayer.contents = (id)image.CGImage;
    
    // 获取window的最顶层视图控制器
    UIViewController *rootVC = [[UIApplication sharedApplication].delegate window].rootViewController;
    UIViewController *parentVC = rootVC;
    while ((parentVC = rootVC.presentedViewController) != nil ) {
        rootVC = parentVC;
    }
    while ([rootVC isKindOfClass:[UINavigationController class]]) {
        rootVC = [(UINavigationController *)rootVC topViewController];
    }
    
    // 添加layer到顶层视图控制器上
    [rootVC.view.layer addSublayer:shapeLayer];
    
    NSTimeInterval duration = 1.0f;
    //创建轨迹
    UIBezierPath *bezierPath = [UIBezierPath bezierPath];
    [bezierPath moveToPoint:startPoint];
    [bezierPath addQuadCurveToPoint:endPoint controlPoint:CGPointMake(rootVC.view.bounds.size.width*0.5,rootVC.view.bounds.size.height*0.5)];
    CAKeyframeAnimation *animation = [CAKeyframeAnimation animationWithKeyPath:@"position"];
    animation.duration = duration;
    animation.removedOnCompletion = NO;
    animation.fillMode = kCAFillModeForwards;
    animation.path = bezierPath.CGPath;
    
    //创建缩放动画
    CABasicAnimation *scaleAnimation = [CABasicAnimation animationWithKeyPath:@"transform.scale"];
    scaleAnimation.fromValue = @(1.0f);
    scaleAnimation.toValue = @(0.5f);
    scaleAnimation.duration = duration;
    scaleAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    scaleAnimation.removedOnCompletion = NO;
    scaleAnimation.fillMode = kCAFillModeForwards;
    
    //添加动画
    [shapeLayer addAnimation:animation forKey:nil];
    [shapeLayer addAnimation:scaleAnimation forKey:nil];
    
    //延时直到动画结束
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(duration * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [shapeLayer removeFromSuperlayer];
        completion(YES);
    });
}
@end
