import 'package:graphql_flutter/graphql_flutter.dart';

final getProductDetail = gql(r'''
query getProductDetail($id: uuid = "") {
  products_by_pk(id: $id) {
    color
    mat_size
    offset
    pitch_circle_code
    price
    tread_ware
    width
  }
}
''');

final listProductByBrandAndModelQuery = gql(r'''
query listProductByBrandAndModelQuery($brand: String!, $model: String!) {
  products(where: {model: {_eq: $model}, brand: {_eq: $brand}}, order_by: {created_by: asc}) {
    id
    price
    name
    product_files {
      file_id
    }
  }
}
''');

final listBrandAndModelQuery = gql(r'''
query listBrandAndModelQuery($distinct_on: [products_select_column!] = [brand,model], $brand: [String!], $group: [String!]) {
  products(where: {brand: {_in: $brand}, _and: {group_code: {_in: $group}}}, distinct_on: $distinct_on) {
    id
    brand
    model
    product_files {
      file_id
    }
  }
}
''');
