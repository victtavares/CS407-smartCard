//
//  SCDeckViewController.m
//  Smart Card
//
//  Created by Victor Tavares on 3/13/14.
//  Copyright (c) 2014 CS407. All rights reserved.
//

#import "SCDeckViewController.h"
#import "Deck+CRUD.h"
#import "SCCardViewController.h"
@interface SCDeckViewController () <UITextFieldDelegate>
@property (strong,nonatomic) NSMutableArray *cards;
@end


@interface SCDeckViewController ()


//Make some comment


@end

@implementation SCDeckViewController


- (void)viewDidLoad
{
    [super viewDidLoad];
    self.nameTextField.delegate = self;
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
////    if([segue.destinationViewController isKindOfClass:[SCCardViewController class]] ) {
////        SCCardViewController *cvc = (SCCardViewController *) segue.destinationViewController;
////    
////        cvc.cards  = self.cards;
//    }
    
}

- (IBAction)saveButtonPressed:(id)sender {
    
    
}

#pragma Mark - Text View Delegate
- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [textField resignFirstResponder];
    return NO;
}
@end
