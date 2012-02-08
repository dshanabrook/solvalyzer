//
//  studentModel.m
//  Solvalyzer
//
//  Created by david hilton shanabrook on 5/20/11.
//  Copyright 2011 Diabolical Labs, LLC. All rights reserved.
//

#import "studentModel.h"

static StudentModel *sharedStudentModel;

@implementation StudentModel

@synthesize correctnessLevel;
@synthesize correctnessCutoff;

- (id)init{
    self = [super init];
    if (self) {
    }
    [self setCorrectnessCutoff:3];
    [self setCorrectnessLevel: 0];
    return self;
}

- (void) incCorrectnessLevel{
    correctnessLevel++;
}

-(void) decCorrectnessLevel{
    correctnessLevel = correctnessLevel - 1;
}


- (void)dealloc
{
    [super dealloc];
}

+ (StudentModel *) sharedStudentModel{
    if (!sharedStudentModel) {
        sharedStudentModel = [[StudentModel alloc] init];
    }
        return sharedStudentModel;
}
- (void)resetSharedStudentModel {
    self.correctnessLevel = 0;
}

@end
