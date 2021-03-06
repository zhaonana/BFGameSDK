//
//  CXPayParams.h
//  CXGameSDK
//
//  Created by NaNa on 14-11-5.
//  Copyright (c) 2014年 nn. All rights reserved.
//

#import <Foundation/Foundation.h>

/**
 *  支付参数
 */
@interface CXPayParams : NSObject

/**
 *  商品ID 随机分配，需要提供给服务器productId一一对应
 */
@property (nonatomic, copy) NSString *good_id;
/**
 *  CP订单号
 */
@property (nonatomic, copy) NSString *cp_bill_no;
/**
 *  回调URL 如果不设置 请提供同一通知地址给我们 ，通知将统一发送到所提供的地址
 */
@property (nonatomic, copy) NSString *notify_url;
/**
 *  扩展参数 支付成功服务器通知接口将原样返回
 */
@property (nonatomic, copy) NSString *extra;

@end
