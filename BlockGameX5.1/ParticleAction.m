//
//  ParticleAction.m
//  BlockGameX5.1
//
//  Created by Sandip Saha on 13/11/13.
//  Copyright 2013 Sandip Saha. All rights reserved.
//

#import "ParticleAction.h"


@implementation ParticleAction

+(CCScene*)scene
{
    CCScene *scene=[CCScene node];
    CCLayer *layer=[ParticleAction node];
    
    [scene addChild:layer];
    
    return  scene;
    
}
CCParticleSystem *fireWorks;

-(id)init
{
    if(self=[super init])
    {
        //registering with touch dispatcher
        
        [[CCDirector sharedDirector].touchDispatcher addTargetedDelegate:self priority:INT_MIN+1 swallowsTouches:YES];
        
        fireWorks=[[CCParticleSystem alloc]init];
        
        
        
    }
    return  self;
}


-(BOOL)ccTouchBegan:(UITouch *)touch withEvent:(UIEvent *)event
{
    [self removeChild:fireWorks];
    return  YES;
}

-(void)ccTouchEnded:(UITouch *)touch withEvent:(UIEvent *)event
{
    static int rand=0;
    CGSize winSize=[CCDirector sharedDirector].winSize;
    
    switch (++rand) {
        case 1:
        {
            fireWorks=[[CCParticleFireworks alloc]init];
            fireWorks.texture=[[CCTextureCache sharedTextureCache]addImage:@"fireworks.png"];
            fireWorks.position=ccp(winSize.width/2,10);
            
            [self addChild:fireWorks];
        }
            break;
        case 2:
        {
            fireWorks=[[CCParticleExplosion alloc]init];
            fireWorks.texture=[[CCTextureCache sharedTextureCache]addImage:@"explosion.png"];
            fireWorks.position=ccp(winSize.width/2,winSize.height/2);
            
            [self addChild:fireWorks];
        }
            break;
        case 3:
        {
            fireWorks=[[CCParticleRain alloc]init];
            fireWorks.texture=[[CCTextureCache sharedTextureCache]addImage:@"water-drop-md.png"];
            fireWorks.position=ccp(winSize.width/2,winSize.height);
            
            [self addChild:fireWorks];
        }
            break;
        case 4:
        {
            fireWorks=[[CCParticleSnow alloc]init];
            fireWorks.texture=[[CCTextureCache sharedTextureCache]addImage:@"snow.png"];
            fireWorks.position=ccp(winSize.width/2,winSize.height);
            
            [self addChild:fireWorks];
        }
            break;
        case 5:
        {
            fireWorks=[[CCParticleSpiral alloc]init];
            fireWorks.texture=[[CCTextureCache sharedTextureCache]addImage:@"spiral.png"];
            fireWorks.position=ccp(winSize.width/2,winSize.height/2);
            
            [self addChild:fireWorks];
        }
            break;
        case 6:
        {
            fireWorks=[[CCParticleSun alloc]init];
            fireWorks.texture=[[CCTextureCache sharedTextureCache]addImage:@"sun.png"];
            fireWorks.position=ccp(winSize.width/2,winSize.height/2);
            
            [self addChild:fireWorks];
        }
            break;
        case 7:
        {
            fireWorks=[[CCParticleSmoke alloc]init];
            fireWorks.texture=[[CCTextureCache sharedTextureCache]addImage:@"smoke.png"];
            fireWorks.position=ccp(winSize.width/2,winSize.height/2);
            
            [self addChild:fireWorks];
        }
            break;
        case 8:
        {
            fireWorks=[[CCParticleFlower alloc]init];
            fireWorks.texture=[[CCTextureCache sharedTextureCache]addImage:@"flower.png"];
            fireWorks.position=ccp(winSize.width/2,winSize.height/2);
            
            //[self addChild:fireWorks];
        }
        case 9:
        {
            fireWorks=[[CCParticleGalaxy alloc]init];
            fireWorks.texture=[[CCTextureCache sharedTextureCache]addImage:@"galaxy.png"];
            fireWorks.position=ccp(winSize.width/2,winSize.height/2);
            
            [self addChild:fireWorks];
        }
            break;
        case 10:
        {
            fireWorks=[[CCParticleMeteor alloc]init];
            fireWorks.texture=[[CCTextureCache sharedTextureCache]addImage:@"meteor.png"];
            fireWorks.position=ccp(winSize.width/2,winSize.height/2);
            
            [self addChild:fireWorks];
        }
            break;
            
        default:
            break;
    }
    
   // CCFadeOut *fade=[CCFadeOut actionWithDuration:5.0];
    //[fireWorks runAction:fade];
    
}
@end
