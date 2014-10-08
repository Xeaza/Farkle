//
//  DieLabel.m
//  Farkle
//
//  Created by Taylor Wright-Sanson on 10/8/14.
//  Copyright (c) 2014 Taylor Wright-Sanson. All rights reserved.
//

#import "DieLabel.h"

@interface DieLabel ()

@property BOOL selected;

@end

@implementation DieLabel

-(IBAction)onTapped:(UITapGestureRecognizer *)tapGesture
{
    UIColor *blueColor = [UIColor colorWithRed:(27.0/255.0) green:(228.0/255.0) blue:(255.0/255.0) alpha:1.0];
    UIColor *purpleColor = [UIColor colorWithRed:(76.0/255.0) green:(54.0/255.0) blue:(107.0/255.0) alpha:1.0];

    if (self.selected == NO) {
        [self.delegate addSelectedDieToDice:self];
        self.backgroundColor = purpleColor;
        self.selected = YES;
    }
    else
    {
        [self.delegate removeSelectedDieToDice:self];
        self.selected = NO;
        self.backgroundColor = blueColor;
    }
}

-(void)roll
{
    int randomNUmber = arc4random_uniform(6) + 1;
    self.text = @(randomNUmber).description;
}

@end
