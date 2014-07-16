//
//  ViewController.m
//  AutoresizeImperfection
//
//  Created by Philippe Converset on 16/07/2014.
//  Copyright (c) 2014 AutreSphere. All rights reserved.
//

#import "ViewController.h"

@interface ViewController () <UIScrollViewDelegate>
@property (strong, nonatomic) IBOutlet UIView *headerView;
@property (strong, nonatomic) IBOutlet UIScrollView *scrollView;
@property (assign, nonatomic) CGFloat headerInitialHeight;
@property (strong, nonatomic) IBOutlet UIView *autoSizeView;
@property (strong, nonatomic) IBOutlet UIView *manualLayoutView;
@property (strong, nonatomic) IBOutlet UIView *autoLayoutView;
@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];

    self.scrollView.contentSize = CGSizeMake(self.view.bounds.size.width, self.view.bounds.size.height + 20);
    self.headerInitialHeight = self.headerView.bounds.size.height;
    [self setupAutoLayoutView];
}

- (void)setupAutoLayoutView
{
    UIView *subview;
    CGRect frame;
    
    subview = self.autoLayoutView.subviews[0];
    frame = subview.frame;
    [subview setTranslatesAutoresizingMaskIntoConstraints:NO];
    [self.autoLayoutView addConstraints:[NSLayoutConstraint
                                         constraintsWithVisualFormat:@"V:|-0-[subview]-0-|"
                                         options:NSLayoutFormatDirectionLeadingToTrailing
                                         metrics:nil
                                         views:NSDictionaryOfVariableBindings(subview)]];
}

- (void)manualLayout
{
    UIView *imageView;
    CGRect frame;
    
    frame = self.manualLayoutView.frame;
    frame.size.height = self.headerView.bounds.size.height;
    self.manualLayoutView.frame = frame;
    
    frame = self.autoLayoutView.frame;
    frame.size.height = self.headerView.bounds.size.height;
    self.autoLayoutView.frame = frame;
    
    imageView = self.manualLayoutView.subviews[0];
    frame = imageView.frame;
    frame.size.height = self.headerView.bounds.size.height;
    imageView.frame = frame;
}

#pragma mark - UIScrollViewDelegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    CGRect frame;
    
    frame = self.headerView.frame;
    frame.size.height = self.headerInitialHeight;

    if(scrollView.contentOffset.y < 0)
    {
        frame.size.height -= scrollView.contentOffset.y;
        frame.origin.y = scrollView.contentOffset.y;
    }
    
    self.headerView.frame = frame;
    [self manualLayout];
}
@end
