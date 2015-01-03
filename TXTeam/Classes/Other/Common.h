
//1.是否为ios6系统
#define IsIOS6 ([[[UIDevice currentDevice] systemVersion] floatValue] >=6.0&&[[[UIDevice currentDevice] systemVersion] floatValue]<7.0 ? YES : NO)

//2.是否为ios7系统
#define IsIOS7 ([[[UIDevice currentDevice] systemVersion] floatValue] >=7.0&&[[[UIDevice currentDevice] systemVersion] floatValue]<8.0 ? YES : NO)

//3.是否为ios8系统
#define IsIOS8 ([[[UIDevice currentDevice] systemVersion] floatValue] >=8.0 ? YES : NO)

//4.是否为iPhone5
#define iPhone5 ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(640, 1136), [[UIScreen mainScreen] currentMode].size) : NO)

//5.获取设备的物理高度

#define kScreenHeight (IsIOS6?([UIScreen mainScreen].bounds.size.height)-20.0:[UIScreen mainScreen].bounds.size.height)

//6.获取设备的物理宽度
#define kScreenWidth [UIScreen mainScreen].bounds.size.width

//7.定义导航栏的高度
#define kNavigationH (IsIOS6?44:64)

//8.获取设备的系统版本
#define CurrentSystemVersion [[[UIDevice currentDevice] systemVersion] intValue]

//9.日志输出宏定义
#ifdef DEBUG
// 调试状态
#define MyLog(...) NSLog(__VA_ARGS__)
#else
// 发布状态
#define MyLog(...)
#endif

// 10.默认的动画时间
#define kDefaultAnimDuration 0.3

// 11.定义自定义button宽
#define kButtonW ((kScreenWidth-30)/2)

// 12.定义自定义button高
#define kButtonH kButtonW

// 13.定义间距大小
#define kSpacing 10

// 14定义statusBar高度
#define kStatusBarH 20

// 15定义背景颜色
#define kBackgroundColor [UIColor colorWithRed:(CGFloat)233/255 green:(CGFloat)231/255 blue:(CGFloat)233/255 alpha:1.0]

// 16.定义头视图高度
#define kHeaderViewHeight (kScreenWidth>320?125:100)

// 17.定义io6下screenHeight（不包括导航栏）
#define kIOS6or7ScreenHeight (IsIOS6?(kScreenHeight-kNavigationH):kScreenHeight)

// 18.定义黄金比例
#define kGoldenRatio 0.618


