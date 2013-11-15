//
//  LoadingScreen.m
//  BlockGameX5.1
//
//  Created by Sandip Saha on 14/11/13.
//  Copyright 2013 Sandip Saha. All rights reserved.
//

#import "LoadingScene.h"
#import "HelloWorldLayer.h"
#import "GridActions.h"
#import "ParticleAction.h"

@implementation LoadingScene

+(CCScene*)scene
{
    CCScene *scene=[CCScene node];
    CCLayer *layer=[LoadingScene node];
    
    [scene addChild:layer];
    
    return scene;
    
}


-(id)init
{
    if(self=[super init])
    {
        [[CCSpriteFrameCache sharedSpriteFrameCache] addSpriteFramesWithFile:@"Number-4-icon.png"];
        
        countDownMax=10;
        [self scheduleOnce:@selector(transitionToDestinationScene:) delay:(countDownMax+1)*1.0];
        [self schedule:@selector(updateCountdown:) interval:1.0f repeat:countDownMax delay:1.0f];
    }
    
    return self;
}

-(void)transitionToDestinationScene:(ccTime)dt
{
    printf("\nDestination scene will be loaded now");
    
    [[CCDirector sharedDirector] replaceScene:[CCTransitionPageTurn transitionWithDuration:0.50f
                                                                                 scene:[ParticleAction scene]]];
}

-(void)updateCountdown:(ccTime)dt
{
    
    CGSize winSize=[CCDirector sharedDirector].winSize;
    numberSprite=[CCSprite spriteWithFile:@"Number-4-icon.png"];
    //numberSprite.scale=1.0;
    
    [self addChild:numberSprite];
    
    numberSprite.position=ccp(winSize.width/2,0);
    
    CCMoveBy *moveToMiddle=[CCMoveBy actionWithDuration:0.25f position:ccp(0,winSize.height/2)];
    CCScaleBy *makeLarge=[CCScaleBy actionWithDuration:0.25f scale:2.0];
    
    CCSpawn *lowerMovement=[CCSpawn actionOne:moveToMiddle two:makeLarge];
    
    CCDelayTime *waitAtMiddle=[CCDelayTime actionWithDuration:0.4f];
    
    
    CCMoveBy *moveToUp=[CCMoveBy actionWithDuration:0.25f position:ccp(0,winSize.height)];
    CCScaleBy *makeSmall=[CCScaleBy actionWithDuration:0.25f scale:0.50];
    
    CCSpawn *upperMovement=[CCSpawn actionOne:moveToUp two:makeSmall];
    
    
    CCCallFunc *removeNumberSprite=[CCCallFunc actionWithTarget:self selector:@selector(removeNumberSprite)];
    
    
    CCSequence *countDownSequence=[CCSequence actions:lowerMovement,waitAtMiddle,upperMovement,removeNumberSprite ,nil];
    
    [numberSprite runAction:countDownSequence];
    
    
    
}

-(void)removeNumberSprite
{
    [self removeChild:numberSprite cleanup:YES];
}

@end
