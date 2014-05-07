//
//  SCGameViewController.m
//  Smart Card
//
//  Created by Fan on 4/23/14.
//  Copyright (c) 2014 CS407. All rights reserved.
//

#import "SCGameViewController.h"
#import "SCCardView.h"
#import "SCDropBehavior.h"
#import "Card.h"

@interface SCGameViewController () <UIDynamicAnimatorDelegate, UIGestureRecognizerDelegate> {
    int numOfButtons;
    BOOL isSteady;
    NSMutableArray *leftColumn;
    NSMutableArray *rightColumn;
    int imageNumber;
    UIImage *cardBackgroundImage;
    int score;
}
@property (weak, nonatomic) IBOutlet UIView *gameView;
@property (strong, nonatomic) UIDynamicAnimator *animator;
@property (strong, nonatomic) SCDropBehavior *dropBehavior;
@property (weak, nonatomic) IBOutlet UIImageView *backgoundImage;
@property (weak, nonatomic) IBOutlet UILabel *scoreLabel;

@end

@implementation SCGameViewController

-(void)losePoint{
    if (score>0) {
        score = score - 1;
        self.scoreLabel.text = [NSString stringWithFormat:@"%d",score];
    }
}

-(void)winPoint{
    score = score + 3;
    self.scoreLabel.text = [NSString stringWithFormat:@"%d",score];
}

- (IBAction)changeBackgroundImage:(id)sender {
    switch (imageNumber) {
        case 0: [self.backgoundImage setImage:[UIImage imageNamed:@"game0"]];
            cardBackgroundImage = [UIImage imageNamed:@"card0"]; break;
        case 1: [self.backgoundImage setImage:[UIImage imageNamed:@"game1"]];
            cardBackgroundImage = [UIImage imageNamed:@"card1"]; break;
        case 2: [self.backgoundImage setImage:[UIImage imageNamed:@"game2"]];
            cardBackgroundImage = [UIImage imageNamed:@"card2"]; break;
        case 3: [self.backgoundImage setImage:[UIImage imageNamed:@"game3"]];
            cardBackgroundImage = [UIImage imageNamed:@"card3"]; break;
        case 4: [self.backgoundImage setImage:[UIImage imageNamed:@"game4"]];
            cardBackgroundImage = [UIImage imageNamed:@"card4"]; break;
        case 5: [self.backgoundImage  setImage:[UIImage imageNamed:@"game5"]];
            cardBackgroundImage = [UIImage imageNamed:@"card5"]; break;
        default:
            break;
    }
    imageNumber = (imageNumber + 1)%6;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    isSteady = YES;
    leftColumn = [[NSMutableArray alloc]init];
    rightColumn = [[NSMutableArray alloc]init];
    //[self setCardsId:self.selectedDeck];
    imageNumber = 1;
    cardBackgroundImage = [UIImage imageNamed:@"card0"];
}

// Side A and Side B of the same card will have the same id, which will be used in matching Side A and Side B
//-(void)setCardsId:(Deck *)deck{
//    NSArray *cards = [deck.cards allObjects];
//    for (Card *card in cards) {
//        car
//    }
//    for (int i=0; i<[cards count]; i++) {
//        Card *card = (Card *)cards[i];
//        
//        card.cardId = [NSNumber numberWithInt:i];
//    }
//}


- (IBAction)dropSideA:(id)sender {
    if (isSteady && [leftColumn count]<=4) {
        isSteady = NO;
        CGRect frame;
        frame.origin = CGPointZero;
        frame.size = CGSizeMake(self.gameView.bounds.size.width/2.0, self.gameView.bounds.size.height/5);
        
        SCCardView *cardView = [[SCCardView alloc]initWithFrame:frame];
        [cardView setSideAfromDeck:self.selectedDeck withImage:cardBackgroundImage];
        
        
        //add index to card view
        [leftColumn addObject:cardView];
        cardView.index = [leftColumn count]-1;
        
        UITapGestureRecognizer *tapGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(flyLeft:)];
        tapGestureRecognizer.delegate = self;
        [cardView.textView addGestureRecognizer:tapGestureRecognizer];
        
        [self.gameView addSubview:cardView];
        [self.dropBehavior addItem:cardView];
    }
}


- (IBAction)dropSideB:(id)sender {
    if (isSteady && [rightColumn count]<=4) {
        isSteady = NO;
        CGRect frame;
        frame.origin = CGPointMake(self.gameView.bounds.size.width/2.0, 0);
        frame.size = CGSizeMake(self.gameView.bounds.size.width/2.0, self.gameView.bounds.size.height/5);
        
        SCCardView *cardView = [[SCCardView alloc]initWithFrame:frame];
        [cardView setSideBfromDeck:self.selectedDeck withImage:cardBackgroundImage];
        
        //add index to cardView
        [rightColumn addObject:cardView];
        cardView.index = [rightColumn count]-1;
        
        
        UITapGestureRecognizer *tapGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(flyRight:)];
        tapGestureRecognizer.delegate = self;
        [cardView.textView addGestureRecognizer:tapGestureRecognizer];
        
        [self.gameView addSubview:cardView];
        [self.dropBehavior addItem:cardView];
    }
}

-(void) flyLeft:(UITapGestureRecognizer *)sender {
    
    if (isSteady) {
        isSteady = NO;
        SCCardView *cardView = (SCCardView *)[sender.view superview];
        [UIView animateWithDuration:0.1 animations:^{
            cardView.center =CGPointMake(cardView.center.x *(-1), cardView.center.y);
        } completion:^(BOOL finished) {
            [self losePoint];
            [cardView removeFromSuperview];
            [self.dropBehavior removeItem:cardView];
            
            //refresh cardView index of those cardView still on screen
            [leftColumn removeObject:cardView];
            for (int i=0; i<[leftColumn count]; i++) {
                SCCardView *cv = [leftColumn objectAtIndex:i];
                cv.index = i;
            }
        }];
    }
}

-(void) flyRight:(UITapGestureRecognizer *)sender {
    if (isSteady) {
        isSteady = NO;
        SCCardView *cardView = (SCCardView *)[sender.view superview];
        [UIView animateWithDuration:0.1 animations:^{
            cardView.center =CGPointMake(cardView.center.x *5/3.0, cardView.center.y);
        } completion:^(BOOL finished) {
            [self losePoint];
            [cardView removeFromSuperview];
            [self.dropBehavior removeItem:cardView];
            
            //refresh cardView index of those cardView still on screen
            [rightColumn removeObject:cardView];
            for (int i=0; i<[rightColumn count]; i++) {
                SCCardView *cv = [rightColumn objectAtIndex:i];
                cv.index = i;
            }
        }];
    }
}

-(void) matchAndCancel {
    int n = MIN([leftColumn count], [rightColumn count]);
    for (int i=0 ; i<n ; i++) {
        SCCardView *cardViewLeft = leftColumn[i];
        SCCardView *cardViewRight = rightColumn[i];
        if ([cardViewLeft.cardId isEqual:cardViewRight.cardId]) {
            [UIView animateWithDuration:1.0
                             animations:^{
                                 cardViewRight.alpha = 0;
                                 cardViewLeft.alpha =0;
                             }
                             completion:^(BOOL finished){
                                 [self winPoint];
                                 [cardViewLeft removeFromSuperview];
                                 [cardViewRight removeFromSuperview];
                                 [self.dropBehavior removeItem:cardViewLeft];
                                 [self.dropBehavior removeItem:cardViewRight];
                                 
                                 //refresh cardView index of those cardView still on screen
                                 [leftColumn removeObject:cardViewLeft];
                                 for (int i=0; i<[leftColumn count]; i++) {
                                     SCCardView *cv = [leftColumn objectAtIndex:i];
                                     cv.index = i;
                                 }
                                 [rightColumn removeObject:cardViewRight];
                                 for (int i=0; i<[rightColumn count]; i++) {
                                     SCCardView *cv = [rightColumn objectAtIndex:i];
                                     cv.index = i;
                                 }
                             }];
        }
    }
    
}


-(void) dynamicAnimatorDidPause:(UIDynamicAnimator *)animator {
    isSteady = YES;
    [self matchAndCancel];
}



#pragma mark - Animation Lazy Instantiation

-(UIDynamicAnimator *)animator {
    if (!_animator) {
        _animator = [[UIDynamicAnimator alloc]initWithReferenceView:self.gameView];
        _animator.delegate = self;
    }
    return _animator;
}

-(SCDropBehavior *)dropBehavior {
    if (!_dropBehavior) {
        _dropBehavior = [[SCDropBehavior alloc] init];
        [self.animator addBehavior:_dropBehavior];
    }
    return _dropBehavior;
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
