//
//  Content.m
//  COMP 523 Project
//
//  Created by Christopher Spargo on 4/8/13.
//  Copyright (c) 2013 Christopher Spargo. All rights reserved.
//

#import "Content.h"

@implementation Content
@synthesize label;
@synthesize word;
@synthesize matchID;
@synthesize matched;
@synthesize position = _position;
@synthesize hasSound = False;

- (id) initWithWord:(NSString *)aWord;
{
    self = [super init];
    
    if(self)
    {
        word = [aWord copy];
    }
    
    return self;
}

- (void) setLabel:(BOOL)memory useGrid:(BOOL)alpha withIndex:(int)index withSize:(int)size {

    if(memory)
    {
        if (size == 4 || size == 6) {
            if (alpha) {
                label = [NSString stringWithFormat:@"%@ %@", [self getDirectional:index withSize:size], [self getGrid:index withSize:size]];
            }
            else {
                label = [NSString stringWithFormat:@"%@",  [self getDirectional:index withSize:size]];
            }
        }
        else {
            label = [NSString stringWithFormat:@"%@", [self getGrid:index withSize:size]];
            NSLog(@"label = grid spot");
        }
    }
    else {
        label = [NSString stringWithFormat:@"%@", word];
    }
}


- (NSString *) getDirectional:(int)index withSize:(int)size {
    if (size == 4) {
        switch(index) {
            case 0: {
                return [NSString stringWithFormat:@"%s", "Top Left"];
                break;
            }
            case 1: {
                return [NSString stringWithFormat:@"%s", "Top Right"];
                break;
            }
            case 2: {
                return [NSString stringWithFormat:@"%s", "Bottom Left"];
                break;
            }
            case 3: {
                return [NSString stringWithFormat:@"%s", "Bottom Right"];
                break;
            }
            default: {
            }
        }
    }
    else {
        switch (index) {
            case 0: {
                return [NSString stringWithFormat:@"%s", "Top Left"];
                break;
            }
            case 1: {
                return [NSString stringWithFormat:@"%s", "Top Right"];
                break;
            }
            case 2: {
                return [NSString stringWithFormat:@"%s", "Middle Left"];
                break;
            }
            case 3: {
                return [NSString stringWithFormat:@"%s", "Middle Right"];
                break;
            }
            case 4: {
                return [NSString stringWithFormat:@"%s", "Bottom Left"];
                break;
            }
            case 5: {
                return [NSString stringWithFormat:@"%s", "Bottom Right"];
                break;
            }
            default: {
            }
        }
    }
}

- (NSString*) getGrid:(int)index withSize:(int)size {
    int c;
    switch(size) {
        case 4: {
            c = 2;
            break;
        }
        case 8: {
            c = 2;
            break;
        }
        case 12: {
            c = 3;
            break;
        }
        case 16: {
            c = 4;
            break;
        }
        case 20: {
            c = 4;
            break;
        }
    }
    row = floor(index/c) + 65;
    column = (index + 1) % c;
    if (column == 0) {
        column = c;
    }
    return [NSString stringWithFormat:@"%c%i", row, column];
}

@end
