//
//  HelloWorldLayer.m
//  BlockGame1.0
//
//  Created by Sandip Saha on 07/11/13.
//  Copyright Sandip Saha 2013. All rights reserved.
//


// Import the interfaces
#import "HelloWorldLayer.h"
#import "Player.h"
#import "HelloWorldBackGround.h"

// Needed to obtain the Navigation Controller
#import "AppDelegate.h"

#pragma mark - HelloWorldLayer

// HelloWorldLayer implementation
@implementation HelloWorldLayer


NSMutableArray *jumpFrames;
Player *player;
BOOL gamePaused;


// Helper class method that creates a Scene with the HelloWorldLayer as the only child.
+(CCScene *) scene
{
	
    // 'scene' is an autorelease object.
	CCScene *scene = [CCScene node];
    
    
    //'adding the background'
    HelloWorldBackGround *backGround=[HelloWorldBackGround node];
    [scene addChild:backGround];
	
    
	// 'layer' is an autorelease object.
	HelloWorldLayer *layer = [HelloWorldLayer node];
    
    
    
    
	// add layer as a child to scene
	[scene addChild: layer];
	
	// return the scene
	return scene;
}



// on "init" you need to initialize your instance
-(id) init
{
	// always call "super" init
	// Apple recommends to re-assign "self" with the "super's" return value
	if( (self=[super init]))  {
        
        
        
        CGSize winSize=[[CCDirector sharedDirector] winSize];
        
        [[CCDirector sharedDirector].touchDispatcher addTargetedDelegate:self
                                                                priority:INT_MIN+1
                                                         swallowsTouches:YES];
        
        
        CCLayer *backGround=[HelloWorldBackGround node];
        [self addChild:backGround];
        
        
        player=[[Player alloc]initAtPosition:ccp(winSize.width/2, winSize.height/2)];
        
        [self addChild:player];
        
        [self scheduleOnce:@selector(pauseGame:) delay:10];
       
        CCSprite *followingSprite=[CCSprite spriteWithFile:@"YellowGem.png"];
        followingSprite.position=ccp(player.position.x,player.position.y+30);
        [self addChild:followingSprite];
        
        
        
        //CCFollow *followaction=[CCFollow actionWithTarget:player worldBoundary:CGRectMake(0, 0, winSize.width, winSize.height)];
        //[followingSprite runAction:followaction];
       
        
    
       
        
        
		
	}
    
    
    
	return self;
}


-(BOOL)ccTouchBegan:(UITouch *)touch withEvent:(UIEvent *)event
{
   
    
    if(gamePaused)
    {
        [[CCDirector sharedDirector] resume];
    }
    else
    {
        
    }
    
    
    
    return TRUE;
    
}

-(void)ccTouchEnded:(UITouch *)touch withEvent:(UIEvent *)event
{
    
   
    CGPoint touchPoint=[[CCDirector sharedDirector] convertTouchToGL:touch];
    
    if(touchPoint.y<player.position.y)
    {
        printf("\nPlayer Should run");

        if(touchPoint.x>player.position.x )
            [player runRight];

        else if(touchPoint.x<player.position.x )
            [player runLeft];
    }
    
    else if(touchPoint.y>player.position.y)
    {
        
        printf("\nPlayer Should Jump");

        if(touchPoint.x>player.position.x)
            [player jumpRight];
        
        else if(touchPoint.x<player.position.x )
            [player jumpLeft];
     
    }
    
     
    
}

//this method will be called every time the accelerometer acceleartes

-(void)accelerometer:(UIAccelerometer *)accelerometer didAccelerate:(UIAcceleration *)acceleration
{
    
}

//Scheduler to Pause the game
-(void)pauseGame:(ccTime)dt
{
    
    [[CCDirector sharedDirector] pause];
    gamePaused=TRUE;
}

















// on "dealloc" you need to release all your retained objects
- (void) dealloc
{
	// in case you have something to dealloc, do it in this method
	// in this particular example nothing needs to be released.
	// cocos2d will automatically release all the children (Label)
	
	// don't forget to call "super dealloc"
    
    
	[super dealloc];
}


@end
