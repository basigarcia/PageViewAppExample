//
//  PageAppExampleViewController.m
//  PageAppExample
//
//  Created by Basilio García Castillo on 6/22/14.
//  Copyright (c) 2014 Basilio García. All rights reserved.
//

#import "PageAppExampleViewController.h"

@interface PageAppExampleViewController ()

@end

@implementation PageAppExampleViewController

-(void) createContentPages{
    NSMutableArray* pageStrings = [[NSMutableArray alloc] init];
    for(int i = 1; i < 11; i++){
        NSString *contentString = [[NSString alloc] initWithFormat:@"<html><head></head><body><br><h1>Page %d</h1><p>This is the page number %d of our PageViewController app example.</p></body></html>", i, i];
        [pageStrings addObject:contentString];
    }
    _pageContent = [[NSArray alloc] initWithArray:pageStrings];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self createContentPages];
    
    //We create an NSDictionary to contain the options for the controller object, this is just the location of the border of the page
    NSDictionary *options = [NSDictionary dictionaryWithObject:[NSNumber numberWithInteger:UIPageViewControllerSpineLocationMin]forKey:UIPageViewControllerOptionSpineLocationKey];
    
    //Next create an instance of the UIPageViewController with previous options and horizontal transitions
    _pageController = [[UIPageViewController alloc]
                       initWithTransitionStyle:UIPageViewControllerTransitionStylePageCurl navigationOrientation:UIPageViewControllerNavigationOrientationHorizontal
                       options:options];
    
    //Set the bounds of our view to the entire screen
    _pageController.dataSource = self;
    [[_pageController view] setFrame:[[self view] bounds]];
    
    //Create a viewController by using the viewControllerAtIndex, once its been created assign the array of view controllers
    ContentViewController *initialViewController = [self viewControllerAtIndex:0];
    NSArray *viewControllers = [NSArray arrayWithObjects:initialViewController];
    
    //Then assign the array to the viewController, and direction is to move forward
    [_pageController setViewControllers:viewControllers direction:UIPageViewControllerNavigationDirectionForward
                               animated:NO
                             completion:nil];
    
    //Finally add the page view controller to the current view
    [self addChildViewController:_pageController];
    [[self view] addSubview:[_pageController view]];
    [_pageController didMoveToParentViewController:self];

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(NSUInteger)indexOfViewController:(ContentViewController *)viewController{
    return [_pageContent indexOfObject:viewController.dataObject];
}

-(ContentViewController *) viewControllerAtIndex: (NSUInteger) index{
    if(([self.pageContent count] == 0) || (index >= [self.pageContent count])){
        return nil;
    }
    
    UIStoryboard * storyBoard = [UIStoryboard storyboardWithName:@"Main" bundle:[NSBundle mainBundle]];
    
    ContentViewController *dataViewController = [storyBoard instantiateViewControllerWithIdentifier:@"contentView"];
    dataViewController.dataObject = _pageContent[index];
    return dataViewController;
}

-(UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerAfterViewController:(UIViewController *)viewController{
    NSUInteger index = [self indexOfViewController:(ContentViewController *)viewController];
    if(index == NSNotFound){
        return nil;
    }
    index++;
    if(index == [self.pageContent count]){
        return nil;
    }
    return [self viewControllerAtIndex:index];
    
}

-(UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerBeforeViewController:(UIViewController *)viewController{
    
    NSUInteger index = [self indexOfViewController:(ContentViewController *)viewController];
    if((index == 0) || (index == NSNotFound)){
        return nil;
    }
    index--;
    return [self viewControllerAtIndex:index];
}

@end
