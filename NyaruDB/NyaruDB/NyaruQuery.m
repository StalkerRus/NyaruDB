//
//  NyaruQuery.m
//  NyaruDB
//
//  Created by Kelp on 2013/02/19.
//
//

#import "NyaruQuery.h"
#import "NyaruCollection.h"
#import "NyaruQueryCell.h"


@implementation NyaruQuery


- (id)init
{
    self = [super init];
    if (self) {
        _queries = [NSMutableArray new];
    }
    return self;
}

- (id)initWithCollection:(NyaruCollection *)collection
{
    self = [super init];
    if (self) {
        _queries = [NSMutableArray new];
        _collection = collection;
    }
    return self;
}

@end


@implementation NyaruQuery (NyaruQueryIn)
#pragma mark - Intersection
- (NyaruQuery *)qand:(NSString *)indexName equal:(id)value
{
    NyaruQueryCell *query = [NyaruQueryCell new];
    query.schemaName = indexName;
    query.operation = NyaruQueryEqual | NyaruQueryIntersection;
    query.value = value;
    [_queries addObject:query];
    return self;
}
- (NyaruQuery *)qand:(NSString *)indexName notEqual:(id)value
{
    NyaruQueryCell *query = [NyaruQueryCell new];
    query.schemaName = indexName;
    query.operation = NyaruQueryUnequal | NyaruQueryIntersection;
    query.value = value;
    [_queries addObject:query];
    return self;
}
- (NyaruQuery *)qand:(NSString *)indexName less:(id)value
{
    NyaruQueryCell *query = [NyaruQueryCell new];
    query.schemaName = indexName;
    query.operation = NyaruQueryLess | NyaruQueryIntersection;
    query.value = value;
    [_queries addObject:query];
    return self;
}
- (NyaruQuery *)qand:(NSString *)indexName lessEqual:(id)value
{
    NyaruQueryCell *query = [NyaruQueryCell new];
    query.schemaName = indexName;
    query.operation = NyaruQueryLessEqual | NyaruQueryIntersection;
    query.value = value;
    [_queries addObject:query];
    return self;
}
- (NyaruQuery *)qand:(NSString *)indexName greater:(id)value
{
    NyaruQueryCell *query = [NyaruQueryCell new];
    query.schemaName = indexName;
    query.operation = NyaruQueryGreater | NyaruQueryIntersection;
    query.value = value;
    [_queries addObject:query];
    return self;
}
- (NyaruQuery *)qand:(NSString *)indexName greaterEqual:(id)value
{
    NyaruQueryCell *query = [NyaruQueryCell new];
    query.schemaName = indexName;
    query.operation = NyaruQueryGreaterEqual | NyaruQueryIntersection;
    query.value = value;
    [_queries addObject:query];
    return self;
}
- (NyaruQuery *)qand:(NSString *)indexName like:(NSString *)value
{
    NyaruQueryCell *query = [NyaruQueryCell new];
    query.schemaName = indexName;
    query.operation = NyaruQueryLike | NyaruQueryIntersection;
    query.value = value;
    [_queries addObject:query];
    return self;
}


#pragma mark - Union
- (NyaruQuery *)qorAll
{
    NyaruQueryCell *query = [NyaruQueryCell new];
    query.operation = NyaruQueryAll | NyaruQueryUnion;
    [_queries addObject:query];
    return self;
}
- (NyaruQuery *)qor:(NSString *)indexName equal:(id)value
{
    NyaruQueryCell *query = [NyaruQueryCell new];
    query.schemaName = indexName;
    query.operation = NyaruQueryEqual | NyaruQueryUnion;
    query.value = value;
    [_queries addObject:query];
    return self;
}
- (NyaruQuery *)qor:(NSString *)indexName notEqual:(id)value
{
    NyaruQueryCell *query = [NyaruQueryCell new];
    query.schemaName = indexName;
    query.operation = NyaruQueryUnequal | NyaruQueryUnion;
    query.value = value;
    [_queries addObject:query];
    return self;
}
- (NyaruQuery *)qor:(NSString *)indexName less:(id)value
{
    NyaruQueryCell *query = [NyaruQueryCell new];
    query.schemaName = indexName;
    query.operation = NyaruQueryLess | NyaruQueryUnion;
    query.value = value;
    [_queries addObject:query];
    return self;
}
- (NyaruQuery *)qor:(NSString *)indexName lessEqual:(id)value
{
    NyaruQueryCell *query = [NyaruQueryCell new];
    query.schemaName = indexName;
    query.operation = NyaruQueryLessEqual | NyaruQueryUnion;
    query.value = value;
    [_queries addObject:query];
    return self;
}
- (NyaruQuery *)qor:(NSString *)indexName greater:(id)value
{
    NyaruQueryCell *query = [NyaruQueryCell new];
    query.schemaName = indexName;
    query.operation = NyaruQueryGreater | NyaruQueryUnion;
    query.value = value;
    [_queries addObject:query];
    return self;
}
- (NyaruQuery *)qor:(NSString *)indexName greaterEqual:(id)value
{
    NyaruQueryCell *query = [NyaruQueryCell new];
    query.schemaName = indexName;
    query.operation = NyaruQueryGreaterEqual | NyaruQueryUnion;
    query.value = value;
    [_queries addObject:query];
    return self;
}
- (NyaruQuery *)qor:(NSString *)indexName like:(NSString *)value
{
    NyaruQueryCell *query = [NyaruQueryCell new];
    query.schemaName = indexName;
    query.operation = NyaruQueryLike | NyaruQueryUnion;
    query.value = value;
    [_queries addObject:query];
    return self;
}


#pragma mark - Order By
- (NyaruQuery *)orderBy:(NSString *)indexName
{
    NyaruQueryCell *query = [NyaruQueryCell new];
    query.schemaName = indexName;
    query.operation = NyaruQueryOrderASC;
    [_queries addObject:query];
    return self;
}
- (NyaruQuery *)orderByDESC:(NSString *)indexName
{
    NyaruQueryCell *query = [NyaruQueryCell new];
    query.schemaName = indexName;
    query.operation = NyaruQueryOrderDESC;
    [_queries addObject:query];
    return self;
}


#pragma mark - Count
- (NSUInteger)count
{
    return [_collection countByQuery:_queries];
}
- (void)countAsync:(void (^)(NSUInteger))handler
{
    [_collection countByQuery:_queries async:handler];
}


#pragma mark - Fetch
- (NSArray *)fetch
{
    return [_collection fetchByQuery:_queries skip:0 limit:0];
}
- (NSArray *)fetch:(NSUInteger)limit
{
    return [_collection fetchByQuery:_queries skip:0 limit:limit];
}
- (NSArray *)fetch:(NSUInteger)limit skip:(NSUInteger)skip
{
    return [_collection fetchByQuery:_queries skip:skip limit:limit];
}
- (NSMutableDictionary *)fetchFirst
{
    NSArray *docs = [_collection fetchByQuery:_queries skip:0 limit:1];
    if (docs.count == 0) {
        return nil;
    }
    else {
        return docs[0];
    }
}

#pragma mark Fetch Async
- (void)fetchAsync:(void (^)(NSArray *))handler
{
    [_collection fetchByQuery:_queries skip:0 limit:0 async:handler];
}
- (void)fetch:(NSUInteger)limit async:(void (^)(NSArray *))handler
{
    [_collection fetchByQuery:_queries skip:0 limit:limit async:handler];
}
- (void)fetch:(NSUInteger)limit skip:(NSUInteger)skip async:(void (^)(NSArray *))handler
{
    [_collection fetchByQuery:_queries skip:skip limit:limit async:handler];
}
- (void)fetchFirstAsync:(void (^)(NSMutableDictionary *))handler
{
    [_collection fetchByQuery:_queries skip:0 limit:1 async:^(NSArray *documents) {
        if (documents.count == 0) {
            handler(nil);
        }
        else {
            handler(documents[0]);
        }
    }];
}


#pragma mark - Remove
- (void)remove
{
    [_collection removeByQuery:_queries];
}


@end
