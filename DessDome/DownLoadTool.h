//
//  DownLoadTool.h
//  DessDome
//
//  Created by Jack on 15/9/15.
//  Copyright (c) 2015年 zhr. All rights reserved.
//

#import <Foundation/Foundation.h>
@class CourseComment;

typedef NS_ENUM(NSInteger, DownloadStatus){
    DownloadStatusNotBegin,         // --下载未开始
    DownloadStatusDowning,          // --正在下载中
    DownloadStatusPause,            // --下载暂停中
    DownloadStatusFinished          // --下载结束
    
};

@interface DownLoadTool : NSObject
singleton_interface(DownLoadTool)



//返回课程资源下载状态
-(DownloadStatus)downloadStatusByCourseComment:(CourseComment *)comment;
//取消下载
-(void)cancelOperationById:(NSString *)commenId;
//下载
-(void)downloadCourseById:(NSString *)commeId OriginType:(NSString *)originType;


//下载路径
+(NSString *)downloadFolderPath;

@end
