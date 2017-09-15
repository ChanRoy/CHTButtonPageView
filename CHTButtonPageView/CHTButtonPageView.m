//
//  CHTButtonPageView.m
//  CHTButtonPageViewDemo
//
//  Created by cht on 2017/9/15.
//  Copyright © 2017年 cht. All rights reserved.
//

#import "CHTButtonPageView.h"
#import "CHTLayoutButton.h"

static NSInteger const kVerCountPerPage = 2; ///< default buttons count of vertical direction per page
static NSInteger const khorCountPerPage = 5; ///< default buttons count of horizontal direction per page
static NSInteger const kButtonStartTag = 100; ///< button start tag

@interface CHTButtonPageView() <UIScrollViewDelegate>

@property (nonatomic, assign) NSInteger verCountPerPage; ///< buttons count of vertical direction per page

@property (nonatomic, assign) NSInteger horCountPerPage; ///< buttons count of horizontal direction per page

@property (nonatomic, strong) NSArray <NSString *>*icons; ///< array of button icon string

@property (nonatomic, strong) NSArray <NSString *>*titles; ///< array of button title string

@property (nonatomic, strong) UIScrollView *scrollView; ///< content scrollview

@property (nonatomic, assign) BOOL hasPageControl; ///< if pageControl exist

@property (nonatomic, strong) UIPageControl *pageControl; ///< UIPageControl to indicate current page & total page

@end

@implementation CHTButtonPageView

#pragma mark - publish methods
- (instancetype)init
{
    return [self initWithFrame:CGRectZero];
}

- (instancetype)initWithFrame:(CGRect)frame
{
    return [self initWithFrame:frame verCountPerPage:0 horCountPerPage:0];
}

- (instancetype)initWithFrame:(CGRect)frame verCountPerPage:(NSInteger)verCountPerPage horCountPerPage:(NSInteger)horCountPerPage
{
    self = [super initWithFrame:frame];
    if (self) {
        
        self.backgroundColor = [UIColor whiteColor];
        _verCountPerPage = verCountPerPage > 0 ? verCountPerPage : kVerCountPerPage;
        _horCountPerPage = horCountPerPage > 0 ? horCountPerPage : khorCountPerPage;
    }
    return self;
}

- (void)configIcons:(NSArray <NSString *>*)icons titles: (NSArray <NSString *>*)titles {
    
    NSAssert(icons.count == titles.count, @"the count of icons is not equal to the count of titles");
    
    _icons = icons;
    _titles = titles;
    
    if (_verCountPerPage * _horCountPerPage < _icons.count) {
        
        _hasPageControl = YES;
    }
    [self setupUI];
}

#pragma mark - private methods
- (void)setupUI {
    
    CGFloat pageControllH = _hasPageControl ? 20 : 0;
    NSInteger pageCount = ceil((double)_icons.count / (_verCountPerPage * _horCountPerPage));
    
    CGFloat scrollViewH = CGRectGetHeight(self.frame) - pageControllH;
    _scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.frame), scrollViewH)];
    _scrollView.showsVerticalScrollIndicator = NO;
    _scrollView.showsHorizontalScrollIndicator = NO;
    _scrollView.contentSize = CGSizeMake(CGRectGetWidth(self.frame) * pageCount, scrollViewH);
    _scrollView.pagingEnabled = YES;
    _scrollView.delegate = self;
    [self addSubview:_scrollView];
    
    CGFloat buttonW = CGRectGetWidth(_scrollView.frame) / _horCountPerPage;
    CGFloat buttonH = CGRectGetHeight(_scrollView.frame) / _verCountPerPage;
    
    for (NSInteger i = 0; i < pageCount; i ++) {
        
        for (NSInteger j = 0; j < _verCountPerPage; j ++) {
            
            for (NSInteger k = 0; k < _horCountPerPage; k ++) {
                
                NSInteger index = i * _verCountPerPage * _horCountPerPage + j * _horCountPerPage + k;
                
                if (index >= _icons.count) {
                    
                    break;
                }
                
                CHTLayoutButton *btn = [[CHTLayoutButton alloc] initWithFrame:CGRectMake(i * CGRectGetWidth(_scrollView.frame) + k * buttonW, j * buttonH, buttonW, buttonH)
                                                                    subMargin:5
                                                             layoutButtonType:CHTLayoutButtonTypeTop];
                btn.titleLabel.font = [UIFont systemFontOfSize:12];
                btn.tag = index + kButtonStartTag;
                [btn setTitle:_titles[index] forState:UIControlStateNormal];
                [btn setImage:[UIImage imageNamed:_icons[index]] forState:UIControlStateNormal];
                [btn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
                [_scrollView addSubview:btn];
            }
        }
        
    }
    
    if (_hasPageControl) {
        
        _pageControl = [[UIPageControl alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(_scrollView.frame), CGRectGetWidth(self.frame), pageControllH)];
        _pageControl.numberOfPages = pageCount;
        _pageControl.pageIndicatorTintColor = [UIColor grayColor];
        _pageControl.currentPageIndicatorTintColor = [UIColor orangeColor];
        [self addSubview:_pageControl];
    }
}

// button click event
- (void)btnClick:(UIButton *)button {
    
    if (_delegate && [_delegate respondsToSelector:@selector(buttonPageView:didSelectButtonWithIndex:)]) {
        
        [_delegate buttonPageView:self didSelectButtonWithIndex:button.tag - kButtonStartTag];
    }
}

#pragma mark - scrollview delegate
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    
    CGFloat offsetX = scrollView.contentOffset.x;
    CGFloat currentPage = floor(offsetX / CGRectGetWidth(scrollView.frame));
    _pageControl.currentPage = currentPage;
}

@end
