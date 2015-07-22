//
//  DAL.h
//  GSK_IpadApp
//
//  Created by mac on 4/14/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
//---
#import <sqlite3.h> 
//---


@interface DAL : UIViewController {
	
    NSString *PlistName;
	NSString *DatabaseName;
	NSString *DatabasePath; // deger olarak sımulatordekı projenin documents klasoru icerisindeki databaseName'in path'ını alacak
}

@property (nonatomic, strong) NSString *DatabaseName;
@property (nonatomic, strong) NSString *DatabasePath;


// Onemli : plistname sonunda uzanti (.plist) olmadan yazilacak
-(id)initwithPlistName:(NSString *)plistname;

//- (void) createDatabaseIfItIsNotExist;
//- (void) SaveToDB;

-(void)DeleteAllFromPlist;


//-(void)WriteToPlistWithKey:(NSString*)_Key Value:(id)Value;
-(id)ReadFromPlistWithKey:(NSString *)_Key;

//-(void)CreatePlistIfNotExist:(NSString*)_PlistName;
-(void)DeleteFromPlistWithKey:(NSString*)_Key;

-(NSArray *)AllKeysInPList;

-(int)NumberOfKeysInPList;

-(BOOL)KeyExists:(NSString *)Key;

// Later 
//-(BOOL)ValueExists:(id) Value;

@end
