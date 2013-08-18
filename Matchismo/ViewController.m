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
@property (strong, nonatomic) PlayingCard *card3;

@property (weak, nonatomic) IBOutlet UILabel *matchLabel;


@property (weak, nonatomic) IBOutlet UIButton *button1;
@property (weak, nonatomic) IBOutlet UIButton *button2;
@property (weak, nonatomic) IBOutlet UIButton *button3;
@property (weak, nonatomic) IBOutlet UIButton *button4;
@property (weak, nonatomic) IBOutlet UIButton *button5;
@property (weak, nonatomic) IBOutlet UIButton *button6;
@property (weak, nonatomic) IBOutlet UIButton *button7;
@property (weak, nonatomic) IBOutlet UIButton *button8;

@property (weak, nonatomic) IBOutlet UIButton *button9;
@property (weak, nonatomic) IBOutlet UIButton *button10;
@property (weak, nonatomic) IBOutlet UIButton *button11;
@property (weak, nonatomic) IBOutlet UIButton *button12;
@property (weak, nonatomic) IBOutlet UIButton *button13;
@property (weak, nonatomic) IBOutlet UIButton *button14;
@property (weak, nonatomic) IBOutlet UIButton *button15;
@property (weak, nonatomic) IBOutlet UIButton *button16;
@property (weak, nonatomic) IBOutlet UISegmentedControl *mode;

@property (strong, nonatomic)NSMutableArray *history;


@property (weak, nonatomic) IBOutlet UISlider *historySlider;

@end

@implementation ViewController

-(NSMutableArray *)history{
    if(!_history) _history = [[NSMutableArray alloc] init];
    return _history;
}


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
    
    
    self.matchLabel.alpha=1;

    self.historySlider.enabled = YES;

    UIImage *cardBackImage = [UIImage imageNamed:@"cardback.jpg"];
    [sender setBackgroundImage:cardBackImage forState:UIControlStateNormal];
    UIImage *cardFrontImage = [UIImage imageNamed:@"cardfront.png"];
    [sender setBackgroundImage:cardFrontImage forState:UIControlStateSelected];
    
    self.mode.enabled = NO;
    
    if(sender.isSelected){
        sender.selected = NO;
    }
    else{
        sender.selected = YES;

        self.flipsCount++;
        PlayingCard *myCard = self.myDeck.drawRandomCard;
        [sender setTitle: myCard.contents forState:UIControlStateSelected];
        //  How to compare two cards is independent from the UI, so it should be written in Model. But how to tell users about the matching result is dependent of the UI, so it should be written in Controller.
        self.card1 = self.card2;
        self.card2 = self.card3;
        self.card3 = myCard;
        
        
        NSString *message=@"";
        
        if(self.mode.selectedSegmentIndex == 0){
        
            if(self.card2){

                if([self.card2 isEqual2Card:self.card3]){
                    message = [NSString stringWithFormat:@"Matched %@ & %@ for 4 points", self.card2.contents, self.card3.contents];
                    self.matchLabel.text = message;
                }else{
                    message=[NSString stringWithFormat:@"%@ and %@ don't match! 2 point penalty!", self.card2.contents, self.card3.contents];
                    self.matchLabel.text = message;
                }
            }
            else{
                message = [NSString stringWithFormat:@"Flipped up %@",myCard.contents];
                self.matchLabel.text = message;
            }
        }else if(self.mode.selectedSegmentIndex ==1){
            if(self.card2){
                if(self.card1){
                
                    if([self.card1 isEqual3Card:self.card2 card2:self.card3]){
                        message = [NSString stringWithFormat:@"Matched %@ & %@ & %@ for 4 points", self.card1.contents, self.card2.contents, self.card3.contents];
                        self.matchLabel.text = message;
                    }else{
                        message=[NSString stringWithFormat:@"%@, %@ and %@ don't match! 2 point penalty!", self.card1.contents, self.card2.contents, self.card3.contents];
                        self.matchLabel.text = message;
                    }
                }
                else{
                    message=[NSString stringWithFormat:@"Flipped up %@ and %@",self.card2.contents,self.card3.contents];
                    self.matchLabel.text = message;
                }
            }else{
                message=[NSString stringWithFormat:@"Flipped up %@",self.card3.contents];
                self.matchLabel.text = message;
            }
            
        }
        [self.history addObject:message];
        
        self.historySlider.minimumValue=0;
        self.historySlider.maximumValue=self.history.count-1;
        
    }
}

- (IBAction)reset:(id)sender {
    
    
    self.history = nil;
    self.historySlider.minimumValue=0;
    self.historySlider.maximumValue=0;
    self.historySlider.enabled = NO;
    self.card1 = nil;
    self.card2 = nil;
    self.card3 = nil;
    
    self.matchLabel.text = @"";
    
    
    self.mode.enabled = YES;
    
    self.button1.selected=NO;
    self.button2.selected=NO;
    self.button3.selected=NO;
    self.button4.selected=NO;
    
    self.button5.selected=NO;
    self.button6.selected=NO;
    self.button7.selected=NO;
    self.button8.selected=NO;
    
    self.button9.selected=NO;
    self.button10.selected=NO;
    self.button11.selected=NO;
    self.button12.selected=NO;
    
    self.button13.selected=NO;
    self.button14.selected=NO;
    self.button15.selected=NO;
    self.button16.selected=NO;
    
    _myDeck = [[PlayingCardDeck alloc] init];
    _flipsCount = 0;
    self.flipLabel.text = [NSString stringWithFormat:@"Flips: %d",self.flipsCount];
}
- (IBAction)slide:(UISlider *)sender {
    
    NSString *message = self.history[(int)sender.value];
    self.matchLabel.text = message;
    self.matchLabel.alpha = 0.5;
}


@end
