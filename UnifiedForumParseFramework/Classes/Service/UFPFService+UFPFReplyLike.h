//
//  UFPFService+UFPFReplyLike.h
//  UFPFParse
//
//  Created by XueFeng Chen on 2022/7/17.
//

#import "UFPFService.h"

NS_ASSUME_NONNULL_BEGIN

@class UFPFReply;
@class UFPFReplyLike;
@class UFPFUser;

@interface UFPFService (UFPFReplyLike)

// 判断用户是否喜欢这个Reply
+ (BOOL)isReply:(UFPFReply *)reply likedbyUser:(UFPFUser *)user error:(NSError **)error;

// 添加
+ (UFPFReplyLike *)addReplyLikeWithFromUser:(UFPFUser *)fromUser toReply:(UFPFReply *)toReply error:(NSError **)error;

// 删除
+ (BOOL)deleteReplyLike:(UFPFReplyLike *)replyLike error:(NSError **)error;
+ (BOOL)deleteReplyLikeFromUser:(UFPFUser *)fromUser toReply:(UFPFReply *)toReply error:(NSError **)error;

@end

NS_ASSUME_NONNULL_END
