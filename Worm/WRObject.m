//
//  WRObject.m
//  Worm
//
//  Created by Jon Como on 4/4/14.
//  Copyright (c) 2014 Jon Como. All rights reserved.
//

#import "WRObject.h"

#import "WRWorldScene.h"

@implementation WRObject

-(id)initWithTexture:(SKTexture *)texture
{
    texture.filteringMode = SKTextureFilteringNearest;
    
    if (self = [super initWithTexture:texture]) {
        //init
        self.xScale = self.yScale = 3;
    }
    
    return self;
}

-(void)update
{
    
}

-(BOOL)isOnScreen
{
    WRWorldScene *worldScene = (WRWorldScene *)self.scene;
    
    CGPoint testPoint = CGPointMake(self.position.x + worldScene.world.position.x, self.position.y + worldScene.world.position.y);
    
    return (testPoint.x > -100 && testPoint.x < worldScene.size.width + 100 && testPoint.y > -100 && testPoint.y < worldScene.size.height + 100);
}

@end
