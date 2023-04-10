//
//  UFPFService+UFPFNotification.m
//  UFPFParse
//
//  Created by XueFeng Chen on 2022/5/28.
//

#import "UFPFService+UFPFNotification.h"

#import "UFPFNotification.h"

#import "UFPFDefines.h"

@implementation UFPFService (UFPFNotification)

+ (NSArray<UFPFNotification *> *)findCommentNotificationToUser:(UFPFUser *)toUser
                                                                 page:(NSInteger)page
                                                            pageCount:(NSInteger)pageCount
                                                                error:(NSError **)error {
    return [UFPFService queryNotificationToUser:toUser type:UFPFNotificationTypeComment page:page pageCount:pageCount error:error];
}

+ (NSArray<UFPFNotification *> *)findLikeNotificationToUser:(UFPFUser *)toUser
                                                              page:(NSInteger)page
                                                         pageCount:(NSInteger)pageCount
                                                             error:(NSError **)error {
    return [UFPFService queryNotificationToUser:toUser type:UFPFNotificationTypeLike page:page pageCount:pageCount error:error];
}

+ (NSArray<UFPFNotification *> *)findFollowNotificationToUser:(UFPFUser *)toUser
                                                                page:(NSInteger)page
                                                           pageCount:(NSInteger)pageCount
                                                               error:(NSError **)error {
    return [UFPFService queryNotificationToUser:toUser type:UFPFNotificationTypeFollow page:page pageCount:pageCount error:error];
}

+ (NSArray<UFPFNotification *> *)findMessageGroupNotificationToUser:(UFPFUser *)toUser
                                                                      page:(NSInteger)page
                                                                 pageCount:(NSInteger)pageCount
                                                                     error:(NSError **)error {
    return [UFPFService queryNotificationToUser:toUser type:UFPFNotificationTypeMessage page:page pageCount:pageCount error:error];
}

+ (NSArray<UFPFNotification *> *)findOtherNotificationToUser:(UFPFUser *)toUser
                                                               page:(NSInteger)page
                                                          pageCount:(NSInteger)pageCount
                                                              error:(NSError **)error {
    return [UFPFService queryNotificationToUser:toUser type:UFPFNotificationTypeOther page:page pageCount:pageCount error:error];
}


+ (NSArray<UFPFNotification *> *)queryNotificationToUser:(UFPFUser *)toUser
                                                           type:(NSString *)type
                                                           page:(NSInteger)page
                                                      pageCount:(NSInteger)pageCount
                                                          error:(NSError **)error {
    PFQuery *query = [PFQuery queryWithClassName:UFPFNotificationKeyClass];
    [query whereKey:UFPFNotificationKeyToUser equalTo:toUser];
    [query whereKey:UFPFNotificationKeyType equalTo:type];
    
    [query orderByDescending:UFPFKeyUpdatedAt];
    
    [query setSkip:pageCount * page];
    [query setLimit:pageCount];
    
    return [query findObjects:error];
}

+ (BOOL)addNotificationFromUser:(UFPFUser *)fromUser
                         toUser:(UFPFUser *)toUser
                                  type:(NSString *)type
                               subType:(NSString *)subType
                                 topic:(UFPFTopic * _Nullable)topic
                                  post:(UFPFPost * _Nullable)post
                                 reply:(UFPFReply * _Nullable)reply
                          messageGroup:(UFPFMessageGroup * _Nullable)messageGroup
                                 error:(NSError **)error {
    UFPFNotification *notification = [[UFPFNotification alloc] init];
    
    notification.fromUser = fromUser;
    notification.toUser = toUser;
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
