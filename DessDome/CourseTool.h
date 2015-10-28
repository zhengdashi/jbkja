//
//  CourseTool.h
//  DessDome
//
//  Created by Jack on 15/9/8.
//  Copyright (c) 2015年 zhr. All rights reserved.
//

#import <Foundation/Foundation.h>
@class CourseComment;
@class CourseDetail;
@class Course;
@interface CourseTool : NSObject
/**
 *  删除数组
 *
 *  @param entert 实例对象
 *  @param frome  条件
 */
+(void)delegateCourse:(NSString *)entert Condilet:(NSString *)frome;
/**
 *  添加Course类对象
 *
 *  @param array 条件
 *  @param type  添加条件
 */
+(void)addCourseArray:(NSArray *)array ByType:(NSString *)type;
/**
 *  得到数组
 *
 *  @param array 实例对象
 *  @param frome 条件
 *
 *  @return 返回数组
 */
+(NSArray *)addArrayCourse:(NSString *)array Condile:(NSString *)frome;
/**
 *  给courseDeatil存入对象
 *
 *  @param dict 内容
 *  @param type 存入条件
 */
+(void)addCourseDetail:(NSDictionary *)dict OryType:(NSString *)type;

/**
 *  给coummen类存入对象
 *
 *  @param array      章节书
 *  @param courseId   课程id
 *  @param originType 来源
 *  @param courseTyp  E:多章节视屏 V:单章节视屏 D:单章节文档 O:多章节文档
 */
+(void)addCourseCommentArray:(NSArray *)array CourseId:(NSString *)courseId OriginType:(NSString *)originType CourseType:(NSString *)courseTyp;
/**
 *  添加课程评论
 *
 *  @param array  数组
 *  @param detail deltai 类
 *  @param total  total
 */
+(void)addCourseInfoByArray:(NSArray *)array CourseInfo:(CourseDetail *)detail TotalCount:(NSString *)total;

/////////////////*******************///////////////////////
/**
 *  获取课程列表
 *
 *  @param type         排序类型,热门:R  最新:N  精品:P  师说:F
 *  @param originalType 来源，Q 企大。   C企业
 *  @param categoryId
 *  @param pageNo       页码
 *  @param pageSize     行数
 *  @param success      请求成功
 *  @param fail         请求失败
 *
 *  @return 请求线程对象
 */
+(NSOperation *)courseListWithType:(NSString *)type OriginalType:(NSString *)originalType CategoryId:(NSString *)categoryId PageNo:(int)pageNo andPageSize:(int)pageSize Success:(void(^)(NSArray *CourseList,BOOL hasMore,int totalCount,NSString *errorCode,NSString *errorMsg))success Fail:(void(^)(NSError *error))fail;
/**
 *  获得课程简介
 *
 *  @param course  course类
 *  @param success 成功
 *  @param fail    失败
 */
+(void)courseDetailWithID:(Course *)course Success:(void(^)(CourseDetail  * detail, NSString  *errorCode,NSString *errorMsg))success Fail:(void(^)(NSError *error))fail;

/**
 *  获取章节
 *
 *  @param course     cour类
 *  @param courseName 课程名称
 *  @param courseType E:多章节视屏 V:单章节视屏 D:单章节文档 O:多章节文档
 *  @param success    成功
 *  @param fail       失败
 */
+(void)courseCommentCourse:(Course *)course CourseName:(NSString *)courseName CourseType:(NSString *)courseType Success:(void(^)(NSArray *array,NSString *errorCode,NSString *errorMsg))success Fail:(void(^)(NSError *error))fail;
/**
 *  获取课程评论
 *
 *  @param detail   detail类
 *  @param pageNo   页数
 *  @param pageSize 个数
 *  @param success  成功
 *  @param fail     失败
 *
 */
+(NSOperation *)courseCommentWithDeate:(CourseDetail *)detail PageNo:(int)pageNo PageSize:(int)pageSize Success:(void(^)(NSArray *array,BOOL hasMore,int totalCount , NSString *errorCode ,NSString *errorMsg))success Fail:(void(^)(NSError *error))fail;

/////////////*******下载*******////////////

/**
 *  更新章节状态
 *
 *  @param comment 下载状态 0:下载未开始  1:下载中  2:下载暂停中  3:下载完成
 */
+(void)updateCourseCoomentDownloadStatus:(int)status CourseCommnet:(CourseComment *)comment;
/**
 *  更新章节下载百分比
 *
 *  @param process 下载进度
 *  @param comment 章节id
 */
+(void)updateCourseChapterDownloadProcess:(float)process CourseComment:(CourseComment *)comment;
/**
 *  获取章节文件大小
 *
 *  @param size    大小
 *  @param comment comment类
 */

+(void)updateCourseCommentFileSize:(long long)size CourseComment:(CourseComment *)comment;
/**
 *  根据id得到comment类
 *
 *  @param commentId   id
 *  @param oringinType 来源
 *
 *  @return course
 */

+(CourseComment *)fetchSingleCourseCommentById:(NSString *)commentId OriginType:(NSString *)oringinType;
@end


























