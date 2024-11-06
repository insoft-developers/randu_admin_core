import 'package:flutter/foundation.dart';
import 'package:sqflite/sqflite.dart' as sql;

class SQLHelper {
  static Future<void> createTableVarian(sql.Database database) async {
    await database.execute("""CREATE TABLE varians(
      id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,
      varian_group STRING NOT NULL,
      varian_name STRING NOT NULL,
      sku STRING,
      harga INTEGER,
      single_pick INTEGER,
      max_quantity INTEGER
       ) """);
    print("create_table_varians");
  }

  static Future<void> createTableProduct(sql.Database database) async {
    await database.execute("""CREATE TABLE products(
      id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,
      product_id INTEGER NOT NULL,
      product_name STRING NOT NULL,
      satuan STRING NOT NULL,
      product_type INTEGER NOT NULL,
      quantity INTEGER NOT NULL
       ) """);
    print("create_table_product");
  }

  static Future<sql.Database> db() async {
    return sql.openDatabase('randu_core.db', version: 1,
        onCreate: (sql.Database database, int version) async {
      await createTableVarian(database);
      await createTableProduct(database);
    });
  }

  static Future<int> tambahVarian(String varianGroup, String varianName,
      String sku, int harga, int singlePick, int maxQuantity) async {
    final db = await SQLHelper.db();
    final data = {
      'varian_group': varianGroup,
      'varian_name': varianName,
      'sku': sku,
      'harga': harga,
      'single_pick': singlePick,
      'max_quantity': maxQuantity
    };
    final id = await db.insert("varians", data,
        conflictAlgorithm: sql.ConflictAlgorithm.replace);
    print('insert varian');
    return id;
  }

  static Future<int> tambahProduk(int productId, String productName,
      String satuan, int productType, int quantity) async {
    final db = await SQLHelper.db();
    final data = {
      'product_id': productId,
      'product_name': productName,
      'satuan': satuan,
      'product_type': productType,
      'quantity': quantity,
    };
    final id = await db.insert("products", data,
        conflictAlgorithm: sql.ConflictAlgorithm.replace);
    return id;
  }

  static Future<List<Map<String, dynamic>>> getVarians() async {
    final db = await SQLHelper.db();
    return db.query('varians', orderBy: "varian_group desc");
  }

  static Future<List<Map<String, dynamic>>> getProducts() async {
    final db = await SQLHelper.db();
    return db.query('products', orderBy: "id desc");
  }

  static Future<void> clearVarian() async {
    final db = await SQLHelper.db();
    try {
      await db.delete("varians");
    } catch (err) {
      debugPrint("Something wrong when deleting all items : $err");
    }
  }

  static Future<void> clearProduct() async {
    final db = await SQLHelper.db();
    try {
      await db.delete("products");
    } catch (err) {
      debugPrint("Something wrong when deleting all items : $err");
    }
  }

  static Future<void> deleteVarian(int id) async {
    final db = await SQLHelper.db();
    try {
      await db.delete("varians", where: "id = ?", whereArgs: [id]);
    } catch (err) {
      debugPrint("Something wrong when deleting the items : $err");
    }
  }

  static Future<void> deleteProduct(int id) async {
    final db = await SQLHelper.db();
    try {
      await db.delete("products", where: "id = ?", whereArgs: [id]);
    } catch (err) {
      debugPrint("Something wrong when deleting the items : $err");
    }
  }

  static Future<int> updateVarian(int id, String varianGroup, String varianName,
      String sku, int harga, int singlePick, int maxQuantity) async {
    final db = await SQLHelper.db();
    final data = {
      'varian_group': varianGroup,
      'varian_name': varianName,
      'sku': sku,
      'harga': harga,
      'single_pick': singlePick,
      'max_quantity': maxQuantity
    };

    final result =
        await db.update("varians", data, where: "id = ?", whereArgs: [id]);
    return result;
  }

  static Future<int> updateProduct(int id, int productId, String productName,
      String satuan, int productType, int quantity) async {
    final db = await SQLHelper.db();
    final data = {
      'product_id': productId,
      'product_name': productName,
      'satuan': satuan,
      'product_type': productType,
      'quantity': quantity,
    };

    final result =
        await db.update("products", data, where: "id = ?", whereArgs: [id]);
    return result;
  }

  // static Future<List<Map<String, dynamic>>> getItem(int id) async {
  //   final db = await SQLHelper.db();
  //   return db.query("items", where: "id = ?", whereArgs: [id], limit: 1);
  // }

  // static Future calculateTotal() async {
  //   var dbClient = await SQLHelper.db();
  //   var result = await dbClient
  //       .rawQuery("SELECT SUM(total_price) as Total FROM sales_items");
  //   print(result.toList());
  //   return result.toList();
  // }
}
