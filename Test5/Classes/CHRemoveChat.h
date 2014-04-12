//
//  CHRemoveChat.h
//  Test5
//
//  Created by Appota on 4/10/14.
//  Copyright (c) 2014 Appota. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CHDraggableView.h"

@interface CHRemoveChat : UIView

@property (strong, nonatomic) IBOutlet UIImageView *removeIcon;

+ (id)drawRemoveChatView;
- (void)scaleBigRemoveIcon;
- (void)scaleNormalRemoveIcon;
@end
