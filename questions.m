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
@synthesize numberOfQuestions;

+(Questions *) sharedQuestions{
    if (!sharedQuestions) {
        sharedQuestions = [[Questions alloc] init];
    }
    else{
        [sharedQuestions incCurrentQuestion];
    }
    return sharedQuestions;
}

//could also set currentQuestion= blank when > noq
-(int) incCurrentQuestion{
    currentQuestion++;
    if (currentQuestion > numberOfQuestions) {
        currentQuestion = 1;
    }
    return currentQuestion;
}

-(void) incNumberOfQuestions{
    numberOfQuestions++;
}
-(void) resetCurrentQuestion {
    currentQuestion = 1;
    }
    
    
- (id)init {
    [self setCurrentQuestion:1];
    questionImages = [[NSMutableArray alloc] init];
    [self setNumberOfQuestions:0];

    do {
        NSString *imageURL = [[NSString alloc] initWithFormat:@"http://public.me.com/ix/davidshanabrook/questions/image%d.png",numberOfQuestions+1];
        NSURL *URL = [NSURL URLWithString:imageURL];
        [imageURL release];
        NSData *imageData = [NSData dataWithContentsOfURL:URL];
        if (imageData != nil){
            [self incNumberOfQuestions];
            [questionImages addObject:imageData];
            }
        else {
            break;
        }
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