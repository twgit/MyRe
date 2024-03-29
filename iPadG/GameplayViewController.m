//
//  GameplayViewController.m
//  iPadG
//
//  Created by Deniz Aydemir on 4/9/13.
//  Copyright (c) 2013 Deniz Aydemir. All rights reserved.
//

#import "GameplayViewController.h"
#import "Grid.h"
#import <QuartzCore/QuartzCore.h>
#import "DDFileReader.h"
#import <stdlib.h>
#import "NSMutableArray_Shuffling.h"
#import <AudioToolbox/AudioToolbox.h>
#import "SoundEffects.h"
#import "iPadGameViewController.h"
#import "Specs.h"


@interface GameplayViewController ()



@end

@implementation GameplayViewController

@synthesize gameSpecs;

Grid *gameGrid;
BOOL oneButtonClickedAlready = false;
UIButton *clickedButton;
NSArray *gridContent;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        
    }
    return self;
}

- (void)setSpecs:(Specs*)gs
{
    gameSpecs = gs;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    clickedButton = nil;
    int gamesize=0;
    gameGrid = [[Grid alloc] init];
    if ([gameSpecs memory] != FALSE && [gameSpecs memory] != TRUE) { //make default memory setting false
        [gameSpecs setMemory:FALSE];
    }
    
    if ([gameSpecs difficultyLevel] == kVeryEasy) {
        gamesize = 4;
    }
    else if ([gameSpecs difficultyLevel] == kEasy) {
        gamesize = 6;
    }
    else if ([gameSpecs difficultyLevel] == kMedium) {
        NSLog(@"MEDIUM GAME DIFF");
        gamesize = 12;
    }
    else if ([gameSpecs difficultyLevel] == kHard) {
        gamesize = 16;
    }
    else {
        gamesize = 20;
    }
    
    NSLog(@"memory is %@", [gameSpecs memory]? @"true":@"false");
    gridContent = [[NSArray alloc] initWithArray:[gameGrid getGameContent:gamesize andGameType:[gameSpecs gameType] andMemory:[gameSpecs memory]]];
    
    [self createButtons:[gridContent count] array:gridContent];
}


/*- (void)willAnimateRotationToInterfaceOrientation:
(UIInterfaceOrientation)toInterfaceOrientation
                                         duration:(NSTimeInterval)duration
{
    if (toInterfaceOrientation == UIInterfaceOrientationLandscapeLeft ||
        toInterfaceOrientation == UIInterfaceOrientationLandscapeRight)
    {
     //   firstButton.frame = CGRectMake(20, 20, 482, 708);
      //  secondButton.frame = CGRectMake(522, 20, 482, 708);
    }
    else
    {
       // firstButton.frame = CGRectMake(20, 20, 728, 472);
        //secondButton.frame = CGRectMake(20, 512, 728, 472);
    }
}*/

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)createButtons:(int)numButtons array:(NSArray*)gc
{
    //default for 16 cards or 8 cards
    int yOffset = 0;
    int xOffset = 0;
    int yOffsetIncrement = 225;
    int width = 192;
    int height = 220;
    int cardsInRow = 4;
    
    //insert function that adjusts button distribution according to size of cards
    
    if(numButtons == 4)
    {
        width = 384;
        height = 440;
        yOffsetIncrement = 450;
        cardsInRow = 2;
    }
    
    else if(numButtons == 6)
    {
        height = 293;
        width = 384;
        yOffsetIncrement = 300;
        cardsInRow = 2;
    }
    
    else if(numButtons == 8)
    {
        width = 384;
        cardsInRow = 2;
    }
    
    else if(numButtons == 12)
    {
        width = 256;
        cardsInRow = 3;
    }
    
    else if(numButtons == 16) {
        //anything else for 16?
    }
    
    else
    {
        width = 192;
        height = 176;
        yOffsetIncrement = 180;
    }
    
    
    for(int a = 0; a < numButtons; a++) {
        
        if((a%cardsInRow==0) && (a>0)) { yOffset+=yOffsetIncrement; xOffset=0; }
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        CALayer * layer = [button layer];
        [layer setMasksToBounds:YES];
        [layer setCornerRadius:10.0]; //when radius is 0, the border is a rectangle
        [layer setBorderWidth:1.0];
        [layer setBorderColor:[[UIColor grayColor] CGColor]];
        [button addTarget:self
                   action:@selector(buttonClicked:)
         forControlEvents:UIControlEventTouchDown];
        Content *cardContent = [gc objectAtIndex:a];
        NSLog(@"%i", (int)[cardContent matchID]);
        if ([cardContent label] == NULL) {
            [button setTitle:[NSString stringWithFormat:@"iMATCH"] forState:UIControlStateNormal];
        }
        else if([cardContent hasSound] && ![gameSpecs memory]){
            [button setTitle:@"" forState:UIControlStateNormal];
        }
        else {
            [button setTitle:[NSString stringWithFormat:@"%@", [cardContent label]] forState:UIControlStateNormal];
        }
        button.frame = CGRectMake(xOffset, yOffset, width, height);
        button.clipsToBounds = YES;
        [button setTag:a];
        [button setAutoresizingMask:UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleRightMargin | UIViewAutoresizingFlexibleTopMargin | UIViewAutoresizingFlexibleBottomMargin]; //makes autoresize work for orientation change
        NSLog(@"%i", a);
        [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];


        [self.view addSubview:button];
        xOffset+=width;
    }
}

-(void)buttonClicked:(UIButton*)sender {
    int currentTag = [sender tag];
    int previousTag = [clickedButton tag];
    Content *currentContent =  [gridContent objectAtIndex:currentTag];
    Content *previousContent = [gridContent objectAtIndex:previousTag];
    //some test prints
    NSLog(@"%i", currentTag);
    NSLog(@"button clicked");
    
    if([currentContent hasSound]){
        
        //play sound
        NSString *addr = [currentContent word];
        NSString *myString = [addr stringByReplacingOccurrencesOfString:@"\n" withString:@""];
        SoundEffects *sound = [[SoundEffects alloc] initWithSoundNamed:myString];
        [sound play];
        
    }
    
    
    if([currentContent matched])
    {
       //play some sound indicating they already matched this card?
        NSLog(@"This card already matched!");
    }
    
    else if(!oneButtonClickedAlready) { // see if the button being clicked is the first or second of a pair
        oneButtonClickedAlready = true;
        clickedButton = sender;
        [self highlightSelectedButton:sender];
        
        //play sound
        SoundEffects *se = [[SoundEffects alloc] initWithSoundNamed:@"Blop.mp3"];
        [se play];
        
        }
    else if(clickedButton == sender){
        //action to be done if clicked button is clicked again...
        SoundEffects *se = [[SoundEffects alloc] initWithSoundNamed:@"Blop.mp3"];
        [se play];
    }
    else {
        if([currentContent matchID] == [previousContent matchID])
        {
            [self highlightMatchedButtons:clickedButton secondButton:sender];
            [currentContent setMatched:true];
            [previousContent setMatched:true];
            SoundEffects *se = [[SoundEffects alloc] initWithSoundNamed:@"A-Tone.mp3"];
            [se play];
            if([gameGrid gameOver])
            {
                NSLog(@"YOU WIN");
                [self performSegueWithIdentifier:@"winSegue'" sender:self];
                
                SoundEffects *se = [[SoundEffects alloc] initWithSoundNamed:@"Yahoo.mp3"];
                SoundEffects *se2 = [[SoundEffects alloc] initWithSoundNamed:@"Donkey_Kong_Win.mp3"];
                [se play];
                [se2 play];
                
            }
        }
        else {
            [self highlightNoMatchButtons:clickedButton secondButton:sender];
        }
        oneButtonClickedAlready = false;
            
    }
}

-(void)highlightMatchedButtons:(UIButton*)sender secondButton:(UIButton*)sender2
{
    
    UIColor * green = [UIColor colorWithRed:60/255.0f green:226/255.0f blue:63/255.0f alpha:1.0f];
    sender.backgroundColor = green;
    sender2.backgroundColor = green;
    Content *currentCard1 = [gridContent objectAtIndex:[sender tag]];
    if([currentCard1 hasSound] == false){
        [sender setTitle:[NSString stringWithFormat:@"%@", currentCard1.label] forState:UIControlStateNormal];
    }
    
    Content *currentCard2 = [gridContent objectAtIndex:[sender2 tag]];
    if([currentCard2 hasSound] == false){
        [sender setTitle:[NSString stringWithFormat:@"%@", currentCard2.label] forState:UIControlStateNormal];
    }
}

-(void)highlightSelectedButton:(UIButton*)sender
{    
    UIColor * gray = [UIColor colorWithRed:204/255.0f green:204/255.0f blue:204/255.0f alpha:1.0f];
    sender.backgroundColor = gray;
    Content *currentCard = [gridContent objectAtIndex:[sender tag]];
    if([currentCard hasSound] == false){
        [sender setTitle:[NSString stringWithFormat:@"%@", currentCard.word] forState:UIControlStateNormal];
    }
    
}

-(void)highlightNoMatchButtons:(UIButton*)sender secondButton:(UIButton*)sender2
{
    SoundEffects *se = [[SoundEffects alloc] initWithSoundNamed:@"Buzzer.aiff"];
    [se play];
    UIColor * red = [UIColor colorWithRed:255/255.0f green:25/255.0f blue:54/255.0f alpha:1.0f];
    sender.backgroundColor = red;
    sender2.backgroundColor = red;
    Content *currentCard2 = [gridContent objectAtIndex:[sender2 tag]];
    if([currentCard2 hasSound] == false){
        [sender2 setTitle:[NSString stringWithFormat:@"%@", currentCard2.word] forState:UIControlStateNormal];
    }

    [self performSelector:@selector(clearButtonHighlighting:) withObject:sender afterDelay:1];
    [self performSelector:@selector(clearButtonHighlighting:) withObject:sender2 afterDelay:1];
}

-(void)clearButtonHighlighting:(UIButton*)sender {
    
    if(sender.backgroundColor == [UIColor colorWithRed:204/255.0f green:204/255.0f blue:204/255.0f alpha:1.0f]) {
        return;
    }
    else {
        sender.backgroundColor = [UIColor whiteColor];
        
        Content *currentCard = [gridContent objectAtIndex:[sender tag]];
        [sender setTitle:[NSString stringWithFormat:@"%@", @""] forState:UIControlStateNormal];
        if([gameSpecs memory]){
            [sender setTitle:[NSString stringWithFormat:@"%@", currentCard.label] forState:UIControlStateNormal];
        }

    }
}



/*-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{ //send specs to gameplayviewcontroller
    if([segue.identifier isEqualToString:@"winSegue"]){
        iPadGameViewController  *controller = [segue destinationViewController];
        [controller setGameSpecs:gameSpecs];
        NSLog(@"SEGUE IDENTIFIED");
    }
}*/



- (IBAction)quitGamePressed:(id)sender {
    UIActionSheet *gameQuit = [[UIActionSheet alloc] initWithTitle:@"Are you sure?" delegate:self cancelButtonTitle:nil destructiveButtonTitle:nil otherButtonTitles:@"Quit",@"Resume", nil];
    [gameQuit showInView:[self.view window]];

    
}

-(void) actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex    {
    if(buttonIndex == 0){
        oneButtonClickedAlready = false;
        [self performSegueWithIdentifier:@"quitGame" sender:self];
    }
    [actionSheet dismissWithClickedButtonIndex:1 animated:true];
}
@end
