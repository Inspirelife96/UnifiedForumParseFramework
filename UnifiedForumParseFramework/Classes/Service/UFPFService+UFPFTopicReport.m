//
//  UFPFService+UFPFTopicReport.m
//  UFPFParse
//
//  Created by XueFeng Chen on 2022/5/20.
//

#import "UFPFService+UFPFTopicReport.h"

#import "UFPFTopicReport.h"

@implementation UFPFService (UFPFTopicReport)

+ (UFPFTopicReport *)addTopicReportFromUser:(UFPFUser *)fromUser toTopic:(UFPFTopic *)toTopic forReason:(UFPFParseReportReason)reason error:(NSError **)error {
    UFPFTopicReport *topicReport = [[UFPFTopicReport alloc] init];
    
    topicReport.fromUser = fromUser;
    topicReport.toTopic = toTopic;
    topicReport.reason = @(reason);
    
    BOOL succeeded = [topicReport save:error];
    
    if (succeeded) {
        return topicReport;
    } else {
        return nil;
    }
}

@end
