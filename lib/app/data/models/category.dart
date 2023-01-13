List<Category> categoryList = [
  Category(
    id: "1",
    title: "ล้อ",
  ),
  Category(
    id: "2",
    title: "ยาง",
  ),
  Category(
    id: "3",
    title: "โปรโมชั่น",
  ),
];

class Category {
  String id;
  String title;
  Category({
    required this.id,
    required this.title,
  });
}
