//
//  Deck.h
//  Matchismo
//
//  Created by tcz on 8/13/13.
//  Copyright (c) 2013 Maer Studios Inc. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "PlayingCard.h"

@interface Deck : NSObject

- (void)addCard:(PlayingCard *)card atTop:(BOOL)atTop;
- (PlayingCard *)drawRandomCard;

@end
