//
//  LYLeftViewContainer.m
//  LYQianNiu
//
//  Created by Leonidas on 2017/3/8.
//  Copyright © 2017年 Leon. All rights reserved.
//

#import "LYLeftViewContainer.h"
#import "LYQunZuViewController.h"
#import "LYLianXiRenViewController.h"
#import "LYZuiJinHuiHuaViewController.h"
#import "LYJinRiJieDaiViewController.h"
#import "CommonDef.h"

@interface LYLeftViewContainer () <NSSearchFieldDelegate>  {
    NSViewController *_currentBottomVC;//当前显示的底部控制器
    NSMutableDictionary *_VCAndNotiMap;//保存导航按钮按下通知和对应显示的控制器的映射字典
}
@property (weak) IBOutlet NSView *topView;//顶部视图容器
@property (weak) IBOutlet NSView *bottomView;//底部视图容器

@property (nonatomic, strong) NSSearchField *searchBar;//搜索条

@property (nonatomic, strong) LYQunZuViewController *qunZuViewController;//群组
@property (nonatomic, strong) LYLianXiRenViewController *lianXiRenViewController;//联系人
@property (nonatomic, strong) LYZuiJinHuiHuaViewController *zuiJinHuiHuaViewController;//最近会话
@property (nonatomic, strong) LYJinRiJieDaiViewController *jinRiJieDaiViewController;//今日接待

@end

@implementation LYLeftViewContainer

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initObjects];
    [self addNotifications];
}

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

#pragma mark - Notification

- (void)addNotifications {
    //TODO 切换控制器通知优化
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(switchBottomViewWith:) name:LYQunZuBtnClickNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(switchBottomViewWith:) name:LYLianXiRenBtnClickNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(switchBottomViewWith:) name:LYZuiJinHuiHuaBtnClickNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(switchBottomViewWith:) name:LYJinRiJieDaiBtnClickNotification object:nil];
}

- (void)initObjects {
    _currentBottomVC = nil;
    _VCAndNotiMap = [NSMutableDictionary dictionary];
    [self setupSearchBar];
}

- (void)clearObjects {
    _VCAndNotiMap = nil;
}

#define PaddingLR 10
#define SearchBarH 40

- (void)setupSearchBar {
    //TODO 位置调整，
    CGFloat w = self.topView.frame.size.width - 2 * PaddingLR;
    CGFloat h = SearchBarH;
    CGFloat x = PaddingLR;
    CGFloat y = (self.topView.frame.size.height - h ) * 0.5;
    self.searchBar.frame = NSMakeRect(x, y, w, h);
    self.searchBar.placeholderString = @"搜索联系人、群组";
    self.searchBar.autoresizingMask = 1|2|4|8|16|32;
    self.searchBar.focusRingType = NSFocusRingTypeNone;
    [self.topView addSubview:self.searchBar];
}

- (void)switchBottomViewWith:(NSNotification *)noti {
    if (!noti) return;
    NSString *notiName = noti.name;
    NSViewController *bottomVCToShow = _VCAndNotiMap[notiName];
    if ( bottomVCToShow && [bottomVCToShow isEqualTo:_currentBottomVC]) return;
    
    //先从父视图移除
    [self hideViewFromSuperView:_currentBottomVC.view];

    
    if (bottomVCToShow) {
    } else {//若字典里还没有就加入字典
        if ([notiName isEqualToString:LYJinRiJieDaiBtnClickNotification]) {
            bottomVCToShow = self.jinRiJieDaiViewController;
        } else if ([notiName isEqualToString:LYZuiJinHuiHuaBtnClickNotification]) {
            bottomVCToShow = self.zuiJinHuiHuaViewController;
        } else if ([notiName isEqualToString:LYLianXiRenBtnClickNotification]) {
            bottomVCToShow = self.lianXiRenViewController;
        } else if ([notiName isEqualToString:LYQunZuBtnClickNotification]) {
            bottomVCToShow = self.qunZuViewController;
            
        }
        _VCAndNotiMap[notiName] = bottomVCToShow;
    }
    
    //添加到子视图
    [self showNewView:bottomVCToShow.view ToHostingView:self.bottomView];
    _currentBottomVC = bottomVCToShow;
}


/**
 从父视图移除

 @param aView 将要移除的视图
 */
- (void)hideViewFromSuperView:(NSView *)aView {
    if (!aView) return;
    if (!aView.superview) return;
    
    [aView removeFromSuperview];
}

/**
 将一个视图作为子视图显示在另一个宿主视图上

 @param aView 将要显示的视图
 @param aHostView 宿主视图
 */
- (void)showNewView:(NSView *)aView ToHostingView:(NSView *)aHostView {
    if (!aView || !aHostView) return;
    
    aView.frame = aHostView.bounds;
    [aHostView addSubview:aView];
}

#pragma mark - Lazy loading

- (NSSearchField *)searchBar {
    if (!_searchBar) {
        _searchBar = [[NSSearchField alloc] init];
    }
    return _searchBar;
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

#pragma mark - NSSearchFieldDelegate 搜索框代理 

- (void)searchFieldDidStartSearching:(NSSearchField *)sende{

}

- (void)searchFieldDidEndSearching:(NSSearchField *)sender{

}

@end
