//
//  SCDeckViewController.m
//  Smart Card
//
//  Created by Victor Tavares on 3/13/14.
//  Copyright (c) 2014 CS407. All rights reserved.
//

#import "SCDeckViewController.h"
#import "Deck+CRUD.h"
@interface SCDeckViewController () <UITextFieldDelegate>

@interface SCDeckViewController ()
@property (weak, nonatomic) IBOutlet UISegmentedControl *favoriteSegmentControl;
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

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)saveButtonPressed:(id)sender {
    
    NSMutableArray *cards = [[NSMutableArray alloc] init];
    
    [Deck addDeckWithName:self.nameTextField.text isFavorite:self.favoriteSwitch.isOn withLat:[NSNumber numberWithFloat:30.30] withLon:[NSNumber numberWithFloat:30.30] withCards:cards  intoManagedObjectContext:self.context];
}

#pragma Mark - Text View Delegate
- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [textField resignFirstResponder];
    return NO;
}
@end
