//
//  ViewController.m
//  Hybrid App Analytics
//
//  Created by Randy Dailey on 1/9/13.
//  Copyright (c) 2013 Localytics. All rights reserved.
//

#import "ViewController.h"
#import "LocalyticsSession.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    _webView.delegate = self;
    [_webView loadRequest:[NSURLRequest requestWithURL:[NSURL fileURLWithPath:[[NSBundle mainBundle] pathForResource:@"index" ofType:@"html" inDirectory:@""] isDirectory:NO]]];
}


- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType
{
    // Intercept calls to the 'localytics' protocol
    if ([request.URL.scheme isEqualToString:@"localytics"])
    {
        NSString *event = [self valueFromQueryStringKey:@"event" url:request.URL];
        if (event)
        {
            NSString *attributes = [self valueFromQueryStringKey:@"attributes" url:request.URL];
            NSDictionary* attributesDict = nil;
            if(attributes)
            {
                NSData *attributesData = [attributes dataUsingEncoding:NSUTF8StringEncoding];
                attributesDict = [NSJSONSerialization JSONObjectWithData:attributesData
                                                                 options:NSJSONReadingMutableLeaves error:nil];
            }
            
            // Perform the native tagging call with the retrieved data
            [[LocalyticsSession sharedLocalyticsSession] tagEvent:event attributes:attributesDict];
        }
        
        // From here, cancel the request. Don't let the webView try and load our custom URL
        return NO;
    }
    
    // Otherwise, load the request in the webView
    return YES;
}

// Helper function for extracting querystring key/value pairs
- (NSString *)valueFromQueryStringKey:(NSString *)queryStringKey url:(NSURL *)url
{
    if (!queryStringKey.length || !url.query)
        return nil;
    
    NSArray *urlComponents = [url.query componentsSeparatedByString:@"&"];
    for (NSString *keyValuePair in urlComponents)
    {
        NSArray *keyValuePairComponents = [keyValuePair componentsSeparatedByString:@"="];
        if ([[keyValuePairComponents objectAtIndex:0] isEqualToString:queryStringKey])
        {
            if(keyValuePairComponents.count == 2)
                return [[keyValuePairComponents objectAtIndex:1]
                        stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
        }
    }
    
    return nil;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
