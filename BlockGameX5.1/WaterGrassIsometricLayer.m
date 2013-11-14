//
//  WaterGrassIsometricLayer.m
//  BlockGameX5.1
//
//  Created by Sandip Saha on 13/11/13.
//  Copyright 2013 Sandip Saha. All rights reserved.
//

#import "WaterGrassIsometricLayer.h"
#import "PlayerOnTiledMap.h"

@implementation WaterGrassIsometricLayer


+(CCScene*)scene
{
    
    CCScene *scene=[CCScene node];
    CCLayer *layer=[WaterGrassIsometricLayer node];
    [scene addChild:layer];
    
    return scene;
    
}
CGSize winSize;
PlayerOnTiledMap *player;

-(id)init
{
    if(self=[super init])
    {
        
        winSize =[[CCDirector sharedDirector] winSize];
        [self registerWithTouchDispatcher];
        
        tileMap=[CCTMXTiledMap tiledMapWithTMXFile:@"desert.tmx"];
        //tileMap.position=ccp(winSize.width/2,winSize.height/2);
        [self addChild:tileMap];
        
        player=[[PlayerOnTiledMap alloc]initAtPosition:ccp(0,winSize.height/2)];
        [self addChild:player];
        
    }
    
    return self;
}


-(void)registerWithTouchDispatcher
{
    [[CCDirector sharedDirector].touchDispatcher addTargetedDelegate:self priority:INT_MIN+1 swallowsTouches:YES];
}

-(BOOL)ccTouchBegan:(UITouch*)touche withEvent:(UIEvent *)event
{
    
    
    return YES;
    
}
-(void)ccTouchEnded:(UITouch *)touch withEvent:(UIEvent *)event
{
    
    [player runRight];
    CGPoint touchPoint=[[CCDirector sharedDirector] convertTouchToGL:touch];
    CCTMXLayer *mapLayer=[tileMap layerNamed:@"Ground"];
    
    CCNode *node=[CCNode node];
    node.position=touchPoint;
    
    [self schedule:@selector(playerCoordinateOnLitedMap:) interval:0.5];
    
    [self moveLayer:mapLayer forNode:node];
    
    
}

-(void)moveLayer:(CCTMXLayer*)layer forNode:(CCNode*)node
{
    
    printf("\nTile map position=(%f,%f)",tileMap.position.x,tileMap.position.y);
    
    printf("\nTouch received at-->(%f,%f)",node.position.x,node.position.y);
    
    /*/Layer's (x,y) must not be too SMALL
    
    CGSize winSize=[[CCDirector sharedDirector] winSize];
    int x=MAX(node.position.x,winSize.width/2);
    int y=MAX(node.position.y,winSize.height/2);
    
    //Layer's (x,y) must not be too BIG
    x=MIN(x,(tileMap.mapSize.width*tileMap.tileSize.width-winSize.width/2));
    y=MIN(x,(tileMap.mapSize.height*tileMap.tileSize.height-winSize.height/2));
    
    CGPoint actualPosition=ccp(x,y);
    CGPoint center=ccp(winSize.width/2,winSize.height/2);
    
    CGPoint viewPoint=ccpSub(center,actualPosition);
    
    //Repositioning the new layer
    //layer.position=viewPoint;*/
    
    //repositioning with animation
    CCMoveTo *repositionAction=[CCMoveTo actionWithDuration:10.0f position:ccp(-tileMap.mapSize.width*tileMap.tileSize.width+winSize.width*2.15,0)];
    [layer runAction:repositionAction];
}

-(void)playerCoordinateOnLitedMap:(ccTime)dt
{
    NSLog(@"%@",NSStringFromCGPoint([self tileCoordinateForNode:player]));
}

-(CGPoint)tileCoordinateForNode:(CCNode*)node
{
    int x=node.position.x/tileMap.tileSize.width;
    
    int heightOfTileMapInCocos2d=tileMap.mapSize.height*tileMap.tileSize.height;
    int y= (heightOfTileMapInCocos2d-node.position.y)/tileMap.tileSize.height;
    
    
    return ccp(x,y);
    
}
@end
