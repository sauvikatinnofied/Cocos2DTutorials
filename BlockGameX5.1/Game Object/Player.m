//
//  Player.m
//  BlockGame1.0
//
//  Created by Sandip Saha on 08/11/13.
//  Copyright 2013 Sandip Saha. All rights reserved.
//

#import "Player.h"
#define kSpeedInPointsPerSecond 60
#define kJumpDistance 80
#define kJumpHeight   80
#define kTagForRunMoveAction 1
#define kTagForRunAnimationRepeatAction 2
#define kJumpDuration .75
@implementation Player

-(id)initAtPosition:(CGPoint)initialPosition
{
    if(self=[super initWithFile:@"PlayerIdle.png"])
    {
       
        
        
        winSize=[[CCDirector sharedDirector]winSize];
        
        
        
        
        //------------Adding the Sprite Sheet Files (.plist and .png) to the game-----------
        
        [[CCSpriteFrameCache sharedSpriteFrameCache]addSpriteFramesWithFile:@"PlayerRunLR.plist"];
        [[CCSpriteFrameCache sharedSpriteFrameCache]addSpriteFramesWithFile:@"PlayerRunRL.plist"];
        [[CCSpriteFrameCache sharedSpriteFrameCache]addSpriteFramesWithFile:@"PlayerJumpLR.plist"];
        [[CCSpriteFrameCache sharedSpriteFrameCache]addSpriteFramesWithFile:@"PlayerJumpRL.plist"];
        
        
        runLRBatchNode=[[CCSpriteBatchNode alloc]initWithFile:@"PlayerRunLR.png" capacity:10];//image containing 10 indivisual frames
        runRLBatchNode=[[CCSpriteBatchNode alloc]initWithFile:@"PlayerRunRL.png" capacity:10];//image containing 10 indivisual frames
        jumpLRBatchNode=[[CCSpriteBatchNode alloc]initWithFile:@"PlayerJumpLR.png" capacity:12];//image containing 12 indivisual frames
        jumpRLBatchNode=[[CCSpriteBatchNode alloc]initWithFile:@"PlayerJumpRL.png" capacity:12];//image containing 12 indivisual frames
        
        
        [self addChild:runLRBatchNode];
        [self addChild:runRLBatchNode];
        [self addChild:jumpLRBatchNode];
        [self addChild:jumpRLBatchNode];
        
        
        
        //----------Allocating memory for the sprite frame arrays------------
        runLRFrames=[[NSMutableArray alloc]initWithCapacity:10];//will contain 10  individual frames for L-R RUN animation
        runRLFrames=[[NSMutableArray alloc]initWithCapacity:10];//will contain 10  individual frames for R-L RUN animation
        jumpLRFrames=[[NSMutableArray alloc]initWithCapacity:12];//will contain 12  individual frames for L-R JUMP animation
        jumpRLFrames=[[NSMutableArray alloc]initWithCapacity:12];//will contain 12  individual frames for R-L JUMP animation
        
        
        
        
        
        //------------Insering the Individual Frames of different animations  to specified arrays--------
        
        for(int i=1;i<=12;i++)
        {
            
            //------Adding to the JUMP L-R array---------
            NSString *file=[NSString stringWithFormat:@"PlayerJumpLR%d.png",i];
            CCSpriteFrame *frame=[[CCSpriteFrameCache sharedSpriteFrameCache]spriteFrameByName:file];
            [jumpLRFrames addObject:frame];
            
            //------Adding to the JUMP R-L array---------
            file=[NSString stringWithFormat:@"PlayerJumpRL%d.png",i];//to remove MOON WALKING EFFECT
            frame=[[CCSpriteFrameCache sharedSpriteFrameCache]spriteFrameByName:file];
            [jumpRLFrames addObject:frame];
           
        
            if(i<=10)//because the RunAnimations only contains 10 frames each
            {
            
                //------Adding to the RUN L-R array---------
                file=[NSString stringWithFormat:@"PlayerRunLR%d.png",i];
                frame=[[CCSpriteFrameCache sharedSpriteFrameCache]spriteFrameByName:file];
                [runLRFrames addObject:frame];
            
            
            
                //------Adding to the RUN R-L array---------
                file=[NSString stringWithFormat:@"PlayerRunRL%d.png",11-i];//to remove MOON WALKING EFFECT
                frame=[[CCSpriteFrameCache sharedSpriteFrameCache]spriteFrameByName:file];
                [runRLFrames addObject:frame];
            }
            
            
        }
     
        
        self.position=initialPosition;
        
             
        
        
    }
    
    return  self;
}

-(void)jumpRight
{
    if(!isJumping && !isRunning)
    {
    
        isJumping=TRUE;
        jumpAction=[CCJumpTo actionWithDuration:kJumpDuration
                                                 position:CGPointMake(self.position.x+kJumpDistance, self.position.y)
                                                   height:kJumpHeight
                                                    jumps:1];
        CCCallFunc *makeIdle=[CCCallFunc actionWithTarget:self selector:@selector(makeIdleOnMoveCompletion)];
        jumpAndStop=[CCSequence actionOne:jumpAction two:makeIdle];


        CCAnimation *jumpAnimation=[CCAnimation animationWithSpriteFrames:jumpLRFrames delay:0.1f];
        CCAction *jumpAnimationOnPlayer=[CCAnimate actionWithAnimation:jumpAnimation];


        [self runAction:jumpAndStop];
        [self runAction:jumpAnimationOnPlayer];
    }
}
-(void)jumpLeft
{
    
    if(!isJumping && !isRunning)
    {
        isJumping=TRUE;
        jumpAction=[CCJumpTo actionWithDuration:kJumpDuration
                                   position:CGPointMake(self.position.x-kJumpDistance, self.position.y)
                                     height:kJumpHeight
                                      jumps:1];
    
        CCCallFunc *makeIdle=[CCCallFunc actionWithTarget:self selector:@selector(makeIdleOnMoveCompletion)];
        jumpAndStop=[CCSequence actionOne:jumpAction two:makeIdle];

        
        
        CCAnimation *jumpAnimation=[CCAnimation animationWithSpriteFrames:jumpRLFrames delay:0.1f];
    
        CCAction *jumpAnimationOnPlayer=[CCAnimate actionWithAnimation:jumpAnimation];
    
    
        [self runAction:jumpAndStop];
        [self runAction:jumpAnimationOnPlayer];
    }
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
    if(!isJumping && !isRunning)
    {
    
        isRunning=TRUE;
        
                 
        //calculating the duration of RUN
        float distanceToCover=(winSize.width-self.contentSize.width/2)-self.position.x;
        float runDuration=distanceToCover/kSpeedInPointsPerSecond;
        
        //------Creating the run animation with the array cointaing individual frames---
        CCAnimation *runAnimation=[CCAnimation animationWithSpriteFrames:runLRFrames delay:0.1f];
        
        
        runAnimationRepeat=[CCRepeatForever actionWithAction:[CCAnimate actionWithAnimation:runAnimation]];
        runMove=[CCMoveTo actionWithDuration:runDuration position:ccp(self.position.x+distanceToCover, self.position.y)];
        
        CCCallFunc *makeIdle=[CCCallFunc actionWithTarget:self selector:@selector(makeIdleOnMoveCompletion)];
        runAndStop=[CCSequence actionOne:runMove two:makeIdle];
        
        
        //-------Tagging the specific actions--------
        runAnimationRepeat.tag=kTagForRunAnimationRepeatAction;
        runAndStop.tag=kTagForRunMoveAction;
        
        [self runAction:runAnimationRepeat];
        [self runAction:runAndStop];
    }
    
    
}


-(void)runLeft
{
    //Run Action cointains TWO ACTIONS
    //  1.Run and  stop sequence(CCSequence)
    //
    //      1.1 MoveAction towards RIGHT---->(CCMoveTo)
    //      1.2 StopAction after touching the left  side of Window-->CCCallFunc
    //
    //  2.Showing the RUN animation----->(CCRepeatForEver)
    
    if(!isJumping && !isRunning)
    {
    
        isRunning=TRUE;
        
        
        
        //calculating the duration of RUN
        float distanceToCover=self.position.x-self.contentSize.width/2;
        float runDuration=distanceToCover/kSpeedInPointsPerSecond;
        
        //------Creating the run animation with the array cointaing individual frames---
        CCAnimation *runAnimation=[CCAnimation animationWithSpriteFrames:runRLFrames delay:0.1f];
        
        
        runAnimationRepeat=[CCRepeatForever actionWithAction:[CCAnimate actionWithAnimation:runAnimation]];
        runMove=[CCMoveTo actionWithDuration:runDuration position:ccp(self.position.x-distanceToCover, self.position.y)];
        
        CCCallFunc *makeIdle=[CCCallFunc actionWithTarget:self selector:@selector(makeIdleOnMoveCompletion)];
        runAndStop=[CCSequence actionOne:runMove two:makeIdle];
        
        
        //-------Tagging the specific actions--------
        runAnimationRepeat.tag=kTagForRunAnimationRepeatAction;
        runAndStop.tag=kTagForRunMoveAction;
        
        [self runAction:runAnimationRepeat];
        [self runAction:runAndStop];
    }
    
}


-(void)makeIdleAtPoint:(CGPoint)idlePoint
{
    /*[self stopActionByTag:kTagForRunMoveAction];
    [self stopActionByTag:kTagForRunAnimationRepeatAction];
     */
    isRunning=FALSE;
    isJumping=FALSE;
    [self stopAllActions];
    [self setDisplayFrame:[CCSpriteFrame frameWithTexture:[[CCSprite spriteWithFile:@"PlayerIdle.png"] texture] rect:CGRectMake(0,0,24, 29)]];
    //self.position=idlePoint;
   
    
}

-(void)makeIdleOnMoveCompletion
{
 
    isRunning=FALSE;
    isJumping=FALSE;
    [self stopAllActions];
    [self setDisplayFrame:[CCSpriteFrame frameWithTexture:[[CCSprite spriteWithFile:@"PlayerIdle.png"] texture] rect:CGRectMake(0,0,24,29)]];
    
    
}


-(void)dealloc
{
    
    [[CCSpriteFrameCache sharedSpriteFrameCache]removeUnusedSpriteFrames];
    [[CCSpriteFrameCache sharedSpriteFrameCache]removeSpriteFrameByName:@"PlayerIdle.png"];
    
    
    [super dealloc];
}

@end
