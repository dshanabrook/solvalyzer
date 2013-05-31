//
//  SolutionPoint.m
//  Solvalyzer
//
//  Created by Andrew Hannon on 3/7/11.
//  Copyright 2011 Diabolical Labs, LLC. All rights reserved.
//

#import "SolutionPoint.h"


@implementation SolutionPoint

@synthesize solutionPoint;
@synthesize solutionAcceleration;
@synthesize strokeTime;

- (id)initWithSolutionPoint:(CGPoint)p 
           withAcceleration:(CMAcceleration)accel
                     atTime:(NSDate*)t {
  if (self=[self init]) {
    solutionPoint = p;
    solutionAcceleration = accel;
    strokeTime = t;
  }
  return self;
}

+ (SolutionPoint*)solutionPoint:(CGPoint)p 
               withAcceleration:(CMAcceleration)accel
                         atTime:(NSDate*)strokeTime {
  return [[SolutionPoint alloc] initWithSolutionPoint:p 
                                      withAcceleration:accel
                                                atTime:strokeTime];
}


@end
