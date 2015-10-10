//
//  CGYFMDB.h
//  CGYFMDataBase
//
//  Created by qf on 9/6/15.
//  Copyright (c) 2015 Chakery. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CGYDB : NSObject

//打开数据库（如果不存在，就会自动创建）
-(BOOL)openDatabaseWithName:(NSString *)name;

//创建表
-(BOOL)createTabelWithName:(NSString *)tableName withArray:(NSArray *)array;

//插入数据
-(BOOL)insertInto:(NSString *)tableName WithDictionary:(NSDictionary *)dic;

//更新数据
-(BOOL)update:(NSString *)tableName WithSetValue:(NSDictionary *)dic withWhere:(NSDictionary *)whereDic;

//删除
-(BOOL)del:(NSString *)tableName withWhere:(NSDictionary *)dic;

//查询
-(NSMutableArray *)select:(NSString *)tableName withWhere:(NSDictionary *)dic;

//关闭
-(BOOL)closeDatabase;
@end
