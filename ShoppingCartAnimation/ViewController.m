//
//  ViewController.m
//  ShoppingCartAnimation
//
//  Created by Tiny on 2017/7/19.
//  Copyright © 2017年 LOVEGO. All rights reserved.
//

#import "ViewController.h"
#import "ShoppingCartTool.h"

@interface ViewController ()

@property (weak, nonatomic) IBOutlet UIButton *addBtn;
@property (weak, nonatomic) IBOutlet UIButton *cartBtn;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}


- (IBAction)addAction:(UIButton *)sender {

    //点击了btn   需要3个参数
    CGPoint startPoint = self.addBtn.center;
    CGPoint endPoint = self.cartBtn.center;
    UIImage *image = [UIImage imageNamed:@"heheda.png"];
    
    [ShoppingCartTool addToShoppingCartWithImage:image startPoint:startPoint endPoint:endPoint completion:^(BOOL finished) {
        //动画结束
        CABasicAnimation *scaleAnimation = [CABasicAnimation animationWithKeyPath:@"transform.scale"];
        scaleAnimation.fromValue = [NSNumber numberWithFloat:1.0];
        scaleAnimation.toValue = [NSNumber numberWithFloat:0.8];
        scaleAnimation.duration = 0.1;
        scaleAnimation.repeatCount = 2; // 颤抖两次
        scaleAnimation.autoreverses = YES;
        scaleAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
        [self.cartBtn.layer addAnimation:scaleAnimation forKey:nil];
    }];
    
}



@end
