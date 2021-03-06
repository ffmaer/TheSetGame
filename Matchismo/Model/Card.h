//
//  Card.h
//  Matchismo
//
//  Created by tcz on 8/18/13.
//  Copyright (c) 2013 Maer Studios Inc. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Card : NSObject

-(NSString *)contents;
-(NSAttributedString *)attributedContents;
@property (nonatomic, getter = isFaceUp) BOOL faceUp;
@property (nonatomic, getter = isUnplayable) BOOL unplayable;
@property (nonatomic, getter = isSelected) BOOL selected;
@end
