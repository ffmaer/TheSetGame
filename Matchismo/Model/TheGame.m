//
//  TheGame.m
//  TheSetGame
//
//  Created by tcz on 8/20/13.
//  Copyright (c) 2013 Maer Studios Inc. All rights reserved.
//

#import "TheGame.h"

@interface TheGame()
@property (strong,nonatomic) NSMutableArray *cards;//of Card
@property (readwrite, nonatomic) NSInteger score;

@end


@implementation TheGame
-(NSMutableArray *)cards{
    if(!_cards) _cards = [[NSMutableArray alloc]init];
    return _cards;
}

-(Card *)cardAtIndex:(NSUInteger)index{
    return self.cards[index];
}

-(id)initWithCardCount: (NSUInteger) count usingDeck:(Deck *)deck{
    
    self = [super init];
    if(self){
        for (int i=0; i<count; i++) {
            Card *card = [deck drawRandomCard];
            self.cards[i]=card;
        }
    }
    return self;
}
@end
