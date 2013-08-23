//
//  SetCard.h
//  TheSetGame
//
//  Created by tcz on 8/20/13.
//  Copyright (c) 2013 Maer Studios Inc. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Card.h"
@interface SetCard : Card
@property (strong,nonatomic) NSMutableAttributedString *pattern;
@property (nonatomic) NSNumber * color;
@property (nonatomic) NSNumber * shape;
@property (nonatomic) NSNumber * underline;
@property (nonatomic) NSNumber * number;
+(NSInteger) match: (NSMutableArray *)cards;
@end