//
//  Problem.h
//  Solvalyzer
//
//  Created by Andrew Hannon on 3/7/11.
//  Copyright 2011 Diabolical Labs, LLC. All rights reserved.
//

#import <Foundation/Foundation.h>

@class ProblemSolution;

@interface Problem : NSObject {
  ProblemSolution *solution;
    NSNumber *problemImageIndex;
  NSDate *problemDisplayTime;
  NSDate *problemSubmitTime;
//    int problemImageIndex;
}
@property (nonatomic, readonly) NSNumber *problemImageIndex;
@property (nonatomic, readonly) NSDate *problemDisplayTime;
@property (nonatomic, readonly) NSDate *problemSubmitTime;
@property (nonatomic, retain, readonly) ProblemSolution *solution;
@property (readonly) long problemID;
//@property (assign) int problemImageIndex;


+ (Problem*)problem;

- (void)problemDisplayed;
- (void)solutionSubmitted:(ProblemSolution*)solution;

- (NSNumber*)timeSinceProblemDisplay:(NSDate*)d;

@end
