//
//  PlayingCard.h
//  Matchismo
//
//  Created by tcz on 8/14/13.
//  Copyright (c) 2013 Maer Studios Inc. All rights reserved.
//

@interface PlayingCard : NSObject

@property (strong,nonatomic) NSString *suit;
@property (nonatomic) NSInteger rank;

-(NSString *)contents;
+(NSArray *)validSuits;
+(NSInteger)maxRank;
-(BOOL)isEqual:(PlayingCard *)card;
@end
