//
//  PlayerOnTiledMap.h
//  BlockGameX5.1
//
//  Created by Sandip Saha on 13/11/13.
//  Copyright 2013 Sandip Saha. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"

@interface PlayerOnTiledMap : CCSprite {
    


@private CCRepeatForever *runAnimationRepeat;
@private CCSpriteBatchNode *runLRBatchNode;
@private NSMutableArray *runLRFrames;
@private CGSize winSize;
@private BOOL isRunning;

    
    
    
}
-(id)initAtPosition:(CGPoint)initialPosition;
-(void)runRight;

@end
