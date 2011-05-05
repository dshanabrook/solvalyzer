//
//  ProblemSolution.m
//  Solvalyzer
//
//  Created by Andrew Hannon on 3/7/11.
//  Copyright 2011 Diabolical Labs, LLC. All rights reserved.
//

#import "ProblemSolution.h"

@interface ProblemSolution()
@property (nonatomic, retain) NSDate *startTime;
@property (nonatomic, retain) NSDate *endTime;
@end

@implementation ProblemSolution

@synthesize startTime;
@synthesize endTime;
@synthesize solutionImageName;
@synthesize solutionCorrect;
@synthesize problemImageIndex;


- (void)dealloc {
  [solutionImageName release];
  [solutionCorrect release];
  [startTime release];
  [endTime release];
  [super dealloc];
}

+ (ProblemSolution*)problemSolution {
  return [[[ProblemSolution alloc] init] autorelease];
}

- (void)beginProblemSolution {
  self.startTime = [NSDate date];
  [solutionStrokes release];
  solutionStrokes = [[NSMutableArray alloc] init];
}

- (void)addSolutionStroke:(SolutionStroke*)stroke {
  [solutionStrokes addObject:stroke];
}

- (void)endProblemSolution {
  self.endTime = [NSDate date];
}

- (void)mapSolutionStrokes:(SolutionStrokeBlock)block {
  NSUInteger strokeNum=0;
  for (SolutionStroke *stroke in solutionStrokes) {
    block(stroke, strokeNum);
    strokeNum++;
  }
}

- (NSUInteger)strokeCount {
  return [solutionStrokes count];
}

#warning Kludge part 2
- (NSString*)documentsDirectory {
  return [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
}

- (NSString*)solutionImagePath {
#warning Kludge part 3
  return [[self documentsDirectory] stringByAppendingPathComponent:solutionImageName];
}

@end
