//
//  UFPFDefines.h
//  UFPFParse
//
//  Created by XueFeng Chen on 2021/6/22.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSInteger, UFPFErrorCode) {
    kUFPFErrorUserIsLocked = 1000,
    kUFPFErrorUserIsDeleted = 1001,
};

typedef NS_ENUM(NSInteger, UFPFParseReportReason) {
    UFPFParseReportReasonPornography = 0,
    UFPFParseReportReasonIllegal = 1,
    UFPFParseReportReasonIrrelated = 2,
    UFPFParseReportReasonLost = 3,
    UFPFParseReportReasonOthers = 4,
};

extern NSString *const UFPFTimeLineTypeAddTopic;
extern NSString *const UFPFTimeLineTypeAddPost;
extern NSString *const UFPFTimeLineTypeAddReply;
extern NSString *const UFPFTimeLineTypeLikeTopic;
extern NSString *const UFPFTimeLineTypeLikePost;
extern NSString *const UFPFTimeLineTypeLikeReply;
extern NSString *const UFPFTimeLineTypeFollow;

extern NSString *const UFPFNotificationTypeComment;
extern NSString *const UFPFNotificationTypeLike;
extern NSString *const UFPFNotificationTypeMessage;
extern NSString *const UFPFNotificationTypeFollow;
extern NSString *const UFPFNotificationTypeOther;

extern NSString *const UFPFNotificationSubTypeNone;
extern NSString *const UFPFNotificationSubTypeCommentTopic;
extern NSString *const UFPFNotificationSubTypeCommentPost;
extern NSString *const UFPFNotificationSubTypeCommentReply;
extern NSString *const UFPFNotificationSubTypeLikeTopic;
extern NSString *const UFPFNotificationSubTypeLikePost;
extern NSString *const UFPFNotificationSubTypeLikeReply;
extern NSString *const UFPFNotificationSubTypeOtherTopicIsNotApproved;
extern NSString *const UFPFNotificationSubTypeOtherPostIsNotApproved;
extern NSString *const UFPFNotificationSubTypeOtherReplyIsNotApproved;

// 目前不支持转发/赞回帖，暂时不要玩的太大。

// PFObject 表自带下面四个字段，所以下面的所有其他表都自带这四个字段
extern NSString *const UFPFKeyObjectId; // objectId (String)
extern NSString *const UFPFKeyCreatedAt; // 创建日期 (Date)
extern NSString *const UFPFKeyUpdatedAt; // 更新日期 (Date)
extern NSString *const UFPFKeyACL; // 权限控制 (ACL)

# pragma mark - Installtion 表

// 表名为：_Installation，系统默认定了如下字段，你可以在 PFInstallationConstants中找到他们的定义
//
// NSString *const PFInstallationKeyParseVersion = @"parseVersion";
// NSString *const PFInstallationKeyDeviceType = @"deviceType";
// NSString *const PFInstallationKeyInstallationId = @"installationId";
// NSString *const PFInstallationKeyDeviceToken = @"deviceToken";
// NSString *const PFInstallationKeyAppName = @"appName";
// NSString *const PFInstallationKeyAppVersion = @"appVersion";
// NSString *const PFInstallationKeyAppIdentifier = @"appIdentifier";
// NSString *const PFInstallationKeyTimeZone = @"timeZone";
// NSString *const PFInstallationKeyLocaleIdentifier = @"localeIdentifier";
// NSString *const PFInstallationKeyBadge = @"badge";
// NSString *const PFInstallationKeyChannels = @"channels";

// 需要追加的定义

// Class key
extern NSString *const PFInstalltionKeyClass;

// Field keys
extern NSString *const UFPFInstalltionKeyLinkedUser;

#pragma mark - User 表

// User 表 ： 用户表，由Parse Server提供，除了默认的字段之外，需要额外添加一些字段。

// Class key
extern NSString *const PFUserKeyClass;

// Field keys

// 系统提供的字段
//extern NSString *const PFUserKeyEmailVerified;
//extern NSString *const PFUserKeyAuthData;
//extern NSString *const PFUserKeyUserName;
//extern NSString *const PFUserKeyPassword;
//extern NSString *const PFUserKeyEmail;

// 自定义字段
extern NSString *const UFPFUserKeyUserProfile; // 用户的展示信息
extern NSString *const UFPFUserKeyBadgeCount; // 推送统计

# pragma mark - Topics 表

// Topics 表 ： 主题

// Class key
extern NSString *const UFPFTopicKeyClass;

// Field keys

// 标记
extern NSString *const UFPFTopicKeyIsLocked;
extern NSString *const UFPFTopicKeyIsDeleted;
extern NSString *const UFPFTopicKeyIsPrivate;
extern NSString *const UFPFTopicKeyIsApproved;
extern NSString *const UFPFTopicKeyIsPopular;

// 核心字段：
extern NSString *const UFPFTopicKeyTitle; // 标题 （NSString）
extern NSString *const UFPFTopicKeyContent; // 内容（NSString）
extern NSString *const UFPFTopicKeyMediaFileObjects; // 图片，可多图 (NSArray<PFFile *>)
extern NSString *const UFPFTopicKeyMediaFileType;
extern NSString *const UFPFTopicKeyFromUserProfile; // 创建者（PFUser）

// 统计字段：
extern NSString *const UFPFTopicKeyPostCount; // 回帖数（NSNumber）
extern NSString *const UFPFTopicLikeKeyCount; // 点赞数（NSNumber）
extern NSString *const UFPFTopicKeyShareCount; // 分享数（NSNumber）

// 板块/话题：
extern NSString *const UFPFTopicKeyCategory; // 标签 （UFPFCategory）
extern NSString *const UFPFTopicKeyTags; // 标签 （NSArray）



# pragma mark - Posts 表

// Posts 表 ： 回帖

// Class key
extern NSString *const UFPFPostKeyClass;

// Field keys

// 标记
extern NSString *const UFPFPostKeyIsLocked;
extern NSString *const UFPFPostKeyIsApproved;
extern NSString *const UFPFPostKeyIsDeleted;

// 核心内容
extern NSString *const UFPFPostKeyContent;
extern NSString *const UFPFPostKeyMediaFileObjects;
extern NSString *const UFPFPostKeyMediaFileType;
extern NSString *const UFPFPostKeyReplies;

// 统计字段：
extern NSString *const UFPFPostKeyReplyCount;
extern NSString *const UFPFPostLikeKeyCount;

// 关系
extern NSString *const UFPFPostKeyFromUserProfile;
extern NSString *const UFPFPostKeyToTopic;

# pragma mark - Replies 表

// Replies 表 ： 回复表 指用户针对回帖发表的内容，只能是文字。

// Class key
extern NSString *const UFPFReplyKeyClass;

// Field keys

// 标记
extern NSString *const UFPFReplyKeyIsLocked;
extern NSString *const UFPFReplyKeyIsApproved;
extern NSString *const UFPFReplyKeyIsDeleted;

// 核心内容
extern NSString *const UFPFReplyKeyContent;

// 统计字段：
extern NSString *const UFPFReplyLikeKeyCount;

// 关系
extern NSString *const UFPFReplyKeyFromUserProfile;
extern NSString *const UFPFReplyKeyToPost;
extern NSString *const UFPFReplyKeyToReply;

# pragma mark - Categories 表

// Categories 表 ： 板块

// Class key
extern NSString *const UFPFCategoryKeyClass;

// Field keys
extern NSString *const UFPFCategoryKeyName;

# pragma mark - Tags 表

// Tags 表 ： 标签

// Class key
extern NSString *const UFPFTagKeyClass;

// Field keys
extern NSString *const UFPFTagKeyName;

# pragma mark - TopicLikes 表

// TopicLikes 表 ：主题点赞

// Class key
extern NSString *const UFPFTopicLikeKeyClass;

// Field keys
extern NSString *const UFPFTopicLikeKeyFromUserProfile;
extern NSString *const UFPFTopicLikeKeyToTopic;
extern NSString *const UFPFTopicLikeKeyIsDeleted;

# pragma mark - PostLikes 表

// PostLikes 表 ：回帖点赞

// Class key
extern NSString *const UFPFPostLikeKeyClass;

// Field keys
extern NSString *const UFPFPostLikeKeyFromUserProfile;
extern NSString *const UFPFPostLikeKeyToPost;
extern NSString *const UFPFPostLikeKeyIsDeleted;

# pragma mark - ReplyLikes 表

// ReplyLikes 表 ：回复点赞

// Class key
extern NSString *const UFPFReplyLikeKeyClass;

// Field keys
extern NSString *const UFPFReplyLikeKeyFromUserProfile;
extern NSString *const UFPFReplyLikeKeyToReply;
extern NSString *const UFPFReplyLikeKeyIsDeleted;

# pragma mark - TopicReports 表

// TopicReports 表 ：主题举报

// Class key
extern NSString *const UFPFTopicReportKeyClass;

// Field keys
extern NSString *const UFPFTopicReportKeyFromUserProfile;
extern NSString *const UFPFTopicReportKeyToTopic;

# pragma mark - PostReports 表

// PostReports 表 ：回帖举报

// Class key
extern NSString *const UFPFPostReportKeyClass;

// Field keys
extern NSString *const UFPFPostReportKeyFromUserProfile;
extern NSString *const UFPFPostReportKeyToPost;

# pragma mark - ReplyReports 表

// ReplyReports 表 ：回复举报

// Class key
extern NSString *const UFPFReplyReportKeyClass;

// Field keys
extern NSString *const UFPFReplyReportKeyFromUserProfile;
extern NSString *const UFPFReplyReportKeyToReply;


# pragma mark - Shares 表

// Shares 表 指用户分享Topic

// Class key
extern NSString *const UFPFShareKeyClass;

// Field keys
extern NSString *const UFPFShareKeyTopic; // 分享的Topic
extern NSString *const UFPFShareKeyFromUserProfile; // 谁分享的
extern NSString *const UFPFShareKeyToPlatform; // 分享到什么地方了

# pragma mark - Follows 表

// Follows 表： 指用户之间的关系

// Class key
extern NSString *const UFPFFollowKeyClass;

// Field keys
extern NSString *const UFPFFollowKeyFromUserProfile; // 关注
extern NSString *const UFPFFollowKeyToUserProfile; // 被关注
extern NSString *const UFPFFollowKeyIsDeleted;


# pragma mark - Blocks 表

// Blocks 表： 黑名单表

// Class key
extern NSString *const UFPFBlockKeyClass;

// Field keys
extern NSString *const UFPFBlockKeyFromUserProfile; // 发起者
extern NSString *const UFPFBlockKeyToUserProfile; // 黑名单用户


# pragma mark - TimeLine 表

// Timeline 表

// Class key
extern NSString *const UFPFTimeLineKeyClass;

extern NSString *const UFPFTimeLineKeyFromUserProfile; // 消息发送者
extern NSString *const UFPFTimeLineKeyToUserProfile; // 消息接受者
extern NSString *const UFPFTimeLineKeyType;
extern NSString *const UFPFTimeLineKeyTopic;
extern NSString *const UFPFTimeLineKeyPost;
extern NSString *const UFPFTimeLineKeyReply;
extern NSString *const UFPFTimeLineKeyIsDeleted;

# pragma mark - UserProfile 表

// UserProfile表
// Parse Server提供的“_User”表，由于安全原因，不能读取，因此创建一个UserProfile表，来保存用户的一些可以展示的内容。
// UserProfile字段在用户创建时创建，并和系统的“_User”表关联。

// Class key
extern NSString *const UFPFUserProfileKeyClass;

// Field keys
extern NSString *const UFPFUserProfileKeyUser; // 关联"_User"表
extern NSString *const UFPFUserProfileKeyIsLocked; // 标记该账户是否被锁定，由管理员锁定
extern NSString *const UFPFUserProfileKeyIsDeleted; // 标记该用户是否被删除，由用户自己删除
extern NSString *const UFPFUserProfileKeyAvatar; // 用户头像
extern NSString *const UFPFUserProfileKeyBackgroundImage; //用户背景
extern NSString *const UFPFUserProfileKeyBio; // 个性签名
extern NSString *const UFPFUserProfileKeyPreferredLanguage; // 喜欢的语言
extern NSString *const UFPFUserProfileKeyProfileviews; // 统计信息：被浏览次数
extern NSString *const UFPFUserProfileKeyReputation; // 统计信息：荣誉值
extern NSString *const UFPFUserProfileKeyTopicCount; // 统计信息：发帖数量
extern NSString *const UFPFUserProfileKeyPostCount; // 统计信息：回复数量
extern NSString *const UFPFUserProfileKeyFollowerCount; // 统计信息：粉丝
extern NSString *const UFPFUserProfileKeyFollowingCount; // 统计信息：关注
extern NSString *const UFPFUserProfileKeyLikedCount; // 统计信息：被赞数量

# pragma mark - Notification 表

// Class key
extern NSString *const UFPFNotificationKeyClass;

// Field keys

extern NSString *const UFPFNotificationKeyFromUserProfile;
extern NSString *const UFPFNotificationKeyToUserProfile;
extern NSString *const UFPFNotificationKeyType;
extern NSString *const UFPFNotificationKeySubType;
extern NSString *const UFPFNotificationKeyTopic;
extern NSString *const UFPFNotificationKeyPost;
extern NSString *const UFPFNotificationKeyReply;
extern NSString *const UFPFNotificationKeyMessage;

# pragma mark - NotificationCount 表

// Class key
extern NSString *const UFPFNotificationCountKeyClass;

// Field keys

extern NSString *const UFPFNotificationCountKeyUser;
extern NSString *const UFPFNotificationCountKeyTotalCount;
extern NSString *const UFPFNotificationCountKeyCommentCount;
extern NSString *const UFPFNotificationCountKeyLikeCount;
extern NSString *const UFPFNotificationCountKeyFollowCount;
extern NSString *const UFPFNotificationCountKeyMessageCount;
extern NSString *const UFPFNotificationCountKeyOtherCount;

# pragma mark - Message 表

// Message表 保存用户的私信信息

// Class key
extern NSString *const UFPFMessageKeyClass;

// Field keys
extern NSString *const UFPFMessageKeyFromUserProfile;
extern NSString *const UFPFMessageKeyToUserProfile;
extern NSString *const UFPFMessageKeyContent;


# pragma mark - MessageGroup 表

// Message表 保存用户的私信信息

// Class key
extern NSString *const UFPFMessageGroupKeyClass;

// Field keys
extern NSString *const UFPFMessageGroupKeyFromUserProfile;
extern NSString *const UFPFMessageGroupKeyToUserProfile;
extern NSString *const UFPFMessageGroupKeyLastMessage;
extern NSString *const UFPFMessageGroupKeyUnreadMessageCount;


# pragma mark - BadgeCount 表

// Message表 保存用户的私信信息

// Class key
extern NSString *const UFPFBadgeCountKeyClass;

// Field keys
extern NSString *const UFPFBadgeCountKeyUser;
extern NSString *const UFPFBadgeCountKeyTotalCount;
extern NSString *const UFPFBadgeCountKeyCommentCount;
extern NSString *const UFPFBadgeCountKeyLikeCount;
extern NSString *const UFPFBadgeCountKeyFollowCount;
extern NSString *const UFPFBadgeCountKeyMessageCount;
extern NSString *const UFPFBadgeCountKeyOtherCount;

# pragma mark - AppInfo 表

// AppInfo表 保存应用的相关信息

// Class key
extern NSString *const UFPFAppInfoKeyClass;

// Field keys
extern NSString *const UFPFAppInfoKeyVersion;
