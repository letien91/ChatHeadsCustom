//
//  ViewController.m
//  Test5
//
//  Created by Appota on 4/7/14.
//  Copyright (c) 2014 Appota. All rights reserved.
//

#import "ViewController.h"
#import "AppDelegate.h"

@interface ViewController ()

@end

@implementation ViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    tableData = [NSMutableArray arrayWithObjects:@"Egg Benedict", @"Mushroom Risotto", @"Full Breakfast", @"Hamburger", @"Ham and Egg Sandwich", @"Creme Brelee", @"White Chocolate Donut", @"Starbucks Coffee", @"Vegetable Curry", @"Instant Noodle with Egg", @"Noodle with BBQ Pork", @"Japanese Noodle with Pork", @"Green Tea", @"Thai Shrimp Cake", @"Angry Birds Cake", @"Ham and Cheese Panini", nil];
    isOdd = NO;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [tableData count];
}
- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *cellIndentify = @"cellIndentify";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIndentify];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIndentify];
    }
    cell.textLabel.text = [NSString stringWithFormat:@"%@",[tableData objectAtIndex:indexPath.row]];
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    [AppDelegate shareInstance].draggableViewTag = [NSString stringWithFormat:@"%d",indexAvatar];
    switch (indexAvatar) {
        case 0:{
            [[AppDelegate shareInstance] draggablewViewIcon:[UIImage imageNamed:@"avatar6.png"] atIndex:indexAvatar];
        }
            break;
        case 1:{
            [[AppDelegate shareInstance] draggablewViewIcon1:[UIImage imageNamed:@"avatar5.png"] atIndex:indexAvatar];
        }
            break;
        case 2:{
            [[AppDelegate shareInstance] draggablewViewIcon2:[UIImage imageNamed:@"avatar4.png"] atIndex:indexAvatar];
        }
            break;
        case 3:{
            [[AppDelegate shareInstance] draggablewViewIcon3:[UIImage imageNamed:@"avatar3.png"] atIndex:indexAvatar];
        }
            break;
        case 4:{
            [[AppDelegate shareInstance] draggablewViewIcon4:[UIImage imageNamed:@"avatar.png"] atIndex:indexAvatar];
        }
            break;
            
        default:
            break;
    }
    
    indexAvatar++;
}
@end
