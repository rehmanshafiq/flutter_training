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