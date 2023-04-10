//
//  UFPFService+UFPFPostLike.h
//  UFPFParse
//
//  Created by XueFeng Chen on 2022/7/17.
//

#import "UFPFService.h"

@class UFPFPost;
@class UFPFPostLike;
@class UFPFUser;

NS_ASSUME_NONNULL_BEGIN

@interface UFPFService (UFPFPostLike)

// 判断用户是否喜欢这个Post
+ (BOOL)isPost:(UFPFPost *)post likedbyUser:(UFPFUser *)user error:(NSError **)error;

// 添加
+ (UFPFPostLike *)addPostLikeWithFromUser:(UFPFUser *)fromUser toPost:(UFPFPost *)toPost error:(NSError **)error;

// 删除
+ (BOOL)deletePostLike:(UFPFPostLike *)postLike error:(NSError **)error;
+ (BOOL)deletePostLikeFromUser:(UFPFUser *)fromUser toPost:(UFPFPost *)toPost error:(NSError **)error;

@end

NS_ASSUME_NONNULL_END
