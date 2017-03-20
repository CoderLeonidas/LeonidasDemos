//
//  LYContactTableCellView.m
//  LYQianNiu
//
//  Created by Leonidas on 2017/3/15.
//  Copyright © 2017年 Leon. All rights reserved.
//

#import "LYContactTableCellView.h"

@interface LYContactTableCellView ()
@property (weak) IBOutlet NSView *view;
@property (weak) IBOutlet NSImageView *avatarImageView;//店铺logo头像
@property (weak) IBOutlet NSTextField *shopMessageLabel;//店铺信息

@end


@implementation LYContactTableCellView

+ (LYContactTableCellView *)contactTableCellView {
    return [[LYContactTableCellView alloc] init];
}

- (instancetype)init {
    if (self = [super init]) {
        NSString* nibName = NSStringFromClass([self class]);
        if ([[NSBundle mainBundle] loadNibNamed:nibName
                                          owner:self
                                topLevelObjects:nil]) {
            [self.view setFrame:[self bounds]];
            [self addSubview:self.view];
        }
    }
    return self;
}

- (void)drawRect:(NSRect)dirtyRect {
    [super drawRect:dirtyRect];
}

- (void)setModel:(XMPPUserCoreDataStorageObject *)model {
    if (!model) return;
    _model = model;

    if (model.photo) {
        self.avatarImageView.image = model.photo;
    }
    self.shopMessageLabel.stringValue = [NSString stringWithFormat:@"%@:%@", model.nickname, model.displayName];
  
    
}


@end
