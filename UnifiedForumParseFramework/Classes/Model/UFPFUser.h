//
//  UFPFUser.h
//  UFPFParse
//
//  Created by XueFeng Chen on 2021/6/26.
//

#import <Parse/Parse.h>

NS_ASSUME_NONNULL_BEGIN

@interface UFPFUser : PFObject <PFSubclassing>

// 需要关联吗？不需要！
// 理论上PFUser关联UFPFUser，因此可以通过PFUser查找到UFPFUser
// 但知道UFPFUser，是不能逆推找到PFUser的。

// 但暂时保留
@property (nonatomic, strong) PFUser *account;

// 基本信息

// 昵称
@property (nonatomic, copy) NSString *nickName;

// 头像
@property (nonatomic, strong, nullable) PFFileObject *avatar;

// 背景图
@property (nonatomic, strong, nullable) PFFileObject *backgroundImage;

// 个性签名
@property (nonatomic, copy, nullable) NSString *bio;

// 喜欢的语言
@property (nonatomic, copy, nullable) NSString *preferredLanguage;

// 标记

// 是否被锁定，可以被管理员锁定，用户将无法登录
@property (nonatomic, assign) BOOL isLocked;

// 是否被删除，可以被用户删除，用户将无法登录，同时数据库维护时，会将该用户的数据清除。
@property (nonatomic, assign) BOOL isDeleted;

// 统计信息

// 被浏览次数
@property (nonatomic, strong) NSNumber *profileViews;

// 积分
@property (nonatomic, strong) NSNumber *reputation;

// 话题数
@property (nonatomic, strong) NSNumber *topicCount;

// 回复数
@property (nonatomic, strong) NSNumber *postCount;

// 粉丝数
@property (nonatomic, strong) NSNumber *followerCount;

// 关注数
@property (nonatomic, strong) NSNumber *followingCount;

// 收获的赞
@property (nonatomic, strong) NSNumber *likedCount;

@end

NS_ASSUME_NONNULL_END
