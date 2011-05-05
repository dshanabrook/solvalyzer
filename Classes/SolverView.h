//
//  SolverView.h
//  Solvalyzer
//
//  Created by Andrew Hannon on 3/7/11.
//  Copyright 2011 Diabolical Labs, LLC. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreMotion/CoreMotion.h>

@interface SolverView : UIView {
#warning See the documentation about why this solution does not scale
  CMMotionManager *motionManager;
}

@end
