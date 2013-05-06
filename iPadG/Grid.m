//
//  Grid.m
//  COMP 523 Project
//
//  Created by Christopher Spargo on 4/8/13.
//  Copyright (c) 2013 Christopher Spargo. All rights reserved.
//

#import "Grid.h"
#import "Specs.h"
#import "Content.h"
#import "DDFileReader.h"
#import <stdlib.h>
#import "NSMutableArray_Shuffling.h"
#import "MathGame.h"

@implementation Grid
@synthesize gameCounter;
@synthesize comparator;
@synthesize array = _array;


- (id) init
{
    self = [super init];
    if(self)
    {
        
    }
    
    Content *cow = [[Content alloc] initWithWord:@"Cow"];
    Content *dog = [[Content alloc] initWithWord:@"Dog"];
    Content *cat = [[Content alloc] initWithWord:@"Cat"];
    Content *horse = [[Content alloc] initWithWord:@"Horse"];
    Content *elephant = [[Content alloc] initWithWord:@"Elephant"];
    Content *fish = [[Content alloc] initWithWord:@"Fish"];
    Content *snake = [[Content alloc] initWithWord:@"Snake"];
    Content *bee = [[Content alloc] initWithWord:@"Bee"];
    
    
    _array = [NSArray arrayWithObjects: cow, dog, cat, horse, elephant, fish, snake, bee, nil];
    //_array = [NSArray arrayWithObjects: cow, dog, cat, dog, horse, elephant, elephant, cow, fish, snake, cat, snake, bee, fish, bee, horse, nil];
    //_array = [NSArray arrayWithObjects:@"Cow", @"Dog", @"Cat", @"Dog", @"Horse", @"Elephant", @"Elephant", @"Cow", @"Fish", @"Snake", @"Cat", @"Snake", @"Bee", @"Fish", @"Bee", @"Horse", nil];
    return self;
    
}


-(id)initWith:(int)numCards {
    _array = [NSArray arrayWithObjects:@"Cow", @"Dog", @"Cat", @"Dog", @"Horse", @"Elephant", @"Elephant", @"Cow", @"Fish", @"Snake", @"Cat", @"Snake", @"Bee", @"Fish", @"Bee", @"Horse", nil];
    NSLog(@"init with ran");
    return self;
}
- (BOOL) gameOver
{
    
    gameCounter = gameCounter - 1;
    if (gameCounter <= 0 ) {
        return true;
    }
    return false;
}

- (BOOL) isMatched: (Content *) useComparatorHere
                  : (Content *) andGetThisStraightFromGrid
{
    if (useComparatorHere == andGetThisStraightFromGrid) {
        return true;
    }
    return false;
}

- (NSArray*)getGameContent:(int)gameSize andGameType:(int)gameType andMemory:(BOOL)mem
{
    NSLog(@"getGameContent running");
    switch (gameType) {
        case 0://wordToWord
        {
            gameCounter = gameSize/2;
            //////////////////////////////////loading words from list/////////////////////////////
            NSMutableArray *words;
            NSMutableArray *words_chosen;
            NSMutableArray *selectedSet;
            words = [NSMutableArray array];
            words_chosen = [NSMutableArray array];
            selectedSet = [NSMutableArray array];
            //read file
            NSString* path = [[NSBundle mainBundle] pathForResource:@"animals"
                                                             ofType:@"txt"];
            DDFileReader *reader = [[DDFileReader alloc] initWithFilePath:path];
            NSString * line = nil;
            //fetch input by lines
            while ((line = [reader readLine])) {
                [words addObject:line];
            }
            
            NSUInteger totalLines = [words count];
            //for 16 objects, randomly select for 8 objects and put a pair in
            for (int i = 0 ; i< gameCounter; i++){
                int r = arc4random() % totalLines ;
                if (![selectedSet containsObject:[NSNumber numberWithInt:r]])
                {
                    [selectedSet addObject:[NSNumber numberWithInt:r]];
                }
                else
                {
                    i--;
                    continue;
                }
                NSString *word = [words objectAtIndex: r];
                Content *wordAsContent = [[Content alloc] initWithWord:word];
                Content *wordAsContent2 = [[Content alloc] initWithWord:word];
                [wordAsContent setMatchID:i];
                [wordAsContent2 setMatchID:i];
                [words_chosen addObject:wordAsContent];
                [words_chosen addObject:wordAsContent2];
            }
                       
            [words_chosen shuffle];
            
            Content *card;
            for (int i = 0; i < gameSize; i++) {
                card = [words_chosen objectAtIndex:i];
                [card setLabel:mem useGrid:true withIndex:i withSize:gameSize];
            }
           
            NSArray *gridContent = words_chosen;
            return gridContent;
        }
            break;
            
        case 1://wordtoSound
        {
            gameCounter = gameSize/2;
            //////////////////////////////////loading words from list/////////////////////////////
            NSMutableArray *words;
            NSMutableArray *words_chosen;
            words = [NSMutableArray array];
            words_chosen = [NSMutableArray array];
            NSMutableArray *selectedSet;
            selectedSet = [NSMutableArray array];
            //read file
            NSString* path = [[NSBundle mainBundle] pathForResource:@"word_sound"
                                                             ofType:@"lst"];
            DDFileReader *reader = [[DDFileReader alloc] initWithFilePath:path];
            NSString * line = nil;
            //fetch input by lines
            while ((line = [reader readLine])) {
                [words addObject:line];
            }
            
            NSUInteger totalLines = [words count];

            for (int i = 0 ; i< gameCounter; i++){
                int r = arc4random() % totalLines ;
                if (![selectedSet containsObject:[NSNumber numberWithInt:r]])
                {
                    [selectedSet addObject:[NSNumber numberWithInt:r]];
                }
                else
                {
                    i--;
                    continue;
                }
                NSString *word = [words objectAtIndex: r];
                NSArray *items = [word componentsSeparatedByString:@":"];
                Content *wordAsContent = [[Content alloc] initWithWord:[items objectAtIndex:0]];
                Content *soundAsContent = [[Content alloc] initWithWord:[items objectAtIndex:1]];
                [soundAsContent setHasSound:true];
                [wordAsContent setMatchID:i];
                [soundAsContent setMatchID:i];
                [words_chosen addObject:wordAsContent];
                [words_chosen addObject:soundAsContent];
            }
            //shuffling inside the words_chosen array
            [words_chosen shuffle];
            //put nil at the end
            //[words_chosen addObject:nil];
            
            Content *card;
            for (int i = 0; i < gameSize; i++) {
                card = [words_chosen objectAtIndex:i];
                [card setLabel:mem useGrid:true withIndex:i withSize:gameSize];
            }

            
            NSArray *gridContent = words_chosen;
            return gridContent;

        }
            break;
            
        case 2://soundtoSound
        {
            gameCounter = gameSize/2;
            //////////////////////////////////loading words from list/////////////////////////////
            NSMutableArray *words;
            NSMutableArray *words_chosen;
            words = [NSMutableArray array];
            words_chosen = [NSMutableArray array];
            NSMutableArray *selectedSet;
            selectedSet = [NSMutableArray array];
            //read file
            NSString* path = [[NSBundle mainBundle] pathForResource:@"word_sound"
                                                             ofType:@"lst"];
            DDFileReader *reader = [[DDFileReader alloc] initWithFilePath:path];
            NSString * line = nil;
            //fetch input by lines
            while ((line = [reader readLine])) {
                [words addObject:line];
            }
            
            NSUInteger totalLines = [words count];
            
            for (int i = 0 ; i< gameCounter; i++){
                int r = arc4random() % totalLines ;
                if (![selectedSet containsObject:[NSNumber numberWithInt:r]])
                {
                    [selectedSet addObject:[NSNumber numberWithInt:r]];
                }
                else
                {
                    i--;
                    continue;
                }
                NSString *word = [words objectAtIndex: r];
                NSArray *items = [word componentsSeparatedByString:@":"];
                Content *sound1 = [[Content alloc] initWithWord:[items objectAtIndex:1]];
                Content *sound2 = [[Content alloc] initWithWord:[items objectAtIndex:1]];
                [sound1 setHasSound:TRUE];
                [sound2 setHasSound:TRUE];
                [sound1 setMatchID:i];
                [sound2 setMatchID:i];
                [words_chosen addObject:sound1];
                [words_chosen addObject:sound2];
            }
            //shuffling inside the words_chosen array
            [words_chosen shuffle];
            //put nil at the end
            //[words_chosen addObject:nil];
            Content *card;
            for (int i = 0; i < gameSize; i++) {
                card = [words_chosen objectAtIndex:i];
                [card setLabel:mem useGrid:true withIndex:i withSize:gameSize];
            }

            
            
            NSArray *gridContent = words_chosen;
            return gridContent;

        }
            break;
            
        case 3://Math
        {
            gameCounter = gameSize/2;
            
            NSLog(@"MATH TYPE");
            NSMutableArray *words_chosen = [NSMutableArray array];
            NSMutableArray *mathCards = [[NSMutableArray alloc] initWithArray:[MathGame generateGrid:gameSize withDifficulty:10 withOp:'b']];
            
            for (int i = 0 ; i < gameCounter; i++){
                
                Content *mathContentQ = [[Content alloc] initWithWord: [mathCards objectAtIndex:2*i]];
                
                Content *mathContentA = [[Content alloc] initWithWord: [mathCards objectAtIndex:2*i+1]];
                [mathContentQ setMatchID:i];
                [mathContentA setMatchID:i];
                [words_chosen addObject:mathContentQ];
                [words_chosen addObject:mathContentA];
            }
            
            [words_chosen shuffle];
        
            Content *card;
            for (int i = 0; i < gameSize; i++) {
                card = [words_chosen objectAtIndex:i];
                [card setLabel:mem useGrid:true withIndex:i withSize:gameSize];
            }
            
            NSArray *gridContent = words_chosen;
            
            NSLog(@"Completed MATH GENERATION");
            return gridContent;
        }
            break;
            
        case 4://braille
        {
            gameCounter = gameSize/2;
            //////////////////////////////////loading words from list/////////////////////////////
            NSMutableArray *words;
            NSMutableArray *words_chosen;
            words = [NSMutableArray array];
            words_chosen = [NSMutableArray array];
            NSMutableArray *selectedSet;
            selectedSet = [NSMutableArray array];
            //read file
            NSString* path = [[NSBundle mainBundle] pathForResource:@"braille"
                                                             ofType:@"lst"];
            DDFileReader *reader = [[DDFileReader alloc] initWithFilePath:path];
            NSString * line = nil;
            //fetch input by lines
            while ((line = [reader readLine])) {
                [words addObject:line];
            }
            
            NSUInteger totalLines = [words count];
            
            for (int i = 0 ; i< gameCounter; i++){
                int r = arc4random() % totalLines ;
                if (![selectedSet containsObject:[NSNumber numberWithInt:r]])
                {
                    [selectedSet addObject:[NSNumber numberWithInt:r]];
                }
                else
                {
                    i--;
                    continue;
                }
                NSString *word = [words objectAtIndex: r];
                NSArray *items = [word componentsSeparatedByString:@":"];
                Content *character = [[Content alloc] initWithWord:[items objectAtIndex:0]];
                Content *repre = [[Content alloc] initWithWord:[items objectAtIndex:1]];
                [character setMatchID:i];
                [repre setMatchID:i];
                [words_chosen addObject:character];
                [words_chosen addObject:repre];
            }
            //shuffling inside the words_chosen array
            [words_chosen shuffle];
            //put nil at the end
            //[words_chosen addObject:nil];
            
            NSArray *gridContent = words_chosen;
            NSLog(@"RETURN GRID CONTENT");
            return gridContent;

            /*
             [words_chosen_l addObject:character];
             [words_chosen-r addObject:repre];
             
             [words_chosen_l shuffle];
             [words_chosen_r shuffle];
             
             for ( int i =0 ; i < gameCounter/2; i++){
                [words_chosen addObject: [words_chosen_l objectAtIndex: i]]
                [words_chosen addObject: [words_chosen_r objectAtIndex: i]]
             }
             */
            
        }
            break;
            
            
        default:
        {
            return 0;
        }
            break;
            
            
            
    }
}


@end
