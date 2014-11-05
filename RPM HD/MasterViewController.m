//
//  MasterViewController.m
//  RPM HD
//
//  Created by Steven Xu on 31/10/2014.
//  Copyright (c) 2014 Sterling Publishing. All rights reserved.
//

#import "MasterViewController.h"
#import "DetailViewController.h"

#import "AFNetworking.h"
#import "RPMArticle.h"

@interface MasterViewController ()

@property NSMutableArray *objects;
@end

@implementation MasterViewController

- (void)awakeFromNib {
    [super awakeFromNib];
    self.clearsSelectionOnViewWillAppear = NO;
    self.preferredContentSize = CGSizeMake(320.0, 600.0);
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.navigationItem.leftBarButtonItem = self.editButtonItem;

//    UIBarButtonItem *addButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(insertNewObject:)];
//    self.navigationItem.rightBarButtonItem = addButton;
    self.detailViewController = (DetailViewController *)[[self.splitViewController.viewControllers lastObject] topViewController];
    
    
//    NSString* html5 = @"http://html5test.com/";
//    NSString* html5title = @"HTML 5 Test Page";
//    RPMArticle* article = [RPMArticle alloc];
//    article.title =  html5title;
//    article.url = html5;
//    
//    
//    if (!self.objects) {
//        self.objects = [[NSMutableArray alloc] init];
//    }
//    [self.objects insertObject:article atIndex:0];
//    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:0 inSection:0];
//    [self.tableView insertRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
    
//        NSString* html5 = @"https://www.scirra.com/demos/c2/particles/";
//        NSString* html5title = @"WebGL Test Page";
//        RPMArticle* article = [RPMArticle alloc];
//        article.title =  html5title;
//        article.url = html5;
//    
//    
//        if (!self.objects) {
//            self.objects = [[NSMutableArray alloc] init];
//        }
//        [self.objects insertObject:article atIndex:0];
//        NSIndexPath *indexPath = [NSIndexPath indexPathForRow:0 inSection:0];
//        [self.tableView insertRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
    
//    NSString* html5 = @"https://www.scirra.com/demos/c2/renderperfgl/";
//    NSString* html5title = @"rendering Test Page";
//    RPMArticle* article = [RPMArticle alloc];
//    article.title =  html5title;
//    article.url = html5;
//    
//    
//    if (!self.objects) {
//        self.objects = [[NSMutableArray alloc] init];
//    }
//    [self.objects insertObject:article atIndex:0];
//    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:0 inSection:0];
//    [self.tableView insertRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
    
    
    
    [self BuildCachePageQueue:@"http://www.rpmonline.com.au/?option=com_ajax&format=json&plugin=latestajaxarticlesfromcategory&cat_id=26"];
    [self BuildCachePageQueue:@"http://www.rpmonline.com.au/?option=com_ajax&format=json&plugin=latestajaxarticlesfromcategory&cat_id=8"];
     [self BuildCachePageQueue:@"http://www.rpmonline.com.au/?option=com_ajax&format=json&plugin=latestajaxarticlesfromcategory&cat_id=13"];
    [self BuildCachePageQueue:@"http://www.rpmonline.com.au/?option=com_ajax&format=json&plugin=latestajaxarticlesfromcategory&cat_id=53"];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)insertNewObject:(id)sender {
    if (!self.objects) {
        self.objects = [[NSMutableArray alloc] init];
    }
//    [self.objects insertObject:[NSDate date] atIndex:0];
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:0 inSection:0];
    [self.tableView insertRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
}

#pragma mark - Segues

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([[segue identifier] isEqualToString:@"showDetail"]) {
        NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
        RPMArticle *object = self.objects[indexPath.row];
        DetailViewController *controller = (DetailViewController *)[[segue destinationViewController] topViewController];
        [controller navigateTo:object.url];
        controller.navigationItem.leftBarButtonItem = self.splitViewController.displayModeButtonItem;
        controller.navigationItem.leftItemsSupplementBackButton = YES;
    }
}

#pragma mark - Table View

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.objects.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];

//    NSDate *object = self.objects[indexPath.row];
//    cell.textLabel.text = [object description];
    RPMArticle *article = self.objects[indexPath.row];
    cell.textLabel.text = [article title];
    return cell;
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        [self.objects removeObjectAtIndex:indexPath.row];
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view.
    }
}


#pragma mark - download item from network
- (void) BuildCachePageQueue: (NSString* )jsonUrl
{
    //json url: http://www.rebonline.com.au/steven/json/LoadingQueue.json
    
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    [manager GET:jsonUrl parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
//                NSLog(@"JSON: %@", responseObject);
        [self parseItems:responseObject];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"Error: %@", error);
    }];
    
}

-(void)parseItems:(id)json
{

    NSDictionary *jsonDict = (NSDictionary *) json;
    NSArray *array = [jsonDict objectForKey:@"data"];
    [array enumerateObjectsUsingBlock:^(id obj,NSUInteger idx, BOOL *stop){
        NSArray *innerarray = obj;
        [innerarray enumerateObjectsUsingBlock:^(id innerobj,NSUInteger idx, BOOL *stop){
            NSString *title = [innerobj objectForKey:@"title"];
            NSString *url = [innerobj objectForKey:@"link"];
            
//                        NSLog(@"Loading queue title = %@, url = %@",title,url);
            
//            [self AddToQueue:[NSString stringWithFormat:@"%@/%@",BASE_URL,url]];
            
            RPMArticle* article = [RPMArticle alloc];
            article.title =  title;
            article.url = [NSString stringWithFormat:@"%@/%@",BASE_URL,url];
            
            
            if (!self.objects) {
                self.objects = [[NSMutableArray alloc] init];
            }
            [self.objects insertObject:article atIndex:0];
            NSIndexPath *indexPath = [NSIndexPath indexPathForRow:0 inSection:0];
            [self.tableView insertRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
            
        }];
        
        
        
    }];
    
//    [self LoadNextCachePage];
    
}

@end
