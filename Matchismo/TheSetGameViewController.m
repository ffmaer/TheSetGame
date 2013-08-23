//
//  TheSetGameViewController.m
//  TheSetGame
//
//  Created by tcz on 8/20/13.
//  Copyright (c) 2013 Maer Studios Inc. All rights reserved.
//

#import "TheSetGameViewController.h"
#import "SetCard.h"
#import "SetDeck.h"
#import "TheSetGame.h"
@interface TheSetGameViewController()
@property (strong, nonatomic) Deck* deck;

@property (strong, nonatomic) IBOutletCollection(UIButton) NSArray *buttons;

@property (strong, nonatomic) TheSetGame*game;
@property (weak, nonatomic) IBOutlet UILabel *matchLabel;
@property (weak, nonatomic) IBOutlet UISlider *historySlider;
@property (nonatomic) int flipsCount;
@property (weak, nonatomic) IBOutlet UILabel *scoreLabel;
@property (strong, nonatomic) NSMutableArray *history;
@property (weak, nonatomic) IBOutlet UILabel *flipLabel;
@end

@implementation TheSetGameViewController

-(Deck *)deck{
    if(!_deck) _deck = [[SetDeck alloc ]init];
    return _deck;
}

-(TheSetGame *)game{
    
    if(!_game) _game = [[TheSetGame alloc] initWithCardCount:self.buttons.count
                                                        usingDeck:(Deck *)self.deck];
    return _game;
}

-(void)updateCardButtons{
    for(int i=0;i<[self.buttons count];i++){
        Card *card = [self.game cardAtIndex:i];
        UIButton *button = self.buttons[i];
        button.enabled = YES;//all cards are enabled when refreshing
        button.backgroundColor = [UIColor whiteColor];
        [button setAttributedTitle:card.attributedContents forState:UIControlStateNormal];//show patterns all states
        button.alpha = 1;//unselected cards have alpha .5
        if(card.isUnplayable){
            button.enabled = NO;
            button.alpha = 0; //don't show disabled cards
        }
        else{
            if(card.selected){
                button.backgroundColor = [UIColor yellowColor];
                button.alpha =0.5;
            }
        }
    }
}

-(void)updateUI{
    self.matchLabel.alpha=1;
    self.historySlider.enabled = YES;
    self.flipsCount++;
    
    NSAttributedString *message = self.game.attributedMessage;
    self.matchLabel.attributedText = message;
    
    // update history
    [self.history addObject:message];
    self.historySlider.minimumValue=0;
    self.historySlider.maximumValue=self.history.count-1;
    
    
    [self updateCardButtons];
    self.scoreLabel.text = [NSString stringWithFormat:@"Score: %d",self.game.score];
}

-(NSMutableArray *)history{
    if(!_history) _history = [[NSMutableArray alloc] init];
    return _history;
}

-(void) setFlipsCount:(int)flipsCount
{
    _flipsCount = flipsCount;
    self.flipLabel.text = [NSString stringWithFormat:@"Flips: %d",self.flipsCount];
}

- (IBAction)flipCard:(UIButton *)sender {
    
    //the line below is important
    [self.game selectCardAtIndex:[self.buttons indexOfObject:sender]];
    [self updateUI];
    
}

- (void)resetHistory{
    self.history = nil;
    self.historySlider.minimumValue=0;
    self.historySlider.maximumValue=0;
    self.historySlider.enabled = NO;
    
}

-(void)viewDidLoad{
    [self reset];
}
- (IBAction)reset {
    [self resetHistory];
    self.matchLabel.text = @"";
    self.flipsCount = 0;
    self.deck = [[SetDeck alloc ]init];
    self.game = [[TheSetGame alloc] initWithCardCount:self.buttons.count
                                                 usingDeck:(Deck *)self.deck];
    [self updateCardButtons];
    self.scoreLabel.text = @"Score: 0";

}
- (IBAction)slide:(UISlider *)sender {
    
    NSMutableAttributedString *message = self.history[(int)sender.value];
    self.matchLabel.attributedText = message;
    self.matchLabel.alpha = 0.5;
}



@end
