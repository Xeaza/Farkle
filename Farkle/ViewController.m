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
@property (weak, nonatomic) IBOutlet UILabel *scoreLabel;

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.dice = [[NSMutableArray alloc] init];
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

-(void)addSelectedDieToDice:(DieLabel *)die
{
    [self.dice addObject:die];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
@end
