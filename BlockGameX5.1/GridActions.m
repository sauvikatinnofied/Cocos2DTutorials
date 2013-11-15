//
//  GridActions.m
//  BlockGameX5.1
//
//  Created by Sandip Saha on 14/11/13.
//  Copyright 2013 Sandip Saha. All rights reserved.
//

#import "GridActions.h"


@implementation GridActions
+(CCScene*)scene
{
    CCScene *scene=[CCScene node];
    CCLayer *layer=[GridActions node];
    
    [scene addChild:layer];
    
    
    return scene;
}


-(id)init
{
    
    winSize=[[CCDirector sharedDirector] winSize];
    if(self=[super init])
    {
        [[CCDirector sharedDirector] setDepthTest:YES];
        
        backGround=[CCSprite spriteWithFile:@"Layer1_2.png"];
        backGround.scaleX=winSize.width/backGround.contentSize.width;
        backGround.scaleY=winSize.height/backGround.contentSize.height;
        backGround.position=ccp(winSize.width/2,winSize.height/2);
        
        [self addChild:backGround];
        
        
        //----------------GRID ACTIONS----------------------
        
        CCLiquid *liqidAction=[CCLiquid actionWithDuration:10.0f size:ccg(30,30) waves:20 amplitude:1.25f];//working perfectly
       /* CCRipple3D *rippleAction=[CCRipple3D actionWithDuration:10.0f
                                                         size:ccg(30,30)
                                                     position:backGround.position
                                                         radius:5.0f waves:2 amplitude:5.0f];//not working*/
        
        id action;
        //action=[CCTwirl actionWithDuration:3.0f size:ccg(30,30) position:backGround.position twirls:3 amplitude:1.0f];//working fine
        
       // action=[CCLens3D actionWithDuration:5.0f size:ccg(30,30) position:backGround.position radius:20.0f];//not working
        //action=[CCPageTurn3D actionWithDuration:10.0 size:ccg(20,20)];//working perfectly
        //action=[CCFlipX3D actionWithDuration:5.0 size:ccg(1,1)];//fliping sprite horizontally
        
        //action=[CCFlipY3D actionWithDuration:5.0 size:ccg(1,1)];//fliping sprite horizontally(working perfectly)
        
        //action =[CCWavesTiles3D actionWithDuration:5.0f size:ccg(1,1) waves:5 amplitude:10];//(not working )
        

        
        
       
        
        //---------------GRID ACTION COMPLETES-------------------------------
        
        
        //***************TILES ACTIONS**********************
        
       // action=[CCSplitRows actionWithDuration:5.0 rows:16];//working perfectly
        //action=[CCSplitCols actionWithDuration:5.0 cols:10];//working perfectly
        
        
         [backGround runAction:liqidAction];
        
        //***************TILES ACTION ENDS******************
        
        
    }
    
    
    return self;
}
@end
