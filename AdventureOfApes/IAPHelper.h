//
//  IAPHelper.h
//  tmsj
//
//  Created by 曾 哲 on 13-8-14.
//
//

#import <Foundation/Foundation.h>
#import <StoreKit/StoreKit.h>



@interface IAPHelper : NSObject<SKProductsRequestDelegate,SKPaymentTransactionObserver,UIAlertViewDelegate>{
   
    SKProduct *skProduct;
    SKProductsRequest *productsRequest;
}

+(id)sharedIAPHelper;

-(id)init;

-(void)requestProducts:(NSString *)productIdentity;

- (void)buyProductIdentifier:(NSString *)productIdentity;

- (NSString *)encode:(const uint8_t *)input length:(NSInteger)length;

-(void)recordServer:(NSString *)receiptString;

@end
