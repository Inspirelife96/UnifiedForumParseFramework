//
//  UFPFService+Follow.h
//  UFPFParse
//
//  Created by XueFeng Chen on 2021/6/24.
//

#import "UFPFService.h"

NS_ASSUME_NONNULL_BEGIN

@class UFPFFollow;
@class UFPFUserProfile;

@interface UFPFService (Follow)

// Follow表查询

// 查找user的粉丝
+ (NSArray<UFPFUserProfile *> *)findFollower:(UFPFUserProfile *)userProfile
                                page:(NSInteger)page
                           pageCount:(NSInteger)pageCount
                               error:(NSError **)error;
// 查找user的关注
+ (NSArray<UFPFUserProfile *> *)findFollowing:(UFPFUserProfile *)userProfile
                                 page:(NSInteger)page
                            pageCount:(NSInteger)pageCount
                                error:(NSError **)error;

// 查询fromUserProfile是否关注了toUser
+ (BOOL)isFollowFromUserProfile:(UFPFUserProfile *)fromUserProfile toUserProfile:(UFPFUserProfile *)toUserProfile error:(NSError **)error;

// Follow表添加
+ (UFPFFollow *)addFollowFromUserProfile:(UFPFUserProfile *)fromUserProfile toUserProfile:(UFPFUserProfile *)toUserProfile error:(NSError **)error;

// Follow表删除
+ (BOOL)deleteFollowFromUserProfile:(UFPFUserProfile *)fromUserProfile toUserProfile:(UFPFUserProfile *)toUserProfile error:(NSError **)error;
+ (BOOL)deleteFollow:(UFPFFollow *)follow error:(NSError **)error;

@end

NS_ASSUME_NONNULL_END
