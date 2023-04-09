//
//  UFPFService+PostReport.m
//  UFPFParse
//
//  Created by XueFeng Chen on 2022/7/22.
//

#import "UFPFService+PostReport.h"

#import "UFPFPostReport.h"

@implementation UFPFService (PostReport)

+ (UFPFPostReport *)addPostReportFromUserProfile:(UFPFUserProfile *)fromUserProfile toPost:(UFPFPost *)toPost forReason:(UFPFParseReportReason)reason error:(NSError **)error {
    UFPFPostReport *postReport = [[UFPFPostReport alloc] init];
    
    postReport.fromUserProfile = fromUserProfile;
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
