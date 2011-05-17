//
//  SolvalyzerViewController.m
//  Solvalyzer
//
//  Created by Andrew Hannon on 3/7/11.
//  Copyright 2011 Diabolical Labs, LLC. All rights reserved.
//

#import <QuartzCore/QuartzCore.h>
#import "questions.h"
#import "ProblemStore.h"
#import "Problem.h"
#import "SolverView.h"
#import "SolvalyzerViewController.h"

@implementation SolvalyzerViewController

@synthesize problemView;
@synthesize solverView;
@synthesize scaleKludgeView;
@synthesize solvalyzerDelegate;

#warning was this release the problem?
- (void)dealloc {
  [problemView release];
  [solverView release];
  [scaleKludgeView release];
  [super dealloc];
}

- (void)viewDidLoad {
  [super viewDidLoad];
  [[NSBundle mainBundle] loadNibNamed:@"ImageScaleKludgeView" owner:self options:nil];

}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    Problem *problem = [[ProblemStore sharedProblemStore] newProblem];
    Questions *current = [Questions sharedQuestions];
    [current incCurrentQuestion];
    problemView.image = [UIImage imageWithData:[[current questionImages]  objectAtIndex:[current currentQuestion]]];
}


- (void)viewDidAppear:(BOOL)animated {
  [super viewDidAppear:animated];  
  [[ProblemStore sharedProblemStore] problemDisplayed];
}

- (void)viewDidUnload {
#warning again is this correct?
 self.problemView = nil;
  self.solverView = nil;
  self.scaleKludgeView = nil;
  [super viewDidUnload];
}


- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation {
  return YES;
}

////////////////////////////////////////
// Actions
////////////////////////////////////////

- (void)writeSolutionImage: (id)isCorrect { 
  UIGraphicsBeginImageContext(self.view.bounds.size);
  [self.view.layer renderInContext:UIGraphicsGetCurrentContext()];
  UIImage *viewImage = UIGraphicsGetImageFromCurrentImageContext();
  UIGraphicsEndImageContext();
  
  self.scaleKludgeView.image = viewImage;
  UIGraphicsBeginImageContext(self.scaleKludgeView.bounds.size);
  [self.scaleKludgeView.layer renderInContext:UIGraphicsGetCurrentContext()];
  viewImage = UIGraphicsGetImageFromCurrentImageContext();
  UIGraphicsEndImageContext();
  
  ProblemSolution *currentSolution = [[ProblemStore sharedProblemStore] currentSolution];
  NSString *filename = [NSString stringWithFormat:@"solution-%ld.png", 
                        [[[ProblemStore sharedProblemStore] currentProblem] problemID]];
  currentSolution.solutionCorrect = isCorrect;
#warning set problemImageIndex here
    Questions *current = [Questions sharedQuestions];
    int x = [current currentQuestion];
  currentSolution.problemImageIndex =  [NSNumber numberWithInteger:x];
  currentSolution.solutionImageName = filename;
  NSData *data = UIImagePNGRepresentation(viewImage);
  [data writeToFile:[currentSolution solutionImagePath] atomically:YES];
}

- (IBAction)finalizeSolution:(id)sender {
   NSString *title = [sender titleForState:UIControlStateNormal];
    [self writeSolutionImage:title];
  [[ProblemStore sharedProblemStore] solutionSubmitted];
  [solvalyzerDelegate solvalyzerControllerSolved:self];
}

- (IBAction)quitSolving:(id)sender {
   NSString *title = [sender titleForState:UIControlStateNormal];
#warning Treating 'quit' like solution!
    [self writeSolutionImage:title];
  [[ProblemStore sharedProblemStore] solutionSubmitted];
  [solvalyzerDelegate solvalyzerControllerQuit:self];
}



@end
