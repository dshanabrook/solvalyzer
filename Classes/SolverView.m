//
//  SolverView.m
//  Solvalyzer
//
//  Created by Andrew Hannon on 3/7/11.
//  Copyright 2011 Diabolical Labs, LLC. All rights reserved.
//

#import "SolutionPoint.h"
#import "SolutionStroke.h"
#import "ProblemStore.h"
#import "SolverView.h"

@implementation SolverView

- (void)dealloc {
  [motionManager release];
  [super dealloc];
}

- (void)drawStroke:(SolutionStroke*)stroke inContext:(CGContextRef)context {
  CGContextBeginPath(context);  
  [stroke mapSolutionPoints:^(SolutionPoint *point, NSUInteger pointNum) {
    if (pointNum == 0) {
      CGContextMoveToPoint(context, point.solutionPoint.x, point.solutionPoint.y);
    } else {
      CGContextAddLineToPoint(context, point.solutionPoint.x, point.solutionPoint.y);
    }
  }];
  CGContextStrokePath(context);  
}

- (void)drawRect:(CGRect)rect {
  __block CGContextRef context = UIGraphicsGetCurrentContext();
  CGContextSaveGState(context);
  CGContextSetStrokeColorWithColor(context, [[UIColor blackColor] CGColor]);
  CGContextSetLineWidth(context, 4.0f);
  CGContextSetLineCap(context, kCGLineCapRound);
  CGContextSetLineJoin(context, kCGLineJoinRound);
  [[ProblemStore sharedProblemStore] mapCurrentSolutionStrokes:^(SolutionStroke *stroke, NSUInteger strokeNum) {
    [self drawStroke:stroke inContext:context];
  }];
  CGContextRestoreGState(context);
}

////////////////////////////////////////
// Touch Handling
////////////////////////////////////////

- (void)touchesBegan:(NSSet *)touches 
           withEvent:(UIEvent *)event {
  if (! motionManager) {
    motionManager = [[CMMotionManager alloc] init];
  }

#warning We may not want to start/stop accelerometer updates in this fashion
  [motionManager startAccelerometerUpdates];
  UITouch *touch = [touches anyObject];
  [[ProblemStore sharedProblemStore] strokeStartedAtPoint:[touch locationInView:self]
                                         withAcceleration:motionManager.accelerometerData.acceleration];
  [self setNeedsDisplay];
}

- (void)touchesMoved:(NSSet *)touches 
           withEvent:(UIEvent *)event {
  UITouch *touch = [touches anyObject];
  [[ProblemStore sharedProblemStore] strokeContinuedAtPoint:[touch locationInView:self]
                                           withAcceleration:motionManager.accelerometerData.acceleration];
  [self setNeedsDisplay];
}

- (void)touchesEnded:(NSSet *)touches 
           withEvent:(UIEvent *)event {
  UITouch *touch = [touches anyObject];
  [[ProblemStore sharedProblemStore] strokeCompletedAtPoint:[touch locationInView:self]
                                           withAcceleration:motionManager.accelerometerData.acceleration];
#warning See warning above start/stopping accelerometer updates
  [motionManager stopAccelerometerUpdates]; 
  [self setNeedsDisplay];
}

- (void)touchesCancelled:(NSSet *)touches 
               withEvent:(UIEvent *)event {
  [[ProblemStore sharedProblemStore] strokeCancelled];
  [self setNeedsDisplay];
}

@end
