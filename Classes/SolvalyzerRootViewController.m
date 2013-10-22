//
//  SolvalyzerRootViewController.m
//  Solvalyzer
//
//  Created by Andrew Hannon on 3/8/11.
//  Copyright 2011 Diabolical Labs, LLC. All rights reserved.
//

#import "studentModel.h"
#import "questions.h"
#import "ProblemStore.h"
#import "Problem.h"
#import "ProblemSolution.h"
#import "SolvalyzerRootViewController.h"
#import <AWSS3/AWSS3.h>
#import <AWSRuntime/AWSRuntime.h>


@interface SolvalyzerRootViewController()
- (void)presentSolvalyzer;
@end

@implementation SolvalyzerRootViewController

@synthesize studentName;
@synthesize restartButton;
//@synthesize initializeQuestionsButton;
//adding a navigation bar
-(void) performAdd:(id)parmSender {
    NSLog(@"action method got logged");
    
}

- (void)presentSolvalyzer {
    
    
    self.title = @"First Controller";
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"add" style:UIButtonTypeRoundedRect
                                                                            target:self action:@selector(performAdd:)];
  self.restartButton.hidden = YES;
  SolvalyzerViewController *c = [[SolvalyzerViewController alloc] initWithNibName:@"SolvalyzerViewController" bundle:nil];
  c.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
  c.solvalyzerDelegate = self;
[self presentModalViewController:c animated:YES];
        [c release];
}

-(IBAction)boySwitch:(id)sender{
    [self.]
}
- (IBAction)restartSolvalyzer:(id)sender {
  [[ProblemStore sharedProblemStore] resetProblemStore]; 
    [[StudentModel sharedStudentModel] resetSharedStudentModel];
    [[Questions sharedQuestions] resetCurrentQuestion];
  [self presentSolvalyzer];
}


- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation {
  return YES;
}
    
    -(BOOL) textFieldShouldReturn:(UITextField *) textField {
        if ([textField isEqual:self.studentName]){
            [textField resignFirstResponder];
        }
    return YES;
}


////////////////////////////////////////
// SolvalyzerViewControllerDelegate
////////////////////////////////////////

- (void)solvalyzerControllerSolved:(SolvalyzerViewController*)controller {
  [self dismissModalViewControllerAnimated:NO];
  [self presentSolvalyzer];
}

/*- (void)solvalyzerControllerQuit:(SolvalyzerViewController*)controller {
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
  
  [c setToRecipients:@[@"davidshanabrook@me.com"]];
  
  [self presentModalViewController:c animated:YES];
  c.mailComposeDelegate = self;
  [c release];
}
 */

- (void) solvalyzerControllerQuit:(SolvalyzerViewController *)controller{
    
    [self dismissModalViewControllerAnimated:NO];
    AmazonS3Client *s3Client = [[AmazonS3Client alloc] initWithAccessKey:@"AKIAIXRARZOIBKMFV5OA" withSecretKey:@"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"];
    
    NSData *seriesData = [[ProblemStore sharedProblemStore] problemStoreToData];
    long problemSetID = [[ProblemStore sharedProblemStore] uniqueID];
    NSString *fileName = [NSString stringWithFormat:@"problem-set-%ld.csv", problemSetID];

    /*
     S3CreateBucketResponse *createBucketResponse = [self.s3 createBucket:createBucketRequest];
     if(createBucketResponse.error != nil)
     {
     NSLog(@"Error: %@", createBucketResponse.error);
     }
     */
    S3PutObjectRequest *por = [[[S3PutObjectRequest alloc] initWithKey:fileName inBucket:@"touchdata2"] autorelease];
    por.data = seriesData;
    [s3Client putObject:por];
    
    /*    S3PutObjectResponse *putObjectResponse = [self.s3 putObject:por];
     dispatch_async(dispatch_get_main_queue(), ^{
     
     if(putObjectResponse.error != nil)
     {
     NSLog(@"Error: %@", putObjectResponse.error);
     [self showAlertMessage:[putObjectResponse.error.userInfo objectForKey:@"message"] withTitle:@"Upload Error"];
     }
     else
     {
     [self showAlertMessage:@"The image was successfully uploaded." withTitle:@"Upload Completed"];
     }*/
    
    //do something with each image
    [[ProblemStore sharedProblemStore] mapAllProblems:^(Problem *p) {
        UIImage *image = [UIImage imageWithContentsOfFile:[p.solution solutionImagePath]];
        NSString *imagefile = p.solution.solutionImageName;
        
        S3PutObjectRequest *por = [[[S3PutObjectRequest alloc] initWithKey:imagefile inBucket:@"touch_images"] autorelease];
        por.contentType = @"image/png";
        por.data = UIImagePNGRepresentation(image);
        [s3Client putObject:por];
    }];

    
    
    
    //get the documents directory:
/*    NSArray *paths = NSSearchPathForDirectoriesInDomains
    (NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    
    //make a file name to write the data to using the documents directory:
    NSString *filePath = [NSString stringWithFormat:@"%@/%@", documentsDirectory, fileName];
    
    NSArray *dirPaths;
   NSString *docsDir;
    dirPaths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,
                                                   NSUserDomainMask, YES);
    docsDir = [dirPaths objectAtIndex:0];
    
    //save content to the documents directory
    [seriesData writeToFile:filePath
              atomically:YES];
    }
 */



/*
- (void)mailComposeController:(MFMailComposeViewController*)controller 
          didFinishWithResult:(MFMailComposeResult)result 
                        error:(NSError*)error {
  [self dismissModalViewControllerAnimated:YES];
  self.restartButton.hidden = NO; 
}
 */
}
@end
