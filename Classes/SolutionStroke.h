//
//  SolutionStroke.h
//  Solvalyzer
//
//  Created by Andrew Hannon on 3/7/11.
//  Copyright 2011 Diabolical Labs, LLC. All rights reserved.
//

#import <Foundation/Foundation.h>

@class SolutionPoint;

typedef void(^SolutionPointBlock)(SolutionPoint *point, NSUInteger pointNum);

@interface SolutionStroke : NSObject {
  NSDate *startTime;
  NSDate *endTime;
  NSMutableArray *solutionPoints;
}

@property (nonatomic, strong, readonly) NSDate *startTime;
@property (nonatomic, strong, readonly) NSDate *endTime;

+ (SolutionStroke*)solutionStroke;

- (void)beginStroke;
- (void)addSolutionPoint:(SolutionPoint*)point;
- (void)endStroke;

- (void)mapSolutionPoints:(SolutionPointBlock)block;

@end
