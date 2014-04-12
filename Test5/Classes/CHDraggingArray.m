//
//  CHDraggingArray.m
//  Test5
//
//  Created by Appota on 4/10/14.
//  Copyright (c) 2014 Appota. All rights reserved.
//

#import "CHDraggingArray.h"
#import "CHDraggingCoordinator.h"

@implementation CHDraggingArray

@synthesize coordinatorDragging;

+ (id)shareInstance {
    static CHDraggingArray *shareInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        shareInstance = [[self alloc] init];
    });
    return shareInstance;
}

- (id)init {
    if (self = [super init]) {
        CHDraggingCoordinator *draggCoor1 = [[CHDraggingCoordinator alloc] init];
        CHDraggingCoordinator *draggCoor2 = [[CHDraggingCoordinator alloc] init];
        CHDraggingCoordinator *draggCoor3 = [[CHDraggingCoordinator alloc] init];
        CHDraggingCoordinator *draggCoor4 = [[CHDraggingCoordinator alloc] init];
        CHDraggingCoordinator *draggCoor5 = [[CHDraggingCoordinator alloc] init];
        coordinatorDragging = [[NSMutableArray alloc] initWithObjects:draggCoor1, draggCoor2, draggCoor3, draggCoor4, draggCoor5, nil];
    }
    return self;
}

@end
