//
//  ProblemStore.h
//  Solvalyzer
//
//  Created by Andrew Hannon on 3/7/11.
//  Copyright 2011 Diabolical Labs, LLC. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreMotion/CoreMotion.h>
#import "ProblemSolution.h"

@class SolutionStroke;
@class Problem ;

typedef void(^ProblemBlock)(Problem *problem);

@interface ProblemStore : NSObject {
  Problem *currentProblem;
  ProblemSolution *currentSolution;
  SolutionStroke *currentStroke;
  NSDate *startTime;
  NSMutableArray *allProblems;
}

@property (nonatomic, strong, readonly) Problem *currentProblem;
@property (nonatomic, strong, readonly) ProblemSolution *currentSolution;
@property (nonatomic, strong, readonly) SolutionStroke *currentStroke;
@property (nonatomic, strong, readonly) NSDate *startTime;

+ (ProblemStore*)sharedProblemStore;

- (long)uniqueID;

- (Problem*)newProblem;
- (void)problemDisplayed;
- (void)strokeStartedAtPoint:(CGPoint)p 
            withAcceleration:(CMAcceleration)accel;
- (void)strokeContinuedAtPoint:(CGPoint)p
              withAcceleration:(CMAcceleration)accel;
- (void)strokeCompletedAtPoint:(CGPoint)p
              withAcceleration:(CMAcceleration)accel;
- (void)strokeCancelled;
- (void)solutionSubmitted;

- (void)mapCurrentSolutionStrokes:(SolutionStrokeBlock)block;
- (void)mapAllProblems:(ProblemBlock)block;

- (void)resetProblemStore;

- (NSData*)problemStoreToData;

@end
