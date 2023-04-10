//
//  UFPFService+UFPFShare.h
//  UFPFParse
//
//  Created by XueFeng Chen on 2021/6/24.
//

#import "UFPFService.h"

@class UFPFTopic;
@class UFPFUser;

NS_ASSUME_NONNULL_BEGIN

@interface UFPFService (UFPFShare)

// Share表添加

// Share表的内容不做删除，不激活Activity。

+ (BOOL)addShareTopic:(UFPFTopic *)Topic
             fromUser:(UFPFUser *)fromUser
           toPlatform:(NSString *)toPlatform
                error:(NSError **)error;

@end

NS_ASSUME_NONNULL_END
