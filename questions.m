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
    

#warning  why doesn't unitl (imageData!nil) work instead of break?
#warning assumes at least on question!  hack
- (id)init {
    questionImages = [[NSMutableArray alloc] init];
    [self setMaxQuestion:-1];
    [self setCurrentQuestion:-1];


    do {
        NSString *imageURL = [[NSString alloc] initWithFormat:@"http://public.me.com/ix/davidshanabrook/questions/image%d.png",maxQuestion+1];
        NSURL *URL = [NSURL URLWithString:imageURL];
        [imageURL release];
        NSData *imageData = [NSData dataWithContentsOfURL:URL];
        if (imageData != nil){
            [self incNumberOfQuestions];
            [questionImages addObject:imageData];
        }
        else 
            break;
    } while (true);
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