#import <Cordova/CDV.h>
#import <UIKit/UIKit.h>
#import <mpos-ui/mpos-ui.h>

@interface Paybutton : CDVPlugin

- (void) greet:(CDVInvokedUrlCommand*)command;
- (void) transaction:(CDVInvokedUrlCommand*)command;
- (IBAction)paymentButtonClicked:(id)sender;

@end