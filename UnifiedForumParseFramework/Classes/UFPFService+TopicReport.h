//
//  UFPFService+TopicReport.h
//  UFPFParse
//
//  Created by XueFeng Chen on 2022/5/20.
//

#import "UFPFService.h"

#import "UFPFDefines.h"

@class UFPFUserProfile;

NS_ASSUME_NONNULL_BEGIN

@class UFPFTopic;
@class UFPFTopicReport;

@interface UFPFService (TopicReport)

+ (UFPFTopicReport *)addTopicReportFromUserProfile:(UFPFUserProfile *)fromUserProfile toTopic:(UFPFTopic *)toTopic forReason:(UFPFParseReportReason)reason error:(NSError **)error;

@end

NS_ASSUME_NONNULL_END
