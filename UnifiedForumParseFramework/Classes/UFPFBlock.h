//
//  UFPFBlock.h
//  UFPFParse
//
//  Created by XueFeng Chen on 2021/9/7.
//

#import <Parse/Parse.h>

@class UFPFUserProfile;

NS_ASSUME_NONNULL_BEGIN

@interface UFPFBlock : PFObject <PFSubclassing>

@property (nonatomic, strong) UFPFUserProfile *fromUserProfile;
@property (nonatomic, strong) UFPFUserProfile *toUserProfile;

@end

NS_ASSUME_NONNULL_END
