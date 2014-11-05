//
//  MasterViewController.h
//  RPM HD
//
//  Created by Steven Xu on 31/10/2014.
//  Copyright (c) 2014 Sterling Publishing. All rights reserved.
//

#import <UIKit/UIKit.h>

#define     BASE_URL @"http://www.rpmonline.com.au"

@class DetailViewController;

@interface MasterViewController : UITableViewController

@property (strong, nonatomic) DetailViewController *detailViewController;


@end

