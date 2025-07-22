import 'cart_item.dart';

enum OrderStatus { preparing, onTheWay, delivered, cancelled }

class Order {
  final String id;
  final String userId;
  final String restaurantId;
  final String restaurantName;
  final List<CartItem> items;
  final DateTime orderTime;
  final double subtotal;
  final double deliveryFee;
  final double total;
  final String deliveryAddress;
  final String paymentMethod;
  OrderStatus status;

  Order({
    required this.id,
    required this.userId,
    required this.restaurantId,
    required this.restaurantName,
    required this.items,
    required this.orderTime,
    required this.subtotal,
    required this.deliveryFee,
    required this.total,
    required this.deliveryAddress,
    required this.paymentMethod,
    this.status = OrderStatus.preparing,
  });
}