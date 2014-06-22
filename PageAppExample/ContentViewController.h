//
//  ContentViewController.h
//  PageAppExample
//
//  Created by Basilio García Castillo on 6/22/14.
//  Copyright (c) 2014 Basilio García. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ContentViewController : UIViewController
@property (strong, nonatomic) IBOutlet UIWebView *webView;
@property (strong ,nonatomic) id dataObject;

@end
