//
//  ViewController.m
//  CoreImageTest
//
//  Created by John Zhao on 12/22/15.
//  Copyright © 2015 John Zhao. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@property (nonatomic, strong) NSArray               *dataSourceArray;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.dataSourceArray = @[
                             @"Blend",
                             ];
}

#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataSourceArray.count;
}

- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"RootCellIdentifier" forIndexPath:indexPath];
    NSString *title = self.dataSourceArray[indexPath.row];
    cell.textLabel.text = title;
    return cell;
}

#pragma mark - UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];

    NSString *title = self.dataSourceArray[indexPath.row];
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:title bundle:nil];
    if (storyboard == nil) {
        NSLog(@"ERROR: Can't open the %@ storyboard file.", title);
        return;
    }

    UIViewController *vc = [storyboard instantiateInitialViewController];
    if (vc == nil) {
        NSLog(@"ERROR: Can't load initial view controller from %@ storyboard file.", title);
        return;
    }

    [self.navigationController pushViewController:vc animated:YES];
}

@end
