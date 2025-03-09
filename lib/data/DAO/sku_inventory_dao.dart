import 'package:sqflite/sqflite.dart';
import 'package:task/data/data_source/local_data_base.dart';
import 'package:task/domain/models/inventory_item.dart';

class InventoryDao {
  final Future<Database> _database = DatabaseHelper.instance.database;

  Future<int> insertItem(InventoryItem item) async {
    final db = await _database;
    return await db.insert(
      'inventory_items',
      item.toJson(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<List<InventoryItem>> getAllItems() async {
    final db = await _database;
    final List<Map<String, dynamic>> maps = await db.query('inventory_items');
    return maps.map((e) => InventoryItem.fromJson(e)).toList();
  }

  Future<int> updateItem(InventoryItem item) async {
    final db = await _database;
    return await db.update(
      'inventory_items',
      item.toJson(),
      where: 'id = ?',
      whereArgs: [item.id],
    );
  }

  Future<int> deleteItem(int id) async {
    final db = await _database;
    return await db.delete('inventory_items', where: 'id = ?', whereArgs: [id]);
  }
}
