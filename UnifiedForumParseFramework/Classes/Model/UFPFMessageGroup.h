//
//  UFPFMessageGroup.h
//  UFPFParse
//
//  Created by XueFeng Chen on 2022/5/28.
//

#import <Parse/Parse.h>

@class UFPFMessage;
@class UFPFUser;

NS_ASSUME_NONNULL_BEGIN

@interface UFPFMessageGroup : PFObject <PFSubclassing>

@property (nonatomic, strong) UFPFUser *fromUser;
@property (nonatomic, strong) UFPFUser *toUser;
@property (nonatomic, strong) UFPFMessage *lastMessage;
@property (nonatomic, strong) NSNumber *unreadMessageCount;

@end

NS_ASSUME_NONNULL_END
