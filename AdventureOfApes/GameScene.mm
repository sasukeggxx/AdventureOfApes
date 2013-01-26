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
#import "CCRoundBy.h"
#import "InputLayer.h"
#import "GameObjectTag.h"
#import "Banana.h"

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
        [[GB2ShapeCache sharedShapeCache] addShapesWithFile:@"ground-shape.plist"];
        

        bgLayer=(CCLayer *)[CCBReader nodeGraphFromFile:@"bgLayer.ccb"];  //背景
        
        inputLayer=(CCLayer *)[CCBReader nodeGraphFromFile:@"inputLayer.ccb"];  //分值
        
        gameObjectLayer=(CCLayer *)[CCBReader nodeGraphFromFile:@"GameObjectLayer.ccb"]; 
        
        [self addChild:inputLayer z:0 tag:inputLayerTag];
        
        [self addChild:bgLayer z:-3];
        
        [self addChild:gameObjectLayer z:-1];
        
        [self initTheWorld];//初始化世界
        
        [GameUtil enableBox2dDebugDrawing:debugDraw withWorld:world];//debug 物理世界渲染
        
        groundShape=[CreateGroundInWorld createGroundWithWorld:world];
        
        [self addChild:groundShape z:-2];
        
        [self initThePlayer];
        
        [self scheduleUpdate];
        
        [self schedule:@selector(countDownTime:) interval:1.0];// 倒计时
        
    }

    return self;
}




-(void) addMotionStreakPoint:(CGPoint)point
{
	CCMotionStreak* streak = [self getMotionStreak];
	[streak.ribbon addPointAt:point width:20];
}

-(CCMotionStreak*) getMotionStreak
{
	CCNode* node = [self getChildByTag:ParallaxSceneTagRibbon];
	NSAssert([node isKindOfClass:[CCMotionStreak class]], @"node is not a CCMotionStreak");
	return (CCMotionStreak*)node;
}




-(void)initThePlayer{
    player=[PlayerSpriteA addToWorld:world];
    [player initTheTailWithLayer:self];
    [self addChild:player];

}


//处理玩家的左右点击 
-(void)ccTouchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{

    CGPoint screenCenter=[GameUtil screenCenter];
    BodyNode *guanjian0=(BodyNode *)[groundShape getChildByTag:0];
    BodyNode *guanjian1=(BodyNode *)[groundShape getChildByTag:1];
    BodyNode *guanjian2=(BodyNode *)[groundShape getChildByTag:2];
    NSMutableArray *array=[NSMutableArray arrayWithObjects:guanjian0,guanjian1,guanjian2,nil];
    nearGuanjian=[GameUtil playerNearToBody:array withPlayer:player];
    if (nearGuanjian==nil) {//如果找不到最近的挂件
        return;
    }
    
    NSArray *twoTouch = [touches allObjects];
    
    //Get both touches
    UITouch *tOne = [twoTouch objectAtIndex:0];
    CGPoint firstTouchLocation =[GameUtil locationFromTouch:tOne];//记录该次触摸点gl位置
    
    BodyNode *midGuanJian=nearGuanjian;
    if (firstTouchLocation.x>screenCenter.x) {//如果点击右边
    
        float actualDistance= ccpDistance(player.position, nearGuanjian.position);
        CCSprite *midRope=[CCSprite spriteWithFile:@"fgtRope.png"];
        int ropeCount=actualDistance/(midRope.contentSize.height);
        b2RevoluteJointDef ropeJointDef;
//        for (int i=0; i<ropeCount; i++) {
//            RopeSprite *ropeSp=[RopeSprite addToWorld:world];
//            [self addChild:ropeSp];
//            
//            ropeJointDef.Initialize(midGuanJian.body,ropeSp.body,midGuanJian.body->GetWorldCenter());
//            world->CreateJoint(&ropeJointDef);
//            midGuanJian=ropeSp;
//            
//        }
//           playerJointDef.Initialize(nearGuanjian.body,player.body,nearGuanjian.body->GetWorldCenter());
//           playerJointDef.maxMotorTorque = 10.0f;
//           playerJointDef.enableMotor = true;
//           playerJoint=(b2RevoluteJoint *)nearGuanjian.body->GetWorld()->CreateJoint(&playerJointDef);
//        
//        if (player.position.x<=nearGuanjian.position.x) {//如果玩家在挂件的左边做逆时针旋转
//              playerJoint->SetMotorSpeed(player.speed);
//
//        }else{//在挂件右边做顺时针旋转
//              playerJoint->SetMotorSpeed(-player.speed);            
//        }
         
        
        
        
        
    }else if (firstTouchLocation.x<screenCenter.x){//如果点击左边则转向
    
          //ropeJoint->SetMotorSpeed(ropeJoint->GetMotorSpeed() * -1);
          playerJoint->SetMotorSpeed(playerJoint->GetMotorSpeed() * -1);
    
    }
    
    
    
 

}
   

    


-(void)ccTouchesEnded:(NSSet *)touches withEvent:(UIEvent *)event{

    UITouch *touch = [touches anyObject];
    CGPoint touchLocation =[GameUtil locationFromTouch:touch];//记录该次触摸位置
    CGPoint screenCenter=[GameUtil screenCenter];
    if (nearGuanjian==nil) {
        return;
    }
    
    if (touchLocation.x>screenCenter.x) {//如果松开的是右边,玩家离开绳子做抛物线
        
        if (playerJoint!=NULL) {
             world->DestroyJoint(playerJoint);
        }
             
//        [self removeChild:rope cleanup:NO];
//        
//        rope=nil;
        
    }
   


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
           
            if (![sprite isKindOfClass:[PlayerSpriteA class]]) {  //如果是玩家则不需要更新旋转
                sprite.rotation = CC_RADIANS_TO_DEGREES(angle) * -1;
            }
			
		}
	}
    
  
    [self addMotionStreakPoint:player.position];
    //判断是否和香蕉碰撞,并计分
	// If you adjust the factors make sure you also change them in the -(void) draw method.
	float playerCollisionRadius =player.contentSize.width* 0.35f;    

//    for (int i=17; i<30; i++) { //香蕉tag区间为
//         Fruit *fruit=(Fruit *)[bgLayer getChildByTag:i];
//
//        if (fruit!=nil) {
//            float banaCollisionRadius = fruit.contentSize.width * 0.4f;
//            float maxCollisionDistance=playerCollisionRadius+banaCollisionRadius;
//            float actualDistance= ccpDistance(player.position, fruit.position);
//            if (actualDistance<maxCollisionDistance) {
//               
//                [bgLayer removeChild:fruit cleanup:YES];
//                score=score+10;
//                CCLabelBMFont *scoreLabel=(CCLabelBMFont *)[inputLayer getChildByTag:4];
//                scoreLabel.string=[NSString stringWithFormat:@"%d",score];
//                
//            }
//            
//        }
//    }
    CCNode* child;
    CCARRAY_FOREACH(gameObjectLayer.children,child){
        Fruit *fruit=(Fruit *)child;
        
                  if (fruit!=nil) {
                      float banaCollisionRadius = fruit.contentSize.width * 0.35f;
                      float maxCollisionDistance=playerCollisionRadius+banaCollisionRadius;
                        float actualDistance= ccpDistance(player.position, fruit.position);
                        if (actualDistance<maxCollisionDistance) {
            
                            [gameObjectLayer removeChild:fruit cleanup:YES];
                             score=score+10;
                            CCLabelBMFont *scoreLabel=(CCLabelBMFont *)[inputLayer getChildByTag:4];
                            scoreLabel.string=[NSString stringWithFormat:@"%d",score];
                            
                        }
                        
                    }

    
    }
    
    
    
    
}

//倒计时
-(void) countDownTime:(ccTime)delta{
            CCLabelBMFont *timeLabel=(CCLabelBMFont *)[inputLayer getChildByTag:3];
            int countTime=[timeLabel.string intValue];
            if (countTime>0) {
                countTime=countTime--;
                timeLabel.string=[NSString stringWithFormat:@"%d",countTime];
            }else{
                [self unschedule:_cmd];
            
            }
            

}

#ifdef DEBUG
-(void) draw
{
	// Default GL states: GL_TEXTURE_2D, GL_VERTEX_ARRAY, GL_COLOR_ARRAY, GL_TEXTURE_COORD_ARRAY
	// Needed states:  GL_VERTEX_ARRAY,
	// Unneeded states: GL_TEXTURE_2D, GL_COLOR_ARRAY, GL_TEXTURE_COORD_ARRAY
	glDisable(GL_TEXTURE_2D);
	glDisableClientState(GL_COLOR_ARRAY);
	glDisableClientState(GL_TEXTURE_COORD_ARRAY);
	
	world->DrawDebugData();
	
	// restore default GL states
	glEnable(GL_TEXTURE_2D);
	glEnableClientState(GL_COLOR_ARRAY);
	glEnableClientState(GL_TEXTURE_COORD_ARRAY);
}
#endif


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
    
    b2Vec2 lowerLeftCorner = b2Vec2(0, -1.0);//左下角
    b2Vec2 lowerRightCorner = b2Vec2(widthInMeters, -1.0);//右下角
    b2Vec2 upperLeftCorner = b2Vec2(0, heightInMeters+3.0);//左上角
    b2Vec2 upperRightCorner = b2Vec2(widthInMeters, heightInMeters+3.0); //右上角
    
    
    b2PolygonShape screenBoxShape;
    int density = 0;//密度
    
    // bottom
    screenBoxShape.SetAsEdge(lowerLeftCorner, lowerRightCorner);
    containerBody->CreateFixture(&screenBoxShape, density);
    
    // top
    screenBoxShape.SetAsEdge(upperLeftCorner, upperRightCorner);
    containerBody->CreateFixture(&screenBoxShape, density);
    
    // left side
    screenBoxShape.SetAsEdge(upperLeftCorner, lowerLeftCorner);
    containerBody->CreateFixture(&screenBoxShape, density);
    
    // right side
    screenBoxShape.SetAsEdge(upperRightCorner, lowerRightCorner);
    containerBody->CreateFixture(&screenBoxShape, density);
    
   
    
}

-(void)dealloc{
   
    
    delete listener;
    listener=NULL;
    
    delete debugDraw;
    debugDraw=NULL;
    
    delete world;
    world=NULL;

    [player release];
    [rope release];
    [groundShape release];
    [bgLayer release];
    
   // delete  ropeJoint;
    
    delete playerJoint;
    
    [nearGuanjian release];
    
    [inputLayer release];
    
    [super dealloc];
    CCLOG(@"GameScene called dealloc");
    
}
@end
