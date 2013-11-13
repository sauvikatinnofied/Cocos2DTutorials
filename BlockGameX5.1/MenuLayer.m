//
//  MenuLayer.m
//  BlockGameX5.1
//
//  Created by Sandip Saha on 12/11/13.
//  Copyright 2013 Sandip Saha. All rights reserved.
//

#import "MenuLayer.h"
#import "SimpleAudioEngine.h"

@implementation MenuLayer
BOOL soundOn;

+(CCScene*)scene
{
    CCScene *scene=[CCScene node];
    CCLayer *layer=[MenuLayer node];
    
    [scene addChild:layer];
    
    return scene;
}

-(id)init
{
    
    
    
   if( self=[super init])
   {
      CGSize  winSize = [CCDirector sharedDirector].winSize;
       
      CCSprite *background = [CCSprite spriteWithFile:@"backgroundMonsters2.png"];
       
       //dirt.scale = 1.0;
       background.position = ccp(winSize.width/2, winSize.height/2);
       background.scaleX=winSize.width/background.contentSize.width;
       background.scaleY=winSize.width/background.contentSize.height;
       
       // and execute a Shaky3D action on sprite 2
       id shaky = [CCShaky3D actionWithDuration:4.0 size:ccg(14,10) range:4 shakeZ:NO];
       [background runAction: [CCRepeatForever actionWithAction: shaky]];
       
       /*id twirl=[CCTwirl actionWithDuration:4.0 size:ccg(14,10)];
       [background runAction: twirl];*/
       
       
       
       [self addChild:background z:-2];
       
       CCSprite *logo = [CCSprite spriteWithFile:@"MonsterSmashing.png"];
       logo.scale = 1.2;
       logo.position =  ccp(winSize.width /2 ,winSize.height-100 );
       
       // add the label as a child to this Layer
       [self addChild: logo];
       
       CCMenuItemImage *startGameButtonImage=[[CCMenuItemImage alloc]initWithNormalImage:@"playButton.png"
                                                                           selectedImage:@"playButtonSelected.png" disabledImage:nil
                                                                                  target:self
                                                                                selector:@selector(onStartGamePressed)];
       
       CCMenuItemImage *_soundOn=[[CCMenuItemImage alloc]initWithNormalImage:@"soundOn.png"
                                                               selectedImage:@"soundOnSelected.png"
                                                               disabledImage:nil target:nil selector:nil];
       
       CCMenuItemImage *_soundOff=[[CCMenuItemImage alloc]initWithNormalImage:@"soundOff.png"
                                                               selectedImage:@"soundOffSelected.png"
                                                               disabledImage:nil target:nil selector:nil];

       
       
       
       
       CCMenuItemToggle *toggleItem = [CCMenuItemToggle itemWithTarget:self
                                                              selector:@selector(soundButtonTapped:)
                                                                 items:_soundOn, _soundOff, nil];
       
       //Create a menu from the button and center it on the screen
       CCMenu *menu = [CCMenu menuWithItems:startGameButtonImage, toggleItem, nil];
       menu.position = ccp(winSize.width * 0.5f, winSize.height * 0.4f);
       [menu alignItemsVerticallyWithPadding:15];
       
       //Add the menu as a child to this layer
       [self addChild:menu];
       
       
   }
    
    return self;
}

-(void)onStartGamePressed
{
    printf("\nUser wants to start the Game");
    if(soundOn)
    {
       [[SimpleAudioEngine sharedEngine] playBackgroundMusic:@"Music.mp3" loop:YES];
    }
    else
    {
        printf("\nSound waas  not selected");
    }
    
}
-(void)soundButtonTapped:(CCMenuItemToggle*)sender
{
    //printf("\nSelected index=%d",sender.selectedIndex);
    
    
     CGSize  winSize = [CCDirector sharedDirector].winSize;
    
    [[SimpleAudioEngine sharedEngine] playEffect:@"ExitReached.mp3"];
    
    
    if(sender.selectedIndex==0)
    {
        soundOn=TRUE;
        
        CCLabelTTF *soundOnSelected=[[CCLabelTTF alloc]initWithString:@"Music On" fontName:@"AvenirNext-HeavyItalic" fontSize:80];
        soundOnSelected.position=ccp(winSize.width/2,winSize.height/2);
        [self addChild:soundOnSelected];
        
        CCFadeOut *fadeOut=[CCFadeOut actionWithDuration:3.0f];
        
        [soundOnSelected runAction:fadeOut];
    }
    else
    {
        soundOn=FALSE;
        CCLabelTTF *soundOffSelected=[[CCLabelTTF alloc]initWithString:@"Music Off" fontName:@"AvenirNext-HeavyItalic" fontSize:80];
        soundOffSelected.position=ccp(winSize.width/2,winSize.height/2);
        [self addChild:soundOffSelected];
        
        CCFadeOut *fadeOut=[CCFadeOut actionWithDuration:3.0f];
        
        [soundOffSelected runAction:fadeOut];
        [[SimpleAudioEngine sharedEngine]pauseBackgroundMusic];
    }
    
    
    
    
}
@end
