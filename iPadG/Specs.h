//
//  Specs.h
//  COMP 523 Project
//
//  Created by Christopher Spargo on 3/27/13.
//  Copyright (c) 2013 Christopher Spargo. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef enum {
    kWordToWord,
    kWordToSound,
    kSoundToSound,
    kMath,
    kBraille
} GameType;

typedef enum {
    kVeryEasy,
    kEasy,
    kMedium,
    kHard,
    kVeryHard
} DifficultyLevel;

@interface Specs : NSObject
{
    BOOL multiplayer;
    GameType gameType;
    DifficultyLevel difficultyLevel;
    BOOL timed;
    BOOL memory;
}
@property (nonatomic) BOOL multiplayer;
@property (nonatomic) GameType gameType;
@property (nonatomic) DifficultyLevel difficultyLevel;
@property (nonatomic) BOOL timed;
@property (nonatomic) BOOL memory;

@end
