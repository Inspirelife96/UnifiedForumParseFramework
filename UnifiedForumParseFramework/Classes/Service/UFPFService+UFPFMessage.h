//
//  UFPFService+UFPFMessage.h
//  UFPFParse
//
//  Created by XueFeng Chen on 2022/7/28.
//

#import "UFPFService.h"

NS_ASSUME_NONNULL_BEGIN

@class UFPFMessage;
@class UFPFUser;

@interface UFPFService (UFPFMessage)

+ (NSArray<UFPFMessage *> *)findMessagesFromUser:(UFPFUser *)fromUser
                                         toUser:(UFPFUser *)toUser
                                           page:(NSInteger)page
                                      pageCount:(NSInteger)pageCount
                                          error:(NSError **)error;

+ (UFPFMessage *)addMessageFromUser:(UFPFUser *)fromUser toUser:(UFPFUser *)toUser content:(NSString *)content error:(NSError **)error;

@end

NS_ASSUME_NONNULL_END
