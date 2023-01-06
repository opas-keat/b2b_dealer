List<MenuItem> menuItems = [
  MenuItem(
    title: "รายการสินค้า",
    isShow: true,
  ),
  MenuItem(
    title: "รายการสั่งซื้อ",
    isShow: true,
  ),
  MenuItem(
    title: "ประวัติการสั่งซื้อ",
    isShow: true,
  ),
  MenuItem(
    title: "ตั้งค่า",
    isShow: true,
  ),
  MenuItem(
    title: "ออกจากระบบ",
    isShow: true,
  ),
];

class MenuItem {
  String title;
  bool isShow;
  MenuItem({
    required this.title,
    required this.isShow,
  });
}
