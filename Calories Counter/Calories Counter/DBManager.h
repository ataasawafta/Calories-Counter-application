#import <Foundation/Foundation.h>
@interface DBManager : NSObject
@property (nonatomic, strong) NSMutableArray *arrColumnNames;
@property (nonatomic, strong) NSString *documentsDirectory;
@property (nonatomic, strong) NSString *databaseFilename;
@property (nonatomic, strong) NSMutableArray *arrResults;
-(NSArray *)loadDataFromDB:(NSString *)query;
-(void)executeQuery:(NSString *)query;


-(void)runQuery:(const char *)query isQueryExecutable:(BOOL)queryExecutable;
-(instancetype)initWithDatabaseFilename:(NSString *)dbFilename;
@end
