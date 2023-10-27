import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:levelx_interview/model/api_model.dart';

class CartNotifier extends ChangeNotifier {
  List<CategoryDish> cartList = [];

  void addtocart(CategoryDish categoryDish) {
    // Check if the cart is empty
    if (cartList.isEmpty) {
      categoryDish = categoryDish.copyWith(itemCount: 1);
      cartList.add(categoryDish);
    } else {
      // Flag to indicate whether the item was found in the cart
      bool itemFound = false;
      for (var item in cartList) {
        if (item.dishId == categoryDish.dishId) {
          // If the item is already in the cart, increment the item count
          item.itemCount++;
          itemFound = true;
          break; // No need to continue searching
        }
      }
      // If the item was not found in the cart, add it with a count of 1
      if (!itemFound) {
        categoryDish = categoryDish.copyWith(itemCount: 1);
        cartList.add(categoryDish);
      }
    }
    notifyListeners();
  }

  void removefromcart(CategoryDish categoryDish) {
    for (var i in cartList) {
      if (i.dishId == categoryDish.dishId) {
        if (i.itemCount > 1) {
          i.itemCount--;
        } else {
          cartList.remove(i);
        }
        notifyListeners();
        break; // Stop after the first occurrence of the item is modified
      }
    }
  }

  int? itemcount(String id) {
    for (var i in cartList) {
      if (id == i.dishId) {
        return i.itemCount;
      }
    }
    if (cartList.isEmpty) {
      return 0;
    }
    return null;
  }

  int toSum() {
    int sum = 0;
    for (var i in cartList) {
      sum += i.dishPrice!.toInt() * i.itemCount;
    }
    return sum;
  }
}

final cartProvider = ChangeNotifierProvider<CartNotifier>((ref) {
  return CartNotifier();
});
