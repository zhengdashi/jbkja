//
//  CourseTool.m
//  DessDome
//
//  Created by Jack on 15/9/8.
//  Copyright (c) 2015年 zhr. All rights reserved.
//
#define kPublicCourseLoginUrl @"router.do?method=clm.res.qida.course.search"  //已登录的公共课程URL
#define kInteriorCourseUrl @"router.do?method=clm.res.crs.course.list" //内部课程URL..
#define kCourseDetailUrl @"pub/router.do?method=clm.res.course.detail.get" //课程介绍
#define kCourseChapter @"pub/router.do?method=clm.res.course.catalog.get"//课程详情
#define kReviewquery @"pub/router.do?method=clm.res.course.remark.list"//课程评论查询

#import "CourseTool.h"
#import "Course.h"
#import "CourseDetail.h"
#import "CourseComment.h"
#import "DownLoadTool.h"
#import "CourseInfo.h"

@implementation CourseTool

//删除数据
+(void)delegateCourse:(NSString *)entert Condilet:(NSString *)frome{
    [DownTool deleteDataByEntityName:entert PredicateWhitFrome:frome];
}
//添加对象
+(void)addCourseArray:(NSArray *)array ByType:(NSString *)type{
    for (NSDictionary  * dict in array) {
        Course  * course = [NSEntityDescription insertNewObjectForEntityForName:@"Course" inManagedObjectContext:kAppDelegate.managedObjectContext];
        course.name = dict[@"name"];
        course.courseId = [NSString stringWithFormat:@"%@",dict[@"id"]];
        NSString  * dateStr = dict[@"releaseDate"];
        if (dateStr.length>11) {
            dateStr = [dateStr substringToIndex:11];
        }
       // NSLog(@"---%@",dateStr);
        if (!course.originType) {
            course.originType = @"Q";
        }
        course.releaseDate = dateStr;
        course.courseType = type;
        course.imgPath = dict[@"imgPath"];
        course.grade = [dict[@"grade"] integerValue];
        [DownTool saveDatabase];
    }
}
+(NSArray *)addArrayCourse:(NSString *)array Condile:(NSString *)frome{
    return [DownTool getDataByEntityName:array PredicateWhitFrome:frome];
}


+(void)addCourseDetail:(NSDictionary *)dict OryType:(NSString *)type{
    CourseDetail   * detail = [NSEntityDescription insertNewObjectForEntityForName:@"CourseDetail" inManagedObjectContext:kAppDelegate.managedObjectContext];
    detail.folderName = dict[@"categoryName"];
   // detail.countNote = [NSNumber numberWithInt:[dict[@"countNote"]integerValue]];
    detail.desc = dict[@"description"];
    
    detail.grade = [NSString stringWithFormat:@"%@",dict[@"grade"]];
    detail.courseId = [NSString stringWithFormat:@"%@",dict[@"id"]];
    detail.imgPath = dict[@"imgPath"];
    detail.isHidden = [dict[@"isHidden"] boolValue];
    detail.isNew = [dict[@"isNew"]boolValue];
    detail.isParticipate = [dict[@"isParticipate"]boolValue];
    detail.isPerfect = [dict[@"isPerfect"]boolValue];
    detail.isTask = [dict[@"isTask"]integerValue];
    detail.learnStatus = dict[@"learnStatus"];
    detail.name = dict[@"name"];
    detail.progressRate = [dict[@"progressRate"]intValue];
    detail.status = dict[@"status"];
    detail.type = dict[@"type"];
    detail.originType = type;
    [DownTool saveDatabase];
    
}

+(void)addCourseCommentArray:(NSArray *)array CourseId:(NSString *)courseId OriginType:(NSString *)originType CourseType:(NSString *)courseTyp{
    NSArray   * commens = [CourseTool addArrayCourse:@"CourseComment" Condile:[NSString stringWithFormat:@"courseId == '%@' && originType == '%@'",courseId,originType]];
    NSManagedObjectContext  * context = kAppDelegate.managedObjectContext;
    [array enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        NSDictionary   * dict = (NSDictionary *)obj;
        CourseComment  * comment = [NSEntityDescription insertNewObjectForEntityForName:@"CourseComment" inManagedObjectContext:context];
        comment.contentType = dict[@"contentType"];
        comment.crsId = [dict[@"crsId"] integerValue];
        comment.commentId = [NSString stringWithFormat:@"%@",dict[@"id"]];
        comment.itemNum = idx;
        comment.itemTitle = dict[@"itemTitle"];
        comment.itemUrl = dict[@"itemUrl"];
        comment.lessonStatus = dict[@"lessonStatus"];
        comment.parentId = [NSString stringWithFormat:@"%@",dict[@"parentId"]];
        comment.sectionType = dict[@"sectionType"];
        comment.type = courseTyp;
        comment.originType = originType;
        comment.courseId = courseId;
        for (int i = 0; i <commens.count; i++) {
            CourseComment   * commentCour = commens[i];
            if ([commentCour.itemUrl isEqualToString:comment.itemUrl]) {
                comment.downloadProgress = commentCour.downloadProgress;
                comment.downloadStatus = commentCour.downloadStatus;
                comment.fileSize = commentCour.fileSize;
            }
        }
        [DownTool saveDatabase];
    }];
    [DownTool deleteDataByArray:commens];
}

+(void)addCourseInfoByArray:(NSArray *)array CourseInfo:(CourseDetail *)detail TotalCount:(NSString *)total{
    NSManagedObjectContext  * context = kAppDelegate.managedObjectContext;
    for (NSDictionary  * dic in array) {
        CourseInfo  * coureInfo = [NSEntityDescription insertNewObjectForEntityForName:@"CourseInfo" inManagedObjectContext:context];
        coureInfo.createDate = dic[@"createDate"];
        coureInfo.grad = [dic[@"grade"] intValue];
        coureInfo.remark = dic[@"remark"];
        coureInfo.userName = dic[@"userName"];
        coureInfo.courseId = detail.courseId;
        coureInfo.oiginType = [NSString stringWithFormat:@"%@",detail.originType];
        //coureInfo.totalcou = total;
        [DownTool saveDatabase];
        
    }
    
    
}

////////////******************////////////

//请求课程列表
+(NSOperation *)courseListWithType:(NSString *)type OriginalType:(NSString *)originalType CategoryId:(NSString *)categoryId PageNo:(int)pageNo andPageSize:(int)pageSize Success:(void (^)(NSArray *, BOOL, int, NSString *, NSString *))success Fail:(void (^)(NSError *))fail{
    NSDictionary   *dic = @{
                            @"searchType":type,
                            @"pageNo":[NSString stringWithFormat:@"%d",pageNo],
                            @"pageSize":[NSString stringWithFormat:@"%d",pageSize],
                            @"categoryId":categoryId,
                            @"token":kToken
                            };
    NSString  * path;
    if ([originalType isEqualToString:@"Q"]) {
        path = kPublicCourseLoginUrl;
    }else if([originalType isEqualToString:@"C"]){
        path = kInteriorCourseUrl;
    }
    NSOperation  * operation = MyCommonHttpRequest(dic, path, ^(id responseObject) {
        //NSLog(@"---\n%@",responseObject);
        if ([responseObject[@"executeStatus"] integerValue]==0) {
            NSArray   * courArray = responseObject[@"values"][@"result"];
           // NSLog(@"----%@",courArray);
            BOOL hasMore = YES;
            if (pageNo == [(responseObject[@"values"][@"totalPages"]) intValue] || courArray.count == 0) {
                hasMore = NO;
            }
            if (pageNo==1) {
                //清空数组
                [CourseTool delegateCourse:@"Course" Condilet:[NSString stringWithFormat:@"originType == '%@' && courseType == '%@'",originalType,type]];
            }
            [CourseTool addCourseArray:courArray ByType:type];
            
             NSArray  * couArray = [CourseTool addArrayCourse:@"Course" Condile:[NSString stringWithFormat:@"originType == '%@' && courseType == '%@'",originalType,type]];
            success(couArray,hasMore,[(responseObject[@"values"][@"totalCount"]) intValue],nil,nil);
        }else{
            NSString *errorCode = [NSString stringWithFormat:@"%@",responseObject[@"errorCode"]];
            NSString *errorMsg = responseObject[@"errorMsg"];
            success(nil,NO,0,errorCode,errorMsg);
            
        }
        
        
    }, ^(NSError *error, NSString *responseString) {
        
    });
    return operation;
}
//获得课程简介
+(void)courseDetailWithID:(Course *)course Success:(void (^)(CourseDetail*, NSString *, NSString *))success Fail:(void (^)(NSError *))fail{
    NSDictionary  * dic = @{
                            @"id":course.courseId,
                            @"originType":course.originType,
                            @"token":kToken,
                            };
    
    MyCommonHttpRequest(dic, kCourseDetailUrl, ^(id responseObject) {
        if ([responseObject[@"executeStatus"] integerValue]==0) {
            NSDictionary  * dict = responseObject[@"values"];
            [CourseTool delegateCourse:@"CourseDetail" Condilet:[NSString stringWithFormat:@"courseId == '%@' && originType == '%@'",course.courseId,course.originType]];
            [CourseTool addCourseDetail:dict OryType:course.originType];
            CourseDetail  * courseDetail = [[CourseTool addArrayCourse:@"CourseDetail" Condile:[NSString stringWithFormat:@"courseId == '%@' && originType == '%@'",course.courseId,course.originType]] firstObject];
            success(courseDetail,nil,nil);
        }else{
            NSString *errorCode = [NSString stringWithFormat:@"%@",responseObject[@"errorCode"]];
            NSString *errorMsg = responseObject[@"errorMsg"];
            success(nil,errorCode,errorMsg);
        }
        
        
    }, ^(NSError *error, NSString *responseString) {
        
    });
}

+(void)courseCommentCourse:(Course *)course CourseName:(NSString *)courseName CourseType:(NSString *)courseType Success:(void (^)(NSArray *, NSString *, NSString *))success Fail:(void (^)(NSError *))fail{
    if (!course.courseId || !course.originType ||!courseType) {
        return;
    }
    NSDictionary  * dic = @{
                            @"id":course.courseId,
                            @"originType":course.originType,
                            @"token":kToken
                            };
    MyCommonHttpRequest(dic, kCourseChapter, ^(id responseObject) {
       // NSLog(@"----\n%@",responseObject);
        if ([responseObject[@"executeStatus"]integerValue]==0) {
            NSArray   * array = responseObject[@"values"];
            //单个章节
            if (array.count == 2) {
                NSDictionary *dict1 = array[0];
                NSDictionary *dict2 = array[1];
                NSString *sectionType1 = dict1[@"sectionType"];
                NSString *sectionType2 = dict2[@"sectionType"];
                NSString *itemUrl1 = dict1[@"itemUrl"];
                NSString *itemUrl2 = dict2[@"itemUrl"];
                if ([sectionType1 isEqualToString:@"C"] && [sectionType2 isEqualToString:@"S"] && (!itemUrl1 || itemUrl1.length == 0) && itemUrl2.length >0) {
                    NSMutableDictionary *singleCourseChapter = [NSMutableDictionary dictionaryWithDictionary:array[1]];
                    [singleCourseChapter setObject:@"C" forKey:@"sectionType"];
                    [singleCourseChapter setObject:[NSString stringWithFormat:@"第一章:%@",courseName] forKey:@"itemTitle"];
                    array = @[singleCourseChapter];
                }
            }
            [CourseTool addCourseCommentArray:array CourseId:course.courseId OriginType:course.originType CourseType:courseType];
            NSArray   * commens = [CourseTool addArrayCourse:@"CourseComment" Condile:[NSString stringWithFormat:@"courseId == '%@' && originType == '%@'",course.courseId,course.originType]];
            success(commens,nil,nil);
        }else{
            NSString *errorCode = [NSString stringWithFormat:@"%@",responseObject[@"errorCode"]];
            NSString *errorMsg = responseObject[@"errorMsg"];
            success(nil,errorCode,errorMsg);
        }
    }, ^(NSError *error, NSString *responseString) {
        
        
    });
    
    
}


+(NSOperation *)courseCommentWithDeate:(CourseDetail *)detail PageNo:(int)pageNo PageSize:(int)pageSize Success:(void (^)(NSArray *, BOOL, int, NSString *, NSString *))success Fail:(void (^)(NSError *))fail{
    NSDictionary  * dic = @{
                            @"courseInfoId":detail.courseId,
                            @"pageSize":[NSNumber numberWithInt:pageSize],
                            @"pageNo":[NSNumber numberWithInt:pageNo],
                            @"originType":detail.originType,
                            @"token":kToken
                            };
    NSOperation  * operation = MyCommonHttpRequest(dic, kReviewquery, ^(id responseObject) {
        if ([responseObject[@"executeStatus"]intValue]==0) {
            NSDictionary  * dict = responseObject[@"values"];
            NSArray  * array = dict[@"result"];
            BOOL hasMore = YES;
            NSString * totalCount =dict[@"totalCount"];
            if (pageNo == [(responseObject[@"values"][@"totalPages"]) intValue] || array.count == 0) {
                hasMore = NO;
            }
            if (pageNo == 1) {
                [CourseTool delegateCourse:@"CourseInfo" Condilet:[NSString stringWithFormat:@"courseId == %@ && oiginType == '%@'",detail.courseId,detail.originType]];
            }
            [CourseTool addCourseInfoByArray:array CourseInfo:detail TotalCount:totalCount];
            NSArray  * arr = [CourseTool addArrayCourse:@"CourseInfo" Condile:[NSString stringWithFormat:@"courseId == %@ && oiginType == '%@'",detail.courseId,detail.originType]];
            success(arr,hasMore,[totalCount intValue],nil,nil);
        }else{
            NSString *errorCode = [NSString stringWithFormat:@"%@",responseObject[@"errorCode"]];
            NSString *errorMsg = responseObject[@"errorMsg"];
            success(nil,NO,0,errorCode,errorMsg);
        }
    }, ^(NSError *error, NSString *responseString) {
        
    });
    return operation;
}








//////////////////////***********************////////////////////
+(void)updateCourseCoomentDownloadStatus:(int)status CourseCommnet:(CourseComment *)comment{
    NSArray  * comArray = [CourseTool addArrayCourse:@"CourseComment" Condile:[NSString stringWithFormat:@"commentId == '%@' && originType == '%@'",comment.commentId,comment.originType]];
    [comArray enumerateObjectsUsingBlock:^(CourseComment* obj, NSUInteger idx, BOOL *stop) {
        if (obj && [obj isKindOfClass:[CourseComment class]]) {
            if (obj.downloadProgress  == 1.0f) {
                obj.downloadStatus = DownloadStatusFinished;
            }else{
                obj.downloadStatus = status;
            }
            [DownTool saveDatabase];
        }
    }];
    
}
+(void)updateCourseCommentFileSize:(long long)size CourseComment:(CourseComment *)comment{
    NSArray  * commArr =[CourseTool addArrayCourse:@"CourseComment" Condile:[NSString stringWithFormat:@"commentId == '%@' && originType == '%@'",comment.commentId,comment.originType]];
    [commArr enumerateObjectsUsingBlock:^(CourseComment * obj, NSUInteger idx, BOOL *stop) {
        if (obj && [obj isKindOfClass:[CourseComment class]]) {
            obj.fileSize = size;
            [DownTool saveDatabase];
        }   
    }];
    
}
+(void)updateCourseChapterDownloadProcess:(float)process CourseComment:(CourseComment *)comment{
    NSArray  * commArr =[CourseTool addArrayCourse:@"CourseComment" Condile:[NSString stringWithFormat:@"commentId == '%@' && originType == '%@'",comment.commentId,comment.originType]];
    [commArr enumerateObjectsUsingBlock:^(CourseComment * obj, NSUInteger idx, BOOL *stop) {
        if (obj && [obj isKindOfClass:[CourseComment class]]) {
            obj.downloadProgress = process;
            [DownTool saveDatabase];
        }
        
    }];
}


+(CourseComment *)fetchSingleCourseCommentById:(NSString *)commentId OriginType:(NSString *)oringinType{
    CourseComment  * comment = [[CourseTool addArrayCourse:@"CourseComment" Condile:[NSString stringWithFormat:@"commentId == '%@' && originType == '%@'",commentId,oringinType]] firstObject];
    if (comment) {
        return comment;
    }
    return nil;
}

@end






















