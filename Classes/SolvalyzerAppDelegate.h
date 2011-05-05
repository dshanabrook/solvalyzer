//
//  SolvalyzerAppDelegate.h
//  Solvalyzer
//
//  Created by Andrew Hannon on 3/7/11.
//  Copyright 2011 Diabolical Labs, LLC. All rights reserved.
//

#import <UIKit/UIKit.h>

@class SolvalyzerRootViewController;

@interface SolvalyzerAppDelegate : NSObject <UIApplicationDelegate> {
  UIWindow *window;
    
  SolvalyzerRootViewController *viewController;

}

@property (nonatomic, retain) IBOutlet UIWindow *window;
@property (nonatomic, retain) IBOutlet SolvalyzerRootViewController *viewController;

@end

