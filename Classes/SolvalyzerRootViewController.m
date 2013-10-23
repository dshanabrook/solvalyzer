//
//  SolvalyzerRootViewController.m
//  Solvalyzer
//
//  Created by Andrew Hannon on 3/8/11.
//  Copyright 2011 Diabolical Labs, LLC. All rights reserved.
//

#import "Student.h"
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
@synthesize girlSwitch;
@synthesize boySwitch;

@synthesize restartButton;
//@synthesize initializeQuestionsButton;
//adding a navigation bar
-(void) performAdd:(id)parmSender {
    NSLog(@"action method got logged");
    
}

- (void)viewDidLoad {
        //textfield
        // [self.studentName.inputView =
        //switches
    [self.boySwitch addTarget:self
                       action:@selector(switchIsChanged:)
             forControlEvents:UIControlEventValueChanged];
    [self.girlSwitch addTarget:self
                        action:@selector(switchIsChanged:)
              forControlEvents:UIControlEventValueChanged];
    [self.mathAnxiety addTarget:self
                     action:@selector(sliderValueChanged:)
           forControlEvents:UIControlEventValueChanged];
    [self.mathAttitude addTarget:self
                         action:@selector(sliderValueChanged:)
               forControlEvents:UIControlEventValueChanged];
    [self.mathAptitude addTarget:self
                         action:@selector(sliderValueChanged:)
               forControlEvents:UIControlEventValueChanged];
    [self.iPadAttitude addTarget:self
                         action:@selector(sliderValueChanged:)
               forControlEvents:UIControlEventValueChanged];
}

-(void) viewDidUnload {
        //handle switches
        //check somewhere for name of person if (([addThisCity.text  isEqual: @""])
    
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

    //only one switch on at a timeipad
- (void) switchIsChanged:(UISwitch *)paramSender{
    if (paramSender == self.girlSwitch) {
        NSLog(@"turning girlSwith %d", [self.girlSwitch isOn]);
        [self.boySwitch setOn:![self.girlSwitch isOn] animated:YES];
        self.aStudent.isaGirl = YES;
    }
    else {
        [self.girlSwitch setOn:![self.boySwitch isOn] animated:YES];
        NSLog(@"turning boySwitch %d", [self.boySwitch isOn]);
        self.aStudent.isaGirl = YES;
    }
}
    //use this to not hide signature window: https://developer.apple.com/library/ios/documentation/StringsTextFonts/Conceptual/TextAndWebiPhoneOS/KeyboardManagement/KeyboardManagement.html

    //entered name and hit return
-(BOOL)textFieldShouldReturn:(UITextField *)textField{
    if ([textField.restorationIdentifier isEqualToString: @"signatureText"]){
        self.aStudent.name = textField.text;
        _permissionImageView.hidden = YES;
        [textField resignFirstResponder];
    }
    else {
        textField.tag = 1;
        self.aStudent.name = textField.text;
        [textField resignFirstResponder];
    }
    return YES;
}

-(IBAction)participate:(id)sender{
        //hide buttons
    _participateButton.hidden = YES;
    _notParticipateButton.hidden = YES;
        //show text field
    _signatureTextField.hidden = NO;
        //show keyboard
    [_signatureTextField becomeFirstResponder];
}


-(IBAction)notParticipate:(id)sender{
        //hide buttons, permission slip
    _participateButton.hidden = YES;
    _notParticipateButton.hidden = YES;
     _signatureTextField.hidden = NO;
    _signatureTextField.userInteractionEnabled = NO;
    _signatureTextField.text = @"STUDENT NOT PARTICIPATING IN STUDY";
    _permissionImageView.hidden = YES;

    
}

- (void) sliderValueChanged:(UISlider *)paramSender{
    
    if ([paramSender isEqual:self.mathAnxiety])
        self.aStudent.mathAnxietyValue = [NSNumber numberWithFloat:self.mathAnxiety.value];
    else if ([paramSender isEqual:self.mathAptitude])
        self.aStudent.mathAptitudeValue = [NSNumber numberWithFloat:self.mathAptitude.value];
    else if ([paramSender isEqual:self.mathAptitude])
        self.aStudent.mathAptitudeValue = [NSNumber numberWithFloat:self.mathAptitude.value];
    else if ([paramSender isEqual:self.iPadAttitude])
        self.aStudent.iPadAttitudeValue = [NSNumber numberWithFloat:self.iPadAttitude.value];
         
        NSLog(@"ipad %f aptitude %f attitude %f anxiety %f", self.iPadAttitude.value, self.mathAptitude.value, self.mathAttitude.value, self.mathAnxiety.value);
    }
    
    
- (IBAction)restartSolvalyzer:(id)sender {
  [[ProblemStore sharedProblemStore] resetProblemStore]; 
        //    [[StudentModel sharedStudentModel] resetSharedStudentModel];
    [[Questions sharedQuestions] resetCurrentQuestion];
  [self presentSolvalyzer];
}


- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation {
  return YES;
}
    
    //    -(BOOL) textFieldShouldReturn:(UITextField *) textField {
    //        if ([textField isEqual:self.studentName]){
    //          [textField resignFirstResponder];
    //        }
    //    return YES;
    //}


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
