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

// Needed to obtain the Navigation Controller
#import "AppDelegate.h"

#pragma mark - HelloWorldLayer

// HelloWorldLayer implementation
@implementation HelloWorldLayer

//CCSprite  *player;
NSMutableArray *jumpFrames;
Player *player;



// Helper class method that creates a Scene with the HelloWorldLayer as the only child.
+(CCScene *) scene
{
	// 'scene' is an autorelease object.
	CCScene *scene = [CCScene node];
	
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
        for(int i=0;i<3;i++)
        {
            NSString *file=[NSString stringWithFormat:@"Layer%d_2.png",i];
            CCSprite *gameBackGround=[CCSprite spriteWithFile:file];
            gameBackGround.position=CGPointMake(winSize.width/2, winSize.height/2);
            gameBackGround.scaleX=winSize.width/gameBackGround.contentSize.width;
            gameBackGround.scaleY=winSize.height/gameBackGround.contentSize.height;

            [self addChild:gameBackGround];
        }
        
        player=[[Player alloc]initAtPosition:ccp(winSize.width/2, winSize.height/2)];
        
        [self addChild:player];
        
        
        
		
	}
    
    
    
	return self;
}


-(BOOL)ccTouchBegan:(UITouch *)touch withEvent:(UIEvent *)event
{
   
    
  
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
