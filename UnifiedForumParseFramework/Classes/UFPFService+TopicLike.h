//
//  UFPFService+TopicLike.h
//  UFPFParse
//
//  Created by XueFeng Chen on 2022/5/19.
//

#import "UFPFService.h"

@class UFPFTopic;
@class UFPFTopicLike;
@class UFPFUserProfile;

NS_ASSUME_NONNULL_BEGIN

@interface UFPFService (TopicLike)

// 查找喜欢这个Topic的用户
+ (NSArray<PFUser *> *)findUsersWhoLikesTopic:(UFPFTopic *)toTopic page:(NSInteger)page pageCount:(NSInteger)pageCount error:(NSError **)error;

// 查找用户喜欢的Topic
+ (NSArray<UFPFTopic *> *)findTopicsLikedByUser:(UFPFUserProfile *)fromUserProfile page:(NSInteger)page pageCount:(NSInteger)pageCount error:(NSError **)error;

// 判断用户是否喜欢这个Topic
+ (BOOL)isTopic:(UFPFTopic *)topic likedbyUserProfile:(UFPFUserProfile *)userProfile error:(NSError **)error;

// 添加
+ (UFPFTopicLike *)addTopicLikeWithFromUserProfile:(UFPFUserProfile *)fromUserProfile toTopic:(UFPFTopic *)toTopic error:(NSError **)error;

// 删除
+ (BOOL)deleteTopicLike:(UFPFTopicLike *)topicLike error:(NSError **)error;
+ (BOOL)deleteTopicLikeFromUserProfile:(UFPFUserProfile *)fromUserProfile toTopic:(UFPFTopic *)toTopic error:(NSError **)error;

@end

NS_ASSUME_NONNULL_END
