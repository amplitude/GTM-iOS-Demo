//
//  AmplitudeGTMHandlers.h
//

#ifndef AmplitudeGTMHandlers_h
#define AmplitudeGTMHandlers_h

#import "TAGContainer.h"

extern NSString *const kAmplitudeGTMLogEventHandlerTag;
extern NSString *const kAmplitudeGTMSetUserIdHandlerTag;
extern NSString *const kAmplitudeGTMSetUserPropertiesHandlerTag;

@interface AmplitudeGTMLogEventHandler : NSObject<TAGFunctionCallTagHandler>
@end

@interface AmplitudeGTMSetUserIdHandler : NSObject<TAGFunctionCallTagHandler>
@end

@interface AmplitudeGTMSetUserPropertiesHandler : NSObject<TAGFunctionCallTagHandler>
@end

#endif /* AmplitudeGTMHandlers_h */
