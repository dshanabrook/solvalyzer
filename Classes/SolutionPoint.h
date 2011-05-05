//
//  SolutionPoint.h
//  Solvalyzer
//
//  Created by Andrew Hannon on 3/7/11.
//  Copyright 2011 Diabolical Labs, LLC. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreMotion/CoreMotion.h>

@interface SolutionPoint : NSObject {
  CGPoint solutionPoint;
  CMAcceleration solutionAcceleration;
  NSDate *strokeTime;
}

@property (readonly) CGPoint solutionPoint;
@property (readonly) CMAcceleration solutionAcceleration;
@property (nonatomic, readonly) NSDate *strokeTime;

- (id)initWithSolutionPoint:(CGPoint)p
           withAcceleration:(CMAcceleration)accel
                     atTime:(NSDate*)strokeTime;
+ (SolutionPoint*)solutionPoint:(CGPoint)p 
               withAcceleration:(CMAcceleration)accel
                         atTime:(NSDate*)strokeTime;

@end
