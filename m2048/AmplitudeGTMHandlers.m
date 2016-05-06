//
//  AmplitudeGTMHandlers.m
//

#import <Foundation/Foundation.h>
#import "AmplitudeGTMHandlers.h"
#import "Amplitude.h"

NSString *const kAmplitudeGTMLogEventHandlerTag = @"logEvent";
NSString *const kAmplitudeGTMSetUserIdHandlerTag = @"setUserId";
NSString *const kAmplitudeGTMSetUserPropertiesHandlerTag = @"setUserProperties";

@implementation AmplitudeGTMLogEventHandler

- (void)execute:(NSString *)functionName parameters:(NSDictionary *)parameters {

    NSLog(@"LogEvent GTM HANDLER");

    if ([functionName isEqualToString:kAmplitudeGTMLogEventHandlerTag]) {
        NSLog(@"Triggered logEvent with params: %@", parameters);
        NSString *eventType = [parameters objectForKey:@"eventType"];
        NSDictionary *eventProperties = [parameters objectForKey:@"eventProperties"];
        [[Amplitude instance] logEvent:eventType withEventProperties:eventProperties];
    }
}
@end


@implementation AmplitudeGTMSetUserIdHandler

- (void)execute:(NSString *)functionName parameters:(NSDictionary *)parameters {

    NSLog(@"SetUserId GTM HANDLER");

    if ([functionName isEqualToString:kAmplitudeGTMSetUserIdHandlerTag]) {
        NSLog(@"Triggered setUserId with params: %@", parameters);
        NSString *userId = [parameters objectForKey:@"userId"];
        [[Amplitude instance] setUserId:userId];
    }
}
@end

@implementation AmplitudeGTMSetUserPropertiesHandler

- (void)execute:(NSString *)functionName parameters:(NSDictionary *)parameters {

    NSLog(@"SetUserProperties GTM HANDLER");

    if ([functionName isEqualToString:kAmplitudeGTMSetUserPropertiesHandlerTag]) {
        NSLog(@"Triggered setUserProperties with params: %@", parameters);
        NSDictionary *userProperties = [parameters objectForKey:@"userProperties"];
        [[Amplitude instance] setUserProperties:userProperties];
    }
}
@end