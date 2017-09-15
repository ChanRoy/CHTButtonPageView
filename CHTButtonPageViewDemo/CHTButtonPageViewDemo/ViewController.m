//
//  ViewController.m
//  CHTButtonPageViewDemo
//
//  Created by cht on 2017/9/15.
//  Copyright © 2017年 cht. All rights reserved.
//

#import "ViewController.h"
#import "CHTButtonPageView.h"

@interface ViewController () <CHTButtonPageViewDelegate>

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    NSArray *titles = @[@"Bookmark",@"Camera",@"Edit",@"File",@"Folder",@"Open",@"Picture",@"Restart",@"Search",@"Share",@"Synchronize",@"Trash"];
    NSArray *icons = @[@"Bookmark",@"Camera",@"Edit",@"File",@"Folder",@"Open",@"Picture",@"Restart",@"Search",@"Share",@"Synchronize",@"Trash"];
    
    CHTButtonPageView *pageView = [[CHTButtonPageView alloc] initWithFrame:CGRectMake(0, 200, CGRectGetWidth(self.view.frame), 120) verCountPerPage:2 horCountPerPage:5];
    [pageView configIcons:icons titles:titles];
    pageView.delegate = self;
    [self.view addSubview:pageView];
}

- (void)buttonPageView:(CHTButtonPageView *)buttonPageView didSelectButtonWithIndex:(NSInteger)index {
    
    NSLog(@"You have selected button at index of %ld.\n",index);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
