//
//  UFPFPostLike.h
//  UFPFParse
//
//  Created by XueFeng Chen on 2022/5/2.
//

#import <Parse/Parse.h>

NS_ASSUME_NONNULL_BEGIN

@class UFPFPost;
@class UFPFUserProfile;


@interface UFPFPostLike : PFObject <PFSubclassing>

@property (nonatomic, strong) UFPFUserProfile *fromUserProfile;
@property (nonatomic, strong) UFPFPost *toPost;
@property (nonatomic, assign) BOOL isDeleted;

@end

NS_ASSUME_NONNULL_END
