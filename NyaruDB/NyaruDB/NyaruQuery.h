//
//  NyaruQuery.h
//  NyaruDB
//
//  Created by Kelp on 2013/02/19.
//
//

#import <Foundation/Foundation.h>

@class NyaruCollection;


@interface NyaruQuery : NSObject

#pragma mark - Properties
@property (strong, nonatomic, readonly) NyaruCollection *collection;
@property (strong, nonatomic) NSMutableArray *queries;

/**
 Get NyaruQuery instance.
 */
- (id)initWithCollection:(NyaruCollection *)collection;

@end



#pragma mark - Extensions
@interface NyaruQuery (NyaruQueryIn)
#pragma mark - Intersection
- (NyaruQuery *)qand:(NSString *)indexName equal:(id)value;
- (NyaruQuery *)qand:(NSString *)indexName notEqual:(id)value;
- (NyaruQuery *)qand:(NSString *)indexName less:(id)value;
- (NyaruQuery *)qand:(NSString *)indexName lessEqual:(id)value;
- (NyaruQuery *)qand:(NSString *)indexName greater:(id)value;
- (NyaruQuery *)qand:(NSString *)indexName greaterEqual:(id)value;
- (NyaruQuery *)qand:(NSString *)indexName like:(NSString *)value;

#pragma mark - Union
- (NyaruQuery *)qorAll;
- (NyaruQuery *)qor:(NSString *)indexName equal:(id)value;
- (NyaruQuery *)qor:(NSString *)indexName notEqual:(id)value;
- (NyaruQuery *)qor:(NSString *)indexName less:(id)value;
- (NyaruQuery *)qor:(NSString *)indexName lessEqual:(id)value;
- (NyaruQuery *)qor:(NSString *)indexName greater:(id)value;
- (NyaruQuery *)qor:(NSString *)indexName greaterEqual:(id)value;
- (NyaruQuery *)qor:(NSString *)indexName like:(NSString *)value;


#pragma mark - Order By
- (NyaruQuery *)orderBy:(NSString *)indexName;
- (NyaruQuery *)orderByDESC:(NSString *)indexName;


#pragma mark - Count
/**
 Count documents with queries.
 @return The number of documents.
 */
- (NSUInteger)count;
/**
 Count documents with queries.
 @param handler The result handler. It will run in main dispatch.
 */
- (void)countAsync:(void (^)(NSUInteger))handler;


#pragma mark - Fetch
/**
 Fetch documents.
 @return [NSMutableDictionary()]
 */
- (NSArray *)fetch;
/**
 Fetch documents with limit.
 @param limit The result limit.
 */
- (NSArray *)fetch:(NSUInteger)limit;
/**
 Fetch documents with limit and skip.
 @param limit The result limit.
 @param skip The result skip.
 */
- (NSArray *)fetch:(NSUInteger)limit skip:(NSUInteger)skip;
/**
 Fetch the first document.
 If result is empty it will return nil.
 @return nil or NSMutableDictionary()
 */
- (NSMutableDictionary *)fetchFirst;

#pragma mark Fetch Async
/**
 Async fetch documents.
 @param handler The result handler. It will run in main dispatch.
 */
- (void)fetchAsync:(void (^)(NSArray *))handler;
/**
 Async fetch documents with limit.
 @param limit The result limit.
 @param handler The result handler. It will run in main dispatch.
 */
- (void)fetch:(NSUInteger)limit async:(void (^)(NSArray *))handler;
/**
 Fetch documents with limit and skip.
 @param limit The result limit.
 @param skip The result skip.
 @param handler The result handler. It will run in main dispatch.
 */
- (void)fetch:(NSUInteger)limit skip:(NSUInteger)skip async:(void (^)(NSArray *))handler;
/**
 Fetch the first document.
 If result is empty it will return nil.
 @param handler The result handler. It will run in main dispatch. The result is nil or NSMutableDictionary().
 */
- (void)fetchFirstAsync:(void (^)(NSMutableDictionary *))handler;


#pragma mark - Remove
- (void)remove;


@end
