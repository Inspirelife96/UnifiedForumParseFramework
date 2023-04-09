//
//  UFPFShare.h
//  UFPFParse
//
//  Created by XueFeng Chen on 2021/6/22.
//

#import <Parse/Parse.h>

NS_ASSUME_NONNULL_BEGIN

@class UFPFTopic;
@class UFPFUserProfile;

@interface UFPFShare : PFObject <PFSubclassing>

@property (nonatomic, strong) UFPFTopic *topic;
@property (nonatomic, strong) UFPFUserProfile *fromUserProfile;
@property (nonatomic, copy) NSString *toPlatform;

@end

NS_ASSUME_NONNULL_END
