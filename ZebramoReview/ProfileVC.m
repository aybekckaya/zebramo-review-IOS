//
//  ProfileVC.m
//  ZebramoReview
//
//  Created by aybek can kaya on 22/07/15.
//  Copyright (c) 2015 aybek can kaya. All rights reserved.
//

#import "ProfileVC.h"

@interface ProfileVC ()

@end

@implementation ProfileVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
  
    
    [self initializeGUI];
    [self initializePickerViews];
    

    [self testUIWithPresuppliedUserObject:self.user];
    
    [self networkQueryForUserProfileInfoUserID:self.user.ID];
    
}


-(void)testUIWithPresuppliedUserObject:(User *)user
{
    
}




#pragma mark GUI INIT

-(void)initializeGUI
{
    // view Show Surname BG Colors
    UIColor *offColor = [UIColor grayColor];
    UIColor *onColor = [UIColor colorWithR:54 G:215 B:183 A:1.0];
    arrColorsForShowSurname = @[offColor , onColor];
    
    
    // profile Image Borders
    self.imViewProfile.layer.borderColor = [UIColor grayColor].CGColor;
    self.imViewProfile.layer.borderWidth = 1.5;
    
    // textView
    self.twDescription.layer.borderWidth = 1.2;
    self.twDescription.layer.borderColor =[[UIColor grayColor]CGColor];
    
    
    
}


-(void)initializePickerViews
{
    
}


-(void)autoFillInputAreas
{
    
}



#pragma mark PICKERVIEW DELEGATES + DATASOURCES

#pragma mark TEXTFIELD DELEGATES 

#pragma mark TEXTVIEW DELEGATES



#pragma mark NETWORK

/**
    @description : get info with userID from webservice 
    @testNotes : - when writing tests use userID with different Values to get differeent types of datas .
                            - you may use user object as dependency , but it is not recomended.
 */
-(void)networkQueryForUserProfileInfoUserID:(int) userID
{
    
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)saveOnTap:(id)sender
{
    
}
@end
