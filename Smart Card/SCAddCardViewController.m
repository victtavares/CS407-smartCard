//
//  SCAddCardViewController.m
//  Smart Card
//
//  Created by Victor Tavares on 4/30/14.
//  Copyright (c) 2014 CS407. All rights reserved.
//

#import "SCAddCardViewController.h"

@interface SCAddCardViewController () < UITextViewDelegate>
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
@property (weak, nonatomic) IBOutlet UITextView *textViewB;
@property (weak, nonatomic) IBOutlet UITextView *textViewA;
@property (weak, nonatomic) IBOutlet UIView *cardAView;
@property (weak, nonatomic) IBOutlet UIView *cardBView;
@property (nonatomic) CGRect selectedTextViewCoordinates;
@property (nonatomic) CGRect textViewACoordinates;
@property (nonatomic) CGRect textViewBCoordinates;



@end

@implementation SCAddCardViewController

- (void) viewWillAppear:(BOOL)animated {
    [self registerForKeyboardNotifications];
}

- (void) viewDidLayoutSubviews {
    //Making Palceholder
    NSString *message = @"Put a text or a image here";
    self.textViewA.text = message;
    self.textViewB.text = message;
    self.textViewA.textColor = [UIColor lightGrayColor];
    self.textViewB.textColor = [UIColor lightGrayColor];
    self.textViewA.delegate = self;
    self.textViewB.delegate = self;
   
    //coordinates
    self.textViewACoordinates = self.cardAView.frame;
    self.textViewBCoordinates = CGRectMake(self.cardBView.frame.origin.x,self.cardBView.frame.origin.y + 140, self.textViewB.frame.size.width, self.textViewB.frame.size.height);
    
    
    self.cardAView.layer.cornerRadius = 10;
    self.cardBView.layer.cornerRadius = 10;
    self.cardAView.layer.masksToBounds = YES;
    self.cardBView.layer.masksToBounds = YES;
    [self.scrollView setContentSize:CGSizeMake(320, 480)];
}

- (void)viewDidLoad
{
    [super viewDidLoad];

    
    // Do any additional setup after loading the view.
}



- (void)registerForKeyboardNotifications
{
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWasShown:)
                                                 name:UIKeyboardDidShowNotification object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillBeHidden:)
                                                 name:UIKeyboardWillHideNotification object:nil];
    
}


- (void)keyboardWasShown:(NSNotification*)aNotification
{
   NSDictionary* info = [aNotification userInfo];
    CGSize kbSize = [[info objectForKey:UIKeyboardFrameBeginUserInfoKey] CGRectValue].size;
    
    UIEdgeInsets contentInsets = UIEdgeInsetsMake(0.0, 0.0, kbSize.height, 0.0);
    self.scrollView.contentInset = contentInsets;
    self.scrollView.scrollIndicatorInsets = contentInsets;
    // If active text field is hidden by keyboard, scroll it so it's visible
    // Your app might not need or want this behavior.
    CGRect aRect = self.view.frame;
    aRect.size.height -= kbSize.height;
    if (!CGRectContainsPoint(aRect, self.selectedTextViewCoordinates.origin) ) {
    [self.scrollView scrollRectToVisible:self.selectedTextViewCoordinates animated:YES];
    }
   

}
- (void)keyboardWillBeHidden:(NSNotification*)aNotification
{
    UIEdgeInsets contentInsets = UIEdgeInsetsZero;
    self.scrollView.contentInset = contentInsets;
    self.scrollView.scrollIndicatorInsets = contentInsets;
}


- (BOOL) textViewShouldBeginEditing:(UITextView *)textView
{
    textView.text = @"";
    textView.textColor = [UIColor blackColor];
    return YES;
}

-(void) textViewDidChange:(UITextView *)textView
{
    
    if(textView.text.length == 0){
        textView.textColor = [UIColor lightGrayColor];
        textView.text = @"Put a text or a image here";
        [textView resignFirstResponder];
    }
}

-(void) textViewDidBeginEditing:(UITextView *)textView {
    if ([textView isEqual:self.textViewB]) {
        self.selectedTextViewCoordinates = self.textViewBCoordinates;
        
    }
    
    if ([textView isEqual:self.textViewA]) {
        self.selectedTextViewCoordinates = self.textViewACoordinates;
    }
    [self.scrollView scrollRectToVisible:self.selectedTextViewCoordinates animated:YES];
    
    

}

-(void) textViewDidEndEditing:(UITextView *)textView {
    self.selectedTextViewCoordinates = CGRectNull;
    if(textView.text.length == 0){
        textView.textColor = [UIColor lightGrayColor];
        textView.text = @"Put a text or a image here";
        [textView resignFirstResponder];
    }
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
- (IBAction)cancelButtonPressed:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

@end
