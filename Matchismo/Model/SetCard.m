//
//  SetCard.m
//  TheSetGame
//
//  Created by tcz on 8/20/13.
//  Copyright (c) 2013 Maer Studios Inc. All rights reserved.
//

#import "SetCard.h"

@implementation SetCard


#define MATCH_SCORE 16;
#define NOT_MATCH_SCORE -2;


+(BOOL)checkCards:(NSMutableArray *)cards Property:(NSString *)property{
    NSUInteger sum =0;
    for(NSNumber *number in [cards valueForKey:property]) sum+= [number unsignedIntegerValue];
    NSArray *validSum = @[@0,@3,@6];//after some analysis, we found only these three sum are valid.
    return [validSum containsObject:[NSNumber numberWithUnsignedInteger:sum]];
}

+(NSInteger) match: (NSMutableArray *)cards{
    if([self checkCards:cards Property:@"color"] && [self checkCards:cards Property:@"shape"] && [self checkCards:cards Property:@"underline"] && [self checkCards:cards Property:@"number"]){
        return MATCH_SCORE;
    }
    else{
        return NOT_MATCH_SCORE;
    }
}
-(NSAttributedString *)attributedContents{
    return self.pattern;
}

@end