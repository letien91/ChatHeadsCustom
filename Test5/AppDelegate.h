//
//  AppDelegate.h
//  Test5
//
//  Created by Appota on 4/7/14.
//  Copyright (c) 2014 Appota. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CHDraggingCoordinator.h"
#import "CHDraggingArray.h"
#import "CHDraggableView.h"

@class ViewController;

@interface AppDelegate : UIResponder <UIApplicationDelegate, CHDraggingCoordinatorDelegate>

@property (strong, nonatomic) UIWindow *window;
@property (strong, nonatomic) ViewController *viewController;
@property (strong, nonatomic) UINavigationController *navigationController;
@property (strong, nonatomic) CHDraggableView *draggableView;
@property (strong, nonatomic) CHDraggableView *draggableView1;
@property (strong, nonatomic) CHDraggableView *draggableView2;
@property (strong, nonatomic) CHDraggableView *draggableView3;
@property (strong, nonatomic) CHDraggableView *draggableView4;
@property (strong, nonatomic) CHDraggingCoordinator *draggingCoordinator;
@property (strong, nonatomic) CHDraggingCoordinator *draggingCoordinator1;
@property (strong, nonatomic) CHDraggingCoordinator *draggingCoordinator2;
@property (strong, nonatomic) CHDraggingCoordinator *draggingCoordinator3;
@property (strong, nonatomic) CHDraggingCoordinator *draggingCoordinator4;
@property (strong, nonatomic) CHDraggingArray *draggingArray;
@property (strong, nonatomic) NSMutableArray *listUserChat;
@property (strong, nonatomic) NSString *draggableViewTag;

+ (AppDelegate *)shareInstance;
- (void)draggablewViewIcon: (UIImage*)avatarUser atIndex: (int)index;
- (void)draggablewViewIcon1: (UIImage*)avatarUser atIndex: (int)index;
- (void)draggablewViewIcon2: (UIImage*)avatarUser atIndex: (int)index;
- (void)draggablewViewIcon3: (UIImage*)avatarUser atIndex: (int)index;
- (void)draggablewViewIcon4: (UIImage*)avatarUser atIndex: (int)index;

@end
