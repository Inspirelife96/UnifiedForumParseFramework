//
//  UFPFService+Message.m
//  UFPFParse
//
//  Created by XueFeng Chen on 2022/7/28.
//

#import "UFPFService+Message.h"

#import "UFPFDefines.h"

#import "UFPFMessage.h"

@implementation UFPFService (Message)

+ (NSArray<UFPFMessage *> *)findMessagesFromUserProfile:(UFPFUserProfile *)fromUserProfile
                                         toUserProfile:(UFPFUserProfile *)toUserProfile
                                           page:(NSInteger)page
                                      pageCount:(NSInteger)pageCount
                                          error:(NSError **)error {
    PFQuery *query = [PFQuery queryWithClassName:UFPFMessageKeyClass];
    [query whereKey:UFPFMessageKeyFromUserProfile equalTo:fromUserProfile];
    [query whereKey:UFPFMessageKeyToUserProfile equalTo:toUserProfile];
    
    [query orderByDescending:UFPFKeyCreatedAt];
    
    [query setSkip:pageCount * page];
    [query setLimit:pageCount];
    
    return [query findObjects:error];
}

+ (UFPFMessage *)addMessageFromUserProfile:(UFPFUserProfile *)fromUserProfile toUserProfile:(UFPFUserProfile *)toUserProfile content:(NSString *)content error:(NSError **)error {
    UFPFMessage *message = [[UFPFMessage alloc] init];
    message.fromUserProfile = fromUserProfile;
    message.toUserProfile = toUserProfile;
    message.content = content;
    
    BOOL succeeded = [message save:error];
    if (succeeded) {
        return message;
    } else {
        return nil;
    }
}

@end
