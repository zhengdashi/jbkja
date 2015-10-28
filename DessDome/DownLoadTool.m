//
//  DownLoadTool.m
//  DessDome
//
//  Created by Jack on 15/9/15.
//  Copyright (c) 2015年 zhr. All rights reserved.
//

#import "DownLoadTool.h"
#import "CourseComment.h"
#import "CourseTool.h"

@interface DownLoadTool (){
    
}
@property (strong, nonatomic) AFHTTPRequestOperationManager *httpClient;
@end

@implementation DownLoadTool
singleton_implementation(DownLoadTool)

//下载路径
+(NSString *)downloadFolderPath{
    NSString  * filePath = [NSHomeDirectory() stringByAppendingPathComponent:@"Library/Caches/Download"];
    NSError  * error = nil;
    NSFileManager  * fileManager = [NSFileManager defaultManager];
    BOOL isDir;
    if (![fileManager fileExistsAtPath:filePath isDirectory:&isDir]) {
       BOOL success = [fileManager createDirectoryAtPath:filePath withIntermediateDirectories:NO attributes:nil error:&error];
        if (!success ||error) {
            NSLog(@"创建失败 Error:%@",[error localizedDescription]);
        }
        
    }
    return filePath;
}
//测试网络
-(AFHTTPRequestOperationManager *)httpClient{
    if (_httpClient ==nil) {
        NSURL  * url = [NSURL URLWithString:@"http://www.baidu.com"];
        AFHTTPRequestOperationManager *manager = [[AFHTTPRequestOperationManager alloc] initWithBaseURL:url];
        self.httpClient = manager;
        
    }
    return _httpClient;
    
}

//返回课程资源下载状态
-(DownloadStatus)downloadStatusByCourseComment:(CourseComment *)comment{
    if (comment.downloadStatus ==0) {
        return DownloadStatusNotBegin; // --下载未开始
    }else if (comment.downloadStatus ==1){
        return DownloadStatusDowning; // --正在下载中
    }else if (comment.downloadStatus==2){
        return DownloadStatusPause; // --下载暂停中
    }else if (comment.downloadStatus ==3){
        return DownloadStatusFinished; //下载完成
    }
    return DownloadStatusNotBegin;
}
//取消下载
-(void)cancelOperationById:(NSString *)commenId{
    for (int i = 0; i<self.httpClient.operationQueue.operations.count; i++) {
        AFHTTPRequestOperation *operation = self.httpClient.operationQueue.operations[i];
        if (operation && [operation isKindOfClass:[AFHTTPRequestOperation class]] && [operation.userInfo[@"commentId"] isEqualToString:commenId]) {
            [operation cancel];
        }
    }
    
}
//下载
-(void)downloadCourseById:(NSString *)commeId OriginType:(NSString *)originType{
    __block CourseComment  * comment = [CourseTool fetchSingleCourseCommentById:commeId OriginType:originType];
    if (comment) {
        NSString  * path;
        if (![comment.contentType isEqualToString:@"exam"]) {
           // path = [NSHomeDirectory() stringByAppendingPathComponent:[NSString stringWithFormat:@"Library/Caches/Download/%@.mp4",comment.commentId]];
            path = [[DownLoadTool downloadFolderPath] stringByAppendingPathComponent:[NSString stringWithFormat:@"%@.mp4",comment.commentId]];
        }else{
            path = [[DownLoadTool downloadFolderPath] stringByAppendingPathComponent:[NSString stringWithFormat:@"%@.txt",comment.commentId]];
        }
        
        if (path == nil) {
            return;
        }
        NSURLRequest  * request = [NSURLRequest requestWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@",comment.itemUrl]]];
        
        unsigned long long downloaedBytes = 0;
        if ([[NSFileManager defaultManager] fileExistsAtPath:path]) {
            //获取已下载的文件长度
            downloaedBytes = fileSizeForPath(path);
            if (downloaedBytes >0) {
                NSMutableURLRequest  * mutableUrl = [request mutableCopy];
                NSString  * requestRange = [NSString stringWithFormat:@"bytes=%llu-", downloaedBytes];
                [mutableUrl setValue:requestRange forHTTPHeaderField:@"Range"];
                request = mutableUrl;
            }
        }
        //不实用缓存，避免断点续传出现问题
        [[NSURLCache sharedURLCache] removeCachedResponseForRequest:request];
        //下载请求
        AFHTTPRequestOperation  * operation = [[AFHTTPRequestOperation alloc] initWithRequest:request];
        //下载路径
        operation.outputStream = [NSOutputStream outputStreamToFileAtPath:path append:YES];
        
        //下载进度回调
        [operation setDownloadProgressBlock:^(NSUInteger bytesRead, long long totalBytesRead, long long totalBytesExpectedToRead) {
            float  progress = ((float)totalBytesRead +downloaedBytes)/(totalBytesExpectedToRead+downloaedBytes);
          //  NSLog(@"------%f",progress);
            if (progress - comment.downloadProgress >0.01) {
                if (comment.commentId) {
                    [CourseTool updateCourseChapterDownloadProcess:progress CourseComment:comment];
                }else{
                    comment = [CourseTool fetchSingleCourseCommentById:commeId OriginType:originType];
                    if (comment.commentId.length >0) {
                        [CourseTool updateCourseChapterDownloadProcess:progress CourseComment:comment];
                    }
                }
                if (comment.fileSize ==0) {
                    [CourseTool updateCourseCommentFileSize:totalBytesExpectedToRead CourseComment:comment];
                }
            }else if (comment.downloadProgress ==1){
                [CourseTool updateCourseChapterDownloadProcess:1 CourseComment:comment];
            }
        }];
        
        //下载成功或者失败
        [operation setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
            
            
        } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
            
        }];
        operation.queuePriority = NSOperationQueuePriorityLow;
        operation.userInfo = @{@"commentId":comment.commentId?comment.commentId:@""};
        if ([[[UIDevice currentDevice] name] isEqualToString:@"iPhone 4S"]) {
            self.httpClient.operationQueue.maxConcurrentOperationCount = 1;
        }else{
            self.httpClient.operationQueue.maxConcurrentOperationCount = 3;
        }
        
        [self.httpClient.operationQueue addOperation:operation];
        
        [CourseTool updateCourseCoomentDownloadStatus:DownloadStatusDowning CourseCommnet:comment];
    }
}

unsigned long long fileSizeForPath(NSString *path){
    signed long long fileSize = 0;
    NSFileManager *fileManager = [NSFileManager new]; // default is not thread safe
    if ([fileManager fileExistsAtPath:path]) {
        NSError *error = nil;
        NSDictionary *fileDict = [fileManager attributesOfItemAtPath:path error:&error];
        if (!error && fileDict) {
            fileSize = [fileDict fileSize];
        }
    }
    return fileSize;
}

@end


















