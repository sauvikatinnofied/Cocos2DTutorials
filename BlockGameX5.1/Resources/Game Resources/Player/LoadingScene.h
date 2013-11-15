//
//  LoadingScreen.h
//  BlockGameX5.1
//
//  Created by Sandip Saha on 14/11/13.
//  Copyright 2013 Sandip Saha. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"

@interface LoadingScene : CCLayer {

@private NSUInteger countDownMax;
@private CCSprite *numberSprite;
}

+(CCScene*)scene;


@end
