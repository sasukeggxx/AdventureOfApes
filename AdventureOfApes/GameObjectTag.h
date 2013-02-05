//
//  GameObjectTag.h
//  AdventureOfApes
//
//  Created by Alex Zen on 13-1-10.
//
//

#ifndef AdventureOfApes_GameObjectTag_h
#define AdventureOfApes_GameObjectTag_h



#endif



typedef enum {
    inputLayerTag,
    ParallaxSceneTagRibbon,
    ropeTag,
    pauseLayerTag,
    winLayerTag,
    faiureLayerTag,
}GameSceneObjectTag;

typedef enum {
    lifeTag,
    seriesFruitTag,
    timeTag,
    scoreTag,
    
}InputLayerObjectTag;


//typedef enum {
//
//    
//
//}pauseLayerObjectTag;



typedef enum {
    BananaType,
    CarambolaType,
    GrapeType,
    TomatoType,
    
}FruitType;


typedef enum {
   winType,
   lifeOverType,
   timeUpType,
   notOverType,
    
}GameOverType;