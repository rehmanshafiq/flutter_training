const String CollectionsQuery = '''
  query CollectionsQuery {
    collections(first: 10) {
      edges {
        node {
          id
          handle
          image {
            originalSrc
          }
          title
          products(first: 10) {
            edges {
              node {
                id
                title
                vendor
                productType
                descriptionHtml
                availableForSale
                priceRange {
                  minVariantPrice {
                    amount
                    currencyCode
                  }
                  maxVariantPrice {
                    amount
                    currencyCode
                  }
                }
              }
            }
          }
        }
      }
    }
  }
''';

///// Query with params

const String collectionsQuery = """
  query CollectionsQuery(
    \$query: String!,
    \$lang: LanguageCode!,
    \$productCount: Int,
    \$variantCount: Int,
    \$meta: [HasMetafieldsIdentifier!]!
  ) @inContext(language: \$lang) {
    collections(first: 10, query: \$query) {
      edges {
        node {
          id
          title
          products(first: \$productCount) {
            edges {
              node {
                id
                title
                metafields(identifiers: \$meta) {
                  key
                  value
                }
              }
            }
          }
        }
      }
    }
  }
""";

final Map<String, dynamic> collectionsParams = {
  "query": "441439650012",
  "lang": "AR",
  "productCount": 10,
  "variantCount": 10,
  "meta": [
    {"namespace": "custom", "key": "video"},
    {"namespace": "product", "key": "vendor_image"},
    {"namespace": "product", "key": "pof"},
    {"namespace": "product", "key": "implementation_time"},
    {"namespace": "product", "key": "washing_instruction"},
    {"namespace": "product", "key": "type"},
    {"namespace": "product", "key": "cut"},
    {"namespace": "product", "key": "attachements"},
  ],
};
