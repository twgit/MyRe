//
//  Grid.h
//  COMP 523 Project
//
//  Created by Christopher Spargo on 4/8/13.
//  Copyright (c) 2013 Christopher Spargo. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Content.h"


@interface Grid : NSObject
{
    int gameCounter;
    Content *comparator;
    NSMutableArray *array;
}
@property (nonatomic) int gameCounter;
@property (nonatomic, retain) Content *comparator;
@property (nonatomic, retain) NSMutableArray *array;
- (BOOL) gameOver;
- (BOOL) isMatched: (Content *) useComparatorHere
                  : (Content *) andGetThisStraightFromGrid;
- (NSArray*) getGameContent:(int)gameSize andGameType: (int)gameType andMemory:(BOOL)mem;

@end
