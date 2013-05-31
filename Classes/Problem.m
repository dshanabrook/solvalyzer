//
//  Problem.m
//  Solvalyzer
//
//  Created by Andrew Hannon on 3/7/11.
//  Copyright 2011 Diabolical Labs, LLC. All rights reserved.
//

#include <stdlib.h>
#import "Problem.h"

@interface Problem()
@property (nonatomic, strong) ProblemSolution *solution;
@end

@implementation Problem

@synthesize solution;
@synthesize problemDisplayTime;
@synthesize problemSubmitTime;
@dynamic problemID;


- (id)init {
  if (self =[super init]) {
  }
  return self;
}

+ (Problem*)problem {
  return [[Problem alloc] init];
}


- (long)problemID {
  return (long)floor([problemDisplayTime timeIntervalSinceReferenceDate]);
}

- (void)problemDisplayed {
  problemDisplayTime = [[NSDate alloc] init];
}

- (void)solutionSubmitted:(ProblemSolution*)sol {
  self.solution = sol;
  problemSubmitTime = [[NSDate alloc] init];
}
- (NSNumber*)timeSinceProblemDisplay:(NSDate*)d {
  return @([d timeIntervalSinceDate:problemDisplayTime]);
}

@end
