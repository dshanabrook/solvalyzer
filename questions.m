//
//  questions.m
//  Solvalyzer
//
//  Created by dshanabrook on 4/23/11.
//  Copyright 2011 Diabolical Labs, LLC. All rights reserved.
//

#import "questions.h"

static Questions *sharedQuestions;

@implementation Questions


@synthesize currentQuestion;
@synthesize maxQuestion;

+(Questions *) sharedQuestions{
    if (!sharedQuestions) {
        sharedQuestions = [[Questions alloc] init];
    }
    return sharedQuestions;
}

//could also set currentQuestion= blank when > noq
-(void) incCurrentQuestion{
    currentQuestion++;
//    if (currentQuestion >= maxQuestion) {
//        currentQuestion = 0;
 //   }
}

-(void) incNumberOfQuestions{
    maxQuestion++;
}
-(void) resetCurrentQuestion {
    currentQuestion =-1;
    }
    
#warning assumes at least on question!  hack
- (id)init {
    questionImages = [[NSMutableArray alloc] init];
    [self setMaxQuestion:-1];
    [self setCurrentQuestion:-1];
    Boolean finished = false;
    
    while (!finished){
        NSString *imageURL = [[NSString alloc] initWithFormat:@"http://dl.dropbox.com/u/38837548/questions/image%d.png",maxQuestion+1];
        NSURL *URL = [NSURL URLWithString:imageURL];
        NSData *imageData = [NSData dataWithContentsOfURL:URL];
        if (imageData != nil){
            [self incNumberOfQuestions];
            [questionImages addObject:imageData];
        }
        else
            finished = TRUE;
    }
    return self;
}

- (NSMutableArray*) questionImages{
    return questionImages;
    }




//-(void) setquestionImages:(NSMutableArray *)input{
//    [questionImages autorelease];
//    questionImages = [input retain];
    
//}
@end