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
//群组按钮被点击
#define LYQunZuBtnClickNotification         @"kLYQunZuBtnClickNotification"

//联系人按钮被点击
#define LYLianXiRenBtnClickNotification     @"kLYLianXiRenBtnClickNotification"
//最近会话按钮被点击
#define LYZuiJinHuiHuaBtnClickNotification  @"kLYZuiJinHuiHuaBtnClickNotification"
//今日接待按钮被点击
#define LYJinRiJieDaiBtnClickNotification   @"kLYJinRiJieDaiBtnClickNotification"

//联系人单元格选中变化
#define LYContactRowSelectionDidChangeNotification   @"kLYContactRowSelectionDidChangeNotification"

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

//图片上传路径
#define  GetImageUploadURLWith(fileName) [@"http://localhost:8080/imfileserver/Upload/Image/" stringByAppendingString:fileName];


#define WS(weakSelf)  __weak __typeof(&*self)weakSelf = self;

#endif /* CommonDef_h */
