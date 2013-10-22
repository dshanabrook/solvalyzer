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


@interface SolvalyzerRootViewController : UIViewController<SolvalyzerViewControllerDelegate, MFMailComposeViewControllerDelegate, UITextFieldDelegate> {

}

@property (nonatomic, retain) IBOutlet UIButton *restartButton;

- (IBAction)restartSolvalyzer:(id)sender;

@property (strong, nonatomic) IBOutlet UISlider *mathAttitude;
@property (strong, nonatomic) IBOutlet UISlider *mathAptitude;
@property (strong, nonatomic) IBOutlet UISlider *mathAnxiety;
@property (unsafe_unretained, nonatomic) IBOutlet UISlider *iPadAttitude;

@property (strong, nonatomic) IBOutlet UISwitch *boySwitch;

@property (strong, nonatomic) IBOutlet UISwitch *girlSwitch;
@property (strong, nonatomic) IBOutlet UITextField *studentName;

-(IBAction)boySwitch:(id)sender;
@end
