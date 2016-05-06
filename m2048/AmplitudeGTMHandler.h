//
//  AmplitudeGTMHandlers.h
//

#ifndef AmplitudeGTMHandler_h
#define AmplitudeGTMHandler_h

#import "TAGContainer.h"

extern NSString *const kAmplitudeGTMLogEventHandlerTag;
extern NSString *const kAmplitudeGTMSetUserIdHandlerTag;
extern NSString *const kAmplitudeGTMSetUserPropertiesHandlerTag;

@interface AmplitudeGTMHandler : NSObject<TAGFunctionCallTagHandler>

+ (AmplitudeGTMHandler*)instance;

@end

#endif /* AmplitudeGTMHandler_h */
