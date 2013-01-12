//
//  ViewController.h
//  Hybrid App Analytics
//
//  Created by Randy Dailey on 1/9/13.
//  Copyright (c) 2013 Localytics. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController<UIWebViewDelegate>

@property (strong, nonatomic) IBOutlet UIWebView *webView;

@end
