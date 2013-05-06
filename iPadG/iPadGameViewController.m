//
//  iPadGameViewController.m
//  iPadG
//
//  Created by Deniz Aydemir on 3/1/13.
//  Copyright (c) 2013 Deniz Aydemir. All rights reserved.
//

#import "iPadGameViewController.h"
#import <QuartzCore/QuartzCore.h>
#import "Specs.h"
#import "GameplayViewController.h"
#import "AVFoundation/AVFoundation.h"
#import "SoundEffects.h"

@interface iPadGameViewController ()

@end

@implementation iPadGameViewController


@synthesize NumPlayersLabel = _NumPlayersLabel;
@synthesize GameTypeLabel = _GameTypeLabel;
@synthesize GameDifficultyLabel = _GameDifficultyLabel;
@synthesize TimerLabel = _TimerLabel;
@synthesize memoryLabel = _memoryLabel;
@synthesize EasyButton;
@synthesize MediumButton;
@synthesize HardButton;
@synthesize MathButton;
@synthesize WordToSoundButton;
@synthesize WordToWordButton;
@synthesize SoundToSoundButton;
@synthesize gameTypeControl;
@synthesize difficultyControl;
@synthesize memoryControl;

Specs *gameSpecs = nil;



/*-(void)awakeFromNib
{
    
    
    
    NSLog(@"INITIALIZATION");
    

    
    
    
}*/

+(void)initialize
{
    gameSpecs = [[Specs alloc] init];
    NSLog(@"gamespecs init");
    [gameSpecs setMemory:FALSE];
    [gameSpecs setGameType:kWordToWord];
    [gameSpecs setDifficultyLevel:kEasy];
    
    
    
    NSString *soundFilePath = [[NSBundle mainBundle] pathForResource:@"JazzyElevatorMusic" ofType:@"mp3"];
    NSURL *soundFileURL = [NSURL fileURLWithPath:soundFilePath];
    AVAudioPlayer *player = [[AVAudioPlayer alloc] initWithContentsOfURL:soundFileURL error:nil];
    player.numberOfLoops = -1; //infinite
    
    [player play];
    
    
    

}
/*- (id)initWithCoder:(NSCoder *)aDecoder {
    
    if(self = [super initWithCoder:aDecoder]) {
        //self.instanceVariable = [aDecoder decodeObjectForKey:INSTANCEVARIABLE_KEY];
        
        // similarly for other instance variables
        
        
        
    }
    
    return self;
}

- (void)encodeWithCoder:(NSCoder *)enCoder {
    [super encodeWithCoder:enCoder];
    
    //[enCoder encodeObject:instanceVariable forKey:INSTANCEVARIABLE_KEY];
    
    // Similarly for the other instance variables.
}*/


- (void)viewDidLoad
{
    [super viewDidLoad];
    NSLog(@"VIEW DID LOAD");
    [self printGameSpecs];
    //[[self view] setBackgroundColor:[UIColor clearColor]];
    // set background here
    /*if (UIDeviceOrientationIsLandscape([UIDevice currentDevice].orientation))
       {
           UIGraphicsBeginImageContext(self.view.frame.size);
           [[UIImage imageNamed:@"background2.png"] drawInRect:self.view.bounds];
           UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
           UIGraphicsEndImageContext();
           
           self.view.backgroundColor = [UIColor colorWithPatternImage:image];
       }
    else {
        UIGraphicsBeginImageContext(self.view.frame.size);
        [[UIImage imageNamed:@"background.jpg"] drawInRect:self.view.bounds];
        UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();
        
        self.view.backgroundColor = [UIColor colorWithPatternImage:image];
    }*/
    

    
    

    //SoundEffects *se = [[SoundEffects alloc] initWithSoundNamed:@"Buzzer.aiff"];
    //[se play];
    
    
    //setting segmented controls
    [gameSpecs memory]? [memoryControl setSelectedSegmentIndex:1]:[memoryControl setSelectedSegmentIndex:0];
    [difficultyControl setSelectedSegmentIndex:[gameSpecs difficultyLevel]];
    [gameTypeControl setSelectedSegmentIndex:[gameSpecs gameType]];
    
    UIFont *font = [UIFont boldSystemFontOfSize:20.0];
    NSDictionary *attributes = [NSDictionary dictionaryWithObject:font
                                                          forKey:UITextAttributeFont ];
    //[memoryControl setTitleTextAttributes:attributes forState:UIControlStateNormal];
    //[[UISegmentedControl appearance] setTitleTextAttributes:attributes forState:UIControlStateNormal];
    
    NSDictionary *unselectedAttributes = [NSDictionary dictionaryWithObjectsAndKeys:
                                [UIFont boldSystemFontOfSize:20], UITextAttributeFont,
                                [UIColor blackColor], UITextAttributeTextColor,
                                nil];
    [[UISegmentedControl appearance] setTitleTextAttributes:unselectedAttributes forState:UIControlStateNormal];
    NSDictionary *highlightedAttributes = [NSDictionary dictionaryWithObject:[UIColor whiteColor] forKey:UITextAttributeTextColor];
    [[UISegmentedControl appearance] setTitleTextAttributes:highlightedAttributes forState:UIControlStateHighlighted];
    
    
    //[[UIButton appearance] setTitleTextAttributes:attributes];
    
    
    
    /*if([gameSpecs multiplayer]) {
        _NumPlayersLabel.text = @"2";
        //NSLog(@"CHECKED MULTI");
    }
    else {
        _NumPlayersLabel.text = @"1";
    }
    
    if([gameSpecs timed]) {
        _TimerLabel.text = @"Yes";
    }
    else {
        _TimerLabel.text = @"No";
    }
    */
    
    if([gameSpecs memory]) {
        _memoryLabel.text = @"Cards Face Down"; }
    {
        _memoryLabel.text = @"Cards Face Up"; }
    
    GameType gt = [gameSpecs gameType];
    
    if(gt == kWordToWord) {
        _GameTypeLabel.text = @"Game Type: Words";
    }
    else if (gt == kWordToSound) {
        _GameTypeLabel.text  = @"Game Type: Words and Sounds"; }
    else if (gt == kSoundToSound){
        _GameTypeLabel.text = @"Game Type: Sounds"; }
    else {
        _GameTypeLabel.text = @"Game Type: Math"; 
    }
    
    DifficultyLevel dl = [gameSpecs difficultyLevel];
    if(dl == kEasy) {
        _GameDifficultyLabel.text = @"Difficulty: Easy"; }
    else if (dl == kVeryEasy) {
        _GameDifficultyLabel.text  = @"Difficulty:Super Easy"; }
    else if (dl == kMedium) {
        _GameDifficultyLabel.text  = @"Difficulty:Medium"; }
    else if (dl == kHard) {
        _GameDifficultyLabel.text  = @"Difficulty:Hard"; }
    else {
        _GameDifficultyLabel.text = @"Difficulty: SUPER Hard!"; }
    
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}




- (IBAction)ChooseSettingsSelected:(id)sender {

    
}

- (IBAction)SinglePlayerPressed:(id)sender {
    [gameSpecs setMultiplayer: false];
    NSLog(@"Multiplayer set to false");
}

- (IBAction)TwoPlayerPressed:(id)sender {
    [gameSpecs setMultiplayer: true];
    NSLog(@"Multiplayer set to true");
}

- (IBAction)TimedPressed:(id)sender {
    [gameSpecs setTimed: true];
    NSLog(@"Timer set to %s", [gameSpecs timed] ? "true" : "false" );
}

- (IBAction)NotTimedPressed:(id)sender {
    [gameSpecs setTimed: false];
    NSLog(@"Timer set to false");
}

- (IBAction)WordToWordPressed:(id)sender {
    [gameSpecs setGameType:kWordToWord];
    NSLog(@"Game Type is Word to Word");
    
    [sender setBackgroundColor:[UIColor grayColor]];
}

- (IBAction)WordToSoundPressed:(id)sender {
    [gameSpecs setGameType:kWordToSound];
    NSLog(@"Game Type is Word to Sound");
}

- (IBAction)SoundToSoundPressed:(id)sender {
    [gameSpecs setGameType:kSoundToSound];
    NSLog(@"Game Type is Sound to Sound");
}

-(IBAction)MathPressed:(id)sender {
    [gameSpecs setGameType:kMath];
    NSLog(@"Game Type is set to Math");
}

- (IBAction)VeryEasyPressed:(id)sender {
    [gameSpecs setDifficultyLevel:kVeryEasy];
    NSLog(@"Difficulty is Very Easy");
}

- (IBAction)EasyPressed:(id)sender {
    [gameSpecs setDifficultyLevel:kEasy];
    NSLog(@"Difficulty is Easy");
}

- (IBAction)MediumPressed:(id)sender {
    [gameSpecs setDifficultyLevel:kMedium];
    NSLog(@"Difficulty is Medium");
}

-(IBAction)HardPressed:(id)sender {
    [gameSpecs setDifficultyLevel:kHard];
    NSLog(@"Difficulty is Hard");
    [sender setBackgroundColor:[UIColor grayColor]];
}

-(IBAction)VeryHardPressed:(id)sender {
    [gameSpecs setDifficultyLevel:kVeryHard];
    NSLog(@"Difficulty is Very Hard");
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender { //send specs to gameplayviewcontroller
    if([segue.identifier isEqualToString:@"gameStarts"]){
        /**if(gameSpecs == nil) {
            gameSpecs = [[Specs alloc] init];
            [gameSpecs setDifficultyLevel:kEasy];
            [gameSpecs setGameType:kWordToWord];
            [gameSpecs setMultiplayer:false];
            [gameSpecs setTimed:false];
            NSLog(@"default settings activated");
        }**/
        GameplayViewController  *controller = [segue destinationViewController];
        [controller setGameSpecs:gameSpecs];
        NSLog(@"SEGUE IDENTIFIED");
    }
}

-(IBAction)gameTypeSegmentPressed:(id)sender
{
    [gameSpecs setGameType:gameTypeControl.selectedSegmentIndex];
    NSLog(@"%i", [gameSpecs gameType]);
}

- (IBAction)difficultySegmentPressed:(id)sender {
    [gameSpecs setDifficultyLevel:difficultyControl.selectedSegmentIndex];
}

- (IBAction)submitSettingsPressed:(id)sender {
    //settings submitted!!
}

- (IBAction)memorySegmentPressed:(id)sender {
    NSLog(@"selected memory index: %ld", (long)memoryControl.selectedSegmentIndex);
    if(memoryControl.selectedSegmentIndex == 0){
        [gameSpecs setMemory:FALSE];
        NSLog(@"memory set to false");
    }
    else {
        [gameSpecs setMemory:TRUE];
        NSLog(@"memory set to true");
    }
}


-(void)printGameSpecs //just for testing
{
    GameType gt = [gameSpecs gameType];
    
    NSString *gametype = @"nothing" ;
    NSString *difficulty = @"no diff" ;
    NSString *memory;
    
    if(gt == kWordToWord) {
        gametype = @"Word To Word";
    }
    else if (gt == kWordToSound) {
        gametype  = @"Word to Sound"; }
    else if (gt == kSoundToSound){
        gametype = @"Sound to Sound"; }
    else if (gt == kMath){
        gametype = @"Math";
    }
    
    DifficultyLevel dl = [gameSpecs difficultyLevel];
    if(dl == kEasy) {
        difficulty = @"Easy"; }
    else if (dl == kVeryEasy) {
        difficulty  = @"Very Easy"; }
    else if (dl == kMedium) {
        difficulty  = @"Medium"; }
    else if (dl == kHard) {
        difficulty  = @"Hard"; }
    else if (dl == kVeryHard){
        difficulty = @"Very Hard!"; }
    
    BOOL m = [gameSpecs memory];
    if(m)   {
        memory = @"true";
    }
    else if( !m ){
        memory = @"false";
    }

    NSLog(@"Specs are: %@, %@, %@", gametype, difficulty, memory);
}



@end
