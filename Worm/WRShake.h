//
//  WRShake.h
//  Worm
//
//  Created by Jon Como on 4/6/14.
//  Copyright (c) 2014 Jon Como. All rights reserved.
//

#import <Foundation/Foundation.h>

@class SKSpriteNode;

@interface WRShake : NSObject

@property CGPoint offset;

+(WRShake *)manager;

-(void)shakeWithIntensity:(float)intensity;
-(void)update;

@end