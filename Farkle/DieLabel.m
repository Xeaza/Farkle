//
//  DieLabel.m
//  Farkle
//
//  Created by Taylor Wright-Sanson on 10/8/14.
//  Copyright (c) 2014 Taylor Wright-Sanson. All rights reserved.
//

#import "DieLabel.h"

@implementation DieLabel


-(IBAction)onTapped:(UITapGestureRecognizer *)tapGesture
{
    //[self roll];
    self.backgroundColor = [UIColor greenColor];
    [self.delegate addSelectedDieToDice:self];
}

-(void)roll
{
    int randomNUmber = arc4random_uniform(6) + 1;
    self.text = @(randomNUmber).description;
}

@end
