//
//  ProblemStore.m
//  Solvalyzer
//
//  Created by Andrew Hannon on 3/7/11.
//  Copyright 2011 Diabolical Labs, LLC. All rights reserved.
//
#import "questions.h"
#import "Problem.h"
#import "ProblemSolution.h"
#import "SolutionStroke.h"
#import "SolutionPoint.h"
#import "ProblemStore.h"

#warning  why was this here?  commented out and changed in .h getting rid of readonly
#warning possible danger!
@interface ProblemStore()
@property (nonatomic, strong) Problem *currentProblem;
@property (nonatomic, strong) ProblemSolution *currentSolution;
@property (nonatomic, strong) SolutionStroke *currentStroke;
@property (nonatomic, strong) NSDate *startTime;
@end

@implementation ProblemStore

//@synthesize currentImageIndex;
@synthesize currentProblem;
@synthesize currentSolution;
@synthesize currentStroke;
@synthesize startTime;

- (id)init {
  if (self=[super init]) {
    allProblems = [[NSMutableArray alloc] init];
  }
  return self;
}


+ (ProblemStore*)sharedProblemStore {
  static ProblemStore *store = nil;
  @synchronized([ProblemStore class]) {
    if (! store) {
      store = [[ProblemStore alloc] init];
    }
  }
  return store;
}

- (long)uniqueID {
  return (long)floor([startTime timeIntervalSinceReferenceDate]);
}

- (Problem*)newProblem {
  if (! startTime) {
    self.startTime = [NSDate date];
  }
  self.currentProblem = [Problem problem];
  self.currentSolution = [ProblemSolution problemSolution];
  return self.currentProblem;
}

- (void)problemDisplayed {
  [self.currentProblem problemDisplayed]; 
}

- (void)strokeStartedAtPoint:(CGPoint)p 
            withAcceleration:(CMAcceleration)accel {
  if ([self.currentSolution strokeCount] == 0) {
    [self.currentSolution beginProblemSolution];
  }
  self.currentStroke = [SolutionStroke solutionStroke];
  [self.currentStroke beginStroke];
  SolutionPoint *sp = [SolutionPoint solutionPoint:p withAcceleration:accel atTime:[NSDate date]];
  [self.currentStroke addSolutionPoint:sp];
}

- (void)strokeContinuedAtPoint:(CGPoint)p
              withAcceleration:(CMAcceleration)accel {
  SolutionPoint *sp = [SolutionPoint solutionPoint:p withAcceleration:accel atTime:[NSDate date]];
  [self.currentStroke addSolutionPoint:sp];
}

- (void)strokeCompletedAtPoint:(CGPoint)p
              withAcceleration:(CMAcceleration)accel {
  SolutionPoint *sp = [SolutionPoint solutionPoint:p withAcceleration:accel atTime:[NSDate date]];
  [self.currentStroke addSolutionPoint:sp];
  [self.currentStroke endStroke];
  [self.currentSolution addSolutionStroke:self.currentStroke];
  self.currentStroke = nil;
}

- (void)strokeCancelled {
  self.currentStroke = nil;
}

- (void)solutionSubmitted {
  [self.currentSolution endProblemSolution];
  [self.currentProblem solutionSubmitted:self.currentSolution];
  [allProblems addObject:self.currentProblem];
  self.currentSolution = nil;
  self.currentStroke = nil;
}

- (void)resetProblemStore {
  self.currentProblem = nil;
  self.currentSolution = nil;
  self.currentStroke = nil;
  self.startTime = nil;
  allProblems = [[NSMutableArray alloc] init];
}

- (void)mapCurrentSolutionStrokes:(SolutionStrokeBlock)block {
  [self.currentSolution mapSolutionStrokes:block];
  block(self.currentStroke, [self.currentSolution strokeCount]);
}

- (void)mapAllProblems:(ProblemBlock)block {
  for (Problem *problem in allProblems) {
    block(problem);
  }
}

- (NSData*)problemStoreToData {
NSLog(@"probleStoreToData");
#warning Quick hacked approach: 
  __unsafe_unretained NSMutableArray *rows = [NSMutableArray array];
  NSArray *header = @[@"solutionImageName",
                     @"problemImageIndex",
                     @"solutionCorrect",
                     @"correctnessLevel",
                     @"problemSubmitTimeDelta",
                     @"solutionStartTime",
                     @"solutionSubmitTime",
                     @"strokeStartTime",
                     @"strokeEndTime",
                     @"x", @"y", @"pointTime",
                     @"accel_x", @"accel_y", @"accel_z"];
  [rows addObject:[header componentsJoinedByString:@","]];
  for (Problem *problem in allProblems) {
    // solutionImageName
      //problemImageIndex
      //solutionCorrect
      //correctneLevel
    // problemDisplayTime
    // problemSubmitTime 
    // [solution]startTime
    // [solution]endTime
    // [stroke]startTime
    // [stroke]endTime
    // solutionPoint;
    // strokeTime;
    // accelerometer
    [problem.solution mapSolutionStrokes:^(SolutionStroke *stroke, NSUInteger strokeNum) {
      [stroke mapSolutionPoints:^(SolutionPoint *p, NSUInteger pNum) {
        NSMutableArray *d = [NSMutableArray array];
        [d addObject:problem.solution.solutionImageName];
          [d addObject:problem.solution.problemImageIndex];
          [d addObject:problem.solution.solutionCorrect];
#warning either have to add student model to problem (wrong!) or better just access the singleton value here.  But then this should also be done for the problemImageIndex, removing it and accessing the singleton directly.
          [d addObject:problem.solution.correctnessLevel];
        [d addObject:[problem timeSinceProblemDisplay:problem.problemSubmitTime]];
        [d addObject:[problem timeSinceProblemDisplay:problem.solution.startTime]];
        [d addObject:[problem timeSinceProblemDisplay:problem.solution.endTime]];
        [d addObject:[problem timeSinceProblemDisplay:stroke.startTime]];
        [d addObject:[problem timeSinceProblemDisplay:stroke.endTime]];
        [d addObject:@(p.solutionPoint.x)];
        [d addObject:@(p.solutionPoint.y)];
        [d addObject:[problem timeSinceProblemDisplay:p.strokeTime]];
        [d addObject:@(p.solutionAcceleration.x)];
        [d addObject:@(p.solutionAcceleration.y)];
        [d addObject:@(p.solutionAcceleration.z)];
        [rows addObject:[d componentsJoinedByString:@","]];
      }];
    }];
  }
  NSString *stringData = [rows componentsJoinedByString:@"\n"];
  return [stringData dataUsingEncoding:NSUTF8StringEncoding];
}

@end
