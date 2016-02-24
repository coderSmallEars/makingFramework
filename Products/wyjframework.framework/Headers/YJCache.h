
#import <Foundation/Foundation.h>
#import <sqlite3.h>
#import "FMDB.h"


@interface YJCache : NSObject


+ (instancetype)sharedInstence;

//数据缓存
@property (strong,nonatomic)FMDatabase *dataBase;
//清空缓存
- (void)clearBuddylist;


+(void)initialize;

#pragma mark 插入一条
+ (int)insert:(NSData *)allData withCategoryName:(NSString *)categoryName;

#pragma  mark 通过类别更新 缓存
+(BOOL)update:(NSData *)allData withCategoryName:(NSString *)categoryName;

#pragma  mark 通过类别查询
+ (NSData *)queryByCategroy:(NSString *)categoryName;

//查询所有
+ (NSMutableArray *)queryAllCategory;

//删除表
+(void)deleteTable;

//将对象归档
+ (NSData *)dataOfArchiverObject:(id)object forKey:(NSString *)key;

//反归档
+ (id)unarchiverObject:(NSData *)data forKey:(NSString *)key;


+(BOOL)deleteWithCategoryName:(NSString*)categoryName;


@end
