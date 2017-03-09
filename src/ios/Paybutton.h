#import <Cordova/CDV.h>
#import <mpos-ui/mpos-ui.h>

@interface Paybutton : CDVPlugin

- (void) greet:(CDVInvokedUrlCommand*)command;
- (void) transaction:(CDVInvokedUrlCommand*)command;

@end