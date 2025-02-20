import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'admin_dashboard_state.dart';

class AdminDashboardCubit extends Cubit<AdminDashboardState> {
  AdminDashboardCubit(BuildContext context) : super(AdminDashboardState()) {
    // Initialize with default primary color from theme

    // Load initial data
    loadDashboardData();
  }

  final Color primaryColor = const Color(0xFFF9A825);
  int selectedMenuIndex = 0;
  bool isDrawerOpen = false;

  // Sample data for dashboard
  List<DailySales> salesData = [];
  List<OrderData> recentOrders = [];
  List<PopularItem> popularItems = [];

  void selectMenuItem(int index) {
    selectedMenuIndex = index;
    emit(state.copyWith());
  }

  void toggleDrawer() {
    isDrawerOpen = !isDrawerOpen;
    emit(state.copyWith());
  }

  void loadDashboardData() {
    // Load mock sales data
    salesData = List.generate(7, (index) {
      return DailySales(
        day: ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun'][index],
        amount: [4500, 5200, 4800, 6300, 7800, 8500, 7200][index].toDouble(),
      );
    });

    // Load mock recent orders
    recentOrders = [
      OrderData(id: '#ORD-001', customer: 'John Smith', amount: 125.50, status: 'Completed', time: '10:30 AM'),
      OrderData(id: '#ORD-002', customer: 'Alice Johnson', amount: 78.25, status: 'Processing', time: '11:45 AM'),
      OrderData(id: '#ORD-003', customer: 'Robert Davis', amount: 210.00, status: 'Completed', time: '01:15 PM'),
      OrderData(id: '#ORD-004', customer: 'Emma Wilson', amount: 45.75, status: 'Cancelled', time: '02:30 PM'),
      OrderData(id: '#ORD-005', customer: 'Michael Brown', amount: 165.30, status: 'Preparing', time: '03:20 PM'),
    ];

    // Load mock popular items
    popularItems = [
      PopularItem(name: 'Grilled Salmon', category: 'Seafood', orders: 125, revenue: 3125.0),
      PopularItem(name: 'Beef Wellington', category: 'Main Course', orders: 98, revenue: 2940.0),
      PopularItem(name: 'Tiramisu', category: 'Dessert', orders: 87, revenue: 870.0),
      PopularItem(name: 'Lobster Bisque', category: 'Soup', orders: 76, revenue: 1140.0),
    ];

    emit(state.copyWith());
  }
}

// Data models
class DailySales {
  final String day;
  final double amount;

  DailySales({required this.day, required this.amount});
}

class OrderData {
  final String id;
  final String customer;
  final double amount;
  final String status;
  final String time;

  OrderData({required this.id, required this.customer, required this.amount, required this.status, required this.time});
}

class PopularItem {
  final String name;
  final String category;
  final int orders;
  final double revenue;

  PopularItem({required this.name, required this.category, required this.orders, required this.revenue});
}