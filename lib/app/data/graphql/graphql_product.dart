import 'package:graphql_flutter/graphql_flutter.dart';

final getProductDetail = gql(r'''
query getProductDetail($id: uuid!) {
  products(where: {id: {_eq: $id}}) {
    color
    mat_size
    offset
    pitch_circle_code
    price
    tread_ware
    width
    code
    brand
    dealer_price_1
    group_code
    id
    link_id
    model
    name
    mat_size
    load_index
    speed_index
    year
    week
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

final searchProduct = gql(r'''
query searchProduct($where1: products_bool_exp!) {
  products(where: $where1) {
    ...productsFragment
  }
}

fragment productsFragment on products {
  color
  mat_size
  offset
  pitch_circle_code
  price
  tread_ware
  width
  code
  brand
  dealer_price_1
  group_code
  id
  link_id
  model
  name
  mat_size
  load_index
  speed_index
  year
  week
  product_files {
    file_id
  }
}
''');
