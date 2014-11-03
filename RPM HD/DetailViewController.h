//
//  DetailViewController.h
//  RPM HD
//
//  Created by Steven Xu on 31/10/2014.
//  Copyright (c) 2014 Sterling Publishing. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <WebKit/WebKit.h>

@interface DetailViewController : UIViewController

@property (strong, nonatomic) id detailItem;
@property (weak, nonatomic) IBOutlet UILabel *detailDescriptionLabel;

@end

