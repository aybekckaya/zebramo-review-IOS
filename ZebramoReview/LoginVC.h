//
//  LoginVC.h
//  ZebramoReview
//
//  Created by aybek can kaya on 22/07/15.
//  Copyright (c) 2015 aybek can kaya. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NSString+formInput.h"
#import "MBProgressHUD.h"
#import "TFNetwork.h"
#import "TFJson.h"
#import "User.h"

/**
   Localized strings gerekli mi ?
 
 */


@interface LoginVC : UIViewController<UITextFieldDelegate>
{
    MBProgressHUD *CHUD;
}


@property (weak, nonatomic) IBOutlet UIScrollView *scrollContent;

@property (strong, nonatomic) IBOutletCollection(UIView) NSArray *textboxHolders;


@property (weak, nonatomic) IBOutlet UITextField *tfPassword;
@property (weak, nonatomic) IBOutlet UITextField *tfEmail;


- (IBAction)loginOnTap:(id)sender;

@end
