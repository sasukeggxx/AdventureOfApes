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
        
        gameOverType=notOverType;
        
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
        
       // [GameUtil enableBox2dDebugDrawing:debugDraw withWorld:world];//debug 物理世界渲染
        
        groundShape=[CreateGroundInWorld createGroundWithWorld:world];

        
        [self addChild:groundShape z:-2];
        
        [self initThePlayer];
        
        [self scheduleUpdate];
        
        [self schedule:@selector(countDownTime:) interval:1.0];// 倒计时
        
        [self schedule:@selector(lifeCheck:)];  //生命值检查
        
        [self schedule:@selector(gameOverCheck:)];  //gameOver检查        
        
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
    
    NSArray *touchs = [touches allObjects];
    if (touches.count>=2) { //同时两点不支持
        return;
    }
    
    //Get both touches
    UITouch *tOne = [touchs objectAtIndex:0];
    CGPoint firstTouchLocation =[GameUtil locationFromTouch:tOne];//记录该次触摸点gl位置
    
   
    if (firstTouchLocation.x>screenCenter.x) {//如果点击右边
        
        float duibian=abs(player.position.y-nearGuanjian.position.y) ;  //三角对边
        
        float actualDistance=ccpDistance(player.position, nearGuanjian.position); //三角斜边
        
        float hudu=asinf(duibian/actualDistance);  //绳子摆放位置需要的弧度
    
  
        b2BodyDef ropeBodyDef;
        
        ropeBodyDef.type = b2_dynamicBody;              
        CCSprite *sprite=[CCSprite spriteWithFile:@"fgtRope3.png"  rect:CGRectMake(0, 0, actualDistance, 4)];
        
        sprite.anchorPoint=ccp(0.0, 0.5);
        sprite.position=nearGuanjian.position;
        
        [self addChild:sprite z:-1 tag:ropeTag];
        ropeBodyDef.position=[GameUtil toMeters:nearGuanjian.position];
        ropeBodyDef.userData = sprite;
        ropeBody = world->CreateBody(&ropeBodyDef);
        //设置绳子偏移弧度
        if (player.position.x>=nearGuanjian.position.x&&player.position.y>=nearGuanjian.position.y) {//第一象限
            ropeBody->SetTransform([GameUtil toMeters:nearGuanjian.position],hudu);
        }else if(player.position.x<nearGuanjian.position.x&&player.position.y>nearGuanjian.position.y) {//第二象限
            ropeBody->SetTransform([GameUtil toMeters:nearGuanjian.position],b2_pi-hudu);
        }else if (player.position.x<=nearGuanjian.position.x&&player.position.y<=nearGuanjian.position.y){ //第三象限
            ropeBody->SetTransform([GameUtil toMeters:nearGuanjian.position],b2_pi+hudu);
        }else{  //第4象限
            ropeBody->SetTransform([GameUtil toMeters:nearGuanjian.position],2*b2_pi-hudu);

          }
        // Define another box shape for our dynamic body.
        b2PolygonShape dynamicBox;
   
        dynamicBox.SetAsBox(actualDistance/PTM_RATIO * 0.5f, 4.0/PTM_RATIO * 0.5f,[GameUtil toMeters:ccp(actualDistance*0.5, 0.0)],0.0);
        
        // Define the dynamic body fixture.
        b2FixtureDef fixtureDef;
        fixtureDef.shape = &dynamicBox;
        fixtureDef.density = 0.05f;
        fixtureDef.friction = 0.0f;
        fixtureDef.restitution = 0.0f;
        ropeBody->CreateFixture(&fixtureDef);
                
        playerJointDef.Initialize(player.body, ropeBody, player.body->GetWorldCenter());
        playerJoint=(b2RevoluteJoint *)world->CreateJoint(&playerJointDef);
            
        ropeJointDef.Initialize(nearGuanjian.body, ropeBody, nearGuanjian.body->GetWorldCenter());
        ropeJoint=(b2RevoluteJoint *)world->CreateJoint(&ropeJointDef);
        ropeJointDef.maxMotorTorque = 10.0f;
        ropeJointDef.enableMotor = true;
        if (player.position.x<=nearGuanjian.position.x) {//如果玩家在挂件的左边做逆时针旋转
            ropeJoint->SetMotorSpeed(player.speed);
            [player setIsCircle:YES];
            [player setFlipX:YES];//玩家转脸
            
        }else{//在挂件右边做顺时针旋转
            ropeJoint->SetMotorSpeed(-player.speed);
            [player setIsCircle:YES];
            [player setFlipX:NO];//玩家转脸
        }
     
       
    }else if (firstTouchLocation.x<screenCenter.x){//如果点击左边则转向
          ropeJoint->SetMotorSpeed(ropeJoint->GetMotorSpeed() * -1);          
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
        [player setIsCircle:NO];
        if (ropeJoint!=NULL) {
             world->DestroyJoint(ropeJoint);
             ropeBody->SetTransform(b2Vec2(0,0),0);
             world->DestroyBody(ropeBody);
            [self removeChildByTag:ropeTag cleanup:YES];
            
        }
    }

}




//处理每帧的物理变化
-(void) update:(ccTime)delta{
    
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
    
  
    [self addMotionStreakPoint:player.position];//添加拖尾
    
    
    //判断是否和香蕉碰撞,并计分
	float playerCollisionRadius =player.contentSize.width* 0.35f;
    //todo bug,木桩也能吃分
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
                            CCLabelBMFont *scoreLabel=(CCLabelBMFont *)[inputLayer getChildByTag:scoreTag];
                            scoreLabel.string=[NSString stringWithFormat:@"%d",score];
                            
                        }
                        
                    }

    }
    
    //如果水果吃完了,只剩3个木桩了.游戏win
    if (gameObjectLayer.children.count<=3) {
        CCParticleSystem* system=[CCParticleSystemQuad particleWithFile:@"treeParticle.plist"];
        system.positionType = kCCPositionTypeFree;
        CCSprite *guanJian=(CCSprite *)[gameObjectLayer getChildByTag:2];
        system.position=guanJian.position;
        [gameObjectLayer addChild:system];
        gameOverType=winType;//游戏结束类型为胜利
    }
   
    
    
}


//判断玩家生命值
-(void) lifeCheck:(ccTime)delta{
    //判断玩家生命值
    if (player.position.y<-20) {//玩家死了,生命数减1
        
        [player setSpriteStartPosition];
        
        if (player.life>0) {
            player.life=player.life-1;
            CCLabelBMFont *lifeLabel=(CCLabelBMFont *)[inputLayer getChildByTag:lifeTag];
            lifeLabel.string=[NSString stringWithFormat:@"%d",player.life];
            
        }
        if (player.life==0) {
            gameOverType=lifeOverType; //游戏结束类型为玩家生命数为0
            
        }
        
    }


}


//游戏结束类型检查
-(void)gameOverCheck:(ccTime)delta{
    switch (gameOverType) {
        case winType:
           
            //[self unscheduleAllSelectors];
            break;
        case lifeOverType:
            NSLog(@"生命值为0");
            
            //[self unscheduleAllSelectors];
            break;
        case timeUpType:
            NSLog(@"时间到");
            //[self unscheduleAllSelectors];
            break;
        default:
            break;
    }


}


//倒计时
-(void) countDownTime:(ccTime)delta{
            CCLabelBMFont *timeLabel=(CCLabelBMFont *)[inputLayer getChildByTag:timeTag];
            int countTime=[timeLabel.string intValue];
            if (countTime>0) {
                countTime=countTime--;
                timeLabel.string=[NSString stringWithFormat:@"%d",countTime];
            }else{
                gameOverType=timeUpType;//游戏结束类型为时间到期
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
    
    b2Vec2 lowerLeftCorner = b2Vec2(0, -2.0);//左下角
    b2Vec2 lowerRightCorner = b2Vec2(widthInMeters, -2.0);//右下角
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
   
    world->DestroyBody(ropeBody);
    world->DestroyBody(player.body);
    
    delete listener;
    listener=NULL;
    
    delete debugDraw;
    debugDraw=NULL;
    
    delete world;
    world=NULL;

    [player release];
    
    [groundShape release];
    
    [bgLayer release];
    
    [nearGuanjian release];
    
    [inputLayer release];
    
    [gameObjectLayer release];
    
    [super dealloc];
    CCLOG(@"GameScene called dealloc");
    
}
@end
