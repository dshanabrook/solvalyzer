//
//  SolvalyzerViewController.h
//  Solvalyzer
//
//  Created by Andrew Hannon on 3/7/11.
//  Copyright 2011 Diabolical Labs, LLC. All rights reserved.
//

#import <UIKit/UIKit.h>

@class SolverView;
@class SolvalyzerViewController;

@protocol SolvalyzerViewControllerDelegate<NSObject>
- (void)solvalyzerControllerSolved:(SolvalyzerViewController*)controller;
- (void)solvalyzerControllerQuit:(SolvalyzerViewController*)controller;
@end

@interface SolvalyzerViewController : UIViewController 
{
  IBOutlet id<SolvalyzerViewControllerDelegate> solvalyzerDelegate;
  IBOutlet UIImageView *problemView;
  IBOutlet SolverView *solverView;
  IBOutlet UIImageView *scaleKludgeView;
}
@property (nonatomic, retain) IBOutlet UIImageView *problemView;
@property (nonatomic, retain) IBOutlet SolverView *solverView;
@property (nonatomic, retain) IBOutlet UIImageView *scaleKludgeView;
@property (nonatomic, assign) IBOutlet id<SolvalyzerViewControllerDelegate> solvalyzerDelegate;


- (IBAction)finalizeSolution:(id)sender;
- (IBAction)quitSolving:(id)sender;
//- (IBAction)setQuestions:(id)sender;


@end
