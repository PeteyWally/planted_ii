/*   */

import 'package:mongo_dart/mongo_dart.dart';
import '/models/model_category.dart';
import '../mongo_config.dart';

class MongoCategoryRepository implements CategoryRepository {
  final DbCollection _collection = MongoConfig.db.collection('categories');

  @override
  Future<List<CategoryModel>> getCategories() async {
    try {
      final categories = await _collection.find().toList();
      return categories.map((e) => CategoryModel.fromMap(e)).toList();
    } catch (e) {
      print('Error fetching categories: $e');
      return [];
    }
  }

  @override
  Future<CategoryModel?> getCategoryById(String id) async {
    try {
      final category =
          await _collection.findOne(where.id(ObjectId.fromHexString(id)));
      return category != null ? CategoryModel.fromMap(category) : null;
    } catch (e) {
      print('Error fetching category by ID: $e');
      return null;
    }
  }

  @override
  Future<void> addCategory(CategoryModel category) async {
    try {
      await _collection.insertOne(category.toMap());
    } catch (e) {
      print('Error adding category: $e');
    }
  }

  @override
  Future<void> updateCategory(CategoryModel category) async {
    try {
      await _collection.updateOne(
        where.id(ObjectId.fromHexString(category.id)),
        modify
            .set('name', category.name)
            .set('icon', category.icon.toString())
            .set('iconColor', category.iconColor)
            .set('sizeTime', category.sizeTime)
            .set('subTaskIds', category.subTaskIds),
      );
    } catch (e) {
      print('Error updating category: $e');
    }
  }

  @override
  Future<void> deleteCategory(String id) async {
    try {
      await _collection.remove(where.id(ObjectId.fromHexString(id)));
    } catch (e) {
      print('Error deleting category: $e');
    }
  }
}
