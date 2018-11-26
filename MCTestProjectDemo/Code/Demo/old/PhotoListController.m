//
// Created by majiancheng on 2017/7/28.
// Copyright (c) 2017 waqu. All rights reserved.
//

#import "PhotoListController.h"
#import "PlayerController.h"
#import <Photos/Photos.h>

@interface PhotoCell : UICollectionViewCell

@property(nonatomic, strong) UIImageView *imageView;

@end

@implementation PhotoCell

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        _imageView = ({
            UIImageView *imageView = [[UIImageView alloc] initWithFrame:self.bounds];
            [self.contentView addSubview:imageView];
            imageView;
        });
    }
    return self;
}


@end

@interface PhotoListController () <UICollectionViewDelegate, UICollectionViewDataSource>

@property(nonatomic, strong) UICollectionView *collectionView;
@property(nonatomic, strong) NSMutableArray<PHAsset *> *dataList;
@property(nonatomic, strong) NSMutableArray<UIImage *> *imageList;

@end

@implementation PhotoListController {

}

- (NSMutableArray<PHAsset *> *)dataList {
    if (_dataList == nil) {
        _dataList = [[NSMutableArray alloc] init];
    }
    return _dataList;
}

- (NSMutableArray<UIImage *> *)imageList {
    if (_imageList == nil) {
        _imageList = [[NSMutableArray alloc] init];
    }
    return _imageList;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    _collectionView = ({
        UICollectionViewFlowLayout *layout = [UICollectionViewFlowLayout new];
        UICollectionView *collectionView = [[UICollectionView alloc] initWithFrame:self.view.bounds collectionViewLayout:layout];
        layout.minimumLineSpacing = 5;
        layout.minimumInteritemSpacing = 5;
        layout.itemSize = CGSizeMake((self.view.frame.size.width - 10.0f) / 2.0f, (self.view.frame.size.width - 10.0f) / 2.0f);
        [self.view addSubview:collectionView];
        [collectionView registerClass:[PhotoCell class] forCellWithReuseIdentifier:@"cell"];
        collectionView.dataSource = self;
        collectionView.delegate = self;
        collectionView;
    });

    // 列出所有相册智能相册
    PHFetchResult *smartAlbums = [PHAssetCollection fetchAssetCollectionsWithType:PHAssetCollectionTypeSmartAlbum
                                                                          subtype:PHAssetCollectionSubtypeAlbumRegular options:nil];
    PHFetchResult *topLevelUserCollections = [PHCollectionList fetchTopLevelUserCollectionsWithOptions:nil];
    PHFetchOptions *options = [[PHFetchOptions alloc] init];
    options.sortDescriptors = @[[NSSortDescriptor sortDescriptorWithKey:@"creationDate" ascending:YES]];
    PHFetchResult *assetsFetchResults = [PHAsset fetchAssetsWithOptions:options];
    PHFetchResult *result = [PHAsset fetchAssetsWithMediaType:PHAssetMediaTypeVideo options:options];

    __weak typeof(self) weakSelf = self;
    [result enumerateObjectsUsingBlock:^(PHAsset *asset, NSUInteger idx, BOOL *stop) {
        __strong typeof(weakSelf) strongSelf = weakSelf;
        [strongSelf.dataList addObject:asset];
        NSLog(@"%@", asset);
    }];

    [self.dataList enumerateObjectsUsingBlock:^(PHAsset *asset, NSUInteger idx, BOOL *stop) {
        [[PHImageManager defaultManager] requestImageForAsset:asset
                                                   targetSize:CGSizeMake((self.view.frame.size.width - 10.0f) / 2.0f, (self.view.frame.size.width - 10.0f) / 2.0f)
                                                  contentMode:PHImageContentModeAspectFill
                                                      options:nil
                                                resultHandler:^(UIImage *image, NSDictionary *info) {
                                                    __strong typeof(weakSelf) strongSelf = weakSelf;
                                                    [strongSelf.imageList addObject:image];
                                                }];

        [self.collectionView reloadData];

    }];
}


- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView
                           cellForItemAtIndexPath:
                                   (NSIndexPath *)indexPath {
    PhotoCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cell" forIndexPath:indexPath];

    PHAsset *asset = self.dataList[indexPath.row];
    UIImage *image = ({
        UIImage *i = nil;
        if (indexPath.row < self.imageList.count) {
            i = self.imageList[indexPath.row];
        }
        i;
    });

    cell.imageView.image = image;
//    cell.imageView.image = [asset ]

    return cell;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView
     numberOfItemsInSection:
             (NSInteger)section {
    return _dataList.count;
}

- (void)  collectionView:(UICollectionView *)collectionView
didSelectItemAtIndexPath:
        (NSIndexPath *)indexPath {
    PHAsset *asset = self.dataList[indexPath.row];
    [[PHImageManager defaultManager] requestAVAssetForVideo:asset options:nil resultHandler:^(AVAsset *asset, AVAudioMix *audioMix, NSDictionary *info) {
        PlayerController *vc = [[PlayerController alloc] init];
        vc.asset = asset;
        NSLog(@"");
        [self.navigationController pushViewController:vc animated:YES];
    }];
}

@end
