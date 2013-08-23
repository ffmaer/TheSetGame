//
//  SetDeck.m
//  TheSetGame
//
//  Created by tcz on 8/20/13.
//  Copyright (c) 2013 Maer Studios Inc. All rights reserved.
//

#import "SetDeck.h"


@implementation SetDeck

-(id)init{
    self = [super init];
    if(self){
        for(NSDictionary *pattern in [self patterns]){
            SetCard *card = [[SetCard alloc] init];
            card.pattern = pattern[@"pattern"];
            card.color = pattern[@"color"] ;
            card.shape = pattern[@"shape"] ;
            card.underline = pattern[@"underline"] ;
            card.number = pattern[@"number"] ;
            [self addCard:card atTop:YES];
        }
    }
    return self;
}

-(NSMutableArray *)patterns{
    
    NSMutableArray *patterns = [[NSMutableArray alloc] init];
    
    NSArray *shapes = @[@"✤",@"★",@"✱"];
    NSArray *numbers = @[@1,@2,@3];
    NSArray *colors = @[[UIColor blueColor],[UIColor redColor],[UIColor blackColor]];
    NSArray *underlineStyles = @[@0x00, @0x01, @0x09];
    
    for(NSString *shape in shapes){
        for(NSNumber *number in numbers){
            for(UIColor *color in colors){
                for(NSNumber *underlineStyle in underlineStyles){
                    NSString *str = [self repeatString:shape forTimes:[number unsignedIntegerValue]];
                    NSMutableAttributedString *aStr = [[NSMutableAttributedString alloc] initWithString:str];
                    NSRange range = NSMakeRange (0, [str length]);
                    [aStr addAttributes:@{NSForegroundColorAttributeName: color, NSUnderlineStyleAttributeName: underlineStyle} range:range];
                    [patterns addObject:
                     @{@"pattern":[aStr copy],
                     @"shape":[NSNumber numberWithInteger:[shapes indexOfObject:shape]],
                     @"number":[NSNumber numberWithInteger:[numbers indexOfObject:number]],
                     @"underline":[NSNumber numberWithInteger:[underlineStyles indexOfObject:underlineStyle]],
                     @"color":[NSNumber numberWithInteger:[colors indexOfObject:color]]}];
                    
                    
                }
            }
        }
    }
    return patterns;
}


- (NSString *)repeatString:(NSString *)string forTimes:(NSUInteger)times {
    return [@"" stringByPaddingToLength:times * [string length] withString:string startingAtIndex:0];
}


@end
