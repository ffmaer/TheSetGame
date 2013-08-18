//
//  PlayingCard.m
//  Matchismo
//
//  Created by tcz on 8/14/13.
//  Copyright (c) 2013 Maer Studios Inc. All rights reserved.
//

#import "PlayingCard.h"

@implementation PlayingCard

- (NSString *) contents {
    NSArray *rankStrings = [PlayingCard rankStrings];
    return [rankStrings[self.rank] stringByAppendingString:self.suit];
}

@synthesize suit =_suit;

+ (NSArray *)validSuits
{
    return @[@"♥",@"♦",@"♠",@"♣"];
}

- (NSString *) suit{
    return _suit ? _suit :@"?";
}

- (void) setSuit:(NSString *)suit
{
    if([[PlayingCard validSuits] containsObject:suit]){
        _suit = suit;
    }
}

+ (NSArray *) rankStrings {
    return @[@"?",@"A",@"2",@"3",@"4",@"5",@"6",@"7",@"8",@"9",@"10",@"J",@"Q",@"K"];
}

+(NSInteger) maxRank
{
    return [self rankStrings].count -1 ;
}

- (void)setRank:(NSInteger)rank
{
    if(rank <= [PlayingCard maxRank]){
        _rank = rank;
    }
}

-(BOOL)isEqual2Card: (PlayingCard *)card{
    return ([self.suit isEqualToString:card.suit] || self.rank == card.rank);
}
-(BOOL)isEqual3Card:(PlayingCard *)card1 card2:(PlayingCard *)card2
{
    return (([self.suit isEqualToString:card1.suit ]&& [self.suit isEqualToString:card2.suit] )|| (self.rank == card1.rank && self.rank == card2.rank));
}

@end