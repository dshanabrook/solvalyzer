//
//  SolvalyzerRootViewController.m
//  Solvalyzer
//
//  Created by Andrew Hannon on 3/8/11.
//  Copyright 2011 Diabolical Labs, LLC. All rights reserved.
//

#import "questions.h"
#import "ProblemStore.h"
#import "Problem.h"
#import "ProblemSolution.h"
#import "SolvalyzerRootViewController.h"


@interface SolvalyzerRootViewController()
- (void)presentSolvalyzer;
@end

@implementation SolvalyzerRootViewController

@synthesize restartButton;
//@synthesize initializeQuestionsButton;

- (void)presentSolvalyzer {
  self.restartButton.hidden = YES;
  SolvalyzerViewController *c = [[SolvalyzerViewController alloc] initWithNibName:@"SolvalyzerViewController" bundle:nil];
  c.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
  c.solvalyzerDelegate = self;
[self presentModalViewController:c animated:YES];
  [c release];
}

- (IBAction)restartSolvalyzer:(id)sender {
  [[ProblemStore sharedProblemStore] resetProblemStore]; 
  [self presentSolvalyzer];
}


- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation {
  return YES;
}

////////////////////////////////////////
// SolvalyzerViewControllerDelegate
////////////////////////////////////////

- (void)solvalyzerControllerSolved:(SolvalyzerViewController*)controller {
  [self dismissModalViewControllerAnimated:NO];
  [self presentSolvalyzer];
}

- (void)solvalyzerControllerQuit:(SolvalyzerViewController*)controller {
  [self dismissModalViewControllerAnimated:NO];
  
  __block MFMailComposeViewController *c = [[MFMailComposeViewController alloc] init];
  long problemSetID = [[ProblemStore sharedProblemStore] uniqueID];
  [c setSubject:[NSString stringWithFormat:@"Problem Set %ld", problemSetID]];
  NSData *seriesData = [[ProblemStore sharedProblemStore] problemStoreToData];
  [c addAttachmentData:seriesData mimeType:@"text/csv" 
              fileName:[NSString stringWithFormat:@"problem-set-%ld.csv", problemSetID]];
  
  [[ProblemStore sharedProblemStore] mapAllProblems:^(Problem *p) {
    UIImage *image = [UIImage imageWithContentsOfFile:[p.solution solutionImagePath]];
    [c addAttachmentData:UIImagePNGRepresentation(image) mimeType:@"image/png" fileName:p.solution.solutionImageName];
  }];
  
  [c setToRecipients:[NSArray arrayWithObject:@"davidshanabrook@me.com"]];
  
  [self presentModalViewController:c animated:YES];
  c.mailComposeDelegate = self;
  [c release];
}

////////////////////////////////////////
// MFMailComposeViewControllerDelegate
////////////////////////////////////////

- (void)mailComposeController:(MFMailComposeViewController*)controller 
          didFinishWithResult:(MFMailComposeResult)result 
                        error:(NSError*)error {
  [self dismissModalViewControllerAnimated:YES];
  self.restartButton.hidden = NO; 
}

@end
