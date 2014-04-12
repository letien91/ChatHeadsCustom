//
//  ViewController.h
//  Test5
//
//  Created by Appota on 4/7/14.
//  Copyright (c) 2014 Appota. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController<UITableViewDataSource, UITableViewDelegate> {
    NSMutableArray *tableData;
    BOOL isOdd;
    int indexAvatar;
}
@property (strong, nonatomic) IBOutlet UITableView *listTableView;

@end
