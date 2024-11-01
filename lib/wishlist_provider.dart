import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'wishlist_item.dart';

class WishlistProvider with ChangeNotifier {
  final FirebaseFirestore _db = FirebaseFirestore.instance;
  List<WishlistItem> _items = [];

  List<WishlistItem> get items => _items;

  Future<void> fetchItems() async {
    final snapshot = await _db.collection('wishlist').get();
    _items = snapshot.docs
        .map((doc) => WishlistItem.fromMap(doc.id, doc.data()))
        .toList();
    notifyListeners();
  }

  Future<void> addItem(String title, String description) async {
    final docRef = await _db.collection('wishlist').add({
      'title': title,
      'description': description,
    });
    final newItem = WishlistItem(id: docRef.id, title: title, description: description);
    _items.add(newItem);
    notifyListeners();
  }

  Future<void> updateItem(String id, String title, String description) async {
    await _db.collection('wishlist').doc(id).update({
      'title': title,
      'description': description,
    });
    final index = _items.indexWhere((item) => item.id == id);
    if (index != -1) {
      _items[index] = WishlistItem(id: id, title: title, description: description);
      notifyListeners();
    }
  }

  Future<void> deleteItem(String id) async {
    await _db.collection('wishlist').doc(id).delete();
    _items.removeWhere((item) => item.id == id);
    notifyListeners();
  }
}
