//
//  HomeView.m
//  DessDome
//
//  Created by Jack on 15/9/7.
//  Copyright (c) 2015年 zhr. All rights reserved.
//

#import "HomeView.h"
#import "PictureTool.h"
#import "UIImageView+WebCache.h"
#import "Picture.h"
#import "HomeTitleCell.h"

@interface HomeView ()<UIScrollViewDelegate,UICollectionViewDataSource,UICollectionViewDelegate>{
    NSArray         *_picturLict;
   // NSTimer         *_timer;
}
@property (weak, nonatomic) IBOutlet UIScrollView *homeScrollView;
@property (strong, nonatomic) NSTimer *timer;
@property (weak, nonatomic) IBOutlet UIPageControl *pageHome;
@property (weak, nonatomic) IBOutlet UICollectionView *homCollection;

@end

@implementation HomeView

-(void)awakeFromNib{
    NSLog(@"----");
    _homeScrollView.scrollsToTop = NO;
    _homeScrollView.pagingEnabled = YES;
    _homeScrollView.delegate = self;
    _homCollection.delegate = self;
    _homCollection.dataSource = self;
    
    [_homCollection registerNib:[UINib nibWithNibName:@"HomeTitleCell" bundle:nil] forCellWithReuseIdentifier:@"HomeTitleCell"];
    
    [self reload];
    //获得图片
    [self requestPicture];
    
}

-(void)reload{
    if (_timer  && _timer.isValid) {
        [_timer invalidate];
    }
    self.timer = [NSTimer scheduledTimerWithTimeInterval:2 target:self selector:@selector(changePic) userInfo:nil repeats:YES];
    _homeScrollView.contentSize = CGSizeMake(4*_homeScrollView.frame.size.width, _homeScrollView.frame.size.height);
    
}
-(void)changePic{
    if (_pageHome.currentPage<(_picturLict.count-1)) {
        _pageHome.currentPage++;
    }else{
        _pageHome.currentPage =0;
    }
    [_homeScrollView setContentOffset:CGPointMake(_pageHome.currentPage*_homeScrollView.frame.size.width, 0)];
}

//请求图片
-(void)requestPicture{
    __weak typeof(self) weakSelf = self;
    [PictureTool pictureListBySuccess:^(NSArray *pictureList, NSString *errorCode, NSString *errorMsg) {
        if (!errorCode) {
            _picturLict = pictureList;
            
            [weakSelf displayPicture];
        }
        
    } Fail:^(NSString *error) {
        
    }];
    
}
-(void)displayPicture{
    _pageHome.numberOfPages = _picturLict.count;
    _pageHome.currentPage = 0;
    
    [_picturLict enumerateObjectsUsingBlock:^(Picture *pict, NSUInteger idx, BOOL *stop) {
        if ([pict isKindOfClass:[Picture class]]) {
            UIImageView   *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(idx*_homeScrollView.frame.size.width, 0, _homeScrollView.frame.size.width, _homeScrollView.frame.size.height)];
            [imageView sd_setImageWithURL:[NSURL URLWithString:pict.imgUrl] placeholderImage:[UIImage imageNamed:@"common_loading"]];
            [_homeScrollView addSubview:imageView];
        }

    }];
}
#pragma mark - scrollView Delegate
-(void)scrollViewDidScroll:(UIScrollView *)scroll{
    CGFloat  pageWith = scroll.frame.size.width;
    int page = floor((scroll.contentOffset.x - pageWith/2)/pageWith)+1;
    if (scroll == _homeScrollView) {
        _pageHome.currentPage = page;
    }
    
}
#pragma mark - collectionDele
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return 4;
}
-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    HomeTitleCell   * cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"HomeTitleCell" forIndexPath:indexPath];
    if (!cell) {
        cell = [[NSBundle mainBundle] loadNibNamed:@"HomeTitleCell" owner:nil options:nil][0];
    }
    cell.index = indexPath.row;
    return cell;
}

@end

















