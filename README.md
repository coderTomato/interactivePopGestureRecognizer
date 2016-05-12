# interactivePopGestureRecognizer
## 自定义滑动返回

- 利用runtime获取UIGestureRecognizer所有成员变量
```objc 
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
```