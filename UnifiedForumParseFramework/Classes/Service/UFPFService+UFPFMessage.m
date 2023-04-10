//
//  UFPFService+UFPFMessage.m
//  UFPFParse
//
//  Created by XueFeng Chen on 2022/7/28.
//

#import "UFPFService+UFPFMessage.h"

#import "UFPFDefines.h"

#import "UFPFMessage.h"

@implementation UFPFService (UFPFMessage)

+ (NSArray<UFPFMessage *> *)findMessagesFromUser:(UFPFUser *)fromUser
                                         toUser:(UFPFUser *)toUser
                                           page:(NSInteger)page
                                      pageCount:(NSInteger)pageCount
                                          error:(NSError **)error {
    PFQuery *query = [PFQuery queryWithClassName:UFPFMessageKeyClass];
    [query whereKey:UFPFMessageKeyFromUser equalTo:fromUser];
    [query whereKey:UFPFMessageKeyToUser equalTo:toUser];
    
    [query orderByDescending:UFPFKeyCreatedAt];
    
    [query setSkip:pageCount * page];
    [query setLimit:pageCount];
    
    return [query findObjects:error];
}

+ (UFPFMessage *)addMessageFromUser:(UFPFUser *)fromUser toUser:(UFPFUser *)toUser content:(NSString *)content error:(NSError **)error {
    UFPFMessage *message = [[UFPFMessage alloc] init];
    message.fromUser = fromUser;
    message.toUser = toUser;
    message.content = content;
    
    BOOL succeeded = [message save:error];
    if (succeeded) {
        return message;
    } else {
        return nil;
    }
}

@end
