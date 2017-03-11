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



#endif /* CommonDef_h */
