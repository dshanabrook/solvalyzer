//
//  SolutionStroke.m
//  Solvalyzer
//
//  Created by Andrew Hannon on 3/7/11.
//  Copyright 2011 Diabolical Labs, LLC. All rights reserved.
//

#import "SolutionStroke.h"

@interface SolutionStroke()
@property (nonatomic, strong) NSDate *startTime;
@property (nonatomic, strong) NSDate *endTime;
@end

@implementation SolutionStroke

@synthesize startTime;
@synthesize endTime;

+ (SolutionStroke*)solutionStroke {
  return [[SolutionStroke alloc] init];
}


- (void)beginStroke {
  solutionPoints = [[NSMutableArray alloc] init];
  self.startTime = [NSDate date];
}

- (void)addSolutionPoint:(SolutionPoint*)point {
  [solutionPoints addObject:point];
}

- (void)endStroke {
  self.endTime = [NSDate date];
}

- (void)mapSolutionPoints:(SolutionPointBlock)block {
  NSUInteger count=0;
  for (SolutionPoint *point in solutionPoints) {
    block(point, count);
    count++;
  }
}
@end
