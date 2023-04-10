//
//  UFPFService+UFPFReplyReport.m
//  UFPFParse
//
//  Created by XueFeng Chen on 2022/7/22.
//

#import "UFPFService+UFPFReplyReport.h"

#import "UFPFReplyReport.h"

@implementation UFPFService (UFPFReplyReport)

+ (UFPFReplyReport *)addReplyReportFromUser:(UFPFUser *)fromUser toReply:(UFPFReply *)toReply forReason:(UFPFParseReportReason)reason error:(NSError **)error {
    UFPFReplyReport *replyReport = [[UFPFReplyReport alloc] init];
    
    replyReport.fromUser = fromUser;
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
