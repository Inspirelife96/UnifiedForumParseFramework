//
//  UFPFReplyLike.h
//  UFPFParse
//
//  Created by XueFeng Chen on 2022/5/3.
//

#import <Parse/Parse.h>

NS_ASSUME_NONNULL_BEGIN

@class UFPFReply;
@class UFPFUser;

@interface UFPFReplyLike : PFObject <PFSubclassing>

@property (nonatomic, strong) UFPFUser *fromUser;
@property (nonatomic, strong) UFPFReply *toReply;
@property (nonatomic, assign) BOOL isDeleted;

@end

NS_ASSUME_NONNULL_END
