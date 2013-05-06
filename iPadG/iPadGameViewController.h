//
//  iPadGameViewController.h
//  iPadG
//
//  Created by Deniz Aydemir on 3/1/13.
//  Copyright (c) 2013 Deniz Aydemir. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Specs.h"

@interface iPadGameViewController : UIViewController
@property (weak, nonatomic) IBOutlet UILabel *NumPlayersLabel;
@property (weak, nonatomic) IBOutlet UILabel *GameTypeLabel;
@property (weak, nonatomic) IBOutlet UILabel *GameDifficultyLabel;
@property (weak, nonatomic) IBOutlet UILabel *TimerLabel;
@property (weak, nonatomic) IBOutlet UILabel *memoryLabel;

@property (retain, nonatomic) IBOutlet UIButton *MathButton;
@property (retain, nonatomic) IBOutlet UIButton *WordToWordButton;
@property (retain, nonatomic) IBOutlet UIButton *WordToSoundButton;
@property (retain, nonatomic) IBOutlet UIButton *SoundToSoundButton;

@property (retain, nonatomic) IBOutlet UIButton *EasyButton;
@property (retain, nonatomic) IBOutlet UIButton *MediumButton;
@property (retain, nonatomic) IBOutlet UIButton *HardButton;
@property (weak, nonatomic) IBOutlet UISegmentedControl *gameTypeControl;
@property (weak, nonatomic) IBOutlet UISegmentedControl *difficultyControl;
@property (weak, nonatomic) IBOutlet UISegmentedControl *memoryControl;



- (IBAction)ChooseSettingsSelected:(id)sender;

//number of players
- (IBAction)SinglePlayerPressed:(id)sender;
- (IBAction)TwoPlayerPressed:(id)sender;

//timed or not
- (IBAction)TimedPressed:(id)sender;
- (IBAction)NotTimedPressed:(id)sender;

//game type 
- (IBAction)WordToWordPressed:(id)sender;
- (IBAction)WordToSoundPressed:(id)sender;
- (IBAction)SoundToSoundPressed:(id)sender;
- (IBAction)MathPressed:(id)sender;

//game difficulty
//- (IBAction)VeryEasyPressed:(id)sender;
- (IBAction)EasyPressed:(id)sender;
- (IBAction)MediumPressed:(id)sender;
- (IBAction)HardPressed:(id)sender;

- (IBAction)gameTypeSegmentPressed:(id)sender;
- (IBAction)difficultySegmentPressed:(id)sender;

- (IBAction)submitSettingsPressed:(id)sender;

- (IBAction)memorySegmentPressed:(id)sender;

@end
