//
//  PictureTool.m
//  DessDome
//
//  Created by Jack on 15/9/7.
//  Copyright (c) 2015年 zhr. All rights reserved.
//
//token a95c50e22f6544d6a577c59eafac57a6
#define kPictureUrl @"router.do?method=clm.res.banner.get"
#import "Picture.h"
#import "PictureTool.h"

@implementation PictureTool
+(void)pictureListBySuccess:(void (^)(NSArray *pictuList, NSString *errorCode, NSString *errorMsg))success Fail:(void (^)(NSString *error))fail{
    NSDictionary   * dic = @{
                             @"token":kToken
                             };
    MyCommonHttpRequest(dic, kPictureUrl, ^(id responseObject) {
        //NSLog(@"---%@",responseObject);
        if (success) {
            if ([responseObject[@"executeStatus"] integerValue]==0) {
                NSArray   * array = responseObject[@"values"];
                [PictureTool deleGateArray];
                [PictureTool addPicturListArray:array];
                NSArray  * picarray = [PictureTool picturArray];
                success(picarray,nil,nil);
            }else{
                NSString *errorCode = [NSString stringWithFormat:@"%@",responseObject[@"errorCode"]];
                NSString *errorMsg = responseObject[@"errorMsg"];
                success(nil,errorCode,errorMsg);
                
            }
        }
    }, ^(NSError *error, NSString *responseString) {
        
    });
    
}
+(void)addPicturListArray:(NSArray *)array{
    for (NSDictionary  *dic in array) {
        Picture   * pic = [NSEntityDescription insertNewObjectForEntityForName:@"Picture" inManagedObjectContext:kAppDelegate.managedObjectContext];
        pic.gotoType = dic[@"gotoType"];
        pic.imgUrl = dic[@"imgUrl"];
        NSDictionary   *params = dic[@"params"];
        pic.crsId = [NSString stringWithFormat:@"%@",params[@"crsId"]];
        pic.crsId = params[@"originType"];
        [DownTool saveDatabase];
    }
}
+(void)deleGateArray{
    return[DownTool deleteDataByEntityName:@"Picture" PredicateWhitFrome:nil];
}

+(NSArray *)picturArray{
    return [DownTool getDataByEntityName:@"Picture" PredicateWhitFrome:nil];
}
@end













