//
//  UFPFService+Message.h
//  UFPFParse
//
//  Created by XueFeng Chen on 2022/7/28.
//

#import "UFPFService.h"

NS_ASSUME_NONNULL_BEGIN

@class UFPFMessage;
@class UFPFUserProfile;

@interface UFPFService (Message)

+ (NSArray<UFPFMessage *> *)findMessagesFromUserProfile:(UFPFUserProfile *)fromUserProfile
                                         toUserProfile:(UFPFUserProfile *)toUserProfile
                                           page:(NSInteger)page
                                      pageCount:(NSInteger)pageCount
                                          error:(NSError **)error;

+ (UFPFMessage *)addMessageFromUserProfile:(UFPFUserProfile *)fromUserProfile toUserProfile:(UFPFUserProfile *)toUserProfile content:(NSString *)content error:(NSError **)error;

@end

NS_ASSUME_NONNULL_END
