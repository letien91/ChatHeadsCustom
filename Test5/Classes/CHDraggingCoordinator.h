//
//  CHDraggingCoordinator.h
//  ChatHeads
//
//  Created by Matthias Hochgatterer on 4/19/13.
//  Copyright (c) 2013 Matthias Hochgatterer. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CHDraggableView.h"
#import "CHRemoveChat.h"

typedef enum {
    CHSnappingEdgeBoth,
    CHSnappingEdgeRight,
    CHSnappingEdgeLeft
} CHSnappingEdge;

typedef enum {
    CHHidePresentedViewController,
    CHSnapBack
} CHDragReleaseAction;

typedef enum {
    CHGotoConversation,
    CHInformDelegate
} CHTapAction;

@protocol CHDraggingCoordinatorDelegate;
@interface CHDraggingCoordinator : NSObject <CHDraggableViewDelegate> {
    BOOL isNotDragg;
    BOOL isScale;
}
@property (nonatomic, strong) CHRemoveChat *viewChat;
@property (nonatomic) CHSnappingEdge snappingEdge;
@property (nonatomic, weak) id<CHDraggingCoordinatorDelegate> delegate;
@property (nonatomic, assign) CHDragReleaseAction releaseAction;
@property (nonatomic, assign) CHTapAction tapAction;

- (id)initWithWindow:(UIWindow *)window draggableViewBounds:(CGRect)bounds;
- (void) dismissPresentedViewController;

@end

@protocol CHDraggingCoordinatorDelegate <NSObject>
@required
- (UIViewController *)draggingCoordinator:(CHDraggingCoordinator *)coordinator viewControllerForDraggableView:(CHDraggableView *)draggableView;
@optional
- (UINavigationController*) customNavigationControllerForConversation;
- (void) draggableViewTapped:(CHDraggableView*)view;
@end
