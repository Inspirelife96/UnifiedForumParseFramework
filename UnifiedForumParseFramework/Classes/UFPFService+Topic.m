//
//  UFPFService+Topic.m
//  UFPFParse
//
//  Created by XueFeng Chen on 2021/6/24.
//

#import "UFPFService+Topic.h"

#import "UFPFDefines.h"

#import "UFPFTopic.h"

#import "UFPFService+Block.h"
#import "UFPFService+UserProfile.h"

@implementation UFPFService (Topic)

// 0 无条件，直接查询Topic表，根据orderBy进行排序，例如查询热门的Topic。
+ (NSArray<UFPFTopic *> *)findTopicsOrderBy:(NSString *)orderBy isOrderByAscending:(BOOL)isOrderByAscending page:(NSUInteger)page pageCount:(NSUInteger)pageCount error:(NSError **)error {
    return [UFPFService findTopicWithCategory:nil tag:nil fromUserProfile:nil orderBy:orderBy isOrderByAscending:isOrderByAscending page:page pageCount:pageCount error:error];
}

// 1 根据Category查询，一般用来展示某个板块的内容
+ (NSArray<UFPFTopic *> *)findTopicsWithCategory:(NSString *)category orderBy:(NSString *)orderBy isOrderByAscending:(BOOL)isOrderByAscending page:(NSUInteger)page pageCount:(NSUInteger)pageCount error:(NSError **)error{
    return [UFPFService findTopicWithCategory:category tag:nil fromUserProfile:nil orderBy:orderBy isOrderByAscending:isOrderByAscending page:page pageCount:pageCount error:error];
}

// 2 根据Tag查询，一般用来展示某个标签的内容
+ (NSArray<UFPFTopic *> *)findTopicsWithTag:(NSString *)tag orderBy:(NSString *)orderBy isOrderByAscending:(BOOL)isOrderByAscending page:(NSUInteger)page pageCount:(NSUInteger)pageCount error:(NSError **)error {
    return [UFPFService findTopicWithCategory:nil tag:tag fromUserProfile:nil orderBy:orderBy isOrderByAscending:isOrderByAscending page:page pageCount:pageCount error:error];
}

// 3 根据fromUserProfile查询，一般用来展示某个用户的内容
+ (NSArray<UFPFTopic *> *)findTopicsCreatedByUser:(UFPFUserProfile *)fromUserProfile orderBy:(NSString *)orderBy isOrderByAscending:(BOOL)isOrderByAscending page:(NSInteger)page pageCount:(NSInteger)pageCount error:(NSError **)error {
    return [UFPFService findTopicWithCategory:nil tag:nil fromUserProfile:fromUserProfile orderBy:orderBy isOrderByAscending:isOrderByAscending page:page pageCount:pageCount error:error];
}

// 4 根据关注，一般用来展示用户关注的内容
+ (NSArray<UFPFTopic *> *)findTopicsFollowedByUser:(UFPFUserProfile *)fromUserProfile orderBy:(NSString *)orderBy isOrderByAscending:(BOOL)isOrderByAscending page:(NSInteger)page pageCount:(NSInteger)pageCount error:(NSError **)error {
    
    // 查询公开的Topic
    PFQuery *query = [PFQuery queryWithClassName:UFPFTopicKeyClass];
    [query whereKey:UFPFTopicKeyIsDeleted equalTo:@(NO)];
    [query whereKey:UFPFTopicKeyIsPrivate equalTo:@(NO)];
    [query whereKey:UFPFTopicKeyIsApproved equalTo:@(YES)];
    
    // 查询fromUserProfile关注的用户
    PFQuery *followQuery = [PFQuery queryWithClassName:UFPFFollowKeyClass];
    [followQuery whereKey:UFPFFollowKeyFromUserProfile equalTo:fromUserProfile];
    
    // 添加条件，Topic的创建者 = fromUserProfile关注的用户
    [query whereKey:UFPFTopicKeyFromUserProfile matchesKey:UFPFFollowKeyToUserProfile inQuery:followQuery];
    
    return [UFPFService _excuteTopicQuery:query orderBy:orderBy isOrderByAscending:isOrderByAscending page:page pageCount:pageCount error:error];
}

+ (UFPFTopic *)addTopicWithIsLocked:(BOOL)isLocked
                          isDeleted:(BOOL)isDeleted
                          isPrivate:(BOOL)isPrivate
                         isApproved:(BOOL)isApproved
                          isPopular:(BOOL)isPopular
                              title:(NSString *)title
                            content:(NSString *)content
                   mediaFileObjects:(NSArray<PFFileObject *> * _Nullable)mediaFileObjects
                      mediaFileType:(NSString *)mediaFileType
                    fromUserProfile:(UFPFUserProfile *)fromUserProfile
                           category:(NSString * _Nullable)category
                               tags:(NSArray<NSString *> * _Nullable)tags
                              error:(NSError **)error
{
    UFPFTopic *topic = [[UFPFTopic alloc] init];
    topic.isLocked = isLocked;
    topic.isDeleted = isDeleted;
    topic.isPrivate = isPrivate;
    topic.isApproved = isApproved;
    topic.isPopular = isPopular;
    topic.title = title;
    topic.content = content;
    
    if (mediaFileObjects) {
        topic.mediaFileObjects = mediaFileObjects;
        topic.mediaFileType = mediaFileType;
    }
    
    topic.fromUserProfile = fromUserProfile;
    topic.postCount = @0;
    topic.likeCount = @0;
    topic.shareCount = @0;
    
    if (category) {
        topic.category = category;
    }
    
    if (tags) {
        topic.tags = tags;
    }
    
    BOOL succeeded = [topic save:error];
    
    if (succeeded) {
        return topic;
        //return [UFPFService addTopicActivity:topic error:error];
    } else {
        return nil;
    }
}

+ (BOOL)updateTopic:(UFPFTopic *)topic
              title:(NSString * _Nullable)title
            content:(NSString * _Nullable)content
   mediaFileObjects:(NSArray<PFFileObject *> * _Nullable)mediaFileObjects
           category:(NSString * _Nullable)category
               tags:(NSArray<NSString *> * _Nullable)tags
              error:(NSError **)error {
    if (title) {
        topic.title = title;
    }
    
    if (content) {
        topic.content = content;
    }
    
    if (mediaFileObjects) {
        topic.mediaFileObjects = mediaFileObjects;
    }
    
    if (category) {
        topic.category = category;
    }
    
    if (tags) {
        topic.tags = tags;
    }
    
    return [topic save:error];
}

// 管理员可以设置锁定状态
+ (BOOL)updateTopic:(UFPFTopic *)topic
           isLocked:(BOOL)isLocked error:(NSError **)error {
    topic.isLocked = isLocked;
    
    return [topic save:error];
}

// 管理员或者作者可以设置删除状态
+ (BOOL)updateTopic:(UFPFTopic *)topic  isDeleted:(BOOL)isDeleted error:(NSError **)error {
    topic.isDeleted = isDeleted;
    
    return [topic save:error];
}

// 作者可以设置私有状态
+ (BOOL)updateTopic:(UFPFTopic *)topic isPrivate:(BOOL)isPrivate error:(NSError **)error {
    topic.isPrivate = isPrivate;
    
    return [topic save:error];
}

// 管理员可以设置审核状态
+ (BOOL)updateTopic:(UFPFTopic *)topic isApproved:(BOOL)isApproved error:(NSError **)error {
    topic.isApproved = isApproved;
    
    return [topic save:error];
}

// 管理员可以设置置顶状态
+ (BOOL)updateTopic:(UFPFTopic *)topic isPopular:(BOOL)isPopular error:(NSError **)error {
    topic.isPopular = isPopular;
    
    return [topic save:error];
}

+ (NSArray<UFPFTopic *> *)findTopicWithCategory:(NSString * _Nullable)category
                                            tag:(NSString * _Nullable)tag
                                fromUserProfile:(UFPFUserProfile * _Nullable)fromUserProfile
                                        orderBy:(NSString *)orderBy
                             isOrderByAscending:(BOOL)isOrderByAscending
                                           page:(NSUInteger)page
                                      pageCount:(NSUInteger)pageCount
                                          error:(NSError **)error
{
    // 查询Topics表
    PFQuery *publicTopicsQuery = [PFQuery queryWithClassName:UFPFTopicKeyClass];
    
    // 默认条件1:软删除标记=NO
    [publicTopicsQuery whereKey:UFPFTopicKeyIsDeleted equalTo:@(NO)];
    
    // 默认条件2:审核标记=YES
    [publicTopicsQuery whereKey:UFPFTopicKeyIsApproved equalTo:@(YES)];
    
    // 默认条件3:私有标记=NO
    [publicTopicsQuery whereKey:UFPFTopicKeyIsPrivate equalTo:@(NO)];
    
    // 默认条件4:发布者不能被注销
    PFQuery *deletedUserQuery = [UFPFService buildUserProfileQueryWhereUserIsDeleted];
    [publicTopicsQuery whereKey:UFPFTopicKeyFromUserProfile doesNotMatchQuery:deletedUserQuery];
    
    // 默认条件5:发布者不能被禁止
    PFQuery *lockedUserQuery = [UFPFService buildUserProfileQueryWhereUserIsLocked];
    [publicTopicsQuery whereKey:UFPFTopicKeyFromUserProfile doesNotMatchQuery:lockedUserQuery];
    
    // 输入条件1:如果设置了Category，那么Category必须一致
    if (category) {
        [publicTopicsQuery whereKey:UFPFTopicKeyCategory equalTo:category];
    }
    
    // 输入条件2:如果设置了Tag，那么Tag必须在Tags中存在。注意UFPFTopicKeyTags是数组字段
    if (tag) {
        [publicTopicsQuery whereKey:UFPFTopicKeyTags equalTo:tag];
    }
    
    // 输入条件2:如果设置了fromUserProfile，那么必须符合
    if (fromUserProfile) {
        [publicTopicsQuery whereKey:UFPFTopicKeyFromUserProfile equalTo:fromUserProfile];
    }
    
    PFQuery *query = publicTopicsQuery;
    
    // 如果是登录用户，那么需要额外的处理
    if ([PFUser currentUser]) {
        // 特殊条件:发布者不能在当前登录用户的黑名单列表中
        UFPFUserProfile *currentUserProfile = [[PFUser currentUser] objectForKey:UFPFUserKeyUserProfile];
        PFQuery *blockQuery = [UFPFService buildBlockQueryWhereFromUserProfileIs:currentUserProfile];
        [publicTopicsQuery whereKey:UFPFTopicKeyFromUserProfile doesNotMatchKey:UFPFBlockKeyToUserProfile inQuery:blockQuery];
    }
    
    // 执行Query
    return [UFPFService _excuteTopicQuery:query orderBy:orderBy isOrderByAscending:isOrderByAscending page:page pageCount:pageCount error:error];
}

+ (NSArray *)_excuteTopicQuery:(PFQuery *)query orderBy:(nonnull NSString *)orderBy isOrderByAscending:(BOOL)isOrderByAscending page:(NSInteger)page pageCount:(NSInteger)pageCount error:(NSError **)error {
    
    if (isOrderByAscending) {
        [query orderByAscending:orderBy];
    } else {
        [query orderByDescending:orderBy];
    }
    
    [query setSkip:pageCount * page];
    [query setLimit:pageCount];
    
    return [query findObjects:error];
}


+ (PFQuery *)buildTopicQueryWhereFromUserProfileIsBlockedByUserProfile:(UFPFUserProfile *)userProfile {
    PFQuery *topicQuery = [PFQuery queryWithClassName:UFPFTopicKeyClass];
    PFQuery *blockQuery = [UFPFService buildBlockQueryWhereFromUserProfileIs:userProfile];
    [topicQuery whereKey:UFPFTopicKeyFromUserProfile matchesKey:UFPFBlockKeyToUserProfile inQuery:blockQuery];
    return topicQuery;
}

+ (PFQuery *)buildTopicQueryWhereFromUserProfileIsDeleted {
    PFQuery *topicQuery = [PFQuery queryWithClassName:UFPFTopicKeyClass];
    PFQuery *userQuery = [UFPFService buildUserProfileQueryWhereUserIsDeleted];
    [topicQuery whereKey:UFPFTopicKeyFromUserProfile matchesQuery:userQuery];
    return topicQuery;
}

+ (PFQuery *)buildTopicQueryWhereFromUserProfileIsLocked {
    PFQuery *topicQuery = [PFQuery queryWithClassName:UFPFTopicKeyClass];
    PFQuery *userQuery = [UFPFService buildUserProfileQueryWhereUserIsLocked];
    [topicQuery whereKey:UFPFTopicKeyFromUserProfile matchesQuery:userQuery];
    return topicQuery;
}

@end
