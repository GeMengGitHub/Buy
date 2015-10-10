//
//  CGYFMDB.m
//  CGYFMDataBase
//
//  Created by qf on 9/6/15.
//  Copyright (c) 2015 Chakery. All rights reserved.
//

#import "CGYDB.h"
#import "FMDatabase.h"

@interface CGYDB ()
@property (nonatomic, strong) FMDatabase *dataBase;
@end

@implementation CGYDB

//打开建库
-(BOOL)openDatabaseWithName:(NSString *)name{
    if (name.length == 0) return NO;
    
    NSString *filePath = [NSString stringWithFormat:@"%@/Documents/%@.sqlite", NSHomeDirectory(), name];
    _dataBase = [[FMDatabase alloc]initWithPath:filePath];
    NSLog(@"%@", filePath);//show path
    return _dataBase.open;
}

//创建表
-(BOOL)createTabelWithName:(NSString *)tableName withArray:(NSArray *)array{
    if (tableName.length == 0) return NO;
    if (array.count == 0) return NO;
    
    NSMutableString *sql = [[NSMutableString alloc]init];
    [sql appendFormat:@"CREATE TABLE IF NOT EXISTS %@", tableName];
    [sql appendString:@"(sid INTEGER PRIMARY KEY AUTOINCREMENT DEFAULT 0"];
    for (NSString *str in array) {
        [sql appendFormat:@", %@ text", str];
    }
    if ([@"," isEqualToString:[sql substringWithRange:NSMakeRange(sql.length-1, 1)]]) {
        [sql setString:[sql substringToIndex:sql.length-1]];
    }
    [sql appendString:@")"];
    NSLog(@"%@", sql);//show sql
    return [_dataBase executeUpdate:sql];
}

//插入数据
-(BOOL)insertInto:(NSString *)tableName WithDictionary:(NSDictionary *)dic{
    if (tableName.length == 0) return NO;
    if (dic.count == 0) return NO;
    
    NSMutableString *sql = [[NSMutableString alloc]init];
    [sql appendFormat:@"INSERT INTO %@", tableName];
    [sql appendFormat:@"("];
    for (NSString *key in dic) {
        [sql appendFormat:@"%@,", key];
    }
    if ([@"," isEqualToString:[sql substringWithRange:NSMakeRange(sql.length-1, 1)]]) {
        [sql setString:[sql substringToIndex:sql.length-1]];
    }
    [sql appendFormat:@") VALUES("];

    for (NSString *key in dic) {
        [sql appendFormat:@":%@,", key];
    }
    if ([@"," isEqualToString:[sql substringWithRange:NSMakeRange(sql.length-1, 1)]]) {
        [sql setString:[sql substringToIndex:sql.length-1]];
    }
    [sql appendString:@")"];
    NSLog(@"%@",sql);//show sql
    return [_dataBase executeUpdate:sql withParameterDictionary:dic];
}

//更新
-(BOOL)update:(NSString *)tableName WithSetValue:(NSDictionary *)dic withWhere:(NSDictionary *)whereDic{
    if (tableName.length == 0)return NO;
    if (dic.count == 0) return NO;
    
    NSMutableString *sql = [[NSMutableString alloc]init];
    [sql appendFormat:@"UPDATE %@ SET", tableName];
    for (NSString *key in dic) {
        [sql appendFormat:@" %@=:%@,", key, key];
    }
    if ([@"," isEqualToString:[sql substringWithRange:NSMakeRange(sql.length-1, 1)]]) {
        [sql setString:[sql substringToIndex:sql.length-1]];
    }
    //如果有条件
    if (whereDic.count > 0) {
        [sql appendFormat:@" WHERE"];
        for (NSString *key in whereDic) {
            [sql appendFormat:@" %@=:%@ AND", key, key];
        }
        if ([@"AND" isEqualToString:[sql substringWithRange:NSMakeRange(sql.length-3, 3)]]) {
            [sql setString:[sql substringToIndex:sql.length-3]];
        }
    }
    //整合两个dic的值
    NSMutableDictionary *paramDic = [[NSMutableDictionary alloc]init];
    [paramDic addEntriesFromDictionary:dic];
    [paramDic addEntriesFromDictionary:whereDic];
    
    NSLog(@"%@", sql);//show sql
    return [_dataBase executeUpdate:sql withParameterDictionary:paramDic];
}

//删除
-(BOOL)del:(NSString *)tableName withWhere:(NSDictionary *)dic{
    NSMutableString *sql = [[NSMutableString alloc]init];
    if (tableName.length == 0) return NO;
    [sql appendFormat:@"DELETE FROM %@",tableName];
    //如果有条件
    if (dic.count > 0) {
        [sql appendFormat:@" WHERE"];
        for (NSString *key in dic) {
            [sql appendFormat:@" %@=:%@ AND", key, key];
        }
        if ([@"AND" isEqualToString:[sql substringWithRange:NSMakeRange(sql.length-3, 3)]]) {
            [sql setString:[sql substringToIndex:sql.length-3]];
        }
    }
    
    NSLog(@"%@", sql);//show sql
    return [_dataBase executeUpdate:sql withParameterDictionary:dic];
}

//查询
-(NSMutableArray *)select:(NSString *)tableName withWhere:(NSDictionary *)dic{
    NSMutableArray *array = [[NSMutableArray alloc]init];
    NSMutableString *sql = [[NSMutableString alloc]init];
    [sql appendFormat:@"SELECT * FROM %@", tableName];
    //如果有条件
    if (dic.count > 0) {
        [sql appendFormat:@" WHERE"];
        for (NSString *key in dic) {
            [sql appendFormat:@" %@=:%@ AND", key, key];
        }
        if ([@"AND" isEqualToString:[sql substringWithRange:NSMakeRange(sql.length-3, 3)]]) {
            [sql setString:[sql substringToIndex:sql.length-3]];
        }
    }
    FMResultSet *result = [_dataBase executeQuery:sql withParameterDictionary:dic];
    while (result.next) {
        NSMutableDictionary *dict = [[NSMutableDictionary alloc]init];
        for (int i = 0; i < result.columnCount; i ++) {
            [dict setObject:[result stringForColumnIndex:i] forKey:[result columnNameForIndex:i]];
        }
        [array addObject:dict];
    }
    NSLog(@"%@", sql);//show sql
    return array;
}

//关闭数据库
-(BOOL)closeDatabase{
    return [_dataBase close];
}
@end
