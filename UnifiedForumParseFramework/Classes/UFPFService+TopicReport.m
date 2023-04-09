//
//  UFPFService+TopicReport.m
//  UFPFParse
//
//  Created by XueFeng Chen on 2022/5/20.
//

#import "UFPFService+TopicReport.h"

#import "UFPFTopicReport.h"

@implementation UFPFService (TopicReport)

+ (UFPFTopicReport *)addTopicReportFromUserProfile:(UFPFUserProfile *)fromUserProfile toTopic:(UFPFTopic *)toTopic forReason:(UFPFParseReportReason)reason error:(NSError **)error {
    UFPFTopicReport *topicReport = [[UFPFTopicReport alloc] init];
    
    topicReport.fromUserProfile = fromUserProfile;
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
