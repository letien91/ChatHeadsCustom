//
//  CHRemoveChat.m
//  Test5
//
//  Created by Appota on 4/10/14.
//  Copyright (c) 2014 Appota. All rights reserved.
//

#import "CHRemoveChat.h"
#import "SKBounceAnimation.h"

@implementation CHRemoveChat

+ (id)drawRemoveChatView {
    NSString *nibNameOrNil = @"CHRemoveChat";
    
//    if (IS_IPAD) {
//        nibNameOrNil = [NSString stringWithFormat:@"%@_ipad",nibNameOrNil];
//    } else {
//        nibNameOrNil = [NSString stringWithFormat:@"%@",nibNameOrNil];
//    }
    nibNameOrNil = [NSString stringWithFormat:@"%@",nibNameOrNil];
    NSArray *subviewArray = [[NSBundle mainBundle] loadNibNamed:nibNameOrNil owner:self options:nil];
    UIView *mainView = [subviewArray objectAtIndex:0];
    if ([mainView isKindOfClass:[CHRemoveChat class]]) {
        return mainView;
    } else {
        return nil;
    }
    return mainView;
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/
- (void)scaleBigRemoveIcon {
    [self animationXYZWithValue:1.11 withDuration:0.3 withNumOfBuonce:2];
}
- (void)scaleNormalRemoveIcon {
    [self animationXYZWithValue:1/1.11 withDuration:0.1 withNumOfBuonce:1];
}

-(void) animationXYZWithValue:(float)value withDuration:(float) duration withNumOfBuonce:(int) numOfBounce {
    NSString *keyPath = @"transform";
	CATransform3D transform = _removeIcon.layer.transform;
	id finalValue = [NSValue valueWithCATransform3D: CATransform3DScale(transform, value, value, value)];
	
	SKBounceAnimation *bounceAnimation = [SKBounceAnimation animationWithKeyPath:keyPath];
	bounceAnimation.fromValue = [NSValue valueWithCATransform3D:transform];
	bounceAnimation.toValue = finalValue;
	bounceAnimation.duration = duration;
	bounceAnimation.numberOfBounces = numOfBounce;
	bounceAnimation.shouldOvershoot = YES;
	
	[_removeIcon.layer addAnimation:bounceAnimation forKey:@"keyScale"];
	[_removeIcon.layer setValue:finalValue forKeyPath:keyPath];
}
@end
