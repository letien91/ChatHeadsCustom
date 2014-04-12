//
//  AppDelegate.m
//  Test5
//
//  Created by Appota on 4/7/14.
//  Copyright (c) 2014 Appota. All rights reserved.
//

#import "AppDelegate.h"
#import "CHDraggableView+Avatar.h"
#import "CHAvatarView.h"
#import "ViewController.h"
#import "SecondsViewController.h"
#import "CHDraggingArray.h"

@implementation AppDelegate
@synthesize draggingCoordinator, draggingCoordinator1, draggingCoordinator2, draggingCoordinator3, draggingCoordinator4, draggableView, draggableView1, draggableView2, draggableView3, draggableView4;
- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    // Override point for customization after application launch.
    _listUserChat = [[NSMutableArray alloc] init];
    _draggableViewTag = [[NSString alloc] init];
    _viewController = [[ViewController alloc] initWithNibName:@"ViewController" bundle:nil];
    _navigationController = [[UINavigationController alloc] initWithRootViewController:_viewController];
    self.window.rootViewController = _navigationController;
    self.window.backgroundColor = [UIColor whiteColor];
    [self.window makeKeyAndVisible];
    return YES;
}

+ (AppDelegate *)shareInstance{
    return (AppDelegate *)[[UIApplication sharedApplication] delegate];
}

- (void)draggablewViewIcon: (UIImage*)avatarUser atIndex: (int)index{
    draggableView = [CHDraggableView draggableViewWithImage:avatarUser];
    draggableView.tag = [_draggableViewTag intValue];
    draggingCoordinator = [[CHDraggingCoordinator alloc] initWithWindow:self.window draggableViewBounds:draggableView.bounds];
    draggingCoordinator.delegate = self;
    draggingCoordinator.snappingEdge = CHSnappingEdgeBoth;
    draggableView.delegate = draggingCoordinator;
    [self.window addSubview:draggableView];
    [_listUserChat addObject:draggableView];

}

- (void)draggablewViewIcon1: (UIImage*)avatarUser atIndex: (int)index{
    draggableView1 = [CHDraggableView draggableViewWithImage:avatarUser];
    draggableView1.tag = [_draggableViewTag intValue];
    draggingCoordinator1 = [[CHDraggingCoordinator alloc] initWithWindow:self.window draggableViewBounds:draggableView1.bounds];
    draggingCoordinator1.delegate = self;
    draggingCoordinator1.snappingEdge = CHSnappingEdgeBoth;
    draggableView1.delegate = draggingCoordinator1;
    [self.window addSubview:draggableView1];
    [_listUserChat insertObject:draggableView1 atIndex:0];
//    [_listUserChat addObject:draggableView1];

}

- (void)draggablewViewIcon2: (UIImage*)avatarUser atIndex: (int)index{
    draggableView2 = [CHDraggableView draggableViewWithImage:avatarUser];
    draggableView2.tag = [_draggableViewTag intValue];
    draggingCoordinator2 = [[CHDraggingCoordinator alloc] initWithWindow:self.window draggableViewBounds:draggableView2.bounds];
    draggingCoordinator2.delegate = self;
    draggingCoordinator2.snappingEdge = CHSnappingEdgeBoth;
    draggableView2.delegate = draggingCoordinator2;
    [self.window addSubview:draggableView2];
    [_listUserChat insertObject:draggableView2 atIndex:0];
//    [_listUserChat addObject:draggableView2];

}

- (void)draggablewViewIcon3: (UIImage*)avatarUser atIndex: (int)index{
    draggableView3 = [CHDraggableView draggableViewWithImage:avatarUser];
    draggableView3.tag = [_draggableViewTag intValue];
    draggingCoordinator3 = [[CHDraggingCoordinator alloc] initWithWindow:self.window draggableViewBounds:draggableView3.bounds];
    draggingCoordinator3.delegate = self;
    draggingCoordinator3.snappingEdge = CHSnappingEdgeBoth;
    draggableView3.delegate = draggingCoordinator3;
    [self.window addSubview:draggableView3];
    [_listUserChat insertObject:draggableView3 atIndex:0];
//    [_listUserChat addObject:draggableView3];

}

- (void)draggablewViewIcon4: (UIImage*)avatarUser atIndex: (int)index{
    draggableView4 = [CHDraggableView draggableViewWithImage:avatarUser];
    draggableView4.tag = [_draggableViewTag intValue];
    draggingCoordinator4 = [[CHDraggingCoordinator alloc] initWithWindow:self.window draggableViewBounds:draggableView4.bounds];
    draggingCoordinator4.delegate = self;
    draggingCoordinator4.snappingEdge = CHSnappingEdgeBoth;
    draggableView4.delegate = draggingCoordinator4;
    [self.window addSubview:draggableView4];
    [_listUserChat insertObject:draggableView4 atIndex:0];
//    [_listUserChat addObject:draggableView4];
}

//- (void)createDragCoordinator: (CHDraggingCoordinator*)dragCoodinator withImage: (UIImage*)avatarUser{
//    CHDraggableView *draggableView = [CHDraggableView draggableViewWithImage:avatarUser];
//    draggableView.tag = [_draggableViewTag intValue];
//    
//    dragCoodinator = [[CHDraggingCoordinator alloc] initWithWindow:self.window draggableViewBounds:draggableView.bounds];
//    dragCoodinator.delegate = self;
//    dragCoodinator.snappingEdge = CHSnappingEdgeBoth;
//    draggableView.delegate = dragCoodinator;
//    [self.window addSubview:draggableView];
//}
- (UIViewController *)draggingCoordinator:(CHDraggingCoordinator *)coordinator viewControllerForDraggableView:(CHDraggableView *)draggableView
{
    return [[SecondsViewController alloc] initWithNibName:@"SecondsViewController" bundle:nil];
}

- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
