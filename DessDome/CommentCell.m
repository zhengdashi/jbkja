//
//  CommentCell.m
//  DessDome
//
//  Created by Jack on 15/9/14.
//  Copyright (c) 2015年 zhr. All rights reserved.
//

#import "CommentCell.h"
#import "DownLoadTool.h"
#import "KAProgressLabel.h"
#import "CourseComment.h"

@interface CommentCell ()
@property (weak, nonatomic) IBOutlet UIImageView *lineImageView;
@property (weak, nonatomic) IBOutlet UIImageView *statusImage;
@property (weak, nonatomic) IBOutlet UILabel *titLab;
@property (weak, nonatomic) IBOutlet UIButton *downBut;
@property (weak, nonatomic) IBOutlet KAProgressLabel *progressLab;

@end


@implementation CommentCell

- (void)awakeFromNib {
    // Initialization code
    self.progressLab.borderWidth = 1.0;
    [self.progressLab setColorTable: @{
                                         NSStringFromProgressLabelColorTableKey(ProgressLabelTrackColor):kGetColor(198, 198, 198),
                                         NSStringFromProgressLabelColorTableKey(ProgressLabelProgressColor):kBlueTextColor
                                         }];
    self.progressLab.progress =0;
    self.titLab.backgroundColor = [UIColor clearColor];
}

-(void)setCourseComment:(CourseComment *)comment andIndex:(NSInteger)index andIsShowDownload:(BOOL)isDownload{
    _comment = comment;
    if ([comment.type isEqualToString:@"V"] ||[comment.type isEqualToString:@"D"]) {
        _lineImageView.hidden = YES;
    }
    
    //根据位置谁知虚线
    if (index ==0) {
        self.lineImageView.image = [UIImage imageNamed:@"line_bottom"];
    }else{
        if ([comment.contentType isEqualToString:@"exam"]||index==2000) {
            self.lineImageView.image = [UIImage imageNamed:@"line_top"];
        }else{
            self.lineImageView.image = [UIImage imageNamed:@"line_all"];
        }
        
    }
    self.titLab.text = comment.itemTitle;
    
    //CGPoint tempPoint = self.statusImage.center;
    
    //处理状态显示
    if ([comment.lessonStatus isEqualToString:@"completed"] || [comment.lessonStatus isEqualToString:@"passed"]) {
        // NSLog(@"1");
        self.statusImage.image = [UIImage imageNamed:@"Learned.png"];
    }else if ([comment.lessonStatus isEqualToString:@"incomplete"]){
        // NSLog(@"2");
        self.statusImage.image = [UIImage imageNamed:@"learning"];
    }else{
        ///  NSLog(@"3");
        self.statusImage.image = [UIImage imageNamed:@"No_Learn.png"];
    }

    //处理字体大小核颜色
    if ([comment.sectionType isEqualToString:@"C"]) {
       // self.statusImage.frame = CGRectMake(0, 0, 13, 13);
        self.titLab.font = [UIFont boldSystemFontOfSize:15];
    }else{
        //self.statusImage.frame = CGRectMake(0, 0, 9, 9);
        self.titLab.font = [UIFont systemFontOfSize:12];
    }
    
//    if ([comment.isPlaying boolValue]) {
//        self.titLab.textColor = kGetColor(52, 152, 219);
//    }else{
//        self.titLab.textColor = kGetColor(33, 33, 33);
//    }

    if (comment.itemUrl.length>0 && isDownload) {
        if ([[DownLoadTool sharedDownLoadTool]downloadStatusByCourseComment:comment]==DownloadStatusFinished) {//下载完成
            if ([comment.contentType isEqualToString:@"exam"]) {
                [self.downBut setImage:[UIImage imageNamed:@"icon_course_exam"] forState:UIControlStateNormal];
            }else{
                [self.downBut setImage:[UIImage imageNamed:@"icon_course_play"] forState:UIControlStateNormal];
            }
        self.progressLab.hidden = YES;
        [self.downBut setTitle:@"" forState:UIControlStateNormal];
    }else if ([[DownLoadTool sharedDownLoadTool]downloadStatusByCourseComment:comment]==DownloadStatusDowning){//正在下载
        [self.downBut setImage:nil forState:UIControlStateNormal];
        [self.downBut setTitle:[NSString stringWithFormat:@"%0.f%%",comment.downloadProgress *100] forState:UIControlStateNormal];
        NSLog(@"--%0.f%%",comment.downloadProgress * 100);
        self.progressLab.hidden = NO;
        self.progressLab.progress = comment.downloadProgress;
    }else if ([[DownLoadTool sharedDownLoadTool] downloadStatusByCourseComment:comment]==DownloadStatusPause){//暂停
        [self.downBut setImage:[UIImage imageNamed:@"Down_pause"] forState:UIControlStateNormal];
        self.progressLab.hidden = NO;
        [self.downBut setImage:nil forState:UIControlStateNormal];
        self.progressLab.progress = comment.downloadProgress;
    }else if ([[DownLoadTool sharedDownLoadTool] downloadStatusByCourseComment:comment]==DownloadStatusNotBegin){//没有下载
        [self.downBut setImage:[UIImage imageNamed:@"icon_course_download"] forState:UIControlStateNormal];
        [self.downBut setTitle:@"" forState:UIControlStateNormal];
        self.progressLab.hidden = YES;
    }else{
        self.progressLab.hidden = YES;
        self.downBut.hidden = YES;
    }
}

}










- (IBAction)downLoad:(UIButton *)sender {
    if ([self.delegate respondsToSelector:@selector(clickCourseChapterCell:)]) {
        [self.delegate clickCourseChapterCell:self.comment];
    }
    
}

+(instancetype)cell{
    return [[NSBundle mainBundle] loadNibNamed:@"CommentCell" owner:nil options:nil][0];
}





- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
