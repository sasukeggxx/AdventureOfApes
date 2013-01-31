//
//  MenuScene.h
//  AdventureOfApes
//
//  Created by mumu ya on 13-1-17.
//  Copyright 2013年 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"

@interface MenuScene : CCLayer {
    CCSprite *settingSprite;
    CCMenuItem* shakeOnItem;
    CCMenuItem* shakeOffItem;
    CCMenuItem* soundOnItem;
    CCMenuItem* soundOffItem;
    CCMenuItem* languageChItem;
    CCMenuItem* languageEnItem;
    int mode;
    float currentShowRect;//当前可视区域的大小
    }
+(id) scene;
@end
