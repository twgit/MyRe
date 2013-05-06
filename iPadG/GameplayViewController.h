//
//  GameplayViewController.h
//  iPadG
//
//  Created by Deniz Aydemir on 4/9/13.
//  Copyright (c) 2013 Deniz Aydemir. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Grid.h"    
#import "Specs.h"

@interface GameplayViewController : UIViewController<UIActionSheetDelegate>

@property (nonatomic) Specs *gameSpecs;
- (IBAction)quitGamePressed:(id)sender;

@end
