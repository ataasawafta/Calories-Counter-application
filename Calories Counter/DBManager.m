
#import "DBManager.h"
#import <sqlite3.h>
@implementation DBManager
{
    sqlite3 *sqlite3Database;
}

@synthesize  documentsDirectory,databaseFilename,arrResults,arrColumnNames;

-(instancetype)initWithDatabaseFilename:(NSString *)dbFilename{
    
    self = [super init];
    if(self !=nil)
    {
       
        NSArray* DBPath =NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
        self.documentsDirectory =[DBPath objectAtIndex:0];
        self.databaseFilename =dbFilename;
        [self copyDataBase];
        
    }
    return self;
}

-(void) copyDataBase
{
    
    NSString *destinationPath = [self.documentsDirectory stringByAppendingPathComponent:self.databaseFilename];
    if (![[NSFileManager defaultManager] fileExistsAtPath:destinationPath]) {
     
        NSString *sourcePath = [[[NSBundle mainBundle] resourcePath] stringByAppendingPathComponent:self.databaseFilename];
        NSError *error;
        [[NSFileManager defaultManager] copyItemAtPath:sourcePath toPath:destinationPath error:&error];
        if (error != nil) {
            NSLog(@"%@", [error localizedDescription]);
        }
    }
  
}

-(void)runQuery:(const char *)query isQueryExecutable:(BOOL)queryExecutable
{
//query ="DELETE from Exerciselist;";
    
  //  query="create table  userInfo  ( Name string ,Email string primary key ,Password string ,Birthday date,Gender char(1),Weight integer (3) ,TargetWeight integer(3) ,Height integer(3),Time integer (4),ID string (50));";
   
    //**// query="create table  Breakfast (email string ,foodName string ,calories float (5),datef  date , FOREIGN KEY(email) REFERENCES userInfo(email));";
    
    
  //**//  query="create table  Lunch (email string ,foodName string ,calories float (5),datef  date, FOREIGN KEY(email) REFERENCES userInfo(email));";
    
    
    
    
    //**//query="create table  Water (email string ,count  integer(3),datef  date, FOREIGN KEY(email) REFERENCES userInfo(email));";
  
    
  //**//  query="create table  Snack (email string ,foodName string ,calories float (5),datef  date, FOREIGN KEY(email) REFERENCES userInfo(email));";
    
    //**// query="create table  Dinner (email string, foodName string ,calories float(5),datef  date, FOREIGN KEY(email) REFERENCES userInfo(email));";
    
   //**// query ="create table Exercise (email string ,execriseName string ,calories float (5),datef  date, FOREIGN KEY(email) REFERENCES userInfo(email));";
    
//**//  query ="Create table  breakfastlist (name string primary key ,calories float(4),weight float (4));";
    
    
    
//**// query ="Create table breakfastfavoritelist (name string, Favorite int(1),email string ,FOREIGN KEY(email) REFERENCES userInfo(email),FOREIGN KEY(name) REFERENCES breakfastlist(name),primary key (name,email,Favorite));";
//**//  query ="Create table  Lunchlist (name string primary key ,calories float(4),weight float(4));";
    
   //**///  query ="Create table lunchfavoritelist (name string, Favorite int(1),email string ,FOREIGN KEY(email) REFERENCES userInfo(email),FOREIGN KEY(name) REFERENCES Lunchlist(name),primary key (name,email,Favorite));";
    //**//
 //   query ="Create table   Dinnerlist (name string primary key ,calories float(4),weight float(4));";
  //**//    query ="Create table Dinnerfavoritelist (name string, Favorite int(1),email string ,FOREIGN KEY(email) REFERENCES userInfo(email),FOREIGN KEY(name) REFERENCES Dinnerlist(name),primary key (name,email,Favorite));";
//**//   query ="Create table  Snacklist (name string primary key ,calories float (4),weight float (4));";
    
   //**//   query ="Create table Snackfavoritelist (name string, Favorite int(1),email string ,FOREIGN KEY(email) REFERENCES userInfo(email),FOREIGN KEY(name) REFERENCES Snacklist(name),primary key (name,email,Favorite));";
    
   //**// query="create table Exerciselist (ExerciseName string Primary Key,time float(5),calories   float (5));";
//**//query ="Create table Exercisefavoritelist (name string, Favorite int(1),email string ,FOREIGN KEY(email) REFERENCES userInfo(email),FOREIGN KEY(name) REFERENCES Exerciselist(ExerciseName),primary key (name,email,Favorite));";
 //  query ="DELETE  from userInfo;";
    
    NSString *databasePath = [self.documentsDirectory stringByAppendingPathComponent:self.databaseFilename];
    
    if (self.arrResults != nil)
    {
        [self.arrResults removeAllObjects];
        self.arrResults = nil;
    }
    self.arrResults = [[NSMutableArray alloc] init];

    if (self.arrColumnNames != nil)
    {
        [self.arrColumnNames removeAllObjects];
        self.arrColumnNames = nil;
    
    }
    self.arrColumnNames = [[NSMutableArray alloc] init];
    
    BOOL openDatabaseResult = sqlite3_open([databasePath UTF8String], &sqlite3Database);
    
    if(openDatabaseResult == SQLITE_OK) {
        
        sqlite3_stmt *compiledStatement;

        BOOL prepareStatementResult = sqlite3_prepare_v2(sqlite3Database, query, -1, &compiledStatement, NULL);
        
        if(prepareStatementResult == SQLITE_OK) {
            if (!queryExecutable){
                
                              NSMutableArray *arrDataRow;
                             while(sqlite3_step(compiledStatement) == SQLITE_ROW) {
                 
                    arrDataRow = [[NSMutableArray alloc] init];
                    
                    int totalColumns = sqlite3_column_count(compiledStatement);
                    
         
                    for (int i=0; i<totalColumns; i++){
                
                        char *dbDataAsChars = (char *)sqlite3_column_text(compiledStatement, i);
           
                        if (dbDataAsChars != NULL) {
                   
                            [arrDataRow addObject:[NSString  stringWithUTF8String:dbDataAsChars]];
                        }
                        
            
                        if (self.arrColumnNames.count != totalColumns) {
                            dbDataAsChars = (char *)sqlite3_column_name(compiledStatement, i);
                            [self.arrColumnNames addObject:[NSString stringWithUTF8String:dbDataAsChars]];
                        }
                    }
                   
                    if (arrDataRow.count > 0) {
                        [self.arrResults addObject:arrDataRow];
                    }
                }
            }
            
        }
        else {
            NSLog(@"%s ", sqlite3_errmsg(sqlite3Database));
        }
        sqlite3_finalize(compiledStatement);
        
    }

    sqlite3_close(sqlite3Database);
}

-(NSArray *)loadDataFromDB:(NSString *)query{
    [self runQuery:[query UTF8String] isQueryExecutable:NO];
    return (NSArray *)self.arrResults;
}
-(void)executeQuery:(NSString *)query{
    [self runQuery:[query UTF8String] isQueryExecutable:NO];
}

@end
