//
//  YSNavigationController.m
//  Lottery
//
//  Created by 李军 on 15/11/4.
//  Copyright © 2015年 军李. All rights reserved.
//

#import "YSNavigationController.h"
#import <objc/runtime.h>

@interface YSNavigationController ()<UIGestureRecognizerDelegate>


@end

@implementation YSNavigationController

+ (void)initialize
{
    UINavigationBar *navBar = [UINavigationBar appearance];
    UIBarButtonItem *barItem = [UIBarButtonItem appearance];
    
    NSString *navBarBg = nil;
    navBarBg = @"NavBar64";
    navBar.tintColor = [UIColor whiteColor];
    [navBar setBackgroundImage:[UIImage imageNamed:navBarBg] forBarMetrics:UIBarMetricsDefault];
    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleBlackOpaque;
    
    NSMutableDictionary *textAttrs = [NSMutableDictionary dictionary];
    textAttrs[UITextAttributeTextColor] = [UIColor whiteColor];
    [navBar setTitleTextAttributes:textAttrs];
    
    [barItem setTitleTextAttributes:@{UITextAttributeTextColor : [UIColor whiteColor]} forState:UIControlStateNormal];
}
/**  打印NSLog(@"%@",self.interactivePopGestureRecognizer);得知
 *   系统滑动手势类型：UIScreenEdgePanGestureRecognizer
      target：_UINavigationInteractiveTransition
     action：handleNavigationTransition:
 */
- (void)viewDidLoad
{
    [super viewDidLoad];
    self.interactivePopGestureRecognizer.enabled = NO;
    
    //利用runtime获取UIGestureRecognizer所有成员变量
    unsigned int count = 0;
    // 返回成员属性的数组
    Ivar *ivars = class_copyIvarList([UIGestureRecognizer class], &count);
    for (int i = 0; i < count; i++)
    {
        Ivar ivar = ivars[i];
        //NSString *name = [[NSString alloc] initWithCString:ivar_getName(ivar) encoding:NSUTF8StringEncoding];
        NSString *name = @(ivar_getName(ivar));
        //NSLog(@"%@",name);
    }
    NSArray *array = [self.interactivePopGestureRecognizer valueForKeyPath:@"_targets"];
    id objc = [array.firstObject valueForKeyPath:@"_target"];
    //objc=_UINavigationInteractiveTransition self.interactivePopGestureRecognizer.delegate==_UINavigationInteractiveTransition
    
    UIPanGestureRecognizer *pan = [[UIPanGestureRecognizer alloc] initWithTarget:self.interactivePopGestureRecognizer.delegate action:@selector(handleNavigationTransition:)];
    pan.delegate = self;
    [self.view addGestureRecognizer:pan];
}

- (BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer *)gestureRecognizer
{
    return (self.topViewController != self.viewControllers.firstObject);
}

@end
