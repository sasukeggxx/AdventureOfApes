//
//  CreateGroundWithCCB.h
//  AdventureOfApes
//
//  Created by Alex Zen on 13-1-29.
//  Copyright 2013年 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"
#import "Box2D.h"
@interface CreateGroundWithCCB : CCLayer {
    
}
+(id) createGroundWithWorld:(b2World*)world withCCBFile:(NSString *)ccbFile;
-(id) initGroundWithWorld:(b2World*)world withCCBFile:(NSString *)ccbFile;
@end
