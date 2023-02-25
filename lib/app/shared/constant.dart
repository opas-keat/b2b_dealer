import 'package:flutter/material.dart';
import 'package:nhost_sdk/nhost_sdk.dart';

const backendUrl = "https://qtntktogobtletqbvjqy.nhost.run";
late NhostClient nhostClient;

const primaryColor = Color(0xff101D40);
const primaryLightColor = Color(0xff223F8F);
const accentColor = Color(0xFF5E000C);
const accentLightColor = Color(0xFFB70018);

const double defaultPadding = 16.0;

const brandWheel = [
  "COSMIS",
  "COSMIS2",
  "FATTAH",
  "FORCE",
  "NAYA",
  "UNIVERSE",
  "VALENZA"
];
const groupWheel = ["COMPLICATED", "FACTORY"];
const brandTires = ["COSMIS", "DOUBLESTAR", "ZESTINO"];
const groupTires = ["TIRE-NEW PP"];

final Map<String, String> optionPaymentChannel = {
  '7': 'เงินสด', // ส่งค่า 7 วันไป
  '60': 'เครดิต', // ส่งค่า 60 วันไป
};

const logActionLogin = "เข้าสู่ระบบ";
const logActionAddProduct = "เพิ่มสินค้า";
const logActionEditProduct = "แก้ไขสินค้า";
const logActionDelete = "ลบสินค้า";
const logActionDisableDealer = "ปิดร้านค้า";
const logActionEnableDealer = "เปิดร้านค้า";
const logActionRegister = "ลงทะเบียนสมาชิก";
const logActionOrder = "สั่งสินค้า";
