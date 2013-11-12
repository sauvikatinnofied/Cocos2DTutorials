//
//  Player.h
//  BlockGame1.0
//
//  Created by Sandip Saha on 08/11/13.
//  Copyright 2013 Sandip Saha. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"

@interface Player : CCSprite {
@private CCMoveTo *runMove,*jumpAction;
@private CCSequence *runAndStop,*jumpAndStop;
@private CCRepeatForever *runAnimationRepeat;
@private CCSpriteBatchNode *runLRBatchNode,*runRLBatchNode,*jumpRLBatchNode,*jumpLRBatchNode;;
@private NSMutableArray *runRLFrames,*runLRFrames,*jumpLRFrames,*jumpRLFrames;
@private CGSize winSize;
@private BOOL isRunning;
@private BOOL isJumping;
    
    
    
}
-(id)initAtPosition:(CGPoint)initialPosition;
-(void)runRight;
-(void)runLeft;
-(void)makeIdleAtPoint:(CGPoint)idlePoint;
-(void)jumpRight;
-(void)jumpLeft;



@end
