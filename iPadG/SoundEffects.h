//
//  SoundEffects.h
//  iPadG
//
//  Created by Deniz Aydemir on 4/12/13.
//  Copyright (c) 2013 Deniz Aydemir. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AudioToolbox/AudioServices.h>

@interface SoundEffects : NSObject
{
    SystemSoundID soundID;
}

- (id)initWithSoundNamed:(NSString *)filename;
- (void)play;

@end