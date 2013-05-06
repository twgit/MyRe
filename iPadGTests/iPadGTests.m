//
//  iPadGTests.m
//  iPadGTests
//
//  Created by Deniz Aydemir on 3/1/13.
//  Copyright (c) 2013 Deniz Aydemir. All rights reserved.
//

#import "iPadGTests.h"
#import "iPadGameViewController.h"
#import "GameplayViewController.h"
#import "Content.h"
#import "Grid.h"
#import "Specs.h"
#import "MathGame.h"

@implementation iPadGTests
iPadGameViewController *ipadgamevc;
GameplayViewController *gameplayvc;
Content *cont;
Grid *gr;
Specs *sp;
MathGame *ma;

- (void)setUp
{
    [super setUp];
    ipadgamevc = [[iPadGameViewController alloc] init];
    gameplayvc = [[GameplayViewController alloc] init];
    cont = [[Content alloc] initWithWord:@"TEST WORD"];
    gr = [[Grid alloc] init];
    sp = [[Specs alloc] init];
    ma = [[MathGame alloc] init];
    
}

- (void)tearDown
{
    // Tear-down code here.
    
    [super tearDown];
}

- (void)testContent
{
    [self setUp];
    STAssertNotNil(cont, @"Content object hasn't been created");
    int num = 90;
    [cont setMatchID:&num];
    STAssertEquals(num, (int)*[cont matchID], @"ids are not equal");

    //STFail(@"Unit tests are not implemented yet in iPadGTests");
    //NSLog(@"%@",[cont word]);
}

- (void)testMath
{
    STAssertNotNil(ma, @"MathGame object hasn't been created");
    NSMutableArray *testArray = [[NSMutableArray alloc] initWithArray:[MathGame generateGrid:8 withDifficulty:1000 withOp:'b']];
    for (int i =0; i<8;i++){
        for(int j =0; j<8;j++){
            if ([[testArray objectAtIndex:i] isEqualToString:[testArray objectAtIndex:j]] && i!=j){
                STFail(@"there exists a pair of same number");
            }
        }
    }
                                

    
}





@end
