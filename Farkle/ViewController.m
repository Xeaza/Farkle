//
//  ViewController.m
//  Farkle
//
//  Created by Taylor Wright-Sanson on 10/8/14.
//  Copyright (c) 2014 Taylor Wright-Sanson. All rights reserved.
//

#import "ViewController.h"
#import "DieLabel.h"

@interface ViewController () <DieLabelDelegate, UIAlertViewDelegate>

@property (strong, nonatomic) IBOutletCollection(DieLabel) NSArray *dieOutletCollection;
@property (strong, nonatomic) NSMutableArray *dice;
@property (weak, nonatomic) IBOutlet UILabel *userScore;
@property (weak, nonatomic) IBOutlet UILabel *bankedScore;
@property NSInteger selectedScoreingDice;

@property NSMutableArray *arrayOfSelectedDiceValues;
@property NSMutableArray *arrayOfDiceValuesFromSecondRoll;

@property NSInteger numberOfScoringDiceSelected;

@property BOOL allDiceSelected;

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.dice = [[NSMutableArray alloc] init];
    self.arrayOfSelectedDiceValues = [[NSMutableArray alloc] initWithObjects:@0, @0, @0, @0, @0, @0, nil];
    for (DieLabel *dieLabel in self.dieOutletCollection)
    {
        dieLabel.delegate = self;
    }
}

- (IBAction)onRollButtonPressed:(id)sender
{
    if ([self getNumberOfNonScoringDiceSelected] > 0)
    {
        // add an alert view
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"You can't roll dice with non scoring dice held!"
                                                            message:nil
                                                           delegate:self
                                                  cancelButtonTitle:@"OK"
                                                  otherButtonTitles:nil, nil];
        alertView.delegate = self;
        [alertView show];
    }
    else
    {
        self.arrayOfDiceValuesFromSecondRoll = [[NSMutableArray alloc] init];

        for (DieLabel *dieLabel in self.dieOutletCollection)
        {
            if (![self.dice containsObject:dieLabel]) {
                [dieLabel roll];
                // Fill array of values
                [self.arrayOfDiceValuesFromSecondRoll addObject:dieLabel.text];
            }
        }
        [self checkForFarkle];
    }
}

- (void)checkForFarkle
{
    int onesScore = 0;
    int twosScore = 0;
    int threesScore = 0;
    int foursScore = 0;
    int fivesScore = 0;
    int sixesScore = 0;

    for (int i = 0; i < self.arrayOfDiceValuesFromSecondRoll.count; i++)
    {
        NSLog(@"%@", self.arrayOfDiceValuesFromSecondRoll[i]);
        //NSLog(@"%ld", (long)[dieValue integerValue]);
        NSInteger number = [self.arrayOfDiceValuesFromSecondRoll[i] integerValue];
        if (number == 1)
        {
            onesScore++;
        }
        else if (number == 5)
        {
            fivesScore++;
        }
        else if (number == 2)
        {
            twosScore++;
        }
        else if (number == 3)
        {
            threesScore++;
        }
        else if (number == 4)
        {
            foursScore++;
        }
        else if (number == 6)
        {
            sixesScore++;
        }
    }
    if (twosScore > 2 || threesScore > 2 || foursScore > 2 || sixesScore > 2 || onesScore > 0 || fivesScore > 0) {
        // NO farkle
    }
//    else if (twosScore > 2 )
//    {
//        NSLog(@"Hot dice!");
//    }
    else
    {
        self.bankedScore.text = @"Banked Score: 0";
        [self clearBoard];
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"FARKLE!"
                                                           message:nil
                                                          delegate:self
                                                 cancelButtonTitle:nil
                                                 otherButtonTitles:nil, nil];
        alertView.delegate = self;
        [alertView show];

        [UIView animateWithDuration:2.0 animations:^{
            [alertView dismissWithClickedButtonIndex:0 animated:YES];
        }];
    }
}

- (void)generateUserScore:(DieLabel *)selectedDie
{
    NSInteger bankScore = 0;

    [self populateArraysOfSelectedDiceValues:self.arrayOfSelectedDiceValues selectedDie:selectedDie.text.integerValue];

    [self checkIfAllDiceAreSelected];

    int onesScore = 0;
    int twosScore = 0;
    int threesScore = 0;
    int foursScore = 0;
    int fivesScore = 0;
    int sixesScore = 0;

    self.numberOfScoringDiceSelected = 0;

    for (int i = 0; i < self.arrayOfSelectedDiceValues.count; i++)
    {
        switch (i)
        {
            case 0:
                if ([[self.arrayOfSelectedDiceValues objectAtIndex:i] integerValue] == 1)
                {
                    onesScore = onesScore + 100;
                    self.numberOfScoringDiceSelected ++;
                }
                else if ([[self.arrayOfSelectedDiceValues objectAtIndex:i] integerValue] == 2)
                {
                    onesScore = onesScore + 200;
                    self.numberOfScoringDiceSelected = self.numberOfScoringDiceSelected + 2;
                }
                else if ([[self.arrayOfSelectedDiceValues objectAtIndex:i] integerValue] == 3)
                {
                    onesScore = onesScore + 1000;
                    self.numberOfScoringDiceSelected = self.numberOfScoringDiceSelected + 3;
                }
                else if ([[self.arrayOfSelectedDiceValues objectAtIndex:i] integerValue] == 4)
                {
                    onesScore = onesScore + 2000;
                    self.numberOfScoringDiceSelected = self.numberOfScoringDiceSelected + 4;
                }
                else if ([[self.arrayOfSelectedDiceValues objectAtIndex:i] integerValue] == 5)
                {
                    onesScore = onesScore + 4000;
                    self.numberOfScoringDiceSelected = self.numberOfScoringDiceSelected + 4;
                }
                else if ([[self.arrayOfSelectedDiceValues objectAtIndex:i] integerValue] == 6)
                {
                    onesScore = onesScore + 8000;
                    self.numberOfScoringDiceSelected = self.numberOfScoringDiceSelected + 6;
                }
                break;
            case 1:
                if ([[self.arrayOfSelectedDiceValues objectAtIndex:i] integerValue] == 3)
                {
                    twosScore = twosScore + 200;
                    self.numberOfScoringDiceSelected = self.numberOfScoringDiceSelected + 3;
                }
                else if ([[self.arrayOfSelectedDiceValues objectAtIndex:i] integerValue] == 4)
                {
                    twosScore = twosScore + 400;
                    self.numberOfScoringDiceSelected = self.numberOfScoringDiceSelected + 4;
                }
                else if ([[self.arrayOfSelectedDiceValues objectAtIndex:i] integerValue] == 5)
                {
                    twosScore = twosScore + 800;
                    self.numberOfScoringDiceSelected = self.numberOfScoringDiceSelected + 5;
                }
                else if ([[self.arrayOfSelectedDiceValues objectAtIndex:i] integerValue] == 6)
                {
                    twosScore = twosScore + 1600;
                    self.numberOfScoringDiceSelected = self.numberOfScoringDiceSelected + 6;
                }
                break;
            case 2:
                if ([[self.arrayOfSelectedDiceValues objectAtIndex:i] integerValue] == 3)
                {
                    threesScore = threesScore + 300;
                    self.numberOfScoringDiceSelected = self.numberOfScoringDiceSelected + 3;
                }
                else if ([[self.arrayOfSelectedDiceValues objectAtIndex:i] integerValue] == 4)
                {
                    threesScore = threesScore + 600;
                    self.numberOfScoringDiceSelected = self.numberOfScoringDiceSelected + 4;
                }
                else if ([[self.arrayOfSelectedDiceValues objectAtIndex:i] integerValue] == 5)
                {
                    threesScore = threesScore + 1200;
                    self.numberOfScoringDiceSelected = self.numberOfScoringDiceSelected + 5;
                }
                else if ([[self.arrayOfSelectedDiceValues objectAtIndex:i] integerValue] == 6)
                {
                    threesScore = threesScore + 2400;
                    self.numberOfScoringDiceSelected = self.numberOfScoringDiceSelected + 6;
                }
                break;
            case 3:
                if ([[self.arrayOfSelectedDiceValues objectAtIndex:i] integerValue] == 3)
                {
                    foursScore = foursScore + 400;
                    self.numberOfScoringDiceSelected = self.numberOfScoringDiceSelected + 3;
                }
                else if ([[self.arrayOfSelectedDiceValues objectAtIndex:i] integerValue] == 4)
                {
                    foursScore = foursScore + 800;
                    self.numberOfScoringDiceSelected = self.numberOfScoringDiceSelected + 4;
                }
                else if ([[self.arrayOfSelectedDiceValues objectAtIndex:i] integerValue] == 5)
                {
                    foursScore = foursScore + 1600;
                    self.numberOfScoringDiceSelected = self.numberOfScoringDiceSelected + 5;
                }
                else if ([[self.arrayOfSelectedDiceValues objectAtIndex:i] integerValue] == 6)
                {
                    foursScore = foursScore + 3200;
                    self.numberOfScoringDiceSelected = self.numberOfScoringDiceSelected + 6;
                }
                break;
            case 4:
                if ([[self.arrayOfSelectedDiceValues objectAtIndex:i] integerValue] == 1)
                {
                    fivesScore = fivesScore + 50;
                    self.numberOfScoringDiceSelected ++;
                }
                else if ([[self.arrayOfSelectedDiceValues objectAtIndex:i] integerValue] == 2)
                {
                    fivesScore = fivesScore + 100;
                    self.numberOfScoringDiceSelected = self.numberOfScoringDiceSelected + 2;
                }
                else if ([[self.arrayOfSelectedDiceValues objectAtIndex:i] integerValue] == 3)
                {
                    fivesScore = fivesScore + 500;
                    self.numberOfScoringDiceSelected = self.numberOfScoringDiceSelected + 3;
                }
                else if ([[self.arrayOfSelectedDiceValues objectAtIndex:i] integerValue] == 4)
                {
                    fivesScore = fivesScore + 1000;
                    self.numberOfScoringDiceSelected = self.numberOfScoringDiceSelected + 4;
                }
                else if ([[self.arrayOfSelectedDiceValues objectAtIndex:i] integerValue] == 5)
                {
                    fivesScore = fivesScore + 2000;
                    self.numberOfScoringDiceSelected = self.numberOfScoringDiceSelected + 5;
                }
                else if ([[self.arrayOfSelectedDiceValues objectAtIndex:i] integerValue] == 6)
                {
                    fivesScore = fivesScore + 4000;
                    self.numberOfScoringDiceSelected = self.numberOfScoringDiceSelected + 6;
                }
                break;
            case 5:
                if ([[self.arrayOfSelectedDiceValues objectAtIndex:i] integerValue] == 3)
                {
                    sixesScore = sixesScore + 600;
                    self.numberOfScoringDiceSelected = self.numberOfScoringDiceSelected + 3;
                }
                else if ([[self.arrayOfSelectedDiceValues objectAtIndex:i] integerValue] == 4)
                {
                    sixesScore = sixesScore + 1200;
                    self.numberOfScoringDiceSelected = self.numberOfScoringDiceSelected + 4;
                }
                else if ([[self.arrayOfSelectedDiceValues objectAtIndex:i] integerValue] == 5)
                {
                    sixesScore = sixesScore + 2400;
                    self.numberOfScoringDiceSelected = self.numberOfScoringDiceSelected + 5;
                }
                else if ([[self.arrayOfSelectedDiceValues objectAtIndex:i] integerValue] == 6)
                {
                    sixesScore = sixesScore + 4800;
                    self.numberOfScoringDiceSelected = self.numberOfScoringDiceSelected + 6;
                }
                break;
            default:
                break;
        }
    }

    if (self.numberOfScoringDiceSelected == 6)
    {
        //NSLog(@"Hot Dice!");
    }

    bankScore = onesScore + twosScore + threesScore + foursScore + fivesScore + sixesScore;

    if ([self checkForThreePairs])
    {
        bankScore = 1000;
    }
    
    self.bankedScore.text = [NSString stringWithFormat:@"Banked Score: %@", @(bankScore).description];

    NSString *scoreInBank = [self getStringOfBankedScore];

    self.userScore.text   = [NSString stringWithFormat:@"Total Score: %@", scoreInBank];
    //self.bankedScore.text = @"Banked Score: 0";

    //[self clearBoard];
}

- (void)populateArraysOfSelectedDiceValues: (NSMutableArray *)arrayToFill selectedDie:(NSInteger)numberOnDieSelected
{
    int numberOfSelectedOnes   = 0;
    int numberOfSelectedTwos   = 0;
    int numberOfSelectedThrees = 0;
    int numberOfSelectedFours  = 0;
    int numberOfSelectedFives  = 0;
    int numberOfSelectedSixes  = 0;

    // Add the number of selected die at the index representing each die in the array self.selecedDie
    switch (numberOnDieSelected)
    {
        case 1:
            numberOfSelectedOnes = [[arrayToFill objectAtIndex:0] intValue];
            numberOfSelectedOnes = numberOfSelectedOnes + 1;
            [arrayToFill replaceObjectAtIndex:0 withObject:[NSNumber numberWithInt:numberOfSelectedOnes]];
            break;
        case 2:
            numberOfSelectedTwos = [[arrayToFill objectAtIndex:1] intValue];
            numberOfSelectedTwos = numberOfSelectedTwos + 1;
            [arrayToFill replaceObjectAtIndex:1 withObject:[NSNumber numberWithInt:numberOfSelectedTwos]];
            break;
        case 3:
            numberOfSelectedThrees = [[arrayToFill objectAtIndex:2] intValue];
            numberOfSelectedThrees = numberOfSelectedThrees + 1;
            [arrayToFill replaceObjectAtIndex:2 withObject:[NSNumber numberWithInt:numberOfSelectedThrees]];
            break;
        case 4:
            numberOfSelectedFours = [[arrayToFill objectAtIndex:3] intValue];
            numberOfSelectedFours = numberOfSelectedFours + 1;
            [arrayToFill replaceObjectAtIndex:3 withObject:[NSNumber numberWithInt:numberOfSelectedFours]];
            break;
        case 5:
            numberOfSelectedFives = [[arrayToFill objectAtIndex:4] intValue];
            numberOfSelectedFives = numberOfSelectedFives + 1;
            [arrayToFill replaceObjectAtIndex:4 withObject:[NSNumber numberWithInt:numberOfSelectedFives]];
            break;
        case 6:
            numberOfSelectedSixes = [[arrayToFill objectAtIndex:5] intValue];
            numberOfSelectedSixes = numberOfSelectedSixes + 1;
            [arrayToFill replaceObjectAtIndex:5 withObject:[NSNumber numberWithInt:numberOfSelectedSixes]];
            break;
        default:
            break;
    }
}

- (NSString *)getStringOfBankedScore
{
    // Scan string to find the : and take the value after it (the score)
    NSMutableArray *substrings = [[NSMutableArray alloc] init];
    NSScanner *scanner = [NSScanner scannerWithString:self.bankedScore.text];
    [scanner scanUpToString:@":" intoString:nil]; // Scan all characters before #
    while(![scanner isAtEnd])
    {
        NSString *substring = nil;
        [scanner scanString:@":" intoString:nil]; // Scan the # character
        if([scanner scanUpToString:@" " intoString:&substring])
        {
            // If the space immediately followed the #, this will be skipped
            [substrings addObject:substring];
        }
    }
    return [substrings objectAtIndex:0];
}

- (NSInteger)numberOfSelectedDice
{
    int selectedDieCounter = 0;
    for (DieLabel *die in self.dieOutletCollection)
    {
        if (die.selected)
        {
            selectedDieCounter ++;
        }
    }
    return selectedDieCounter;
}

- (BOOL)checkForThreePairs
{
    int threePairCounter = 0;
    // Check for three pairs
    for (int y = 0; y < self.arrayOfSelectedDiceValues.count; y++)
    {
        if ([[self.arrayOfSelectedDiceValues objectAtIndex:y] integerValue] == 2)
        {
            threePairCounter++;
        }
    }
    BOOL thereAreThreePairs = NO;
    if (threePairCounter == 3) {
        thereAreThreePairs = YES;
    }
    return thereAreThreePairs;
}

- (void)checkIfAllDiceAreSelected
{
    long diceSelectedCounter = 0;

    for (NSNumber *selected in self.arrayOfSelectedDiceValues)
    {
        if (selected.integerValue > 0 )
        {
            diceSelectedCounter = diceSelectedCounter + selected.integerValue;
        }
    }
    if (diceSelectedCounter == 6)
    {
        self.allDiceSelected = YES;
    }
    else
    {
        self.allDiceSelected = NO;
    }
}

- (int)getNumberOfNonScoringDiceSelected
{
    int nonScoringDiceCounter = 0;

    for (int i = 0; i < self.arrayOfSelectedDiceValues.count; i++)
    {
        if (i != 0 && i != 4)
        {
            if ([[self.arrayOfSelectedDiceValues objectAtIndex:i] integerValue] == 2)
            {
                nonScoringDiceCounter = nonScoringDiceCounter + 2;
            }
            else if ([[self.arrayOfSelectedDiceValues objectAtIndex:i] integerValue] == 1)
            {
                nonScoringDiceCounter++;
            }
        }
    }
    return nonScoringDiceCounter;
}

- (void)clearBoard
{
    UIColor *blueColor = [UIColor colorWithRed:(27.0/255.0) green:(228.0/255.0) blue:(255.0/255.0) alpha:1.0];

    for (DieLabel *die in self.dieOutletCollection)
    {
        [self removeDieFromSelectedDice:die];

        die.selected = NO;
        die.backgroundColor = blueColor;
    }
}

- (void)incrementSelectedScoringDice:(NSInteger)numberOfNewSelectedDice
{
    self.selectedScoreingDice = self.selectedScoreingDice + numberOfNewSelectedDice;
}

-(void)addSelectedDieToDice:(DieLabel *)die
{
    [self.dice addObject:die];
}

-(void)removeDieFromSelectedDice:(DieLabel *)die
{
    UIColor *blueColor = [UIColor colorWithRed:(27.0/255.0) green:(228.0/255.0) blue:(255.0/255.0) alpha:1.0];

    if (die.selected)
    {
        int index = die.text.intValue-1;
        if ([self.arrayOfSelectedDiceValues objectAtIndex:index] > 0)
        {
            // Decrement amount of selected items at the respective index in the array that keeps track of how many of each number
            // has been selected
            int numberOfSelects = [[self.arrayOfSelectedDiceValues objectAtIndex:index] intValue] - 1;
            [self.arrayOfSelectedDiceValues replaceObjectAtIndex:index withObject:[NSNumber numberWithInt:numberOfSelects]];
            // TODO decrement the score if a scoreing die is selected and then unselected
        }
    }
    NSLog(@"%@", self.arrayOfSelectedDiceValues);

    die.selected = NO;
    die.backgroundColor = blueColor;

    if ([self.dice containsObject:die])
    {
        [self.dice removeObject:die];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
@end
