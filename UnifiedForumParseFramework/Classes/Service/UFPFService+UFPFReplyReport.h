//
//  UFPFService+UFPFReplyReport.h
//  UFPFParse
//
//  Created by XueFeng Chen on 2022/7/22.
//

#import "UFPFService.h"

#import "UFPFDefines.h"

@class UFPFUser;

NS_ASSUME_NONNULL_BEGIN

@class UFPFReply;
@class UFPFReplyReport;

@interface UFPFService (PFUFReplyReport)

+ (UFPFReplyReport *)addReplyReportFromUser:(UFPFUser *)fromUser toReply:(UFPFReply *)toReply forReason:(UFPFParseReportReason)reason error:(NSError **)error;

@end

NS_ASSUME_NONNULL_END
