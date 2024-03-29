//
//  UFPFTopicReport.h
//  UFPFParse
//
//  Created by XueFeng Chen on 2022/5/5.
//

#import <Parse/Parse.h>

NS_ASSUME_NONNULL_BEGIN

@class UFPFTopic;
@class UFPFUser;

@interface UFPFTopicReport : PFObject <PFSubclassing>

@property (nonatomic, strong) UFPFUser *fromUser;
@property (nonatomic, strong) UFPFTopic *toTopic;
@property (nonatomic, strong) NSNumber *reason;

@end

NS_ASSUME_NONNULL_END
