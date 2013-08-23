//
//  TheMatchingGame.h
//  Matchismo
//
//  Created by tcz on 8/18/13.
//  Copyright (c) 2013 Maer Studios Inc. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TheGame.h"
@interface TheMatchingGame : TheGame

-(void) flipCardAtIndex:(NSUInteger) index;//only one method to implement
@property (nonatomic) NSUInteger mode;//2-card or 3-card matching modes
@end
