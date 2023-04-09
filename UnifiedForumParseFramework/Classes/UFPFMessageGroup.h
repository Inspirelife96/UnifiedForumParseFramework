//
//  UFPFMessageGroup.h
//  UFPFParse
//
//  Created by XueFeng Chen on 2022/5/28.
//

#import <Parse/Parse.h>

@class UFPFMessage;
@class UFPFUserProfile;

NS_ASSUME_NONNULL_BEGIN

@interface UFPFMessageGroup : PFObject <PFSubclassing>

@property (nonatomic, strong) UFPFUserProfile *fromUserProfile;
@property (nonatomic, strong) UFPFUserProfile *toUserProfile;
@property (nonatomic, strong) UFPFMessage *lastMessage;
@property (nonatomic, strong) NSNumber *unreadMessageCount;

@end

NS_ASSUME_NONNULL_END
