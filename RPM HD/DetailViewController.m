//
//  DetailViewController.m
//  RPM HD
//
//  Created by Steven Xu on 31/10/2014.
//  Copyright (c) 2014 Sterling Publishing. All rights reserved.
//

#import "DetailViewController.h"

@interface DetailViewController ()
{
    NSString* currentUrl;
}
@property(strong,nonatomic) WKWebView *theWebView;
@property(strong,nonatomic) UIWebView *theWebView2;

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
        self.detailDescriptionLabel.text = @"";
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
//    [self configureView];
    
        UIBarButtonItem *addButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemRefresh target:self action:@selector(changeWindowSize:)];
        self.navigationItem.rightBarButtonItem = addButton;
    if (_theWebView==nil) {
            [self initWebView];
    }

}

- (void)changeWindowSize:(id)sender {

    [UIView animateWithDuration:.8f animations:^{
        
        long leftBound = _theWebView.frame.origin.x;
        switch (leftBound) {
            case 355:{
                CGRect newFrame = CGRectMake(0, 60, 700, 708);
                CGRect newFrame2 = CGRectMake(700, 60, 0, 708);
                _theWebView.frame =newFrame2;
                _theWebView2.frame =newFrame;
            }
                break;
            case 700:{
//                CGRect newFrame = CGRectMake(0, 60, 0, 708);
//                CGRect newFrame2 = CGRectMake(0, 60, 700, 708);
                CGRect newFrame = CGRectMake(0, 60, 1, 708);
                CGRect newFrame2 = CGRectMake(1, 60, 699, 708);
                _theWebView.frame =newFrame2;
                _theWebView2.frame =newFrame;
            }
                break;
            case 1:{
                CGRect newFrame = CGRectMake(0, 60, 345, 708);
                CGRect newFrame2 = CGRectMake(355, 60, 345, 708);
                _theWebView.frame =newFrame2;
                _theWebView2.frame =newFrame;
            }
                break;
                
            default:
                break;
        }
        
        

    }];
    
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
    CGRect newFrame2 = CGRectMake(0, 60, 345, 708);
    CGRect newFrame = CGRectMake(355, 60, 345, 708);
    _theWebView = [[WKWebView alloc] initWithFrame:newFrame
                                     configuration:theConfiguration];
    _theWebView.navigationDelegate = self;
    
    
    
    NSString* loadUrl =@"http://www.rpmonline.com.au";
    if (currentUrl.length>0) {
        loadUrl = currentUrl;
    }
    
    NSMutableURLRequest* request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:loadUrl]];
//    [request setValue:[self getAppUA] forHTTPHeaderField:@"User-Agent"];
    
    [self.view addSubview:_theWebView];

    [_theWebView loadRequest:request];
    
    _theWebView2 = [[UIWebView alloc] initWithFrame:newFrame2];
     [self.view addSubview:_theWebView2];
    [_theWebView2 loadRequest:request];


    
    
}

-(void) navigateTo:(NSString*)url{
    NSMutableURLRequest* request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:url]];
    
    [_theWebView loadRequest:request];
    [_theWebView2 loadRequest:request];
    currentUrl = url;
}

#pragma mark - WKWebview navigation delegate

-(void)webView:(WKWebView *)webView didStartProvisionalNavigation: (WKNavigation *)navigation {
    
}

- (void)webView:(WKWebView *)webView didFinishNavigation: (WKNavigation *)navigation{
    
}

-(void)webView:(WKWebView *)webView didFailNavigation: (WKNavigation *)navigation withError:(NSError *)error {
    
}

@end
