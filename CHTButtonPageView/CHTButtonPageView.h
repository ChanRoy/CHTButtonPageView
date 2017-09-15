//
//  CHTButtonPageView.h
//  CHTButtonPageViewDemo
//
//  Created by cht on 2017/9/15.
//  Copyright © 2017年 cht. All rights reserved.
//

#import <UIKit/UIKit.h>
@class CHTButtonPageView;

@protocol CHTButtonPageViewDelegate <NSObject>

@optional
- (void)buttonPageView:(CHTButtonPageView *)buttonPageView didSelectButtonWithIndex:(NSInteger)index;

@end

@interface CHTButtonPageView : UIView

@property (nonatomic, weak) id <CHTButtonPageViewDelegate> delegate; ///< CHTButtonPageViewDelegate

// initialize method
- (instancetype)initWithFrame:(CGRect)frame verCountPerPage:(NSInteger)verCountPerPage horCountPerPage:(NSInteger)horCountPerPage;

// config icons & titles
- (void)configIcons:(NSArray <NSString *>*)icons titles: (NSArray <NSString *>*)titles;

@end
