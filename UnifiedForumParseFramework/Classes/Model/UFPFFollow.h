//
//  UFPFFollow.h
//  UFPFParse
//
//  Created by XueFeng Chen on 2021/6/22.
//

#import <Parse/Parse.h>

@class UFPFUser;

NS_ASSUME_NONNULL_BEGIN

@interface UFPFFollow : PFObject <PFSubclassing>

@property (nonatomic, strong) UFPFUser *fromUser;
@property (nonatomic, strong) UFPFUser *toUser;
@property (nonatomic, assign) BOOL isDeleted;

@end

NS_ASSUME_NONNULL_END
