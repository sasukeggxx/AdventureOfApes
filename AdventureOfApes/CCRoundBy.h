//
//  CCRoundBy.h
//  LionAndMouse
//
//  Created by Danny on 12-6-4.
//  Copyright 2012年 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"

@interface CCRoundBy : CCActionInterval <NSCopying>
{
    BOOL turn;
    CGFloat startAngle;
    CGFloat radius;
    CGPoint center;
    CGPoint startPos;
}
@property (nonatomic) BOOL turn;//顺时针还是逆时针
@property (nonatomic) float radius;//半径
@property (nonatomic) CGPoint center;//圆心
@property (nonatomic) CGPoint startPos;//开始坐标

+(id) actionWithDuration: (ccTime) t turn:(BOOL)aTurn center:(CGPoint)aCenter radius:(CGFloat)aRadius;
+(id) actionWithDuration: (ccTime) t turn:(BOOL)aTurn startPos:(CGPoint)aStartPos center:(CGPoint)aCenter radius:(CGFloat)aRadius;
-(id) initWithDuration: (ccTime) t turn:(BOOL)aTurn center:(CGPoint)aCenter radius:(CGFloat)aRadius;
-(id) initWithDuration: (ccTime) t turn:(BOOL)aTurn startPos:(CGPoint)aStartPos center:(CGPoint)aCenter radius:(CGFloat)aRadius;
@end
