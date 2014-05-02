//
//  SCModifyViewController.m
//  Smart Card
//
//  Created by Victor Tavares on 5/2/14.
//  Copyright (c) 2014 CS407. All rights reserved.
//

#import "SCModifyViewController.h"
#import <MobileCoreServices/MobileCoreServices.h>

@interface SCModifyViewController () < UITextViewDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate>

@end

@implementation SCModifyViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // Do any additional setup after loading the view.
}

#pragma mark - Design

- (void) viewWillAppear:(BOOL)animated {
    [self registerForKeyboardNotifications];
}

- (void) viewDidLayoutSubviews {

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



#pragma mark - Actions

- (IBAction)cameraButtonPressed:(UIButton *)sender {
    //tag 0: camera A |  tag 1: camera B
    if (!sender.tag) self.isCameraA = true;
    else self.isCameraA = false;
    
    UIImagePickerController *imagePicker = [[UIImagePickerController alloc] init];
    imagePicker.delegate = self;
    
    imagePicker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    
    imagePicker.mediaTypes = @[(NSString *) kUTTypeImage];
    
    imagePicker.allowsEditing = YES;
    
    [self presentViewController:imagePicker
                       animated:YES completion:nil];
    
    
}

- (IBAction)cancelButtonPressed:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}
- (void)navigationController:(UINavigationController *)navigationController willShowViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    
    navigationController.navigationBar.tintColor = [UIColor whiteColor];
    
}
- (IBAction)deleteImageAButtonPressed:(id)sender {
    self.imageA.image = nil;
    self.deleteImageA.hidden = YES;
    
}


- (IBAction)deleteImageBButtonPressed:(id)sender {
    self.imageB.image = nil;
    self.deleteImageB.hidden = YES;
}

#pragma mark - UIImagepickercontroller delegate

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info {
    
    UIImage *chosenImage = info[UIImagePickerControllerEditedImage];
    
    if (self.isCameraA) {
        self.imageA.image = chosenImage;
        self.textViewA.text = nil;
        self.deleteImageA.hidden = NO;
    }
    else {
        self.imageB.image = chosenImage;
        self.textViewB.text = nil;
        self.deleteImageB.hidden = NO;
    }
    [picker dismissViewControllerAnimated:YES completion:NULL];
    
}



@end
