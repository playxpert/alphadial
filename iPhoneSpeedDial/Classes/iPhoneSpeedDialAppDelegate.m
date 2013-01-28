//
//  iPhoneSpeedDialAppDelegate.m
//  iPhoneSpeedDial
//
//  Created by Geykel on 9/5/08.
//  Copyright __MyCompanyName__ 2008. All rights reserved.
//

#import "iPhoneSpeedDialAppDelegate.h"
#import "LocalContact.h"

@interface iPhoneSpeedDialAppDelegate (Private)
- (void)createEditableCopyOfDatabaseIfNeeded;
- (void)initializeDatabase;
@end

@implementation iPhoneSpeedDialAppDelegate

@synthesize window, tabBarController, localContactList;

- (void)applicationDidFinishLaunching:(UIApplication *)application {
	[self createEditableCopyOfDatabaseIfNeeded];
	[self initializeDatabase];
	
	[window addSubview:tabBarController.view];
	[window makeKeyAndVisible];
}


- (void)dealloc {
	[localContactList release];
	[tabBarController release];
	[window release];
	[super dealloc];
}

- (void)createEditableCopyOfDatabaseIfNeeded {
    BOOL success;
    NSFileManager *fileManager = [NSFileManager defaultManager];
    NSError *error;
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    NSString *writableDBPath = [documentsDirectory stringByAppendingPathComponent:@"contactdb.sql"];
    
	success = [fileManager fileExistsAtPath:writableDBPath];
    if (success) return;
    
	NSString *defaultDBPath = [[[NSBundle mainBundle] resourcePath] stringByAppendingPathComponent:@"contactdb.sql"];
    
	success = [fileManager copyItemAtPath:defaultDBPath toPath:writableDBPath error:&error];
    if (!success) {
        NSAssert1(0, @"Failed to create writable database file with message '%@'.", [error localizedDescription]);
    }
}

- (void)initializeDatabase {
	NSMutableArray *localContactArray = [[NSMutableArray alloc] init];
    self.localContactList = localContactArray;
    [localContactArray release];
    
	NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    NSString *path = [documentsDirectory stringByAppendingPathComponent:@"contactdb.sql"];
    
	if (sqlite3_open([path UTF8String], &database) == SQLITE_OK) {        
		const char *sql = "SELECT * FROM contact";
        sqlite3_stmt *statement;
        
		if (sqlite3_prepare_v2(database, sql, -1, &statement, NULL) == SQLITE_OK) {
            while (sqlite3_step(statement) == SQLITE_ROW) {
            	int primaryKey = sqlite3_column_int(statement, 0);				
				LocalContact *localContact = [[LocalContact alloc] initWithPrimaryKey:primaryKey database:database];
                [localContactList addObject:localContact];
                [localContact release];
            }
        }
        
		sqlite3_finalize(statement);
    } 
	else {        
		sqlite3_close(database);
        NSAssert1(0, @"Failed to open database with message '%s'.", sqlite3_errmsg(database));
	}
}

@end
