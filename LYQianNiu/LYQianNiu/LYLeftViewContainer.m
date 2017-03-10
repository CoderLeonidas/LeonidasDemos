//
//  LYLeftViewContainer.m
//  LYQianNiu
//
//  Created by Leonidas on 2017/3/8.
//  Copyright © 2017年 Leon. All rights reserved.
//

#import "LYLeftViewContainer.h"
#import "LYImageTextField.h"
#import "LYViewManager.h"
#import "LYQunZuViewController.h"
#import "LYLianXiRenViewController.h"
#import "LYZuiJinHuiHuaViewController.h"
#import "LYJinRiJieDaiViewController.h"

/**
 底部视图类型
 */
typedef enum : NSUInteger {
    LYBottomVCTypeJinRiJieDai,//今日接待
    LYBottomVCTypeZuiJinHuiHua,//最近会话
    LYBottomVCTypeLianXiRen,//联系人
    LYBottomVCTypeQunZu//群组
} LYBottomVCType;

@interface LYLeftViewContainer ()  {
    NSViewController *_currentBottomVC;//当前显示的底部控制器
}
@property (weak) IBOutlet NSView *topView;//顶部视图容器
@property (weak) IBOutlet NSView *bottomView;//底部视图容器

@property (nonatomic, strong) LYImageTextField *searchBar;//搜索条
@property (nonatomic, strong) LYViewManager *viewManager;//视图管理器

@property (nonatomic, strong) LYQunZuViewController *qunZuViewController;//群组
@property (nonatomic, strong) LYLianXiRenViewController *lianXiRenViewController;//联系人
@property (nonatomic, strong) LYZuiJinHuiHuaViewController *zuiJinHuiHuaViewController;//最近会话
@property (nonatomic, strong) LYJinRiJieDaiViewController *jinRiJieDaiViewController;//今日接待
@property (nonatomic, copy) NSDictionary *keysAndVCs;

@end

@implementation LYLeftViewContainer

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initObjects];
    

    [self.bottomView addSubview:self.jinRiJieDaiViewController.view positioned:NSWindowAbove relativeTo:nil];
    self.jinRiJieDaiViewController.view.frame = self.bottomView.bounds;
//    //del
//    [LYTool changeBGColor:[NSColor redColor] inView:self.bottomView];
//    [LYTool changeBGColor:[NSColor brownColor] inView:self.jinRiJieDaiViewController.view];
}

- (void)initObjects {
    [self setupSearchBar];
    [self setupViewManager];
}

- (void)setupViewManager {
    [self.viewManager setHostingView:self.bottomView];
    self.keysAndVCs = @{
                                   @(LYBottomVCTypeQunZu):self.qunZuViewController,
                                   @(LYBottomVCTypeLianXiRen):self.lianXiRenViewController,
                                   @(LYBottomVCTypeZuiJinHuiHua):self.zuiJinHuiHuaViewController,
                                   @(LYBottomVCTypeJinRiJieDai):self.jinRiJieDaiViewController};
//    [self.viewManager setKeysAndVCs:keysAndVCs];
//    [self.viewManager showViewWithKey:LYBottomVCTypeZuiJinHuiHua];
}

#define PaddingLR 10
#define SearchBarH 22

- (void)setupSearchBar {
    [self.topView addSubview:self.searchBar.view];
    self.searchBar.image = [NSImage imageNamed:@"WWMainWindowSearchIcon_16x16"];
    
    CGFloat w = self.topView.frame.size.width - 2 * PaddingLR;
    CGFloat h = SearchBarH;
    CGFloat x = PaddingLR;
    CGFloat y = (self.topView.frame.size.height - h ) * 0.5;
    self.searchBar.view.frame = NSMakeRect(x, y, w, h);

}

- (void)switchBottomViewWithKey:(long)key {
    NSViewController *vc = self.keysAndVCs[@(key)];
    if (!vc || [vc isEqualTo:_currentBottomVC]) return;
    //先从父视图移除
    if (_currentBottomVC.view.superview) {
        [_currentBottomVC.view removeFromSuperview];
    }
    
    //添加到子视图
    _currentBottomVC.view.frame = self.bottomView.bounds;
    [self.bottomView addSubview:_currentBottomVC.view];
}

#pragma mark - Lazy loading

- (NSDictionary*) keysAndVCs{
    if (!_keysAndVCs) {
        _keysAndVCs = [[NSDictionary alloc] init];
    }
    return _keysAndVCs;
}
- (LYImageTextField *)searchBar {
    if (!_searchBar) {
        _searchBar = [[LYImageTextField alloc] initWithNibName:@"LYImageTextField" bundle:nil];
    }
    return _searchBar;
}

- (LYViewManager *)viewManager {
    if (!_viewManager) {
        _viewManager  = [[LYViewManager alloc] init];
    }
    return _viewManager;
}
- (LYQunZuViewController*) qunZuViewController{
    if (!_qunZuViewController) {
        _qunZuViewController = [[LYQunZuViewController alloc] initWithNibName:@"LYQunZuViewController" bundle:nil];
    }
    return _qunZuViewController;
}

- (LYLianXiRenViewController *)lianXiRenViewController {
    if (!_lianXiRenViewController) {
        _lianXiRenViewController = [[LYLianXiRenViewController alloc] initWithNibName:@"LYLianXiRenViewController" bundle:nil];
    }
    return _lianXiRenViewController;
}

- (LYZuiJinHuiHuaViewController*) zuiJinHuiHuaViewController{
    if (!_zuiJinHuiHuaViewController) {
        _zuiJinHuiHuaViewController = [[LYZuiJinHuiHuaViewController alloc] initWithNibName:@"LYZuiJinHuiHuaViewController" bundle:nil];
    }
    return _zuiJinHuiHuaViewController;
}
- (LYJinRiJieDaiViewController*) jinRiJieDaiViewController{
    if (!_jinRiJieDaiViewController) {
        _jinRiJieDaiViewController = [[LYJinRiJieDaiViewController alloc] initWithNibName:@"LYJinRiJieDaiViewController" bundle:nil];
    }
    return _jinRiJieDaiViewController;
}



@end
