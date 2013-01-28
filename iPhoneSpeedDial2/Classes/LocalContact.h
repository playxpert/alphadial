//
//  LocalContact.h
//  iPhoneSpeedDial
//
//  Created by Geykel on 9/8/08.
//  Copyright 2008 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AddressBook/ABPerson.h>
#import <AddressBook/ABAddressBook.h>
#import <sqlite3.h>

@interface LocalContact : NSObject {
	sqlite3 *database;
	
	NSInteger primaryKey;
	NSString *combo;
	NSString *phone;
	NSInteger *abrecordid;
	
	BOOL hydrated;
	BOOL dirty;
}

@property (assign, nonatomic) NSInteger primaryKey;
@property (copy, nonatomic) NSString *combo;
@property (copy, nonatomic) NSString *phone;

+ (void)finalizeStatements;

- (id)initWithPrimaryKey:(NSInteger)pk combo:(NSString *)combo database:(sqlite3 *)db;
- (void)insertIntoDatabase:(sqlite3 *)database;
- (void)deleteFromDatabase;
- (void)deleteFromDatabaseByCombo;
- (id)getByCombo:(sqlite3 *)db;

- (void)hydrate;
- (void)dehydrate;

@end
