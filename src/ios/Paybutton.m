#import "Paybutton.h"
#import <UIKit/UIKit.h>
#import <mpos-ui/mpos-ui.h>
#import <mpos.core/mpos-extended.h>


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



- (void)test:(CDVInvokedUrlCommand*)command
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




- (void)transaction:(CDVInvokedUrlCommand*)command {
   self.mposUi = [MPUMposUi initializeWithProviderMode:MPProviderModeMOCK
                                       merchantIdentifier:@"merchantIdentifier"
                                           merchantSecret:@"merchantSecretKey"];
    
    
    // Start with a mocked card reader:
    MPAccessoryParameters *ap = [MPAccessoryParameters mockAccessoryParameters];

    // When using the Bluetooth Miura Shuttle / M007 / M010, use the following parameters:
    // MPAccessoryParameters *ap = [MPAccessoryParameters externalAccessoryParametersWithFamily:MPAccessoryFamilyMiuraMPI
    //                                                                                 protocol:@"com.miura.shuttle"
    //                                                                                optionals:nil];
    
    MPTransactionParameters *tp = [MPTransactionParameters chargeWithAmount:[NSDecimalNumber decimalNumberWithString:@"5.00"]
                                                                   currency:MPCurrencyEUR
                                                                  optionals:^(id<MPTransactionParametersOptionals>  _Nonnull optionals) {
                                                                      optionals.subject = @"Bouquet of Flowers";
                                                                      optionals.customIdentifier = @"yourReferenceForTheTransaction";
                                                                  }];
    
    self.mposUi.configuration.terminalParameters = ap;
    self.mposUi.configuration.summaryFeatures = MPUMposUiConfigurationSummaryFeatureSendReceiptViaEmail;
    // Add this line, if you do also want to offer printed receipts
    //ui.configuration.printerParameters =
    //ui.configuration.summaryFeatures |= MPUMposUiConfigurationSummaryFeaturePrintReceipt;
    // Add this if you would like to collect the customer signature on the printed merchant receipt
    //ui.configuration.signatureCapture = MPUMposUiConfigurationSignatureCaptureOnReceipt;
    
    
    UIViewController *viewController = [self.mposUi createTransactionViewControllerWithTransactionParameters:tp
                                                                                          completed:^(UIViewController * _Nonnull controller, MPUTransactionResult result, MPTransaction * _Nullable transaction)
                                        {
                                            [self.viewController dismissViewControllerAnimated:YES completion:NULL];
                                            
                                            UIAlertView* alert = [[UIAlertView alloc] initWithTitle:@"Result"
                                                                                            message:@""
                                                                                           delegate:nil
                                                                                  cancelButtonTitle:nil
                                                                                  otherButtonTitles:@"OK",nil];
                                            
                                            if (result == MPUTransactionResultApproved) {
                                                alert.message = @"Payment was approved!";
                                            } else {
                                                alert.message = @"Payment was declined/aborted!";
                                            }
                                            
                                            [alert show];
                                        }];
    
    
    UINavigationController *modalNav = [[UINavigationController alloc] initWithRootViewController:viewController];
    modalNav.navigationBar.barStyle = UIBarStyleBlack;
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone) {
        modalNav.modalPresentationStyle = UIModalPresentationFullScreen;
    } else { // Show as Form on iPad
        modalNav.modalPresentationStyle = UIModalPresentationFormSheet;
    }
    [self.viewController presentViewController:modalNav animated:YES completion:NULL];
}

@end
