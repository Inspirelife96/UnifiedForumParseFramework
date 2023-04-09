//
//  UFPFReplyLike.h
//  UFPFParse
//
//  Created by XueFeng Chen on 2022/5/3.
//

#import <Parse/Parse.h>

NS_ASSUME_NONNULL_BEGIN

@class UFPFReply;
@class UFPFUserProfile;

@interface UFPFReplyLike : PFObject <PFSubclassing>

@property (nonatomic, strong) UFPFUserProfile *fromUserProfile;
@property (nonatomic, strong) UFPFReply *toReply;
@property (nonatomic, assign) BOOL isDeleted;

@end

NS_ASSUME_NONNULL_END
