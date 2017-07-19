//
//  ShoppingCartTool.h
//  ShoppingCartAnimation
//
//  Created by Tiny on 2017/7/19.
//  Copyright © 2017年 LOVEGO. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface ShoppingCartTool : NSObject


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
                       completion:(void(^)(BOOL finished))completion;

@end
