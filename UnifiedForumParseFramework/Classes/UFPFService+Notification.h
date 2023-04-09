//
//  UFPFService+Notification.h
//  UFPFParse
//
//  Created by XueFeng Chen on 2022/5/28.
//

#import "UFPFService.h"

NS_ASSUME_NONNULL_BEGIN

@class UFPFTopic;
@class UFPFPost;
@class UFPFReply;
@class UFPFMessageGroup;
@class UFPFNotification;
@class UFPFUserProfile;

@interface UFPFService (Notification)

+ (NSArray<UFPFNotification *> *)findCommentNotificationToUserProfile:(UFPFUserProfile *)toUserProfile
                                                                 page:(NSInteger)page
                                                            pageCount:(NSInteger)pageCount
                                                                error:(NSError **)error;

+ (NSArray<UFPFNotification *> *)findLikeNotificationToUserProfile:(UFPFUserProfile *)toUserProfile
                                                              page:(NSInteger)page
                                                         pageCount:(NSInteger)pageCount
                                                             error:(NSError **)error;

+ (NSArray<UFPFNotification *> *)findFollowNotificationToUserProfile:(UFPFUserProfile *)toUserProfile
                                                                page:(NSInteger)page
                                                           pageCount:(NSInteger)pageCount
                                                               error:(NSError **)error;

+ (NSArray<UFPFNotification *> *)findMessageGroupNotificationToUserProfile:(UFPFUserProfile *)toUserProfile
                                                                      page:(NSInteger)page
                                                                 pageCount:(NSInteger)pageCount
                                                                     error:(NSError **)error;

+ (NSArray<UFPFNotification *> *)findOtherNotificationToUserProfile:(UFPFUserProfile *)toUserProfile
                                                               page:(NSInteger)page
                                                          pageCount:(NSInteger)pageCount
                                                              error:(NSError **)error;

// 部分在客户端实现，部分会在服务器端实现 // todo:这个需要吗？照理说应该全部在服务器实现
+ (BOOL)addNotificationFromUserProfile:(UFPFUserProfile *)fromUserProfile
                         toUserProfile:(UFPFUserProfile *)toUserProfile
                                  type:(NSString *)type
                               subType:(NSString *)subType
                                 topic:(UFPFTopic * _Nullable)topic
                                  post:(UFPFPost * _Nullable)post
                                 reply:(UFPFReply * _Nullable)reply
                          messageGroup:(UFPFMessageGroup * _Nullable)messageGroup
                                 error:(NSError **)error;

@end

NS_ASSUME_NONNULL_END
