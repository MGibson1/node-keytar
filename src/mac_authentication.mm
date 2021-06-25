#import <LocalAuthentication/LocalAuthentication.h>
#import <Security/Security.h>
#import "mac_authentication.h"

@implementation MacAuthentication

- (bool)AuthenticatePresence {
  __block BOOL returned = NO;
  __block BOOL biometricSuccess = NO;
  LAContext *myContext = [[LAContext alloc] init];
  NSString *myLocalizedReasonString = @"unlock your vault";
  CFErrorRef error;
  SecAccessControlRef access = SecAccessControlCreateWithFlags(NULL,  // Use the default allocator.
                                                               kSecAttrAccessibleWhenUnlocked,
                                                               kSecAccessControlUserPresence,
                                                               &error);
  [myContext evaluateAccessControl:access
              operation:LAAccessControlOperationUseItem
              localizedReason:myLocalizedReasonString
              reply:^(BOOL success, NSError *error) {
                                                      returned = YES;
                                                      biometricSuccess = success;
                                                    }];

    CFRelease(error);

    // Wait until prompt is returned
    while (!returned) {
      [NSThread sleepForTimeInterval:0.1f];
    }
    return biometricSuccess == YES;
}

@end

bool AuthenticatePresence() {
     MacAuthentication* myInstance = [[MacAuthentication alloc] init];
    return [myInstance AuthenticatePresence];
}
