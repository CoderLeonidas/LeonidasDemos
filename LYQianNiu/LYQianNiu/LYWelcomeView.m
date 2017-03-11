//
//  LYWelcomeView.m
//  LYQianNiu
//
//  Created by Leonidas on 2017/3/11.
//  Copyright © 2017年 Leon. All rights reserved.
//

#import "LYWelcomeView.h"

@interface LYWelcomeView ()

@property (weak) IBOutlet NSImageView *imageView;

@end

@implementation LYWelcomeView

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

- (instancetype)initWithCoder:(NSCoder*)coder {
    if (self = [super initWithCoder:coder]) {
    }
    return self;
}

- (void)drawRect:(NSRect)dirtyRect {
    [super drawRect:dirtyRect];
    
    [[NSColor whiteColor] set];
    
    NSRectFill(self.bounds);
}

@end
