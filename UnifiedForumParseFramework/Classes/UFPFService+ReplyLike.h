//
//  UFPFService+ReplyLike.h
//  UFPFParse
//
//  Created by XueFeng Chen on 2022/7/17.
//

#import "UFPFService.h"

NS_ASSUME_NONNULL_BEGIN

@class UFPFReply;
@class UFPFReplyLike;
@class UFPFUserProfile;

@interface UFPFService (ReplyLike)

// 判断用户是否喜欢这个Reply
+ (BOOL)isReply:(UFPFReply *)reply likedbyUserProfile:(UFPFUserProfile *)userProfile error:(NSError **)error;

// 添加
+ (UFPFReplyLike *)addReplyLikeWithFromUserProfile:(UFPFUserProfile *)fromUserProfile toReply:(UFPFReply *)toReply error:(NSError **)error;

// 删除
+ (BOOL)deleteReplyLike:(UFPFReplyLike *)replyLike error:(NSError **)error;
+ (BOOL)deleteReplyLikeFromUserProfile:(UFPFUserProfile *)fromUserProfile toReply:(UFPFReply *)toReply error:(NSError **)error;

@end

NS_ASSUME_NONNULL_END
