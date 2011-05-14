//
//  questions.h
//  Solvalyzer
//
//  Created by dshanabrook on 4/23/11.
//  Copyright 2011 Diabolical Labs, LLC. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface Questions : NSObject {
    int currentQuestion;
    int numberOfQuestions;
    NSMutableArray *questionImages;
}

@property(nonatomic) int currentQuestion;
@property(nonatomic) int numberOfQuestions;

+(Questions *) sharedQuestions;

- (NSMutableArray*) questionImages;

- (int) incCurrentQuestion;
- (void) incNumberOfQuestions;

- (void) resetCurrentQuestion;
//- (void) setAllQuestions:(NSMutableArray*)input;
  
@end



