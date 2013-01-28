//
//  LocalContact.m
//  iPhoneSpeedDial
//
//  Created by Geykel on 9/8/08.
//  Copyright 2008 __MyCompanyName__. All rights reserved.
//

#import "LocalContact.h"

static sqlite3_stmt *insert_statement = nil;
static sqlite3_stmt *init_statement = nil;
static sqlite3_stmt *delete_statement = nil;
static sqlite3_stmt *selectbycombo_statement = nil;
static sqlite3_stmt *hydrate_statement = nil;
static sqlite3_stmt *dehydrate_statement = nil;


@implementation LocalContact

+ (void)finalizeStatements {
    if (insert_statement) sqlite3_finalize(insert_statement);
    if (init_statement) sqlite3_finalize(init_statement);
    if (delete_statement) sqlite3_finalize(delete_statement);
    if (selectbycombo_statement) sqlite3_finalize(selectbycombo_statement);
    if (hydrate_statement) sqlite3_finalize(hydrate_statement);
    if (dehydrate_statement) sqlite3_finalize(dehydrate_statement);
}

- (id)initWithPrimaryKey:(NSInteger)pk combo:(NSString *)combo1 database:(sqlite3 *)db{
    if (self = [super init]) {
        primaryKey = pk;
        database = db;
		self.combo = combo1;
        
		if (init_statement == nil) {
            const char *sql = "SELECT combo, phone FROM contact WHERE abrecordid=? and combo=?";
            if (sqlite3_prepare_v2(database, sql, -1, &init_statement, NULL) != SQLITE_OK) {
                NSAssert1(0, @"Error: failed to prepare statement with message '%s'.", sqlite3_errmsg(database));
            }
        }
        
		sqlite3_bind_int(init_statement, 1, primaryKey);
		sqlite3_bind_text(init_statement, 2, [combo UTF8String], -1, SQLITE_TRANSIENT);
		
        if (sqlite3_step(init_statement) == SQLITE_ROW) {
            self.combo = [NSString stringWithUTF8String:(char *)sqlite3_column_text(init_statement, 0)];
			self.phone = [NSString stringWithUTF8String:(char *)sqlite3_column_text(init_statement, 1)];
        } 
		else {
            self.combo = @"";
			self.phone = @"";
        }
		sqlite3_reset(init_statement);
		
        dirty = NO;
    }
    return self;
}

- (void)insertIntoDatabase:(sqlite3 *)db {
    database = db;
    
	if (insert_statement == nil) {
        static char *sql = "INSERT INTO contact (abrecordid, combo, phone) VALUES(?, ?, ?)";
        if (sqlite3_prepare_v2(database, sql, -1, &insert_statement, NULL) != SQLITE_OK) {
            NSAssert1(0, @"Error: failed to prepare statement with message '%s'.", sqlite3_errmsg(database));
        }
    }
	
	sqlite3_bind_int(insert_statement, 1, primaryKey);
    sqlite3_bind_text(insert_statement, 2, [combo UTF8String], -1, SQLITE_TRANSIENT);
	sqlite3_bind_text(insert_statement, 3, [phone UTF8String], -1, SQLITE_TRANSIENT);
	
    int success = sqlite3_step(insert_statement);
    sqlite3_reset(insert_statement);
    
	if (success == SQLITE_ERROR) {
        NSAssert1(0, @"Error: failed to insert into the database with message '%s'.", sqlite3_errmsg(database));
    }
    
	hydrated = YES;
}

- (void)deleteFromDatabase {
    if (delete_statement == nil) {
        const char *sql = "DELETE FROM contact WHERE abrecordid=? and combo=?";
        if (sqlite3_prepare_v2(database, sql, -1, &delete_statement, NULL) != SQLITE_OK) {
            NSAssert1(0, @"Error: failed to prepare statement with message '%s'.", sqlite3_errmsg(database));
        }
    }
    
	sqlite3_bind_int(delete_statement, 1, primaryKey);
	sqlite3_bind_text(delete_statement, 2, [combo UTF8String], -1, SQLITE_TRANSIENT);
	
    int success = sqlite3_step(delete_statement);
    sqlite3_reset(delete_statement);
    
	if (success != SQLITE_DONE) {
        NSAssert1(0, @"Error: failed to delete from database with message '%s'.", sqlite3_errmsg(database));
    }
}
- (void)deleteFromDatabaseByCombo {
    if (delete_statement == nil) {
        const char *sql = "DELETE FROM contact WHERE combo=?";
        if (sqlite3_prepare_v2(database, sql, -1, &delete_statement, NULL) != SQLITE_OK) {
            NSAssert1(0, @"Error: failed to prepare statement with message '%s'.", sqlite3_errmsg(database));
        }
    }
    
    sqlite3_bind_text(delete_statement, 1, [combo UTF8String], -1, SQLITE_TRANSIENT);
    int success = sqlite3_step(delete_statement);
    sqlite3_reset(delete_statement);
    
	if (success != SQLITE_DONE) {
        NSAssert1(0, @"Error: failed to delete from database with message '%s'.", sqlite3_errmsg(database));
    }
}


- (id)getByCombo:(sqlite3 *)db {
	database = db;
	if (selectbycombo_statement == nil) {
        const char *sql = "select abrecordid, combo, phone FROM contact WHERE combo=?";
        if (sqlite3_prepare_v2(database, sql, -1, &selectbycombo_statement, NULL) != SQLITE_OK) {
            NSAssert1(0, @"Error: failed to prepare statement with message '%s'.", sqlite3_errmsg(database));
        }
    }
    sqlite3_bind_text(selectbycombo_statement, 1, [combo UTF8String], -1, SQLITE_TRANSIENT);
    int success = sqlite3_step(selectbycombo_statement);
	if (success == SQLITE_ROW) {
		self.primaryKey = sqlite3_column_int(selectbycombo_statement, 0);
		char *str = (char *)sqlite3_column_text(selectbycombo_statement, 1);
		self.combo = (str) ? [NSString stringWithUTF8String:str]:@"";
		str = (char *)sqlite3_column_text(selectbycombo_statement, 2);
		self.phone = (str) ? [NSString stringWithUTF8String:str]:@"";
	} 
	else {
		self.primaryKey = 0;
		self.phone = @"";
	}
	
    sqlite3_reset(selectbycombo_statement);
	return self;
}

- (void)hydrate {
    if (hydrated) return;
    
	if (hydrate_statement == nil) {
        const char *sql = "SELECT combo, phone FROM contact WHERE abrecordid=? and combo=?";
        if (sqlite3_prepare_v2(database, sql, -1, &hydrate_statement, NULL) != SQLITE_OK) {
            NSAssert1(0, @"Error: failed to prepare statement with message '%s'.", sqlite3_errmsg(database));
        }
    }
    
	sqlite3_bind_int(hydrate_statement, 1, primaryKey);
    sqlite3_bind_text(hydrate_statement, 2, [combo UTF8String], -1, SQLITE_TRANSIENT);
    
	int success = sqlite3_step(hydrate_statement);
    if (success == SQLITE_ROW) {
        char *str = (char *)sqlite3_column_text(hydrate_statement, 0);
        self.combo = (str) ? [NSString stringWithUTF8String:str] : @"";
		
		char *str1 = (char *)sqlite3_column_text(hydrate_statement, 1);
        self.phone = (str1) ? [NSString stringWithUTF8String:str] : @"";
	} 
	else {
        self.combo = @"";
		self.phone = @"";
	}
    
	sqlite3_reset(hydrate_statement);
    
	hydrated = YES;
}

- (void)dehydrate {
    if (dirty) {
        if (dehydrate_statement == nil) {
            const char *sql = "UPDATE contact SET combo=?,phone=? WHERE abrecordid=? and combo=?";
            if (sqlite3_prepare_v2(database, sql, -1, &dehydrate_statement, NULL) != SQLITE_OK) {
                NSAssert1(0, @"Error: failed to prepare statement with message '%s'.", sqlite3_errmsg(database));
            }
        }
        
		sqlite3_bind_text(dehydrate_statement, 1, [combo UTF8String], -1, SQLITE_TRANSIENT);
		sqlite3_bind_text(dehydrate_statement, 2, [phone UTF8String], -1, SQLITE_TRANSIENT);
        sqlite3_bind_int(dehydrate_statement, 3, primaryKey);
		sqlite3_bind_text(dehydrate_statement, 4, [combo UTF8String], -1, SQLITE_TRANSIENT);
        
		int success = sqlite3_step(dehydrate_statement);
        
		sqlite3_reset(dehydrate_statement);
        
		if (success != SQLITE_DONE) {
            NSAssert1(0, @"Error: failed to dehydrate with message '%s'.", sqlite3_errmsg(database));
        }
        
		dirty = NO;
    }
    
	[combo release];
    combo = nil;
	
	[phone release];
	phone = nil;
    
	hydrated = NO;
}

- (void)dealloc {
    [combo release];
	[phone release];
    [super dealloc];
}

#pragma mark Properties

- (NSInteger)primaryKey {
    return primaryKey;
}

- (void)setPrimaryKey:(NSInteger)aInteger {
    if ((!primaryKey && !aInteger)) return;
    dirty = YES;
    primaryKey = aInteger;
}


- (NSString *)combo {
    return combo;
}

- (void)setCombo:(NSString *)aString {
    if ((!combo && !aString) || (combo && aString && [combo isEqualToString:aString])) return;
    dirty = YES;
    [combo release];
    combo = [aString copy];
}

- (NSString *)phone {
    return phone;
}

- (void)setPhone:(NSString *)aString {
    if ((!phone && !aString) || (phone && aString && [phone isEqualToString:aString])) return;
    dirty = YES;
    [phone release];
    phone = [aString copy];
}


@end
