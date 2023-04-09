//
//  UFPFService+ReplyReport.m
//  UFPFParse
//
//  Created by XueFeng Chen on 2022/7/22.
//

#import "UFPFService+ReplyReport.h"

#import "UFPFReplyReport.h"

@implementation UFPFService (ReplyReport)

+ (UFPFReplyReport *)addReplyReportFromUserProfile:(UFPFUserProfile *)fromUserProfile toReply:(UFPFReply *)toReply forReason:(UFPFParseReportReason)reason error:(NSError **)error {
    UFPFReplyReport *replyReport = [[UFPFReplyReport alloc] init];
    
    replyReport.fromUserProfile = fromUserProfile;
    replyReport.toReply = toReply;
    replyReport.reason = @(reason);
    
    BOOL succeeded = [replyReport save:error];
    
    if (succeeded) {
        return replyReport;
    } else {
        return nil;
    }
}

@end
