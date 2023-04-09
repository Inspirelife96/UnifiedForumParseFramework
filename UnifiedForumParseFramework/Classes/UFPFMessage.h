//
//  UFPFMessage.h
//  UFPFParse
//
//  Created by XueFeng Chen on 2022/5/28.
//

#import <Parse/Parse.h>

@class UFPFUserProfile;

NS_ASSUME_NONNULL_BEGIN

@interface UFPFMessage : PFObject <PFSubclassing>

@property (nonatomic, strong) UFPFUserProfile *fromUserProfile;
@property (nonatomic, strong) UFPFUserProfile *toUserProfile;
@property (nonatomic, strong) NSString *content;

@end

NS_ASSUME_NONNULL_END
