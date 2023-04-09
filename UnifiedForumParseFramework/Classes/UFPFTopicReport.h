//
//  UFPFTopicReport.h
//  UFPFParse
//
//  Created by XueFeng Chen on 2022/5/5.
//

#import <Parse/Parse.h>

NS_ASSUME_NONNULL_BEGIN

@class UFPFTopic;
@class UFPFUserProfile;

@interface UFPFTopicReport : PFObject <PFSubclassing>

@property (nonatomic, strong) UFPFUserProfile *fromUserProfile;
@property (nonatomic, strong) UFPFTopic *toTopic;
@property (nonatomic, strong) NSNumber *reason;

@end

NS_ASSUME_NONNULL_END
