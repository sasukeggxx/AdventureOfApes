//
//  IAPHelper.m
//  qosh
//  支付相关
//  Created by 曾 哲 on 13-8-14.
//
//

#import "IAPHelper.h"
#import "cocos2d.h"
#import "LuaCallAppStore.h"

using namespace cocos2d;

@implementation IAPHelper

static IAPHelper *helper = nil;



+(id)sharedIAPHelper{
    
    if (helper==nil) {
        
        helper=[[self alloc]init];
    }
    return helper;

}

-(id)init{
    if (self=[super init]) {
        
    }
    return self;
}

//通知后台发货
-(void)recordServer:(NSString *)receiptString{
    
    LuaCallAppStore::getInstance()->buyComplete([receiptString cStringUsingEncoding:NSUTF8StringEncoding]);

}


//向apple请求商品信息
-(void)requestProducts:(NSString *)productIdentity{

    NSSet *productIdentifiers = [NSSet setWithObject:productIdentity ];
    productsRequest = [[SKProductsRequest alloc] initWithProductIdentifiers:productIdentifiers];
    productsRequest.delegate = self;
    [productsRequest start];
    
  
    
}


//接收apple返回的商品信息
-(void)productsRequest:(SKProductsRequest *)request didReceiveResponse:(SKProductsResponse *)response{

    NSArray *products = response.products;
    skProduct = [products count] == 1 ? [[products firstObjectCommonWithArray:products] retain] : nil;
    
    if (skProduct)
    {
        
        UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"请确认购买?" message:skProduct.localizedDescription delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"购买", nil];
        [alert show];
        [alert release];
    }
    for (NSString *invalidProductId in response.invalidProductIdentifiers)
    {
        NSLog(@"Invalid product id: %@" , invalidProductId);
    }
    
    // finally release the reqest we alloc/init’ed in requestProUpgradeProductData
    [productsRequest release];
}




-(void)paymentQueue:(SKPaymentQueue *)queue updatedTransactions:(NSArray *)transactions{
    
    for(SKPaymentTransaction *transaction in transactions) {
		
        switch (transaction.transactionState) {
				
			case SKPaymentTransactionStatePurchasing:
				// Item is still in the process of being purchased
                
				break;
				
			case SKPaymentTransactionStatePurchased:
				// Item was successfully purchased!
                {
                    NSLog(@"购买成功");
                    UIAlertView *alert=[[UIAlertView alloc] initWithTitle:@"支付提示"
                                                                  message:@"购买成功,请在公告消费栏查看商品信息,如果充值超过两小时未到账请联系论坛客服."
                                                                 delegate:nil
                                                        cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
                    [alert show];
                    [alert release];
                    NSString *receiptString = [self encode:(uint8_t *)transaction.transactionReceipt.bytes length:transaction.transactionReceipt.length];
                    [self recordServer:receiptString];
                    [[SKPaymentQueue defaultQueue] finishTransaction: transaction];
                }
                break;
				
			case SKPaymentTransactionStateRestored:
                
				// Verified that user has already paid for this item.
				[[SKPaymentQueue defaultQueue] finishTransaction: transaction];
				break;
				
			case SKPaymentTransactionStateFailed:
				// Purchase was either cancelled by user or an error occurred.
                NSLog(@"购买失败");
                UIAlertView *alert=[[UIAlertView alloc] initWithTitle:@"支付提示"
                                                              message:@"购买验证失败,请稍后再试,如果您的手机已经越狱,请去下载越狱版,地址www.szkuniu.com/tmsj/m/index.html"
                                                             delegate:nil
                                                    cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
                [alert show];
                [alert release];
                //关闭遮早
                LuaCallAppStore::getInstance()->closeMask();
                
				[[SKPaymentQueue defaultQueue] finishTransaction: transaction];
				break;
		}
	}


}


-(void)buyProductIdentifier:(NSString *)productIdentity{
    
    if ([productIdentity isEqualToString:@""]) {
        return;
    }
    NSLog(@"%@ 发起购买",productIdentity);
    [self requestProducts:productIdentity];
    
}

// not used in ios5.0
//-(void)buyProductIdentifier:(NSString *)productIdentity{
//    NSLog(@"%@ 发起购买",productIdentity);
//    //    SKPayment *paymentRequest = [SKPayment paymentWithProductIdentifier:productIdentity];
//    
//    // Assign an observer to monitor the transaction status.
//    [[SKPaymentQueue defaultQueue] addTransactionObserver:self];
//    
//    // Request a purchase of the product.
//    [[SKPaymentQueue defaultQueue] addPayment:paymentRequest];
//}

-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{

    
    if (buttonIndex==0) {
        //NSLog(@"取消购买");
        //关闭遮早
        LuaCallAppStore::getInstance()->closeMask();

    }else if (buttonIndex==1){
        SKPayment *paymentRequest = [SKPayment paymentWithProduct:skProduct];
        
        // Assign an observer to monitor the transaction status.
        [[SKPaymentQueue defaultQueue] addTransactionObserver:self];
        
        // Request a purchase of the product.
        [[SKPaymentQueue defaultQueue] addPayment:paymentRequest];
    }

}



- (NSString *)encode:(const uint8_t *)input length:(NSInteger)length {
    static char table[] = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+/=";
    
    NSMutableData *data = [NSMutableData dataWithLength:((length + 2) / 3) * 4];
    uint8_t *output = (uint8_t *)data.mutableBytes;
    
    for (NSInteger i = 0; i < length; i += 3) {
        NSInteger value = 0;
        for (NSInteger j = i; j < (i + 3); j++) {
            value <<= 8;
            
            if (j < length) {
                value |= (0xFF & input[j]);
            }
        }
        
        NSInteger index = (i / 3) * 4;
        output[index + 0] =                    table[(value >> 18) & 0x3F];
        output[index + 1] =                    table[(value >> 12) & 0x3F];
        output[index + 2] = (i + 1) < length ? table[(value >> 6)  & 0x3F] : '=';
        output[index + 3] = (i + 2) < length ? table[(value >> 0)  & 0x3F] : '=';
    }
    
    return [[[NSString alloc] initWithData:data encoding:NSASCIIStringEncoding] autorelease];
}


-(void)dealloc{

    [skProduct release];
    [productsRequest release];
    [super dealloc];

}


@end
