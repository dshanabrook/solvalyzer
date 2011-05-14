//
//  ProblemSolution.h
//  Solvalyzer
//
//  Created by Andrew Hannon on 3/7/11.
//  Copyright 2011 Diabolical Labs, LLC. All rights reserved.
//

#import <Foundation/Foundation.h>

@class SolutionStroke;

typedef void(^SolutionStrokeBlock)(SolutionStroke *stroke, NSUInteger strokeNum);

@interface ProblemSolution : NSObject {
  NSString *solutionImageName;
//    NSNumber *problemImageIndex;
    NSString *solutionCorrect;
  NSMutableArray *solutionStrokes;
  NSDate *startTime;
  NSDate *endTime;
}

@property (nonatomic, retain, readonly) NSDate *startTime;
@property (nonatomic, retain, readonly) NSDate *endTime;
@property (nonatomic, retain) NSString *solutionImageName;
@property (nonatomic, retain) NSString *solutionCorrect;
//@property (nonatomic, retain) NSNumber *problemImageIndex;
+ (ProblemSolution*)problemSolution;

- (void)beginProblemSolution;
- (void)addSolutionStroke:(SolutionStroke*)stroke;
- (void)endProblemSolution;

- (void)mapSolutionStrokes:(SolutionStrokeBlock)block;
- (NSUInteger)strokeCount;

#warning kludge
- (NSString*)solutionImagePath;

@end
