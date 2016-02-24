
#import "YJCache.h"
//#import "NSArray+Transform.h"

@interface YJCache ()

@property (nonatomic, retain) NSString * dbPath;

@end

@implementation YJCache

static FMDatabaseQueue *queue;

@synthesize dbPath;


+ (instancetype)sharedInstence
{
    static id instence;
    if (instence == nil) {
        instence = [[self alloc] init];
    }
    return instence;
}


+(void)initialize{
    
    // 0.获得沙盒中的数据库文件名
    NSString *filename = [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject] stringByAppendingPathComponent:@"dealDB.sqlite"];
   // KCLog(@"FMDBpath%@",filename);
    // 1.创建数据库队列
    queue = [FMDatabaseQueue databaseQueueWithPath:filename];
    
    // 2.创表
    [queue inDatabase:^(FMDatabase *dealDB) {
        BOOL result = [dealDB executeUpdate:@"create table if not exists goods (id integer primary key autoincrement, category_name text,allData blob );"];
        if (result) {
          //  KCLog(@"创表成功");
        } else {
         //   KCLog(@"创表失败");
        }
    }];
}

#pragma mark 插入一条
+ (int)insert:(NSData *)allData withCategoryName:(NSString *)categoryName{
    
    [queue inDatabase:^(FMDatabase *dealDB) {
        [dealDB executeUpdate:@"insert into goods (category_name,allData) values(?,?);;",categoryName,allData];
    }];
    
    return 1;
    
}

#pragma  mark 通过类别更新 缓存
+(BOOL)update:(NSData *)allData withCategoryName:(NSString *)categoryName{
    [queue inDatabase:^(FMDatabase *dealDB) {
        
        [dealDB executeUpdate:@"update goods set allData = ? where category_name = ?;", allData, categoryName];
        
    }];
    return 1;
}

#pragma  mark 通过类别查询
+ (NSData *)queryByCategroy:(NSString *)categoryName
{
    __block NSData *data=nil;
    [queue inDatabase:^(FMDatabase *dealDB) {
        // 1.查询数据
        FMResultSet *rs = [dealDB executeQuery:@"select * from goods where category_name = ?;", categoryName];
        
        // 2.遍历结果集
        if(rs.next) {
            data = [rs dataForColumn:@"allData"];
        }else{
            data=nil;
        }
        [rs close];
    }];
    return data;
}
//查询所有
+ (NSMutableArray*)queryAllCategory
{
    NSMutableArray*dataArray=[NSMutableArray array];
    __block NSData *data=nil;
    [queue inDatabase:^(FMDatabase *dealDB) {
        
        
        // 1.查询数据
        
        
        FMResultSet *rs = [dealDB executeQuery:@"select * from goods"];
        while ([rs next]) {
            //retrieve values for each record
            data = [rs dataForColumn:@"allData"];
            [dataArray addObject:data];
        }
        //        else{
        //            data=nil;
        //        }
        
        [rs close];
    }];
    return dataArray;
}
//将对象归档
+ (NSData *)dataOfArchiverObject:(id)object forKey:(NSString *)key
{
    NSMutableData * data = [NSMutableData data];
    
    NSKeyedArchiver * archiver = [[NSKeyedArchiver alloc] initForWritingWithMutableData:data];
    
    [archiver encodeObject:object forKey:key];
    [archiver finishEncoding];
    
    
    return data;
}

//反归档
+ (id)unarchiverObject:(NSData *)data forKey:(NSString *)key
{
    NSKeyedUnarchiver * unarchiver = [[NSKeyedUnarchiver alloc] initForReadingWithData:data];
    
    id object = [unarchiver decodeObjectForKey:key];
    [unarchiver finishDecoding];
    
    
    return object;
}

//删除一条数据
+(BOOL)deleteWithCategoryName:(NSString*)categoryName{
    
    [queue inDatabase:^(FMDatabase *dealDB) {
        
        [dealDB executeUpdate:@"delete from goods where category_name = ?",categoryName];
        
    }];
    
    return YES;
    
}



//删除表
+(void)deleteTable
{

    [queue inDatabase:^(FMDatabase *dealDB) {
        
        
        [dealDB executeUpdate:@"TRUNCATE TABLE customers"];
        
    }];
    
}



- (void)clearBuddylist
{
    if ([self.dataBase executeUpdate:@"DELETE FROM t_buddySorted"]) {
        NSLog(@"删除原始数据");
    }
}

//- (NSArray *)getbuddylist
//{
//    FMResultSet *set = nil;
//    set =  [self.dataBase executeQuery:@"SELECT * FROM t_buddySorted;"];
//    NSMutableArray *resultArr = [NSMutableArray array];
//    while ([set next]) {
//        NSData *data = [set dataForColumn:@"dict"];
//        SectionBase *base = [SectionBase objectWithJSONData:data];
//        [resultArr addObject:base];
//    }
//    return resultArr.copy;
//}
//
//- (void)savebuddyWith:(NSDictionary *)dict
//{
//    //二进制
//    NSData *data = [NSJSONSerialization dataWithJSONObject:dict options:NSJSONWritingPrettyPrinted error:nil];
//    BOOL success =  [self.dataBase executeUpdate:@"INSERT INTO t_buddySorted(dict) VALUES(?);",data];
//    if (success) {
//        KCLog(@"插入数据成功");
//    }else{
//        KCLog(@"插入数据失败!");
//    }
//}
//
//#pragma make -getter
//- (FMDatabase *)dataBase
//{
//    if (_dataBase == nil) {
//        NSString *path = [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)lastObject]stringByAppendingPathComponent:@"buddyList.sqlite"];
//        _dataBase = [FMDatabase databaseWithPath:path];
//        if ([_dataBase open]) {
//            BOOL success =   [_dataBase executeUpdate:@"CREATE TABLE IF NOT EXISTS t_buddySorted(id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL, dict BLOB NOT NULL);"];
//            if (success) {
//                KCLog(@"创建表成功!");
//            }else{
//                KCLog(@"创建表失败");
//            }
//        }else{
//            KCLog(@"打开数据库失败");
//        }
//    }
//    return _dataBase;
//}







@end
