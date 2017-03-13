//
//  LYAvatarImageView.h
//  LYQianNiu
//
//  Created by Leonidas on 2017/3/13.
//  Copyright © 2017年 Leon. All rights reserved.
//

#import <Cocoa/Cocoa.h>

typedef NS_OPTIONS(NSUInteger, LYAvatarImageViewStyleMask) {
    LYAvatarImageViewStyleMaskNone = 0,
    LYAvatarImageViewStyleMaskClose = 1 << 0,//有关闭按钮
    LYAvatarImageViewStyleMaskOnlineStatus = 1 << 1,//有在线状态按钮
};

@interface LYAvatarImageView : NSView
@property (nonatomic, strong) NSImage *avatar;//头像
@property (nonatomic, assign) LYAvatarImageViewStyleMask styleMask;//包含的按钮风格


@end
