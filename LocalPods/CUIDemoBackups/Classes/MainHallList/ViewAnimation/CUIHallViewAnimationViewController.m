//
//  CUIHallViewAnimationViewController.m
//
//  Created by zitao on 03/30/2021.
//  Copyright (c) 2021 zitao. All rights reserved.
//

#import "CUIHallViewAnimationViewController.h"
#import "CUICollectionViewImageCell.h"
#import "CUICollectionViewVideoCell.h"
#import "CUIViewAnimationCollectionViewLayout.h"
#import "CUIDemoCellItemModel.h"
#import "CUIDemoViewAnimationData.h"
#import "CommonKit.h"

#define ImageCellHeight   120
#define VideoCellHeight   242
#define Cellwidth (ScreenWidth - 2) / 2.0;

@interface CUIHallViewAnimationViewController () <UICollectionViewDataSource, UICollectionViewDelegateFlowLayout>
@property (strong, nonatomic) UICollectionView *collectionView;
@property (strong, nonatomic) NSArray <CUIDemoCellItemModel *> *items;
@end

@implementation CUIHallViewAnimationViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self.view addSubview:self.collectionView];
    
    self.items = [[CUIDemoViewAnimationData obtainData] mutableCopy];
    
    self.view.backgroundColor = [UIColor whiteColor];
}


#pragma mark - UICollectionViewDataSource
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.items.count;
}

//footer的size
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForFooterInSection:(NSInteger)section
{
    return CGSizeMake(0, 0);
}

//header的size
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section
{
    return CGSizeMake(0, 0);
}

//每个item的UIEdgeInsets
- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    return UIEdgeInsetsMake(0, 0, 0, 0);
}

//每个item水平间距
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section
{
    return 2;
}

//每个item垂直间距
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section
{
    return 2;
}

//cell显示的内容
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellIdentifier = @"";
    NSInteger row = indexPath.row;
    if (row < self.items.count) {
        CUIDemoCellItemModel *item = [self.items objectAtIndex:row];
        if (ImageItemCellType == item.cellType) {
            cellIdentifier = @"CUICollectionViewImageCell";
            CUICollectionViewImageCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:cellIdentifier forIndexPath:indexPath];
            [cell refreshData:item];
            return cell;
        } else {
            cellIdentifier = @"CUICollectionViewVideoCell";
            CUICollectionViewVideoCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:cellIdentifier forIndexPath:indexPath];
            [cell refreshData:item];
            return cell;
        }
     
    }
    return [UICollectionViewCell new];
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    NSInteger row = indexPath.row;
    if (row < self.items.count) {
        CUIDemoCellItemModel *item = [self.items objectAtIndex:row];
        if (item.detailVCName.length > 0) {
            UIViewController *vc = [NSClassFromString(item.detailVCName) new];
            if (vc) {
                vc.title = item.descrip;
                [self.navigationController pushViewController:vc animated:YES];
            }
        }
    }
    
}

- (UICollectionView *)collectionView
{
    if (!_collectionView) {
        CUIViewAnimationCollectionViewLayout *layout = [[CUIViewAnimationCollectionViewLayout alloc] init];
        _collectionView = [[UICollectionView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight) collectionViewLayout:layout];
        _collectionView.backgroundColor = [[UIColor brownColor]colorWithAlphaComponent:0.2];
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
        [_collectionView registerClass:[CUICollectionViewImageCell class] forCellWithReuseIdentifier:@"CUICollectionViewImageCell"];
        [_collectionView registerClass:[CUICollectionViewVideoCell class] forCellWithReuseIdentifier:@"CUICollectionViewVideoCell"];
        _collectionView.showsVerticalScrollIndicator = YES;
        _collectionView.showsHorizontalScrollIndicator = YES;
        [self.view addSubview:_collectionView];
    }
    return _collectionView;
}

@end
