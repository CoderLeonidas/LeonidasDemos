//
//  CommonDef.h
//  LYQianNiu
//
//  Created by Leonidas on 2017/3/10.
//  Copyright © 2017年 Leon. All rights reserved.
//

#ifndef CommonDef_h
#define CommonDef_h


/**
 通知类型
 */
#define LYQunZuBtnClickNotification         @"kLYQunZuBtnClickNotification"
#define LYLianXiRenBtnClickNotification     @"kLYLianXiRenBtnClickNotification"
#define LYZuiJinHuiHuaBtnClickNotification  @"kLYZuiJinHuiHuaBtnClickNotification"
#define LYJinRiJieDaiBtnClickNotification   @"kLYJinRiJieDaiBtnClickNotification"

/**
 左侧底部视图类型
 */
typedef enum : NSUInteger {
    LYBottomVCTypeJinRiJieDai,//今日接待
    LYBottomVCTypeZuiJinHuiHua,//最近会话
    LYBottomVCTypeLianXiRen,//联系人
    LYBottomVCTypeQunZu//群组
} LYBottomVCType;


#define LeftContainerWidth 160//主界面左边列表容器宽度
#define TopAreaHeight      70//主界面顶部区域高度

//服务器地址
#define HostName  @"luoyang.local"
#define HostPort  5222
#define Resource  @"mac"


#endif /* CommonDef_h */
