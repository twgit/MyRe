//
//  Specs.m
//  COMP 523 Project
//
//  Created by Christopher Spargo on 3/27/13.
//  Copyright (c) 2013 Christopher Spargo. All rights reserved.
//

#import "Specs.h"

@implementation Specs
@synthesize multiplayer = _multiplayer;
@synthesize gameType = _gameType;
@synthesize difficultyLevel = _difficultyLevel;
@synthesize timed = _timed;
@synthesize memory = _memory;

-(id)init
{
    self = [super init];
    _gameType = -1; //this means uninitialized specs
    if(self)
    {
        
    }
    
    return self;
}

@end
