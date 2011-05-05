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
}

@property (nonatomic, retain) IBOutlet UIButton *restartButton;

- (IBAction)restartSolvalyzer:(id)sender;
@end
