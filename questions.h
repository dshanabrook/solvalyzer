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
    NSMutableArray *allQuestions;
}

@property(readonly) int currentQuestion;


-(id) initWithQuestions: (NSMutableArray*)ques
        currentQuestion:(int)cur;
+(id) sharedQuestions;

  
@end



