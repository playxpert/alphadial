//
//  iPhoneSpeedDialAppDelegate.m
//  iPhoneSpeedDial
//
//  Created by Geykel on 9/5/08.
//  Copyright __MyCompanyName__ 2008. All rights reserved.
//

#import "Alpha_DialAppDelegate.h"
#import "LocalContact.h"

@interface Alpha_DialAppDelegate (Private)
- (void)createEditableCopyOfDatabaseIfNeeded;
- (void)initializeDatabase;
@end

@implementation Alpha_DialAppDelegate

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
		const char *sql = "select abrecordid, combo FROM contact";
        sqlite3_stmt *statement;
        
		if (sqlite3_prepare_v2(database, sql, -1, &statement, NULL) == SQLITE_OK) {
            while (sqlite3_step(statement) == SQLITE_ROW) {
            	int primaryKey = sqlite3_column_int(statement, 0);
				
				char *str = (char *)sqlite3_column_text(statement, 1);
				
				LocalContact *localContact = [[LocalContact alloc] initWithPrimaryKey:primaryKey combo:(str)?[NSString stringWithUTF8String:str]:@"" database:database];
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

-(void)saveContact:(LocalContact *) aLocalContact {
	[aLocalContact deleteFromDatabaseByCombo];
	[aLocalContact insertIntoDatabase:database];
	int oldContactId = -1;
	for (int i = 0; i < [localContactList count]; i++) {
		LocalContact *contact = [localContactList objectAtIndex:i];
		if ([contact.combo isEqualToString:aLocalContact.combo]) {
			oldContactId = i;
		}
	}
	if (oldContactId != -1) {
		[localContactList removeObjectAtIndex:oldContactId];
	}
	[localContactList addObject:aLocalContact];
}
-(void)deleteContact:(LocalContact *) aLocalContact {
	int oldContactId = -1;
	for (int i = 0; i < [localContactList count]; i++) {
		LocalContact *contact = [localContactList objectAtIndex:i];
		if ([contact.combo isEqualToString:aLocalContact.combo]) {
			oldContactId = i;
		}
	}
	if (oldContactId != -1) {
		[localContactList removeObjectAtIndex:oldContactId];
	}
	[aLocalContact deleteFromDatabaseByCombo];
}
-(id)getByCombo:(LocalContact *) aLocalContact {
	return [aLocalContact getByCombo:database];
}


@end
