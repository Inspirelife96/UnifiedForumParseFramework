//
//  UFPFBlock.h
//  UFPFParse
//
//  Created by XueFeng Chen on 2021/9/7.
//

#import <Parse/Parse.h>

@class UFPFUser;

NS_ASSUME_NONNULL_BEGIN

@interface UFPFBlock : PFObject <PFSubclassing>

@property (nonatomic, strong) UFPFUser *fromUser;
@property (nonatomic, strong) UFPFUser *toUser;
@property (nonatomic, assign) BOOL isDeleted;

@end

NS_ASSUME_NONNULL_END
