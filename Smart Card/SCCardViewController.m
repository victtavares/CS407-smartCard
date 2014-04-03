//
//  SCCardViewController.m
//  Smart Card
//
//  Created by Victor Tavares on 3/26/14.
//  Copyright (c) 2014 CS407. All rights reserved.
//

#import "SCCardViewController.h"
#import "Card+CRUD.h"

@interface SCCardViewController ()
@property (weak, nonatomic) IBOutlet UITextView *cardTextView;
@property (weak, nonatomic) IBOutlet UILabel *sideLabel;
@property (strong,nonatomic) NSString *sideAText;
@property (strong,nonatomic) NSString *sideBText;
@property (nonatomic) BOOL isSideA;

@end

@implementation SCCardViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}



- (void)viewDidLoad
{
    [super viewDidLoad];
    [self setSideA];
    
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma Mark - Button Pressed

- (IBAction)saveButtonPressed:(id)sender {
    if (!self.isSideA) {
    	self.sideBText = self.cardTextView.text;
	}
    
    BOOL isAdd = [Card addCardWithContentA:self.sideAText inContentB:self.sideBText inDeck:self.deck intoManagedObjectContext:[self.deck managedObjectContext]];
    if (isAdd) {
    [self clearHistory];
    [self setSideA];
    }else {
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"Blank Field" message:@"The card could not be added,one of the fields are blank!"
                                                      delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:nil];
        [alert show];
    }
    
}



- (IBAction)FlipButtonPressed:(id)sender {
    if (self.isSideA) {
    	self.sideAText = _cardTextView.text;
    	self.cardTextView.text = self.sideBText;
    	[self setSideB];
	} else {
    	self.sideBText = _cardTextView.text;
    	self.cardTextView.text =_sideAText;
    	[self setSideA];
	}
    
}

#pragma Mark - Aux Functions
- (void) setSideA {
    self.sideLabel.text = @"Side A";
    self.isSideA = YES;
}

- (void) setSideB {
    self.sideLabel.text = @"Side B";
    self.isSideA = NO;
}

-(void) clearHistory {
    self.cardTextView.text = nil;
    self.sideBText = nil;
    self.sideAText = nil;
}



- (IBAction)doneButtonPressed:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
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
