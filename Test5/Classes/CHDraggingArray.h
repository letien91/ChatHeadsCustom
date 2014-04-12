//
//  CHDraggingArray.h
//  Test5
//
//  Created by Appota on 4/10/14.
//  Copyright (c) 2014 Appota. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CHDraggingArray : NSObject

@property (strong, nonatomic) NSMutableArray *coordinatorDragging;

+ (id)shareInstance;
@end
