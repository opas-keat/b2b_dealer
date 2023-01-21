import 'package:graphql_flutter/graphql_flutter.dart';

final createShipping = gql(r'''
mutation CreateShipping($shippings: [shippings_insert_input!]!) {
  insert_shippings(objects: $shippings) {
    affected_rows
    returning {
      id
    }
  }
}
''');

final subscriptionShipping = gql(r'''
subscription ShippingSubscription($limit: Int!, $offset: Int!, $created_by: uuid_comparison_exp!) {
  shippings(where: {created_by: $created_by}, limit: $limit, offset: $offset) {
    id
    linked_id
    name
  }
}
''');
