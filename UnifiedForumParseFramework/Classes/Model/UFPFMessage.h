//
//  UFPFMessage.h
//  UFPFParse
//
//  Created by XueFeng Chen on 2022/5/28.
//

#import <Parse/Parse.h>

@class UFPFUser;

NS_ASSUME_NONNULL_BEGIN

@interface UFPFMessage : PFObject <PFSubclassing>

@property (nonatomic, strong) UFPFUser *fromUser;
@property (nonatomic, strong) UFPFUser *toUser;
@property (nonatomic, strong) NSString *content;

@end

NS_ASSUME_NONNULL_END
