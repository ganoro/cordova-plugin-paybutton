#import "Paybutton.h"

@implementation Paybutton

- (void)greet:(CDVInvokedUrlCommand*)command
{
    NSString* name = [[command arguments] objectAtIndex:0];
    NSString* msg = [NSString stringWithFormat: @"Hello, %@", name];

    CDVPluginResult* result = [CDVPluginResult
                               resultWithStatus:CDVCommandStatus_OK
                               messageAsString:msg];

    [self.commandDelegate sendPluginResult:result callbackId:command.callbackId];
}



- (void)transaction:(CDVInvokedUrlCommand*)command
{
	NSLog(@"Hitting transction");

	NSMutableDictionary* settings = [command.arguments objectAtIndex:0];
	NSString* store = [settings objectForKey:@"store"];
	NSString* user = [settings objectForKey:@"user"];

	NSLog(@"%@", store);
	NSLog(@"%@", user);

	NSString* msg = [NSString stringWithFormat: @"Making a charge for, %@", store];

    CDVPluginResult* result = [CDVPluginResult
                               resultWithStatus:CDVCommandStatus_OK
                               messageAsString:msg];

    [self.commandDelegate sendPluginResult:result callbackId:command.callbackId];
}

@end
