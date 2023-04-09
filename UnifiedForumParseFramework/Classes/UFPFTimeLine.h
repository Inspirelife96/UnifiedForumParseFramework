//
//  UFPFTimeLine.h
//  UnifiedForumParseFramework
//
//  Created by XueFeng Chen on 2023/2/19.
//

#import <Parse/Parse.h>

@class UFPFTopic;
@class UFPFPost;
@class UFPFReply;
@class UFPFUserProfile;

NS_ASSUME_NONNULL_BEGIN

@interface UFPFTimeLine : PFObject <PFSubclassing>

@property (nonatomic, strong) UFPFUserProfile *fromUserProfile;
@property (nonatomic, strong) UFPFUserProfile *toUserProfile;

@property (nonatomic, strong) NSString *type;

@property (nonatomic, strong) UFPFTopic *topic;
@property (nonatomic, strong) UFPFPost *post;
@property (nonatomic, strong) UFPFReply *reply;

@property (nonatomic, assign) BOOL isDeleted;

@end

NS_ASSUME_NONNULL_END
