//
//  questions.m
//  Solvalyzer
//
//  Created by dshanabrook on 4/23/11.
//  Copyright 2011 Diabolical Labs, LLC. All rights reserved.
//

#import "questions.h"


@implementation Questions

@synthesize currentQuestion;


//- (NSString*) setQuestionSet{
//    return questionSet;
//}

//-(NSNumber*) setcurrentQuestion{
 //   return currentQuestion;
//}

-(id) initWithQuestions:(NSMutableArray*)ques
        currentQuestion:(int)cur;

{
    self = [self init];
    currentQuestion = 0;
    allQuestions = [[NSMutableArray alloc] init];
    return self;
}
+ (Questions*)sharedQuestions {
    static Questions *question = nil;
    @synchronized([Questions class]) {
        if (! question) {
            question = [[Questions alloc] init];
        }
    }
    return question;
}
@end
