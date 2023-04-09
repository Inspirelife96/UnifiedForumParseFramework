//
//  UFPFService+Block.h
//  UFPFParse
//
//  Created by XueFeng Chen on 2022/7/21.
//

#import "UFPFService.h"

NS_ASSUME_NONNULL_BEGIN

@class UFPFBlock;
@class UFPFUserProfile;

@interface UFPFService (Block)

/**
 添加黑名单，用户fromUserProfile将用户toUserProfile加入自己的黑名单

 @param fromUserProfile 用户信息
 @param toUserProfile 用户信息
 @param error 出错信息
 
 @return 返回插入的黑名单的记录
 */
+ (UFPFBlock *)addBlockFromUserProfile:(UFPFUserProfile *)fromUserProfile toUserProfile:(UFPFUserProfile *)toUserProfile error:(NSError **)error;

/**
 创建一个用于查询用户黑名单的Query

 @param userProfile 用户信息
 
 @return 返回查询用户黑名单的Query
 */
+ (PFQuery *)buildBlockQueryWhereFromUserProfileIs:(UFPFUserProfile *)userProfile;

@end

NS_ASSUME_NONNULL_END
