//
//  IntroLayer.m
//  BlockGameX5.1
//
//  Created by Sandip Saha on 12/11/13.
//  Copyright Sandip Saha 2013. All rights reserved.
//


// Import the interfaces
#import "IntroLayer.h"
#import "HelloWorldLayer.h"
#import "MenuLayer.h"
#import "WaterGrassIsometricLayer.h"
#import "ParticleAction.h"
#import "GridActions.h"
#import "LoadingScene.h"


#pragma mark - IntroLayer

// HelloWorldLayer implementation
@implementation IntroLayer

// Helper class method that creates a Scene with the HelloWorldLayer as the only child.
+(CCScene *) scene
{
	
    printf("\nIntrolayer scene() called");
    // 'scene' is an autorelease object.
	CCScene *scene = [CCScene node];
	
	// 'layer' is an autorelease object.
	IntroLayer *layer = [IntroLayer node];
	
	// add layer as a child to scene
	[scene addChild: layer];
	
	// return the scene
	return scene;
}

// 
-(id) init
{
	if( (self=[super init])) {

        printf("\nIntrolayer init() called");
		// ask director for the window size
		CGSize size = [[CCDirector sharedDirector] winSize];

		CCSprite *background;
		
		if( UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone ) {
			background = [CCSprite spriteWithFile:@"Default.png"];
			background.rotation = 90;
		} else {
			background = [CCSprite spriteWithFile:@"Default-Landscape~ipad.png"];
		}
		background.position = ccp(size.width/2, size.height/2);

		// add the label as a child to this Layer
		[self addChild: background];
	}
	
	return self;
}

-(void) onEnter
{
	[super onEnter];
    
    //LoadingScene *loadScene=[[LoadingScene alloc]initWithDestinationScene:[WaterGrassIsometricLayer scene] countDownMax:10];
	[[CCDirector sharedDirector] replaceScene:[CCTransitionFade transitionWithDuration:0.10
                                                                                         scene:[LoadingScene scene]]];
    
    
}
-(void)dealloc
{
    
    CCLOG(@"\n%@: %@", NSStringFromSelector(_cmd), self);
    [super dealloc];
}
@end
