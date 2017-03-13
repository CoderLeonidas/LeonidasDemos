//
//  LYAvatarImageView.m
//  LYQianNiu
//
//  Created by Leonidas on 2017/3/13.
//  Copyright © 2017年 Leon. All rights reserved.
//

#import "LYAvatarImageView.h"
#import "Masonry.h"
#import "MKBCloseButton.h"
@interface LYAvatarImageView ()
@property (strong) IBOutlet LYAvatarImageView *view;

@property (weak) IBOutlet NSImageView *avatarView;//头像
//包含的按钮
@property (weak) IBOutlet MKBCloseButton *closeBtn;//关闭按钮
@property (weak) IBOutlet MKBCloseButton *onlineStatusBtn;//在线状态按钮
@end

@implementation LYAvatarImageView

- (instancetype)init {
    if (self = [super init]) {
        NSString* nibName = NSStringFromClass([self class]);
        if ([[NSBundle mainBundle] loadNibNamed:nibName
                                          owner:self
                                topLevelObjects:nil]) {
           
            [self.avatarView mas_makeConstraints:^(MASConstraintMaker *make) {
                make.top.left.equalTo(@5);
                make.right.bottom.equalTo(@(-5));
            }];
            
            [self.onlineStatusBtn mas_makeConstraints:^(MASConstraintMaker *make) {
                make.centerX.equalTo(self.avatarView);
                CGFloat centerY = self.avatarView.frame.origin.y;
                make.centerY.equalTo(@(centerY));
                make.width.height.equalTo(@(12));
            }];
            
            [self.closeBtn mas_makeConstraints:^(MASConstraintMaker *make) {
                make.top.equalTo(@5);
                make.right.equalTo(@(-5));
                 make.width.height.equalTo(@(12));
            }];
            
            [self.view setFrame:[self bounds]];
            [self addSubview:self.view];
        }
    }
    return self;
}

- (void)drawRect:(NSRect)dirtyRect {
    [super drawRect:dirtyRect];
    
    // Drawing code here.
}

- (void)setAvatar:(NSImage *)avatar {
    if (!avatar || [avatar isEqualTo:_avatar]) return;
    _avatar = avatar;
    self.avatarView.image = avatar;
}

- (void)setStyleMask:(LYAvatarImageViewStyleMask)styleMask {
    if (_styleMask == styleMask) return;
    
    if ((styleMask & LYAvatarImageViewStyleMaskNone) == LYAvatarImageViewStyleMaskNone) {
    
    }
    
    if ((styleMask & LYAvatarImageViewStyleMaskClose) == LYAvatarImageViewStyleMaskClose) {
        ((NSView *)self.closeBtn).hidden = NO;
    }
    
    if ((styleMask & LYAvatarImageViewStyleMaskOnlineStatus) == LYAvatarImageViewStyleMaskOnlineStatus) {
         ((NSView *)self.onlineStatusBtn).hidden = NO;
    }
}

@end
