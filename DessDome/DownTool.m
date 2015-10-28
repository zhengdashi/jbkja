//
//  DownTool.m
//  DessDome
//
//  Created by Jack on 15/7/2.
//  Copyright (c) 2015年 zhr. All rights reserved.
//

#import "DownTool.h"

@implementation DownTool
+(void)saveDatabase{
    NSError  * error = nil;
    BOOL  success = [kAppDelegate.managedObjectContext save:&error];
    if (!success) {
        NSLog(@"%@",[error localizedDescription]);
    }
    
}
//添加数据
+(NSArray *)getDataByEntityName:(NSString *)entityName PredicateWhitFrome:(NSString *)format{
    AppDelegate  * appDelegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
    //查询对象实例
    NSManagedObjectContext  * context = appDelegate.managedObjectContext;
    NSFetchRequest  * fetchRequest = [NSFetchRequest fetchRequestWithEntityName:entityName];
    if (format && format.length >0) {
        //查询条件
        NSPredicate  * predicate = [NSPredicate predicateWithFormat:format];
        fetchRequest.predicate = predicate;
    }
    NSError  * error;
    NSArray  * fetchedObjects = [context executeFetchRequest:fetchRequest error:&error];
    if (error ==nil) {
        return fetchedObjects;
    }
    return nil;
}
//删除数据
+(void)deleteDataByEntityName:(NSString *)entityName PredicateWhitFrome:(NSString *)format{
    AppDelegate *appDelegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
    NSManagedObjectContext  * context = appDelegate.managedObjectContext;
    NSFetchRequest  * fetchRequest = [NSFetchRequest fetchRequestWithEntityName:entityName];
    if (format && format.length >0) {
        //查询条件
        NSPredicate  * predicate = [NSPredicate predicateWithFormat:format];
        fetchRequest.predicate = predicate;
    }
    NSError  * error;
    NSArray  * fetchedObjects = [context executeFetchRequest:fetchRequest error:&error];
    for (NSManagedObject  *object in fetchedObjects) {
        //删除实例
        [context deleteObject:object];
        [context save:&error];
    }
    
    
}

+(void)deleteDataByArray:(NSArray *)array{
    for (NSManagedObject  * obje in array) {
        if ([obje isKindOfClass:[NSManagedObject class]]) {
            [kAppDelegate.managedObjectContext deleteObject:obje];
            [DownTool saveDatabase];
        }
    }
    
}

@end

















