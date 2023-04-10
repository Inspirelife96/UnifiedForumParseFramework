//
//  UFPFService+UFPFBlock.h
//  UFPFParse
//
//  Created by XueFeng Chen on 2022/7/21.
//

#import "UFPFService.h"

NS_ASSUME_NONNULL_BEGIN

@class UFPFBlock;
@class UFPFUser;

@interface UFPFService (UFPFBlock)

/**
 添加黑名单，用户fromUser将用户toUser加入自己的黑名单

 @param fromUser 用户信息
 @param toUser 用户信息
 @param error 出错信息
 
 @return 返回插入的黑名单的记录
 */
+ (UFPFBlock *)addBlockFromUser:(UFPFUser *)fromUser toUser:(UFPFUser *)toUser error:(NSError **)error;

+ (BOOL)deleteBlock:(UFPFBlock *)block error:(NSError **)error;
+ (BOOL)deleteBlockFromUser:(UFPFUser *)fromUser toUser:(UFPFUser *)toUser error:(NSError **)error;

/**
 创建一个用于查询用户黑名单的Query

 @param user 用户信息
 
 @return 返回查询用户黑名单的Query
 */
+ (PFQuery *)buildBlockQueryWhereFromUserIs:(UFPFUser *)user;

@end

NS_ASSUME_NONNULL_END
