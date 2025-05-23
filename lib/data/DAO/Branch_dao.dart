import 'package:sqflite/sqflite.dart';
import 'package:task/data/data_source/local_data_base.dart';
import 'package:task/domain/models/branch.dart';

//DAO design pattern

class BranchDao {
  final database = DatabaseHelper.instance.database;

  Future<int> insertBranch(Branch branch) async {
    final db = await database;
    return await db.insert(
      'branches',
      branch.toJson(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<List<Branch>> getBranches() async {
    final db = await database;
    List<Map<String, dynamic>> maps = await db.query('branches');
    return maps.map((e) => Branch.fromJson(e)).toList();
  }

  Future<int> updateBranch(Branch branch) async {
    final db = await database;
    return await db.update(
      'branches',
      branch.toJson(),
      where: 'id = ?',
      whereArgs: [branch.id],
    );
  }

  Future<int> deleteBranch(int id) async {
    final db = await database;
    return await db.delete('branches', where: 'id = ?', whereArgs: [id]);
  }
}
