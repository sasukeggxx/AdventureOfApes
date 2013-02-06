//
//  WinLayer.h
//  AdventureOfApes
//
//  Created by Alex Zen on 13-2-5.
//  Copyright 2013年 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"

@interface WinLayer : CCLayer {
    CCLabelBMFont *scoreLab;
    CCLabelBMFont *timeLab;
    CCLabelBMFont *lifeLab;
}
@property (nonatomic,retain) CCLabelBMFont *scoreLab;
@property (nonatomic,retain) CCLabelBMFont *timeLab;
@property (nonatomic,retain) CCLabelBMFont *lifeLab;

@end
