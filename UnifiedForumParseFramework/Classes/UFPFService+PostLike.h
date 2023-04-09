//
//  UFPFService+PostLike.h
//  UFPFParse
//
//  Created by XueFeng Chen on 2022/7/17.
//

#import "UFPFService.h"

@class UFPFPost;
@class UFPFPostLike;
@class UFPFUserProfile;

NS_ASSUME_NONNULL_BEGIN

@interface UFPFService (PostLike)

// 判断用户是否喜欢这个Post
+ (BOOL)isPost:(UFPFPost *)post likedbyUserProfile:(UFPFUserProfile *)userProfile error:(NSError **)error;

// 添加
+ (UFPFPostLike *)addPostLikeWithFromUserProfile:(UFPFUserProfile *)fromUserProfile toPost:(UFPFPost *)toPost error:(NSError **)error;

// 删除
+ (BOOL)deletePostLike:(UFPFPostLike *)postLike error:(NSError **)error;
+ (BOOL)deletePostLikeFromUserProfile:(UFPFUserProfile *)fromUserProfile toPost:(UFPFPost *)toPost error:(NSError **)error;

@end

NS_ASSUME_NONNULL_END
