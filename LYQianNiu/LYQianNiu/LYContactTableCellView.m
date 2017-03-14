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
@property (weak) IBOutlet NSImageView *avatarImageView;
@property (weak) IBOutlet NSTextField *shopMessageLabel;

@end


@implementation LYContactTableCellView

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

+ (LYContactTableCellView *)contactTableCellView {
    return [[LYContactTableCellView alloc] init];
//    NSArray  *topLevelObjects = [[NSArray alloc] init];
//    if ([[NSBundle mainBundle] loadNibNamed:@"LYContactTableCellView" owner:self topLevelObjects:&topLevelObjects]) {
//    
//        return [topLevelObjects lastObject];
//    } else {
//        return nil;
//    }
}

- (void)setModel:(LYContactModel *)model {
    if (!model || [model isEqualTo:_model]) return;
    
    _model = model;
    self.avatarImageView.image = [NSImage imageNamed:model.shopAvatarName];
    self.shopMessageLabel.stringValue = [NSString stringWithFormat:@"%@:%@", model.shopName, model.shopAssistantName];
}



@end
