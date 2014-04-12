//
//  CHDraggingCoordinator.m
//  ChatHeads
//
//  Created by Matthias Hochgatterer on 4/19/13.
//  Copyright (c) 2013 Matthias Hochgatterer. All rights reserved.
//

#import "CHDraggingCoordinator.h"
#import <QuartzCore/QuartzCore.h>
#import "CHDraggableView.h"
#import "AppDelegate.h"
#import "CHRemoveChat.h"

typedef enum {
    CHInteractionStateNormal,
    CHInteractionStateConversation
} CHInteractionState;

@interface CHDraggingCoordinator ()

@property (nonatomic, strong) UIWindow *window;
@property (nonatomic, strong) NSMutableDictionary *edgePointDictionary;;
@property (nonatomic, assign) CGRect draggableViewBounds;
@property (nonatomic, assign) CHInteractionState state;
@property (nonatomic, strong) UINavigationController *presentedNavigationController;
@property (nonatomic, strong) UINavigationController *currentNavigationController;
@property (nonatomic, strong) NSMutableArray *arrayController;
@property (nonatomic, strong) UIView *backgroundView;
@property (nonatomic, strong) UIView *backgroundViewRM;

@end

@implementation CHDraggingCoordinator

- (id)initWithWindow:(UIWindow *)window draggableViewBounds:(CGRect)bounds
{
    self = [super init];
    if (self) {
        _window = window;
        _draggableViewBounds = bounds;
        _state = CHInteractionStateNormal;
        _edgePointDictionary = [NSMutableDictionary dictionary];
        _arrayController = [[NSMutableArray alloc] init];
        _releaseAction = CHSnapBack;
        _tapAction = CHGotoConversation;
        isNotDragg = YES;
        isScale = NO;
    }
    return self;
}
#pragma mark - Animation
- (void)animationDraggingIcon: (CHDraggableView*)view {
    
    for (id obj in [[AppDelegate shareInstance] listUserChat]) {
        CHDraggableView *tempView = obj;
        [UIView animateWithDuration:0.3 delay:0.3 options:UIViewAnimationOptionCurveLinear animations:^{
            tempView.frame = CGRectMake(view.frame.origin.x, view.frame.origin.y, view.frame.size.width, view.frame.size.height);
            
        } completion:^(BOOL finished) {
            
        }];
    }
}

- (void)animationDropIcon: (CHDraggableView*)view {
    for (id obj in [[AppDelegate shareInstance] listUserChat]) {
        CHDraggableView *tempView = obj;
        if (tempView.tag != view.tag) {
            [UIView animateWithDuration:0.5 animations:^{
                tempView.frame = CGRectMake(view.frame.origin.x-1, view.frame.origin.y-1, view.frame.size.width, view.frame.size.height);
            }];
            [self.window bringSubviewToFront:tempView];
        }
    }
    [self.window bringSubviewToFront:view];
}

- (void)animationTouchIcon: (CHDraggableView*)view {
    NSLog(@"viewTag: %d", view.tag);
    float xOrigin = view.frame.origin.x;
    float yOrigin = view.frame.origin.y;
    for (id obj in [[AppDelegate shareInstance] listUserChat]) {
        CHDraggableView *tempView = obj;
        [UIView animateWithDuration:0.3 animations:^{
            tempView.frame = CGRectMake(xOrigin, yOrigin, view.frame.size.width, view.frame.size.height);
        }];
        xOrigin -= view.frame.size.width;
        xOrigin += 2;
    }
    [self.window bringSubviewToFront:view];
}

- (void)bringViewToFront {
    if ([[[AppDelegate shareInstance] listUserChat] count]>1) {
        for (int i= ([[[AppDelegate shareInstance] listUserChat] count]-1); i>=0; i--) {
            CHDraggableView *tempView = [[[AppDelegate shareInstance] listUserChat] objectAtIndex:i];
            [self.window bringSubviewToFront:tempView];
        }
    }
    
}
#pragma mark - Geometry

- (CGRect)_dropArea
{
    return CGRectInset([self.window.screen applicationFrame], -(int)(CGRectGetWidth(_draggableViewBounds)/6), 0);
}

- (CGRect)_conversationArea
{
    CGRect slice;
    CGRect remainder;
    CGRectDivide([self.window.screen applicationFrame], &slice, &remainder, CGRectGetHeight(CGRectInset(_draggableViewBounds, -10, 0)), CGRectMinYEdge);
    return slice;
}

- (CGRectEdge)_destinationEdgeForReleasePointInCurrentState:(CGPoint)releasePoint
{
    if (_state == CHInteractionStateConversation) {
//        return CGRectMinYEdge;
        if (_releaseAction == CHSnapBack) {
            return CGRectMinYEdge;
        }
        else if (_releaseAction == CHHidePresentedViewController) {
            return releasePoint.x < CGRectGetMidX([self _dropArea]) ? CGRectMinXEdge : CGRectMaxXEdge;
        }
    } else if(_state == CHInteractionStateNormal) {
        return releasePoint.x < CGRectGetMidX([self _dropArea]) ? CGRectMinXEdge : CGRectMaxXEdge;
    }
    NSAssert(false, @"State not supported");
    return CGRectMinYEdge;
}

- (CGPoint)_destinationPointForReleasePoint:(CGPoint)releasePoint
{
    CGRect dropArea = [self _dropArea];
    
    CGFloat midXDragView = CGRectGetMidX(_draggableViewBounds);
    CGRectEdge destinationEdge = [self _destinationEdgeForReleasePointInCurrentState:releasePoint];
    CGFloat destinationY;
    CGFloat destinationX;
 
    CGFloat topYConstraint = CGRectGetMinY(dropArea) + CGRectGetMidY(_draggableViewBounds);
    CGFloat bottomYConstraint = CGRectGetMaxY(dropArea) - CGRectGetMidY(_draggableViewBounds);
    if (releasePoint.y < topYConstraint) { // Align ChatHead vertically
        destinationY = topYConstraint;
    }else if (releasePoint.y > bottomYConstraint) {
        destinationY = bottomYConstraint;
    }else {
        destinationY = releasePoint.y;
    }

    if (self.snappingEdge == CHSnappingEdgeBoth){   //ChatHead will snap to both edges
        if (destinationEdge == CGRectMinXEdge) {
            destinationX = CGRectGetMinX(dropArea) + midXDragView;
        } else {
            destinationX = CGRectGetMaxX(dropArea) - midXDragView;
        }
        
    }else if(self.snappingEdge == CHSnappingEdgeLeft){  //ChatHead will snap only to left edge
        destinationX = CGRectGetMinX(dropArea) + midXDragView;
        
    }else{  //ChatHead will snap only to right edge
        destinationX = CGRectGetMaxX(dropArea) - midXDragView;
    }

    return CGPointMake(destinationX, destinationY);
}
#pragma mark - Remove
- (void)addViewRemove: (CHDraggableView*)view {
    _viewChat = [CHRemoveChat drawRemoveChatView];
    _viewChat.frame = CGRectMake(0, self.window.frame.size.height+_viewChat.frame.size.height, _viewChat.frame.size.width, _viewChat.frame.size.height);
    [self.window bringSubviewToFront:_viewChat];
    [self.window insertSubview:_viewChat belowSubview:view];
    
    [UIView animateWithDuration:0.3f animations:^{
        _viewChat.frame = CGRectMake(0, self.window.frame.size.height-_viewChat.frame.size.height, _viewChat.frame.size.width, _viewChat.frame.size.height);
    } completion:^(BOOL finished) {
        
    }];
    
}

//chat with user
- (void)removeChat: (CHDraggableView*)view {
    
    [view removeFromSuperview];
}

//view removechat View
- (void)removeChatView {
    [UIView animateWithDuration:0.5f animations:^{
        _viewChat.frame = CGRectMake(0, self.window.frame.size.height + _viewChat.frame.size.height, _viewChat.frame.size.width, _viewChat.frame.size.height);
    } completion:^(BOOL finished) {
        [_viewChat removeFromSuperview];
    }];
    
}
#pragma mark - Dragging

- (void)draggableViewHold:(CHDraggableView *)view
{
    NSLog(@"draggableViewHold");

}

- (void)draggableView:(CHDraggableView *)view didMoveToPoint:(CGPoint)point
{
    
//    NSLog(@"draggableView: didMoveToPoint");
    //set view remove chat
    if (view.frame.origin.y > self.window.frame.size.height - _viewChat.frame.size.height &&
        view.frame.origin.x > self.window.frame.size.width/2 - _viewChat.removeIcon.frame.size.width &&
        view.frame.origin.x < self.window.frame.size.width/2 + _viewChat.removeIcon.frame.size.width) {
        if (isScale == NO) {
            isScale = YES;
            [_viewChat scaleBigRemoveIcon];
        }
    } else {
        if (isScale == YES) {
            isScale = NO;
            [_viewChat scaleNormalRemoveIcon];
        }
    }
    
    //set move
    NSLog(@"ViewTag: %d", view.tag);
    NSLog(@"current: %@", _currentNavigationController);
    NSLog(@"prefer: %@", _presentedNavigationController);
    if (_state == CHInteractionStateConversation) {
        if (_presentedNavigationController) {
            [self _dismissPresentedNavigationController];
        }
        if (_presentedNavigationController == nil) {
            [self _dismissCurrentNavigationController];
        }
    } else {
        [self animationDraggingIcon:view];
        
    }
    if (isNotDragg == YES) {
        isNotDragg = NO;
        [self addViewRemove:view];
    }
    
}

- (void)draggableViewReleased:(CHDraggableView *)view
{
    NSLog(@"draggableViewReleased");
    if (view.frame.origin.y > self.window.frame.size.height - _viewChat.frame.size.height &&
        view.frame.origin.x > self.window.frame.size.width/2 - _viewChat.removeIcon.frame.size.width &&
        view.frame.origin.x < self.window.frame.size.width/2 + _viewChat.removeIcon.frame.size.width) {
        
        [self _dismissPresentedNavigationController];
        [self removeChat:view];
    } else {
        if (_state == CHInteractionStateNormal) {
            [self _animateViewToEdges:view];
            
        } else if(_state == CHInteractionStateConversation) {
            if (self.releaseAction == CHHidePresentedViewController) {
                _state = CHInteractionStateNormal;
                [self _animateViewToEdges:view];
            } else {
                [self _animateViewToConversationArea:view];
                [self _presentViewControllerForDraggableView:view];
            }
        }
    }
    
    isNotDragg = YES;
    [self removeChatView];
}

- (void)draggableViewTouched:(CHDraggableView *)view
{
    NSLog(@"draggableViewTouched");
    
    if (_tapAction == CHInformDelegate) {
        if ([self.delegate respondsToSelector:@selector(draggableViewTapped:)]) {
            [self.delegate draggableViewTapped:view];
        }
    }
    else {
        if (_state == CHInteractionStateNormal) {
            _state = CHInteractionStateConversation;
            [self _animateViewToConversationArea:view];
//            [self _presentViewControllerForDraggableView:view];
            
            [self _unhidePresentedNavigationControllerCompletion:^{
                
            } withDraggableView:view];
            
            [self animationTouchIcon:view];
        } else if(_state == CHInteractionStateConversation) {
            _state = CHInteractionStateNormal;

            NSValue *knownEdgePoint = [_edgePointDictionary objectForKey:@(view.tag)];
            if (knownEdgePoint) {
                [self _animateView:view toEdgePoint:[knownEdgePoint CGPointValue]];
            } else {
                [self _animateViewToEdges:view];
            }
            [self _hidePresentedNavigationControllerCompletion:^{
                
            }];
//            [self _dismissPresentedNavigationController];
        }
    }
    
}

#pragma mark - Alignment

- (void)draggableViewNeedsAlignment:(CHDraggableView *)view
{
    
    NSLog(@"draggableViewNeedsAlignment");
    if (_state == CHInteractionStateNormal) {
        _state = CHInteractionStateConversation;
        [self _animateViewToConversationArea:view];
        [self animationTouchIcon:view];
        [self _presentViewControllerForDraggableView:view];
    } else if(_state == CHInteractionStateConversation) {
        _state = CHInteractionStateNormal;
        NSValue *knownEdgePoint = [_edgePointDictionary objectForKey:@(view.tag)];
        if (knownEdgePoint) {
            [self _animateView:view toEdgePoint:[knownEdgePoint CGPointValue]];
        } else {
            [self _animateViewToEdges:view];
        }
        [self _dismissPresentedNavigationController];
    }
}

#pragma mark Dragging Helper

- (void)_animateViewToEdges:(CHDraggableView *)view {
    //fix bug vị trí xuất hiện ở top
    NSLog(@"_animateViewToEdges");
    CGPoint destinationPoint = [self _destinationPointForReleasePoint:view.center];    
    [self _animateView:view toEdgePoint:destinationPoint];
}

- (void)_animateView:(CHDraggableView *)view toEdgePoint:(CGPoint)point
{
    NSLog(@"_animateView:toEdgePoint");
    [_edgePointDictionary setObject:[NSValue valueWithCGPoint:point] forKey:@(view.tag)];
    [view snapViewCenterToPoint:point edge:[self _destinationEdgeForReleasePointInCurrentState:view.center]];
    [self animationDropIcon: view];
}

- (void)_animateViewToConversationArea:(CHDraggableView *)view {
    //set vị trí hiện của avatar khi show chat, vi tri la ben phai
    NSLog(@"_animateViewToConversationArea");

    CGRect conversationArea = [self _conversationArea];
    CGPoint right = CGPointMake(CGRectGetMaxX(conversationArea) - 33 , CGRectGetMidY(conversationArea) + 10);
    [UIView animateWithDuration:0.5 animations:^{
        [view snapViewCenterToPoint:right edge:[self _destinationEdgeForReleasePointInCurrentState:view.center]];
    }];
}

#pragma mark - View Controller Handling

- (CGRect)_navigationControllerFrame
{
    NSLog(@"_navigationControllerFrame");
    CGRect slice;
    CGRect remainder;
    CGRectDivide([self.window.screen applicationFrame], &slice, &remainder, CGRectGetMaxY([self _conversationArea]), CGRectMinYEdge);
    return remainder;
}

- (CGRect)_navigationControllerHiddenFrame
{
    NSLog(@"_navigationControllerHiddenFrame");
    return CGRectMake(CGRectGetMidX([self _conversationArea]), CGRectGetMaxY([self _conversationArea]), 0, 0);
}

- (void)_presentViewControllerForDraggableView:(CHDraggableView *)draggableView {
    NSLog(@"_presentViewControllerForDraggableView");
    UIViewController *viewController = [_delegate draggingCoordinator:self viewControllerForDraggableView:draggableView];
    
    _presentedNavigationController = [self _createNavigationController:viewController];
    _presentedNavigationController.view.layer.cornerRadius = 3;
    _presentedNavigationController.view.layer.masksToBounds = YES;
    _presentedNavigationController.view.layer.anchorPoint = CGPointMake(0.5f, 0);
    _presentedNavigationController.view.frame = [self _navigationControllerFrame];
    _presentedNavigationController.view.transform = CGAffineTransformMakeScale(0, 0);
    [_arrayController addObject:_presentedNavigationController];
    
    [self.window insertSubview:_presentedNavigationController.view aboveSubview:draggableView];
    [self _unhidePresentedNavigationControllerCompletion:^{} withDraggableView:draggableView];
}

- (UINavigationController*) _createNavigationController:(UIViewController*)rootViewController {
    if ([self.delegate respondsToSelector:@selector(customNavigationControllerForConversation)]) {
        UINavigationController* navController = [self.delegate customNavigationControllerForConversation];
        [navController setViewControllers:@[rootViewController]];
        return navController;
    }
    return [[UINavigationController alloc] initWithRootViewController:rootViewController];
}

- (void) dismissPresentedViewController {
    [self _dismissPresentedNavigationController];
}

- (void)_dismissCurrentNavigationController {
    NSLog(@"_dismissPresentedNavigationController");
    UINavigationController *reference = _currentNavigationController;
    [self _hideCurrentNavigationControllerCompletion:^{
        [reference.view removeFromSuperview];
    }];
    _currentNavigationController = nil;
}
- (void)_dismissPresentedNavigationController {
    NSLog(@"_dismissPresentedNavigationController");
    UINavigationController *reference = _presentedNavigationController;
    [self _hidePresentedNavigationControllerCompletion:^{
        [reference.view removeFromSuperview];
    }];
    _presentedNavigationController = nil;
}

- (void)_unhidePresentedNavigationControllerCompletion:(void(^)())completionBlock withDraggableView:(CHDraggableView *)draggableView {
    //làm mờ view đằng sau
    NSLog(@"__block _unhidePresentedNavigationControllerCompletion");
    CGAffineTransform transformStep1 = CGAffineTransformMakeScale(1.1f, 1.1f);
    CGAffineTransform transformStep2 = CGAffineTransformMakeScale(1, 1);
    _presentedNavigationController.view.alpha = 1.0;
    _backgroundView = [[UIView alloc] initWithFrame:[self.window bounds]];
    _backgroundView.backgroundColor = [UIColor colorWithWhite:0.000 alpha:0.5f];
    _backgroundView.alpha = 0.0f;

    
    [self.window insertSubview:_backgroundView belowSubview:draggableView];

    //cach xuat hien cua view chat
    [UIView animateWithDuration:0.3f delay:0.0f options:UIViewAnimationOptionCurveEaseInOut animations:^{
        _presentedNavigationController.view.layer.affineTransform = transformStep1;
        _backgroundView.alpha = 1.0f;
    }completion:^(BOOL finished){
        if (finished) {
            [UIView animateWithDuration:0.3f animations:^{
                _presentedNavigationController.view.layer.affineTransform = transformStep2;
            }];
        }
        [self.window bringSubviewToFront:_presentedNavigationController.view];
        [self.window bringSubviewToFront:draggableView];
    }];
    
    [self bringViewToFront];
}

- (void)_hidePresentedNavigationControllerCompletion:(void(^)())completionBlock
{
    NSLog(@"_hidePresentedNavigationControllerCompletion");
    UIView *viewToDisplay = _backgroundView;
    [UIView animateWithDuration:0.3f delay:0.0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
        _presentedNavigationController.view.transform = CGAffineTransformMakeScale(0, 0);
        _presentedNavigationController.view.alpha = 0.0f;
        _backgroundView.alpha = 0.0f;
    } completion:^(BOOL finished){
        if (finished) {
            [viewToDisplay removeFromSuperview];
            if (viewToDisplay == _backgroundView) {
                _backgroundView = nil;
            }
            completionBlock();
        }
    }];
}
- (void)_hideCurrentNavigationControllerCompletion:(void(^)())completionBlock
{
    NSLog(@"_hidePresentedNavigationControllerCompletion");
    UIView *viewToDisplay = _backgroundView;
    [UIView animateWithDuration:0.3f delay:0.0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
        _currentNavigationController.view.transform = CGAffineTransformMakeScale(0, 0);
        _currentNavigationController.view.alpha = 0.0f;
        _backgroundView.alpha = 0.0f;
    } completion:^(BOOL finished){
        if (finished) {
            [viewToDisplay removeFromSuperview];
            if (viewToDisplay == _backgroundView) {
                _backgroundView = nil;
            }
            completionBlock();
        }
    }];
}
@end
