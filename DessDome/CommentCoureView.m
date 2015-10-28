//
//  CommentCoureView.m
//  DessDome
//
//  Created by Jack on 15/9/10.
//  Copyright (c) 2015年 zhr. All rights reserved.
//

#import "CommentCoureView.h"
#import "CourseDetail.h"
#import "CourseTool.h"
#import "CourseComment.h"
#import "CommentCell.h"
#import "DownLoadTool.h"
#import "DownTool.h"

@interface CommentCoureView ()<UITableViewDelegate,UITableViewDataSource,CommentCellDelegate>

@property (strong, nonatomic) NSArray *comArray;
@property (strong, nonatomic) UIView *butView;
@end

@implementation CommentCoureView

-(id)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        self.butView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.bounds.size.width, 50)];
        self.butView.backgroundColor = [UIColor redColor];
        [self addSubview:_butView];
        
        self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 50, self.bounds.size.width, self.bounds.size.height) style:UITableViewStylePlain];
        self.tableView.delegate = self;
        self.tableView.dataSource = self;
        self.tableView.tableFooterView = [[UIView alloc] init];
        [self addSubview:self.tableView];
    }
    return self;
}
-(void)addComArray:(NSArray *)comArray{
    if (self.comArray) {
        //移除
        [self performSelectorOnMainThread:@selector(removeMonitor) withObject:nil waitUntilDone:YES];
    }
    //给所有章节添加KVO监测着
    [self performSelectorOnMainThread:@selector(addMonitor) withObject:nil waitUntilDone:YES];
    
}
//移除
-(void)removeMonitor{
    for (CourseComment  *comment in self.comArray) {
        if ([comment isKindOfClass:[CourseComment class]]&&comment.observationInfo) {
            [comment removeObserver:self forKeyPath:@"commentStatus"];
            [comment removeObserver:self forKeyPath:@"downloadProgress"];
            [comment removeObserver:self forKeyPath:@"downloadStatus"];
            [comment removeObserver:self forKeyPath:@"lessonStatus"];
        }
    }
}
//添加kvo
-(void)addMonitor{
    for (CourseComment   * comment in self.comArray) {
        if ([comment isKindOfClass:[CourseComment class]]&&comment.courseId) {
            [comment addObserver:self forKeyPath:@"commentStatus" options:NSKeyValueObservingOptionOld|NSKeyValueObservingOptionNew context:nil];
            [comment addObserver:self forKeyPath:@"downloadProgress" options:NSKeyValueObservingOptionOld|NSKeyValueObservingOptionNew context:nil];
            [comment addObserver:self forKeyPath:@"downloadStatus" options:NSKeyValueObservingOptionOld|NSKeyValueObservingOptionNew context:nil];
            [comment addObserver:self forKeyPath:@"lessonStatus" options:NSKeyValueObservingOptionOld|NSKeyValueObservingOptionNew context:nil];
        }
        
    }
    
}
-(void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context{
    if ([object isKindOfClass:[CourseComment class]]) {
        CourseComment  * comment = (CourseComment *)object;
        if (!comment.commentId &&!self) {
            return;
        }
        NSIndexPath  * indexPath = [NSIndexPath indexPathForRow:[self.comArray indexOfObject:object] inSection:0];
        CommentCell  * cell = (CommentCell *)[self.tableView cellForRowAtIndexPath:indexPath];
        BOOL isShowDownload = YES;
        if (self.comArray.count-1==indexPath.row) {
            [cell setCourseComment:_comArray[indexPath.row] andIndex:2000 andIsShowDownload:isShowDownload];
        }else{
            [cell setCourseComment:_comArray[indexPath.row] andIndex:indexPath.row andIsShowDownload:isShowDownload];
        }
    }
}


#pragma mark - 请求章节信息
-(void)updateCommentCourseViewCourseDetail:(CourseDetail *)courseDetail{
    _detail = courseDetail;
    __weak typeof(self) weakSelf = self;
    [CourseTool courseCommentCourse:_cour CourseName:_detail.name CourseType:_detail.type Success:^(NSArray *array, NSString *errorCode, NSString *errorMsg) {
        if (!errorCode) {
            weakSelf.comArray = array;
            [self addComArray:array];
            [self.tableView reloadData];
            
        }
    } Fail:^(NSError *error) {
        
    }];
    
}


#pragma mark - tab delegate
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.comArray.count;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 40;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    CommentCell  * cell  =[tableView dequeueReusableCellWithIdentifier:@"CommentCell"];
    if (!cell) {
        cell = [CommentCell cell];
    }
    cell.delegate = self;
    BOOL isShowDownload = YES;
    if (self.comArray.count-1==indexPath.row) {
        [cell setCourseComment:_comArray[indexPath.row] andIndex:2000 andIsShowDownload:isShowDownload];
    }else{
        [cell setCourseComment:_comArray[indexPath.row] andIndex:indexPath.row andIsShowDownload:isShowDownload];
    }
    
    
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(nonnull NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    if ([self.delegate respondsToSelector:@selector(didClickCommentCoureTableCourseDetail:)]) {
        [self.delegate didClickCommentCoureTableCourseDetail:_comArray[indexPath.row]];
    }
}


- (void)removeFromSuperview{
    [super removeFromSuperview];
    [self performSelectorOnMainThread:@selector(removeMonitor) withObject:nil waitUntilDone:YES];
}
-(void)dealloc{
    [self removeMonitor];
}
#pragma mark - commentDelegate
-(void)clickCourseChapterCell:(CourseComment *)comment{
    if ([[DownLoadTool sharedDownLoadTool] downloadStatusByCourseComment:comment]==DownloadStatusDowning) {//处于下载中
        [[DownLoadTool sharedDownLoadTool] cancelOperationById:comment.commentId];
        [CourseTool updateCourseCoomentDownloadStatus:DownloadStatusPause CourseCommnet:comment];
    }else{// --如果没有处于下载中，则可能是下载暂停状态或者是下载完成了
        if ([[DownLoadTool sharedDownLoadTool] downloadStatusByCourseComment:comment]==DownloadStatusFinished) {//下载完成
            
        }else{//暂停下载
            [self downloadSingleCourseCommentWith:comment];
        }
        
    }
}
//下载单个章节
-(void)downloadSingleCourseCommentWith:(CourseComment *)comment{
    NSLog(@"----%@",comment.commentId);
    [[DownLoadTool sharedDownLoadTool] downloadCourseById:comment.commentId OriginType:comment.originType];
    
}

@end















