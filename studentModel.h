//
//  studentModel.h
//  Solvalyzer
//
//  Created by david hilton shanabrook on 5/20/11.
//  Copyright 2011 Diabolical Labs, LLC. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface StudentModel : NSObject {
    int  correctnessLevel;
    int correctnessCutoff;
    
}

@property(nonatomic) int correctnessLevel;
@property(nonatomic) int correctnessCutoff;

-(void) incCorrectnessLevel;
-(void) decCorrectnessLevel;
-(void) resetSharedStudentModel;
+ (StudentModel *) sharedStudentModel;
@end
