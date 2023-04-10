//
//  UFPFService+UFPFPostReport.m
//  UFPFParse
//
//  Created by XueFeng Chen on 2022/7/22.
//

#import "UFPFService+UFPFPostReport.h"

#import "UFPFPostReport.h"

@implementation UFPFService (UFPFPostReport)

+ (UFPFPostReport *)addPostReportFromUser:(UFPFUser *)fromUser toPost:(UFPFPost *)toPost forReason:(UFPFParseReportReason)reason error:(NSError **)error {
    UFPFPostReport *postReport = [[UFPFPostReport alloc] init];
    
    postReport.fromUser = fromUser;
    postReport.toPost = toPost;
    postReport.reason = @(reason);
    
    BOOL succeeded = [postReport save:error];
    
    if (succeeded) {
        return postReport;
    } else {
        return nil;
    }
}

@end
