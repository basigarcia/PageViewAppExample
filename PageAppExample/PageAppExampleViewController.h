//
//  PageAppExampleViewController.h
//  PageAppExample
//
//  Created by Basilio García Castillo on 6/22/14.
//  Copyright (c) 2014 Basilio García. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ContentViewController.h"

@interface PageAppExampleViewController : UIViewController
<UIPageViewControllerDataSource>

@property (strong , nonatomic) UIPageViewController* pageController;
@property (strong , nonatomic) NSArray* pageContent;

@end
