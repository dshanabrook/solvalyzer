//
//  SolvalyzerViewController.m
//  Solvalyzer
//
//  Created by Andrew Hannon on 3/7/11.
//  Copyright 2011 Diabolical Labs, LLC. All rights reserved.
//

#import <QuartzCore/QuartzCore.h>
#import "studentModel.h"
#import "questions.h"
#import "ProblemStore.h"
#import "Problem.h"
#import "SolverView.h"
#import "SolvalyzerViewController.h"
#import "SolvalyzerRootViewController.h"
#define SCROLL_AMOUNT 200

@implementation SolvalyzerViewController


@synthesize problemView;
@synthesize solverView;
@synthesize scaleKludgeView;
@synthesize solvalyzerDelegate;

#warning was this release the problem?
- (void)dealloc {
    NSLog(@"dealloc");
  [problemView release];
  [solverView release];
  [scaleKludgeView release];
  [super dealloc];
}


- (void)viewDidLoad {
    NSLog(@"viewDidLoad");
    self.view.frame=CGRectMake(0, 0, 1024, 2000);
    self.view.bounds=CGRectMake(0, 0, 1024, 2000);
    self.scrollView.frame=self.view.frame;
    self.scrollView.bounds=CGRectMake(0, 0, 1024, 2000);
    self.scrollView.contentSize=self.scrollView.frame.size;
    self.solverView.frame=self.scrollView.frame;
    self.solverView.bounds=CGRectMake(0, 0, 1024, 2000);
        //dhs, these add scrollbar and two finger scroll but only work in a limited area
        // [self.scrollView showsVerticalScrollIndicator];
        //self.scrollView.panGestureRecognizer.minimumNumberOfTouches = 2;

    [self.scrollView addSubview:self.solverView];
    [self.view addSubview:self.scrollView];
    
    
    
    [super viewDidLoad];

    
    [[NSBundle mainBundle] loadNibNamed:@"ImageScaleKludgeView" owner:self options:nil];


}

- (void)viewWillAppear:(BOOL)animated {
    NSLog(@"viewWillAppear");
    [super viewWillAppear:animated];
    Problem *problem = [[ProblemStore sharedProblemStore] newProblem];
    [[Questions sharedQuestions]incCurrentQuestion];
    problemView.image = [UIImage imageWithData:[[Questions sharedQuestions] questionImages][[[Questions sharedQuestions] currentQuestion]]];
}


- (void)viewDidAppear:(BOOL)animated {
    NSLog(@"viewDidLoad");
  [super viewDidAppear:animated];  
  [[ProblemStore sharedProblemStore] problemDisplayed];
}

- (void)viewDidUnload {
    NSLog(@"viewDidUnLoad");
#warning again is this correct?
 self.problemView = nil;
  self.solverView = nil;
  self.scaleKludgeView = nil;
  [super viewDidUnload];
}


- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation {
    NSLog(@"shouldAutorotateToInterfaceOrientation");
  return YES;
}

////////////////////////////////////////
// Actions
////////////////////////////////////////

- (void)writeSolutionImage: (id)isCorrect {
NSLog(@"writeSolutionImage");
  UIGraphicsBeginImageContext(self.view.bounds.size);
  [self.view.layer renderInContext:UIGraphicsGetCurrentContext()];
  UIImage *viewImage = UIGraphicsGetImageFromCurrentImageContext();
  UIGraphicsEndImageContext();
  
  self.scaleKludgeView.image = viewImage;
  UIGraphicsBeginImageContext(self.scaleKludgeView.bounds.size);
  [self.scaleKludgeView.layer renderInContext:UIGraphicsGetCurrentContext()];
  viewImage = UIGraphicsGetImageFromCurrentImageContext();
  UIGraphicsEndImageContext();
NSLog(@"set currentSolution, filename");

  ProblemSolution *currentSolution = [[ProblemStore sharedProblemStore] currentSolution];
  NSString *filename = [NSString stringWithFormat:@"solution-%ld.png", 
                        [[[ProblemStore sharedProblemStore] currentProblem] problemID]];
    currentSolution.solutionImageName = filename;
    currentSolution.solutionCorrect = isCorrect;
    int x = [[Questions sharedQuestions] currentQuestion];
    currentSolution.problemImageIndex =  @(x);
    int y = [[StudentModel sharedStudentModel] correctnessLevel];
    currentSolution.correctnessLevel = @(y);
  NSData *data = UIImagePNGRepresentation(viewImage);
  [data writeToFile:[currentSolution solutionImagePath] atomically:YES];
}

- (IBAction)finalizeSolution:(id)sender {
     NSLog(@"finalizeSolution");
    NSString *title = [sender titleForState:UIControlStateNormal];

    if ([title isEqualToString:@"Got it right!"])
        [[StudentModel sharedStudentModel] incCorrectnessLevel];
    else
        [[StudentModel sharedStudentModel] decCorrectnessLevel];
    [self writeSolutionImage:title];
    [[ProblemStore sharedProblemStore] solutionSubmitted];
    NSLog(@"Current Value=%d   Max Questions=%d",[[Questions sharedQuestions] currentQuestion],[[Questions sharedQuestions] maxQuestion]);
    if ([[Questions sharedQuestions] currentQuestion] >= [[Questions sharedQuestions] maxQuestion]){
        NSLog(@"no more questions");
        [solvalyzerDelegate solvalyzerControllerQuit:self];
        UIAlertView *alert =[[UIAlertView alloc]initWithTitle:@"No More" message:@"Therer are no more questions" delegate:nil cancelButtonTitle:nil otherButtonTitles:@"OK", nil];
        [alert show];
    }
    else{
        
        [solvalyzerDelegate solvalyzerControllerSolved:self];
    }
    
}

- (IBAction)quitSolving:(id)sender {
     NSLog(@"quitSolving");
   NSString *title = [sender titleForState:UIControlStateNormal];
#warning Treating 'quit' like solution!
    [self writeSolutionImage:title];
  [[ProblemStore sharedProblemStore] solutionSubmitted];
  [solvalyzerDelegate solvalyzerControllerQuit:self];
    
     SolvalyzerRootViewController *rc = [[SolvalyzerRootViewController alloc] initWithNibName:@"SolvalyzerRootViewController" bundle:nil];
}



- (IBAction)upAction:(id)sender {
     NSLog(@"upAction");
        //   yourButton.frame = CGRectMake(self.view.frame.size.width/2 - yourButton.frame.size.width/2, self.view.frame.size.height/2 - yourButton.frame.size.height/2, yourButton.frame.size.width, yourButton.frame.size.height);

    CGRect rect= self.scrollView.frame;
    CGFloat x = rect.origin.x;
    CGPoint point = self.scrollView.contentOffset;
    CGFloat y = point.y - SCROLL_AMOUNT;
    CGRect goTo =CGRectMake(x, y, rect.size.width, rect.size.height);
    [self.scrollView scrollRectToVisible:goTo animated:YES];
}

- (IBAction)downAction:(id)sender {
     NSLog(@"downAction");
    CGRect rect= self.scrollView.frame;
    CGFloat x = rect.origin.x;
    CGPoint point = self.scrollView.contentOffset;
    CGFloat y = point.y + SCROLL_AMOUNT;    CGRect goTo =CGRectMake(x, y, rect.size.width, rect.size.height);
    [self.scrollView scrollRectToVisible:goTo animated:YES];
}
@end
