//
//  ViewController.m
//  Farkle
//
//  Created by Taylor Wright-Sanson on 10/8/14.
//  Copyright (c) 2014 Taylor Wright-Sanson. All rights reserved.
//

#import "ViewController.h"
#import "DieLabel.h"

@interface ViewController () <DieLabelDelegate>

@property (strong, nonatomic) IBOutletCollection(DieLabel) NSArray *dieOutletCollection;
@property (strong, nonatomic) NSMutableArray *dice;
@property (weak, nonatomic) IBOutlet UILabel *userScore;
@property (weak, nonatomic) IBOutlet UILabel *bankedScore;
@property NSInteger selectedScoreingDice;

@property NSMutableArray *numberOfDieScoresSelected;

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.dice = [[NSMutableArray alloc] init];
    self.numberOfDieScoresSelected = [[NSMutableArray alloc] initWithObjects:@0, @0, @0, @0, @0, @0, nil];
    for (DieLabel *dieLabel in self.dieOutletCollection)
    {
        dieLabel.delegate = self;
    }
}

- (IBAction)onRollButtonPressed:(id)sender
{
    for (DieLabel *dieLabel in self.dieOutletCollection)
    {
        if (![self.dice containsObject:dieLabel]) {
            [dieLabel roll];
        }
    }
}

- (void)generateUserScore:(DieLabel *)selectedDie
{
    int numberOfSelectedOnes   = 0;
    int numberOfSelectedTwos   = 0;
    int numberOfSelectedThrees = 0;
    int numberOfSelectedFours  = 0;
    int numberOfSelectedFives  = 0;
    int numberOfSelectedSixes  = 0;

    NSInteger bankScore = 0;

    // Add the number of selected die at the index representing each die in the array self.selecedDie
    switch (selectedDie.text.integerValue)
    {
        case 1:
            numberOfSelectedOnes = [[self.numberOfDieScoresSelected objectAtIndex:0] intValue];
            numberOfSelectedOnes = numberOfSelectedOnes + 1;
            [self.numberOfDieScoresSelected replaceObjectAtIndex:0 withObject:[NSNumber numberWithInt:numberOfSelectedOnes]];
            break;
        case 2:
            numberOfSelectedTwos = [[self.numberOfDieScoresSelected objectAtIndex:1] intValue];
            numberOfSelectedTwos = numberOfSelectedTwos + 1;
            [self.numberOfDieScoresSelected replaceObjectAtIndex:1 withObject:[NSNumber numberWithInt:numberOfSelectedTwos]];
            break;
        case 3:
            numberOfSelectedThrees = [[self.numberOfDieScoresSelected objectAtIndex:2] intValue];
            numberOfSelectedThrees = numberOfSelectedThrees + 1;
            [self.numberOfDieScoresSelected replaceObjectAtIndex:2 withObject:[NSNumber numberWithInt:numberOfSelectedThrees]];
            break;
        case 4:
            numberOfSelectedFours = [[self.numberOfDieScoresSelected objectAtIndex:3] intValue];
            numberOfSelectedFours = numberOfSelectedFours + 1;
            [self.numberOfDieScoresSelected replaceObjectAtIndex:3 withObject:[NSNumber numberWithInt:numberOfSelectedFours]];
            break;
        case 5:
            numberOfSelectedFives = [[self.numberOfDieScoresSelected objectAtIndex:4] intValue];
            numberOfSelectedFives = numberOfSelectedFives + 1;
            [self.numberOfDieScoresSelected replaceObjectAtIndex:4 withObject:[NSNumber numberWithInt:numberOfSelectedFives]];
            break;
        case 6:
            numberOfSelectedSixes = [[self.numberOfDieScoresSelected objectAtIndex:5] intValue];
            numberOfSelectedSixes = numberOfSelectedSixes + 1;
            [self.numberOfDieScoresSelected replaceObjectAtIndex:5 withObject:[NSNumber numberWithInt:numberOfSelectedSixes]];
            break;
        default:
            break;
    }

    int threePairCounter = 0;

    int onesScore = 0;
    int twosScore = 0;
    int threesScore = 0;
    int foursScore = 0;
    int fivesScore = 0;
    int sixesScore = 0;

    for (int i = 0; i < self.numberOfDieScoresSelected.count; i++)
    {
        switch (i)
        {
            case 0:
                if ([[self.numberOfDieScoresSelected objectAtIndex:i] integerValue] == 1) {
                    onesScore = 100;
                }
                else if ([[self.numberOfDieScoresSelected objectAtIndex:i] integerValue] == 2) {
                    onesScore = 200;
                }
                else if ([[self.numberOfDieScoresSelected objectAtIndex:i] integerValue] == 3) {
                    onesScore = 1000;
                }
                else if ([[self.numberOfDieScoresSelected objectAtIndex:i] integerValue] == 4) {
                    onesScore = 2000;
                }
                else if ([[self.numberOfDieScoresSelected objectAtIndex:i] integerValue] == 5) {
                    onesScore = 4000;
                }
                else if ([[self.numberOfDieScoresSelected objectAtIndex:i] integerValue] == 6) {
                    onesScore = 8000;
                }
                break;
            case 1:
                if ([[self.numberOfDieScoresSelected objectAtIndex:i] integerValue] == 3) {
                    twosScore = 200;
                }
                else if ([[self.numberOfDieScoresSelected objectAtIndex:i] integerValue] == 4) {
                    twosScore = 400;
                }
                else if ([[self.numberOfDieScoresSelected objectAtIndex:i] integerValue] == 5) {
                    twosScore = 800;
                }
                else if ([[self.numberOfDieScoresSelected objectAtIndex:i] integerValue] == 6) {
                    twosScore = 1600;
                }
                break;
            case 2:
                if ([[self.numberOfDieScoresSelected objectAtIndex:i] integerValue] == 3) {
                    threesScore = 300;
                }
                else if ([[self.numberOfDieScoresSelected objectAtIndex:i] integerValue] == 4) {
                    threesScore = 600;
                }
                else if ([[self.numberOfDieScoresSelected objectAtIndex:i] integerValue] == 5) {
                    threesScore = 1200;
                }
                else if ([[self.numberOfDieScoresSelected objectAtIndex:i] integerValue] == 6) {
                    threesScore = 2400;
                }
                break;
            case 3:
                if ([[self.numberOfDieScoresSelected objectAtIndex:i] integerValue] == 3) {
                    foursScore = 400;
                }
                else if ([[self.numberOfDieScoresSelected objectAtIndex:i] integerValue] == 4) {
                    foursScore = 800;
                }
                else if ([[self.numberOfDieScoresSelected objectAtIndex:i] integerValue] == 5) {
                    foursScore = 1600;
                }
                else if ([[self.numberOfDieScoresSelected objectAtIndex:i] integerValue] == 6) {
                    foursScore = 3200;
                }
                break;
            case 4:
                if ([[self.numberOfDieScoresSelected objectAtIndex:i] integerValue] == 1) {
                    fivesScore = 50;
                }
                else if ([[self.numberOfDieScoresSelected objectAtIndex:i] integerValue] == 2) {
                    fivesScore = 100;
                }
                else if ([[self.numberOfDieScoresSelected objectAtIndex:i] integerValue] == 3) {
                    fivesScore = 500;
                }
                else if ([[self.numberOfDieScoresSelected objectAtIndex:i] integerValue] == 4) {
                    fivesScore = 1000;
                }
                else if ([[self.numberOfDieScoresSelected objectAtIndex:i] integerValue] == 5) {
                    fivesScore = 2000;
                }
                else if ([[self.numberOfDieScoresSelected objectAtIndex:i] integerValue] == 6) {
                    fivesScore = 4000;
                }
                break;
            case 5:
                if ([[self.numberOfDieScoresSelected objectAtIndex:i] integerValue] == 3) {
                    sixesScore = 600;
                }
                else if ([[self.numberOfDieScoresSelected objectAtIndex:i] integerValue] == 4) {
                    sixesScore = 1200;
                }
                else if ([[self.numberOfDieScoresSelected objectAtIndex:i] integerValue] == 5) {
                    sixesScore = 2400;
                }
                else if ([[self.numberOfDieScoresSelected objectAtIndex:i] integerValue] == 6) {
                    sixesScore = 4800;
                }
                break;
            default:
                break;
        }
    }

    bankScore = onesScore + twosScore + threesScore + foursScore + fivesScore + sixesScore;
    // Check for three pairs
    for (int y = 0; y < self.numberOfDieScoresSelected.count; y++) {
        if ([[self.numberOfDieScoresSelected objectAtIndex:y] integerValue] == 2) {
            threePairCounter++;
        }
    }

    if (threePairCounter == 3) {
        bankScore = 1000;
    }

    self.bankedScore.text = @(bankScore).description;
}

- (void)incrementSelectedScoringDice:(NSInteger)numberOfNewSelectedDice
{
    self.selectedScoreingDice = self.selectedScoreingDice + numberOfNewSelectedDice;
}

-(void)addSelectedDieToDice:(DieLabel *)die
{
    [self.dice addObject:die];
}

-(void)removeSelectedDieToDice:(DieLabel *)die
{
    if ([self.dice containsObject:die]) {
        [self.dice removeObject:die];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
@end
