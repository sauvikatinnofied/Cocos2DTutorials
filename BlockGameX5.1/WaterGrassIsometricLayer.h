//
//  WaterGrassIsometricLayer.h
//  BlockGameX5.1
//
//  Created by Sandip Saha on 13/11/13.
//  Copyright 2013 Sandip Saha. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"

@interface WaterGrassIsometricLayer : CCLayer {
 
 @public  CCTMXTiledMap *tileMap;
}
+(CCScene *) scene;

@end
