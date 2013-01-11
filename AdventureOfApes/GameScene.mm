//
//  GameScene.m
//  AdventureOfApes
//
//  Created by Alex Zen on 13-1-8.
//  Copyright 2013年 __MyCompanyName__. All rights reserved.
//

#import "GameScene.h"
#import "BodyNode.h"
#import "GameUtil.h"
#import "CCBReader.h"
#import "Helpers.h"
#import "CCRoundBy.h"

@implementation GameScene


+(id)scene{
    CCScene *scene=[CCScene node];
    CCLayer *layer=[GameScene node];
    [scene addChild:layer];
    return scene;

}

-(id)init{
    if (self=[super init]) {
        self.isTouchEnabled=YES;
        
        
        [[CCSpriteFrameCache sharedSpriteFrameCache] addSpriteFramesWithFile:@"image.plist"];
        
        // load physics definitions
       // [[GB2ShapeCache sharedShapeCache] addShapesWithFile:@"ground-shape.plist"];
        
        CCLayerColor *bgcol=[CCLayerColor layerWithColor:ccc4(46, 131, 55,255)];//背景色
        [self addChild:bgcol z:-4];

      
        groundLayer=(CCLayer *)[CCBReader nodeGraphFromFile:@"groundLayer.ccb"];
        
        [self addChild:groundLayer z:-3];
        
//       [self initTheWorld];//初始化世界
        
//       [GameUtil enableBox2dDebugDrawing:debugDraw withWorld:world];//debug 物理世界渲染
//        
//       groundShape=[CreateGroundInWorld createGroundWithWorld:world];
        
//      [self addChild:groundShape z:-2];
        
        [self initThePlayer];
        
   //     [self scheduleUpdate];
    }

    return self;
}



-(void)initThePlayer{
//    player=[PlayerSprite addToWorld:world];
//    [self addChild:player z:-1];
//    world->SetGravity(b2Vec2(0.0, 0.0));//重力为0;
      player=[CCSprite spriteWithFile:@"long.png"];
      directionNow=NO;//精灵顺时针转向
      player.position=ccp(100, 320);
      [self addChild:player z:0 tag:1];
      CCAction *downAction=[CCMoveTo actionWithDuration:2 position:ccp(player.position.x,0)];
      CCAction *easeDownAction=[CCEaseIn actionWithAction:downAction rate:2.0];
      [player runAction:easeDownAction]; //模拟下落
    

}

-(void)ccTouchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{

    CGPoint screenCenter=[GameUtil screenCenter];
    CCSprite *guanjian0=(CCSprite *)[groundLayer getChildByTag:0];
    CCSprite *guanjian1=(CCSprite *)[groundLayer getChildByTag:1];
    CGFloat dis0=ccpDistance(guanjian0.position, player.position);
    CGFloat dis1=ccpDistance(guanjian1.position, player.position);
    
    
    NSArray *twoTouch = [touches allObjects];
    
    //Get both touches
    UITouch *tOne = [twoTouch objectAtIndex:0];
    CGPoint firstTouchLocation =[GameUtil locationFromTouch:tOne];//记录该次触摸点gl位置
    
    if (touches.count==1) {
        if (firstTouchLocation.x>screenCenter.x) {//如果任意一点点击的是屏幕右边
            //player.body->ApplyLinearImpulse(b2Vec2(1.0,0.0), player.body->GetPosition());//施加冲量
            
            if (dis0<dis1) {//离挂件0近,向挂件0做圆周运动
           
                    CCRoundBy *roundAction=[CCRoundBy actionWithDuration:2.0 turn:directionNow startPos:[player position] center:[guanjian0 position] radius:dis0];
                    roundAction.tag=1;
                    CCRepeatForever *rep=[CCRepeatForever actionWithAction:roundAction];
                    [player runAction:rep];
               
                
            }else if(dis0>dis1){//挂件1近,向挂件1做圆周运动

                    CCRoundBy *roundAction=[CCRoundBy actionWithDuration:2.0 turn:directionNow startPos:[player position] center:[guanjian1 position] radius:dis1];
                    roundAction.tag=1;
                    CCRepeatForever *rep=[CCRepeatForever actionWithAction:roundAction];
                    [player runAction:rep];
    
            }
            
        }
    }
    
    if (touches.count>1) {
       UITouch *tTwo = [twoTouch objectAtIndex:1];
       CGPoint secondTouchLocation=[GameUtil locationFromTouch:tTwo];//记录该次触摸点gl位置
        
        if (firstTouchLocation.x>screenCenter.x||secondTouchLocation.x>screenCenter.x) {//如果任意一点点击的是屏幕右边
          
            if (dis0<dis1) {//离挂件0近,向挂件0做圆周运动

                    CCRoundBy *roundAction=[CCRoundBy actionWithDuration:2.0 turn:directionNow center:[guanjian0 position] radius:dis0];
                    roundAction.tag=1;
                    CCRepeatForever *rep=[CCRepeatForever actionWithAction:roundAction];
                    [player runAction:rep];
       
            }else{//挂件1近,向挂件1做圆周运动

                    CCRoundBy *roundAction=[CCRoundBy actionWithDuration:2.0 turn:directionNow center:[guanjian1 position] radius:dis1];
                    roundAction.tag=1;
                    CCRepeatForever *rep=[CCRepeatForever actionWithAction:roundAction];
                    [player runAction:rep];
   
            }
            
        }else if(firstTouchLocation.x<screenCenter.x||secondTouchLocation.x<screenCenter.x){//如果任意一点点击的是屏幕右边则需要转向
            
            [player stopAllActions];
            CCRoundBy *roundAction=(CCRoundBy *)[player getActionByTag:1];
            [player runAction:[roundAction reverse]];
            
            
        }
    }
  

  
   

}
   

    


-(void)ccTouchesEnded:(NSSet *)touches withEvent:(UIEvent *)event{

    UITouch *touch = [touches anyObject];
    CGPoint touchLocation =[GameUtil locationFromTouch:touch];//记录该次触摸位置
    CGPoint screenCenter=[GameUtil screenCenter];
    
    
    if (touchLocation.x>screenCenter.x) {//如果触发的是屏幕右边
     
       
            [player stopAllActions];
            CCAction *downAction=[CCMoveTo actionWithDuration:2 position:ccp(player.position.x,0)];
            CCAction *easeDownAction=[CCEaseIn actionWithAction:downAction rate:2.0];
            [player runAction:easeDownAction]; //模拟下落
      
               
    }


}



-(void)initTheWorld{
    
    //初始化世界
    b2Vec2 gravity=b2Vec2(0.0,-10);//重力常量
    bool allowBodiesToSleep=true;
    world=new b2World(gravity,allowBodiesToSleep);
    listener=new ContactListener();
    world->SetContactListener(listener);//设置碰撞监听器
    
    
    b2BodyDef containerBodydef;
    b2Body *containerBody=world->CreateBody(&containerBodydef);
    
    // for the ground body we'll need these values
    CGSize screenSize = [CCDirector sharedDirector].winSize;
    float widthInMeters = screenSize.width / PTM_RATIO;//转换成米单位
    float heightInMeters = screenSize.height / PTM_RATIO;
    
    b2Vec2 lowerLeftCorner = b2Vec2(0, 0);//左下角
    b2Vec2 lowerRightCorner = b2Vec2(widthInMeters, 0);//右下角
    b2Vec2 upperLeftCorner = b2Vec2(0, heightInMeters);
    b2Vec2 upperRightCorner = b2Vec2(widthInMeters, heightInMeters);
    
    
    b2PolygonShape screenBoxShape;
    int density = 0;//密度
    
    // bottom
    screenBoxShape.SetAsEdge(lowerLeftCorner, lowerRightCorner);
    b2Fixture *bottom=containerBody->CreateFixture(&screenBoxShape, density);
    
    // top
    screenBoxShape.SetAsEdge(upperLeftCorner, upperRightCorner);
    b2Fixture *top=containerBody->CreateFixture(&screenBoxShape, density);
    
    // left side
    screenBoxShape.SetAsEdge(upperLeftCorner, lowerLeftCorner);
    b2Fixture *leftSide=containerBody->CreateFixture(&screenBoxShape, density);
    
    // right side
    screenBoxShape.SetAsEdge(upperRightCorner, lowerRightCorner);
    b2Fixture *rightSide=containerBody->CreateFixture(&screenBoxShape, density);
    
    // set the collision flags: category and mask
//    b2Filter collisonFilter;
//    collisonFilter.groupIndex = 0;
//    collisonFilter.categoryBits = 0x0010; // category = Wall
//    collisonFilter.maskBits = 0x0001;     // mask = bullet
    
    

    
}



//处理每帧的物理变化
-(void) update:(ccTime)delta{
    
    // The number of iterations influence the accuracy of the physics simulation. With higher values the
	// body's velocity and position are more accurately tracked but at the cost of speed.
	// Usually for games only 1 position iteration is necessary to achieve good results.
	float timeStep = 0.03f;
    float capedDelta=fminf(delta, 0.08f);//安全上限
	int32 velocityIterations = 8;
	int32 positionIterations = 1;
	world->Step(capedDelta, velocityIterations, positionIterations);
	
	// for each body, get its assigned sprite and update the sprite's position
	for (b2Body* body = world->GetBodyList(); body != nil; body = body->GetNext())
	{
		BodyNode* sprite = (BodyNode*)body->GetUserData();
		if (sprite != NULL)
		{
			// update the sprite's position to where their physics bodies are
			sprite.position = [GameUtil toPixels:body->GetPosition()];
			float angle = body->GetAngle();
			sprite.rotation = CC_RADIANS_TO_DEGREES(angle) * -1;
		}
	}
    
}




//#ifdef DEBUG
//-(void) draw
//{
//	// Default GL states: GL_TEXTURE_2D, GL_VERTEX_ARRAY, GL_COLOR_ARRAY, GL_TEXTURE_COORD_ARRAY
//	// Needed states:  GL_VERTEX_ARRAY,
//	// Unneeded states: GL_TEXTURE_2D, GL_COLOR_ARRAY, GL_TEXTURE_COORD_ARRAY
//	glDisable(GL_TEXTURE_2D);
//	glDisableClientState(GL_COLOR_ARRAY);
//	glDisableClientState(GL_TEXTURE_COORD_ARRAY);
//	
//	world->DrawDebugData();
//	
//	// restore default GL states
//	glEnable(GL_TEXTURE_2D);
//	glEnableClientState(GL_COLOR_ARRAY);
//	glEnableClientState(GL_TEXTURE_COORD_ARRAY);
//}
//#endif


-(void)dealloc{
   
    
    delete listener;
    listener=NULL;
    
    delete debugDraw;
    debugDraw=NULL;
    
    delete world;
    world=NULL;

    [super dealloc];
    CCLOG(@"GameScene called dealloc");
    
}
@end
