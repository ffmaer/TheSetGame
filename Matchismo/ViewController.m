//
//  ViewController.m
//  Matchismo
//
//  Created by tcz on 8/10/13.
//  Copyright (c) 2013 Maer Studios Inc. All rights reserved.
//

#import "ViewController.h"
#import "PlayingCardDeck.h"
#import "PlayingCard.h"

@interface ViewController ()
@property (nonatomic) int flipsCount;
@property (weak, nonatomic) IBOutlet UILabel *flipLabel;
@property (strong, nonatomic) PlayingCardDeck *myDeck;

@property (strong, nonatomic) PlayingCard *card1;
@property (strong, nonatomic) PlayingCard *card2;

@property (weak, nonatomic) IBOutlet UILabel *matchLabel;


@property (weak, nonatomic) IBOutlet UIButton *button1;
@property (weak, nonatomic) IBOutlet UIButton *button2;
@property (weak, nonatomic) IBOutlet UIButton *button3;
@property (weak, nonatomic) IBOutlet UIButton *button4;


@end

@implementation ViewController


-(PlayingCardDeck *) myDeck
{
    if(!_myDeck) _myDeck = [[PlayingCardDeck alloc] init];
    return _myDeck;
}

-(void) setFlipsCount:(int)flipsCount
{
    _flipsCount = flipsCount;   
    self.flipLabel.text = [NSString stringWithFormat:@"Flips: %d",self.flipsCount];
}

- (IBAction)flipCard:(UIButton *)sender {
    
    if(sender.isSelected){
        sender.selected = NO;
    }
    else{
        self.flipsCount++;
        PlayingCard *myCard = self.myDeck.drawRandomCard;
        [sender setTitle: myCard.contents forState:UIControlStateSelected];
        sender.selected = YES;
        //  How to compare two cards is independent from the UI, so it should be written in Model. But how to tell users about the matching result is dependent of the UI, so it should be written in Controller.
        self.card1 = self.card2;
        self.card2 = myCard;

        if(self.card1){

            if([self.card1 isEqual:self.card2]){
                self.matchLabel.text = [NSString stringWithFormat:@"Matched %@ & %@ for 4 points", self.card1.contents, self.card2.contents];
            }else{
                self.matchLabel.text = [NSString stringWithFormat:@"%@ and %@ don't match! 2 point penalty!", self.card1.contents, self.card2.contents];
            }
        }
        else{
            self.matchLabel.text = [NSString stringWithFormat:@"Flipped up %@",myCard.contents];
        }
    }
}

- (IBAction)reset:(id)sender {
    self.button1.selected=NO;
    self.button2.selected=NO;
    self.button3.selected=NO;
    self.button4.selected=NO;

    _myDeck = [[PlayingCardDeck alloc] init];
    _flipsCount = 0;
    self.flipLabel.text = [NSString stringWithFormat:@"Flips: %d",self.flipsCount];
}
@end
