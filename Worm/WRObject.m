//
//  WRObject.m
//  Worm
//
//  Created by Jon Como on 4/4/14.
//  Copyright (c) 2014 Jon Como. All rights reserved.
//

#import "WRObject.h"

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

@end
