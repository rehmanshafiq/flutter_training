import 'package:graphql_flutter/graphql_flutter.dart';
import 'internet_service.dart';

class GraphQLService {
  late String shopifyBaseURl;
  late String accessToken;

  late final GraphQLClient client;
  final InternetService _internetService = InternetService();

  final Policies defaultPolicies = Policies(
    cacheReread: CacheRereadPolicy.ignoreAll,
    fetch: FetchPolicy.cacheFirst,
  );

  final Duration queryRequestTimeout = Duration(seconds: 30);

  GraphQLService(this.shopifyBaseURl, this.accessToken) {
    final HttpLink httpLink = HttpLink(
      shopifyBaseURl,
      defaultHeaders: {
        'X-Shopify-Storefront-Access-Token': accessToken,
        'Content-Type': 'application/json',
      },
    );

    client = GraphQLClient(
      link: httpLink,
      cache: GraphQLCache(),
      defaultPolicies: DefaultPolicies(
        query: defaultPolicies,
      ),
    );
  }

  Future<QueryResult> performQuery(String query) async {
    bool isConnected = await _internetService.checkInternetIsConnected();
    if (!isConnected) {
      throw Exception('No Internet Connection');
    }

    QueryOptions options = QueryOptions(
      document: gql(query),
      fetchPolicy: FetchPolicy.networkOnly,
      pollInterval: queryRequestTimeout,
    );

    try {
      return await client.query(options);
    } catch (e) {
      print('GraphQL Error: ${e.toString()}');
      rethrow;
    }
  }
}
