//
//  HelloWorldBackGround.m
//  BlockGameX5.1
//
//  Created by Sandip Saha on 12/11/13.
//  Copyright 2013 Sandip Saha. All rights reserved.
//

#import "HelloWorldBackGround.h"


@implementation HelloWorldBackGround


+(CCScene*)scene
{
    CCScene *scene=[CCScene node];
    HelloWorldBackGround *layer=[HelloWorldBackGround node];
    [scene addChild:layer];
    
    return scene;
    
}

-(id)init
{
    
    
    if(self=[super init])
    {
        CGSize winSize=[CCDirector sharedDirector].winSize;
        for(int i=0;i<3;i++)
        {
            NSString *file=[NSString stringWithFormat:@"Layer%d_2.png",i];
            CCSprite *gameBackGround=[CCSprite spriteWithFile:file];
            gameBackGround.position=CGPointMake(winSize.width/2, winSize.height/2);
            gameBackGround.scaleX=winSize.width/gameBackGround.contentSize.width;
            gameBackGround.scaleY=winSize.height/gameBackGround.contentSize.height;
            
            [self addChild:gameBackGround];
        }

        
    }
    
    return self;
}
@end
