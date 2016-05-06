//
//  AmplitudeGTMHandlers.m
//

#import <Foundation/Foundation.h>
#import "AmplitudeGTMHandler.h"
#import "Amplitude.h"

NSString *const kAmplitudeGTMLogEventHandlerTag = @"logEvent";
NSString *const kAmplitudeGTMSetUserIdHandlerTag = @"setUserId";
NSString *const kAmplitudeGTMSetUserPropertiesHandlerTag = @"setUserProperties";

@implementation AmplitudeGTMHandler

+ (AmplitudeGTMHandler*) instance
{
    static AmplitudeGTMHandler *_instance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _instance = [[AmplitudeGTMHandler alloc] init];
    });
    return _instance;
}


- (void)execute:(NSString *)functionName parameters:(NSDictionary *)parameters {

    NSLog(@"AMPLITUDE GTM HANDLER");

    if ([functionName isEqualToString:kAmplitudeGTMLogEventHandlerTag]) {
        NSLog(@"Triggered logEvent with params: %@", parameters);
        NSString *eventType = [parameters objectForKey:@"eventType"];
        NSDictionary *eventProperties = [parameters objectForKey:@"eventProperties"];
        [[Amplitude instance] logEvent:eventType withEventProperties:eventProperties];
    }

    else if ([functionName isEqualToString:kAmplitudeGTMSetUserIdHandlerTag]) {
        NSLog(@"Triggered setUserId with params: %@", parameters);
        NSString *userId = [parameters objectForKey:@"userId"];
        [[Amplitude instance] setUserId:userId];
    }

    else if ([functionName isEqualToString:kAmplitudeGTMSetUserPropertiesHandlerTag]) {
        NSLog(@"Triggered setUserProperties with params: %@", parameters);
        NSDictionary *userProperties = [parameters objectForKey:@"userProperties"];
        [[Amplitude instance] setUserProperties:userProperties];
    }
}

@end