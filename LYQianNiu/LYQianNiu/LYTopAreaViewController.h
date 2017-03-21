//
//  LYTopAreaViewController.h
//  LYQianNiu
//
//  Created by Leonidas on 2017/3/12.
//  Copyright © 2017年 Leon. All rights reserved.
//

#import <Cocoa/Cocoa.h>

typedef void(^FoldRightWebViewBlock)(BOOL shouldFold);

@interface LYTopAreaViewController : NSViewController

@property (nonatomic, copy) FoldRightWebViewBlock foldRightWebViewBlock;
- (void)setFoldRightWebViewBlock:(FoldRightWebViewBlock)foldRightWebViewBlock;
@end
