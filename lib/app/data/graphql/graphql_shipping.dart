import 'package:graphql_flutter/graphql_flutter.dart';

final shippingMutation = gql(r'''
mutation ShippingMutation($shippings: [shippings_insert_input!]!) {
  insert_shippings(objects: $shippings) {
    affected_rows
    returning {
      id
    }
  }
}
''');

final shippingSubscription = gql(r'''
subscription ShippingSubscription($limit: Int!, $offset: Int!, $created_by: uuid_comparison_exp!) {
  shippings(where: {created_by: $created_by}, limit: $limit, offset: $offset) {
    id
    linked_id
    name
  }
}
''');

final listShippingByCreatedByQuery = gql(r'''
query ListShippingByCreatedByQuery($offset: Int!, $limit: Int!, $created_by: uuid!) {
  shippings(limit: $limit, offset: $offset, where: {created_by: {_eq: $created_by}}) {
    id
    linked_id
    name
  }
}
''');
