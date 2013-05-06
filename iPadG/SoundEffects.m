//
//  SoundEffects.m
//  iPadG
//
//  Created by Deniz Aydemir on 4/12/13.
//  Copyright (c) 2013 Deniz Aydemir. All rights reserved.
//

#import "SoundEffects.h"

@implementation SoundEffects

- (id)initWithSoundNamed:(NSString *)filename
{
    if ((self = [super init]))
    {
        NSURL *fileURL = [[NSBundle mainBundle] URLForResource:filename withExtension:nil];
        if (fileURL != nil)
        {
            SystemSoundID theSoundID;
            OSStatus error = AudioServicesCreateSystemSoundID((__bridge CFURLRef)fileURL, &theSoundID);
            if (error == kAudioServicesNoError)
                soundID = theSoundID;
        }
    }
    return self;
}

- (void)dealloc
{
    AudioServicesDisposeSystemSoundID(soundID);
}

- (void)play
{
    AudioServicesPlaySystemSound(soundID);
}
@end
