//
//  DieLabel.h
//  Farkle
//
//  Created by Taylor Wright-Sanson on 10/8/14.
//  Copyright (c) 2014 Taylor Wright-Sanson. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol DieLabelDelegate

- (void)addSelectedDieToDice:(id)die;

@end

@interface DieLabel : UILabel

-(void)roll;

@property id<DieLabelDelegate> delegate;

@end
