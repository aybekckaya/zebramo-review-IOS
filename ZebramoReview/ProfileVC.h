//
//  ProfileVC.h
//  ZebramoReview
//
//  Created by aybek can kaya on 22/07/15.
//  Copyright (c) 2015 aybek can kaya. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "User.h"
#import "TFJson.h"
#import "TFNetwork.h"
#import "UIColor+Convert.h"
#import "NSString+formInput.h"
#import "MBProgressHUD.h"

@interface ProfileVC : UIViewController<UIPickerViewDataSource , UIPickerViewDelegate , UITextFieldDelegate , UITextViewDelegate>
{
    NSArray *arrColorsForShowSurname;
    
    UIPickerView *pickerOverGarments;
    UIPickerView *pickerUnderGarments;
    UIPickerView *pickerShoeSizes;
    
    
    NSArray *shoeSizes;
    NSArray *overgarments;
    NSArray *undergarments;
    
    MBProgressHUD *CHUD;
    
}

// This will supplied from LoginVC
// For Tests : use this as dependency Injection value
@property(nonatomic,strong) User *user;


// UI

@property (weak, nonatomic) IBOutlet UIScrollView *scrollContents;

@property (weak, nonatomic) IBOutlet UITextField *tfName;
@property (weak, nonatomic) IBOutlet UITextField *tfSurname;
@property (weak, nonatomic) IBOutlet UIView *viewShowSurname;
@property (weak, nonatomic) IBOutlet UITextField *tfOvergarments;
@property (weak, nonatomic) IBOutlet UITextField *tfUndergarments;
@property (weak, nonatomic) IBOutlet UITextField *tfShoeSize;

@property (weak, nonatomic) IBOutlet UITextField *tfEmail;
@property (weak, nonatomic) IBOutlet UITextView *twDescription;
@property (weak, nonatomic) IBOutlet UIImageView *imViewProfile;

- (IBAction)saveOnTap:(id)sender;

@end
