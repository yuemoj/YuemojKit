//
//  YJOrderJSON.h
//  NetworkSaleSDK
//
//  Created by HYT200841559 on 2023/3/30.
//

#import <Foundation/Foundation.h>

/**
 Example:
    json:
    {
        "action": "bind",
        "ctrluser": "100010025@hytalkC.com",
        "binduserlist": [
         {
             "binduser": "100010061@hytalkC.com"
         }
        ],
        "operatormodel": "ctrlapp",
        "operator": "100010025@hytalkC.com"
    }
 
 构建固定顺序的json格式, 提供两种构建方式:
 1. 直接根据数据结构一层一层写
 @code
 + (NSString *)jsonFromBody:(NSDictionary *)body {
    [YJOrderJSON dicMake:^(YJOrderJSON * _Nonnull maker) {
        maker.addKeyValue(@"action", body[@"action"]).addComma
            .addKeyValue(@"ctrluser", body[@"ctrluser"]).addComma
            .addKeyJSONValue(@"binduserlist", [YJOrderJSON arrMake:^(YJOrderJSON * _Nonnull maker) {
                NSArray *list = body[@"binduserlist"];
                for (NSDictionary *tmp in list) {
                    maker.addJSONValue([YJOrderJSON dicMake:^(YJOrderJSON * _Nonnull maker) {
                        maker.addKeyValue(@"binduser", tmp[@"binduser"]);
                        if (tmp != list.lastObject) {
                            [maker addComma];
                        }
                    }]);
                }
            }]).addComma
            .addKeyValue(@"operatormodel", body[@"operatormodel"]).addComma
            .addKeyValue(kParamKeyOperator, body[kParamKeyOperator]);
    }];
 }
 @endcode
 
 2.对上面的写法做了一层封装,需要构造一个指定了key顺序的数组keyOrders(根据add的先后顺序排列, 如果嵌套有数组结构,指定数组中某一个字典结构中的keys的顺序即可)
 @code
 + (NSString *)jsonFromBody:(NSDictionary *)body {
    NSArray *keyOrders = YJOrderJSONGenerator.addSimpleItem(@"action")
        .addSimpleItem(@"ctrluser")
        .addOrderItem(@"binduserlist",
                    YJOrderJSONGenerator.addSimpleItem(@"binduser").items)
        .addSimpleItem(@"operatormodel")
        .addSimpleItem(@"operator")
        .items;
     return [YJOrderJSON yjsonWithParams:body orders:keyOrders];
 }
 @endcode
 */
 

NS_ASSUME_NONNULL_BEGIN
@class YJOrderJSONItem;
@interface YJOrderJSON : NSObject
+ (NSString *)dicMake:(void(NS_NOESCAPE^)(YJOrderJSON *maker))aBlock;
+ (NSString *)arrMake:(void(NS_NOESCAPE^)(YJOrderJSON *maker))aBlock;

- (YJOrderJSON *(^)(NSString *, id))addKeyValue;
- (YJOrderJSON *(^)(NSString *, NSString *))addKeyJSONValue;
- (YJOrderJSON *(^)(id))addValue;
- (YJOrderJSON * _Nonnull (^)(NSString * _Nonnull))addJSONValue;
/// array 里不能是字典类型, 字典类型的遍历用dicMake处理(不支持是为了避免字典里多个键值对乱序)
- (YJOrderJSON *(^)(NSArray *))addArr;
- (YJOrderJSON *)addComma;

///
/// @var params 参数字典
/// @var keysOrder 反序列化json时以该数组中的key顺序来处理
+ (NSString *)yjsonWithParams:(NSDictionary *)params orders:(NSArray<YJOrderJSONItem *> *)orders;
@end

@interface YJOrderJSONItem : NSObject
@property (nonatomic, copy) NSString *key;
@property (nonatomic, nullable) NSArray<YJOrderJSONItem *> *items;
@end

@interface YJOrderJSONGenerator : NSObject
@property (nonatomic, readonly, class) YJOrderJSONGenerator *(^addSimpleItem)(NSString *);
@property (nonatomic, readonly, class) YJOrderJSONGenerator *(^addItem)(NSString *, NSArray<YJOrderJSONItem *> * _Nullable);

@property (nonatomic, readonly) YJOrderJSONGenerator *(^addSimpleItem)(NSString *);
@property (nonatomic, readonly) YJOrderJSONGenerator *(^addItem)(NSString *, NSArray<YJOrderJSONItem *> * _Nullable);

@property (nonatomic, readonly) NSString *(^generate)(NSDictionary *params);
- (NSArray<YJOrderJSONItem *> *)items;
@end
NS_ASSUME_NONNULL_END
