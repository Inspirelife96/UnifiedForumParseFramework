//
//  UFPFPostLike.h
//  UFPFParse
//
//  Created by XueFeng Chen on 2022/5/2.
//

#import <Parse/Parse.h>

NS_ASSUME_NONNULL_BEGIN

@class UFPFPost;
@class UFPFUser;

@interface UFPFPostLike : PFObject <PFSubclassing>

@property (nonatomic, strong) UFPFUser *fromUser;
@property (nonatomic, strong) UFPFPost *toPost;
@property (nonatomic, assign) BOOL isDeleted;

@end

NS_ASSUME_NONNULL_END
