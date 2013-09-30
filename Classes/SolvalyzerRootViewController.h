//
//  SolvalyzerRootViewController.h
//  Solvalyzer
//
//  Created by Andrew Hannon on 3/8/11.
//  Copyright 2011 Diabolical Labs, LLC. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MessageUI/MessageUI.h>
#import "SolvalyzerViewController.h"


@interface SolvalyzerRootViewController : UIViewController<SolvalyzerViewControllerDelegate, MFMailComposeViewControllerDelegate> {
  IBOutlet UIButton *restartButton;
    IBOutlet UIButton *initializeQuestionsButton;
}

@property (nonatomic, retain) IBOutlet UIButton *restartButton;
//@property (nonatomic, retain) IBOutlet UIButton *initializeQuestionsButton;

- (IBAction)restartSolvalyzer:(id)sender;
//- (IBAction)initializeQuestions:(id)sender;

@property (unsafe_unretained, nonatomic) IBOutlet UIPickerView *genderPicker;
@property (unsafe_unretained, nonatomic) IBOutlet UISlider *mathApptitudeSlider;
@property (unsafe_unretained, nonatomic) IBOutlet UISlider *mathLikabilitySlider;
@end
