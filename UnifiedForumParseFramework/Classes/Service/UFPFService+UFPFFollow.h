//
//  UFPFService+UFPFFollow.h
//  UFPFParse
//
//  Created by XueFeng Chen on 2021/6/24.
//

#import "UFPFService.h"

NS_ASSUME_NONNULL_BEGIN

@class UFPFFollow;
@class UFPFUser;

@interface UFPFService (UFPFFollow)

// Follow表查询

// 查找user的粉丝
+ (NSArray<UFPFUser *> *)findFollower:(UFPFUser *)user
                                page:(NSInteger)page
                           pageCount:(NSInteger)pageCount
                               error:(NSError **)error;
// 查找user的关注
+ (NSArray<UFPFUser *> *)findFollowing:(UFPFUser *)user
                                 page:(NSInteger)page
                            pageCount:(NSInteger)pageCount
                                error:(NSError **)error;

// 查询fromUser是否关注了toUser
+ (BOOL)isFollowFromUser:(UFPFUser *)fromUser toUser:(UFPFUser *)toUser error:(NSError **)error;

// Follow表添加
+ (UFPFFollow *)addFollowFromUser:(UFPFUser *)fromUser toUser:(UFPFUser *)toUser error:(NSError **)error;

// Follow表删除
+ (BOOL)deleteFollowFromUser:(UFPFUser *)fromUser toUser:(UFPFUser *)toUser error:(NSError **)error;
+ (BOOL)deleteFollow:(UFPFFollow *)follow error:(NSError **)error;

@end

NS_ASSUME_NONNULL_END
