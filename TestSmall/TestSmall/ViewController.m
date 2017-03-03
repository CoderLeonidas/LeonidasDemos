//
//  ViewController.m
//  TestSmall
//
//  Created by 罗阳 on 2017/3/3.
//  Copyright © 2017年 Leon. All rights reserved.
//

#import <Small/Small.h>
#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    // Optional - define a base URI for multi-platforms (HTML etc)
    [Small setBaseUri:@"http://code.wequick.net/"];

    // Set up all the bundles declare in bundle.json
    [Small setUpWithComplection:^{
        [Small openUri:@"main" fromController:self];
    }];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
