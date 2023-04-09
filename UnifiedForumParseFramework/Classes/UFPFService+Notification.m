//
//  UFPFService+Notification.m
//  UFPFParse
//
//  Created by XueFeng Chen on 2022/5/28.
//

#import "UFPFService+Notification.h"

#import "UFPFNotification.h"

#import "UFPFDefines.h"

@implementation UFPFService (Notification)

+ (NSArray<UFPFNotification *> *)findCommentNotificationToUserProfile:(UFPFUserProfile *)toUserProfile
                                                                 page:(NSInteger)page
                                                            pageCount:(NSInteger)pageCount
                                                                error:(NSError **)error {
    return [UFPFService queryNotificationToUserProfile:toUserProfile type:UFPFNotificationTypeComment page:page pageCount:pageCount error:error];
}

+ (NSArray<UFPFNotification *> *)findLikeNotificationToUserProfile:(UFPFUserProfile *)toUserProfile
                                                              page:(NSInteger)page
                                                         pageCount:(NSInteger)pageCount
                                                             error:(NSError **)error {
    return [UFPFService queryNotificationToUserProfile:toUserProfile type:UFPFNotificationTypeLike page:page pageCount:pageCount error:error];
}

+ (NSArray<UFPFNotification *> *)findFollowNotificationToUserProfile:(UFPFUserProfile *)toUserProfile
                                                                page:(NSInteger)page
                                                           pageCount:(NSInteger)pageCount
                                                               error:(NSError **)error {
    return [UFPFService queryNotificationToUserProfile:toUserProfile type:UFPFNotificationTypeFollow page:page pageCount:pageCount error:error];
}

+ (NSArray<UFPFNotification *> *)findMessageGroupNotificationToUserProfile:(UFPFUserProfile *)toUserProfile
                                                                      page:(NSInteger)page
                                                                 pageCount:(NSInteger)pageCount
                                                                     error:(NSError **)error {
    return [UFPFService queryNotificationToUserProfile:toUserProfile type:UFPFNotificationTypeMessage page:page pageCount:pageCount error:error];
}

+ (NSArray<UFPFNotification *> *)findOtherNotificationToUserProfile:(UFPFUserProfile *)toUserProfile
                                                               page:(NSInteger)page
                                                          pageCount:(NSInteger)pageCount
                                                              error:(NSError **)error {
    return [UFPFService queryNotificationToUserProfile:toUserProfile type:UFPFNotificationTypeOther page:page pageCount:pageCount error:error];
}


+ (NSArray<UFPFNotification *> *)queryNotificationToUserProfile:(UFPFUserProfile *)toUserProfile
                                                           type:(NSString *)type
                                                           page:(NSInteger)page
                                                      pageCount:(NSInteger)pageCount
                                                          error:(NSError **)error {
    PFQuery *query = [PFQuery queryWithClassName:UFPFNotificationKeyClass];
    [query whereKey:UFPFNotificationKeyToUserProfile equalTo:toUserProfile];
    [query whereKey:UFPFNotificationKeyType equalTo:type];
    
    [query orderByDescending:UFPFKeyUpdatedAt];
    
    [query setSkip:pageCount * page];
    [query setLimit:pageCount];
    
    return [query findObjects:error];
}

+ (BOOL)addNotificationFromUserProfile:(UFPFUserProfile *)fromUserProfile
                         toUserProfile:(UFPFUserProfile *)toUserProfile
                                  type:(NSString *)type
                               subType:(NSString *)subType
                                 topic:(UFPFTopic * _Nullable)topic
                                  post:(UFPFPost * _Nullable)post
                                 reply:(UFPFReply * _Nullable)reply
                          messageGroup:(UFPFMessageGroup * _Nullable)messageGroup
                                 error:(NSError **)error {
    UFPFNotification *notification = [[UFPFNotification alloc] init];
    
    notification.fromUserProfile = fromUserProfile;
    notification.toUserProfile = toUserProfile;
    notification.type = type;
    notification.subType = subType;
    
    if (topic) {
        notification.topic = topic;
    }
    
    if (post) {
        notification.post = post;
    }
    
    if (reply) {
        notification.reply = reply;
    }
    
    if (messageGroup) {
        notification.messageGroup = messageGroup;
    }
    
    return [notification save:error];
}

@end
