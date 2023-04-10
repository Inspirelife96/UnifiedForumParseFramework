//
//  UFPFPostReport.h
//  UFPFParse
//
//  Created by XueFeng Chen on 2022/5/5.
//

#import <Parse/Parse.h>

NS_ASSUME_NONNULL_BEGIN

@class UFPFPost;
@class UFPFUser;

@interface UFPFPostReport : PFObject <PFSubclassing>

@property (nonatomic, strong) UFPFUser *fromUser;
@property (nonatomic, strong) UFPFPost *toPost;
@property (nonatomic, strong) NSNumber *reason;

@end

NS_ASSUME_NONNULL_END
