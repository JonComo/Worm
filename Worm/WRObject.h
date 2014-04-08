//
//  WRObject.h
//  Worm
//
//  Created by Jon Como on 4/4/14.
//  Copyright (c) 2014 Jon Como. All rights reserved.
//

#import <SpriteKit/SpriteKit.h>

@interface WRObject : SKSpriteNode

-(void)update;

-(BOOL)isOnScreen;

@end