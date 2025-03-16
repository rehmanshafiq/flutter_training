import 'package:graphql_flutter/graphql_flutter.dart';
import 'dart:io';

class GraphQLService {
  final HttpLink httpLink = HttpLink(
    'https://379923-7e.myshopify.com/api/2024-10/graphql.json',
    defaultHeaders: {
      'X-Shopify-Storefront-Access-Token': 'd885c1c7722a638ec9c2703288b0c90f',
      'Content-Type': 'application/json',
    },
  );

  late final GraphQLClient client;

  final Policies defaultPolicies = Policies(
    cacheReread: CacheRereadPolicy.ignoreAll,
    fetch: FetchPolicy.cacheFirst,
  );

  final Duration queryRequestTimeout = Duration(seconds: 30);

  GraphQLService() {
    client = GraphQLClient(
      link: httpLink,
      cache: GraphQLCache(),
      defaultPolicies: DefaultPolicies(
        query: defaultPolicies,
      ),
    );
  }

  Future<QueryResult> performQuery(String query) async {
    QueryOptions options = QueryOptions(
      document: gql(query),
      fetchPolicy: FetchPolicy.networkOnly,
      pollInterval: queryRequestTimeout,
    );

    late QueryResult result;
    try {
      result = await client.query(options);
      return result;
    } catch (e) {
      print('GraphQL Error: ${e.toString()}');
      rethrow;
    }
  }
}
