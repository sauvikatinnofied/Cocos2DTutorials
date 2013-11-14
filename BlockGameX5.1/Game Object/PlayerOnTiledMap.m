//
//  PlayerOnTiledMap.m
//  BlockGameX5.1
//
//  Created by Sandip Saha on 13/11/13.
//  Copyright 2013 Sandip Saha. All rights reserved.
//

#import "PlayerOnTiledMap.h"
#define kSpeedInPointsPerSecond 80

@implementation PlayerOnTiledMap
-(id)initAtPosition:(CGPoint)initialPosition
{
    if(self=[super initWithFile:@"PlayerIdle.png"])
    {
        
        
        
        winSize=[[CCDirector sharedDirector]winSize];
        
        
        
        
        //------------Adding the Sprite Sheet Files (.plist and .png) to the game-----------
        
        [[CCSpriteFrameCache sharedSpriteFrameCache]addSpriteFramesWithFile:@"PlayerRunLR.plist"];
        
        
        runLRBatchNode=[[CCSpriteBatchNode alloc]initWithFile:@"PlayerRunLR.png" capacity:10];//image containing 10 indivisual frames
        
        [self addChild:runLRBatchNode];
        
        
        //----------Allocating memory for the sprite frame arrays------------
        runLRFrames=[[NSMutableArray alloc]initWithCapacity:10];//will contain 10  individual frames for L-R RUN animation
        
        
        
        
        
        //------------Insering the Individual Frames of different animations  to specified arrays--------
        
        for(int i=1;i<=12;i++)
        {
            
           
            
            
            if(i<=10)//because the RunAnimations only contains 10 frames each
            {
                
                //------Adding to the RUN L-R array---------
                NSString *file=[NSString stringWithFormat:@"PlayerRunLR%d.png",i];
                CCSpriteFrame *frame=[[CCSpriteFrameCache sharedSpriteFrameCache]spriteFrameByName:file];
                [runLRFrames addObject:frame];
                
                
                
               
            }
            
            
        }
        
        
        self.position=initialPosition;
        
        
        
        
    }
    
    return  self;
}

-(void)runRight
{
    
    //----------Run Action cointains TWO ACTIONS------------
    //  1.Run and  stop sequence(CCSequence)
    //
    //      1.1 MoveAction towards Left---->(CCMoveTo)
    //      1.2 StopAction after touching the Right  side of Window-->CCCallFunc
    //
    //  2.Showing the RUN animation----->(CCRepeatForEver)
    if(!isRunning)
    {
        
        isRunning=TRUE;
        
        
        //calculating the duration of RUN
       // float distanceToCover=(winSize.width-self.contentSize.width/2)-self.position.x;
       
        
        //------Creating the run animation with the array cointaing individual frames---
        CCAnimation *runAnimation=[CCAnimation animationWithSpriteFrames:runLRFrames delay:0.1f];
        
        
        runAnimationRepeat=[CCRepeatForever actionWithAction:[CCAnimate actionWithAnimation:runAnimation]];
        CCMoveTo *moveAction=[CCMoveTo actionWithDuration:10.0f position:ccp(winSize.width, winSize.height/2)];
        
        
        
        [self runAction:runAnimationRepeat];
        [self runAction:moveAction];
        
    }
    
    
}

@end
