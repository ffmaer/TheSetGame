//
//  TheSetGame.m
//  TheSetGame
//
//  Created by tcz on 8/20/13.
//  Copyright (c) 2013 Maer Studios Inc. All rights reserved.
//

#import "TheSetGame.h"
#import "SetCard.h"

@interface TheGame()
@property (strong,nonatomic) NSMutableArray *cards;//of Card
@property (readwrite, nonatomic) NSInteger score;
@end


@implementation TheSetGame

-(NSMutableAttributedString *)joinAttributedStrings:(NSMutableArray *)attributedStrings{//assitant method
    NSMutableAttributedString *firstString = attributedStrings[0];
    if([attributedStrings count]>1){
        for(int i=1;i<[attributedStrings count];i++){
            [firstString appendAttributedString:[[NSMutableAttributedString alloc]initWithString:@" & "]];
            [firstString appendAttributedString:attributedStrings[i]];
        }
    }
    return firstString;
}
#define SELECT_COST 1;
-(void) selectCardAtIndex:(NSUInteger) index{
    self.score -= SELECT_COST;// it costs 1 points to select a card
    
    SetCard *card = self.cards[index];
    card.selected = !card.isSelected;//select or deselect a card
    
    NSMutableArray *selectedCards = [[NSMutableArray alloc] init];//store three selected cards
    for(SetCard *card in self.cards){
        if(card.isSelected && !card.unplayable) [selectedCards addObject:card];//selected and enabled
    }

    
    NSMutableArray *attributedStrings = [[NSMutableArray alloc]init];
    for(SetCard *card in selectedCards){
        [attributedStrings addObject:[card.pattern mutableCopy]];
    }

    if([selectedCards count ] >0){
        NSMutableAttributedString *content =[self joinAttributedStrings:attributedStrings];

        
        if([selectedCards count] == 3){
            NSInteger result = [SetCard match:selectedCards];
            if(result>0){
                NSMutableAttributedString *message = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@" matched for %d points", result]];
                [content appendAttributedString:message];
                self.attributedMessage = content;

                for(Card *card in selectedCards){
                    card.unplayable = YES;
                }
                
            }
            else{
                NSMutableAttributedString *message = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@" don't match! %d points penalty!", result]];
                [content appendAttributedString:message];
                self.attributedMessage = content;

                for(Card *card in selectedCards){
                    card.selected = NO;
                }

            }
            self.score += result;
        }
        else{
            NSMutableAttributedString *message = [[NSMutableAttributedString alloc] initWithString:@"Fliped"];
            [message appendAttributedString:content];
            self.attributedMessage = message;
        }
    }
    else{
        self.attributedMessage = [[NSMutableAttributedString alloc]initWithString:@"No card is selected."];
    }
}
    
@end
