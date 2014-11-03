//
//  DetailViewController.m
//  RPM HD
//
//  Created by Steven Xu on 31/10/2014.
//  Copyright (c) 2014 Sterling Publishing. All rights reserved.
//

#import "DetailViewController.h"

@interface DetailViewController ()
@property(strong,nonatomic) WKWebView *theWebView;

@end

@implementation DetailViewController

#pragma mark - Managing the detail item

- (void)setDetailItem:(id)newDetailItem {
    if (_detailItem != newDetailItem) {
        _detailItem = newDetailItem;
            
        // Update the view.
        [self configureView];
    }
}

- (void)configureView {
    // Update the user interface for the detail item.
    if (self.detailItem) {
        self.detailDescriptionLabel.text = [self.detailItem description];
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    [self configureView];
    [self initWebView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(NSString*)getAppUA
{
    
    NSString *version = [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"];
    //    NSLog(@"build version = :  %@",version);
    // Modify the user-agent
    NSString* suffixUA = [NSString stringWithFormat:@" mobileapp %@ ",version];//@" mobileapp";
    UIWebView* webView = [[UIWebView alloc] initWithFrame:CGRectZero];
    NSString* defaultUA = [webView stringByEvaluatingJavaScriptFromString:@"navigator.userAgent"];
    NSString* finalUA = [defaultUA stringByAppendingString:suffixUA];
    NSDictionary *dictionary = [NSDictionary dictionaryWithObjectsAndKeys:finalUA, @"UserAgent", nil];
    [[NSUserDefaults standardUserDefaults] registerDefaults:dictionary];
    
    
    
    return finalUA;
}

- (void)initWebView {
    
    WKWebViewConfiguration *theConfiguration =
    [[WKWebViewConfiguration alloc] init];
    NSLog(@"self.view.frame = %f,%f,%f,%f",self.view.frame.origin.x,self.view.frame.origin.y,self.view.frame.size.width,self.view.frame.size.height);
    CGRect newFrame = CGRectMake(0, 60, 700, 708);
    _theWebView = [[WKWebView alloc] initWithFrame:newFrame
                                     configuration:theConfiguration];
    
    NSMutableURLRequest* request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:@"http://www.rpmonline.com.au"]];
//    [request setValue:[self getAppUA] forHTTPHeaderField:@"User-Agent"];
    
    [_theWebView loadRequest:request];
    [self.view addSubview:_theWebView];
    
    
}

@end
