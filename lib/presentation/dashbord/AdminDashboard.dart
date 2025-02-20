import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fl_chart/fl_chart.dart';

import 'cubit/admin_dashboard_cubit.dart';
import 'cubit/admin_dashboard_state.dart';

class AdminDashboard extends StatelessWidget {
  const AdminDashboard({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AdminDashboardCubit(context),
      child: BlocBuilder<AdminDashboardCubit, AdminDashboardState>(
        builder: (context, state) {
          final cubit = context.read<AdminDashboardCubit>();
          final primaryColor = cubit.primaryColor;

          return Scaffold(
            appBar: AppBar(
              backgroundColor: primaryColor,
              elevation: 0,
              title: const Text(
                'GOURMET DELIGHT ADMIN',
                style: TextStyle(
                  fontSize: 16,
                  letterSpacing: 2,
                  fontWeight: FontWeight.w600,
                  color: Colors.white,
                ),
              ),
              actions: [
                IconButton(
                  icon: const Icon(Icons.notifications_outlined),
                  onPressed: () {},
                ),
                const SizedBox(width: 10),
                IconButton(
                  icon: const Icon(Icons.settings_outlined),
                  onPressed: () {},
                ),
                const SizedBox(width: 10),
                CircleAvatar(
                  backgroundColor: Colors.white,
                  radius: 16,
                  child: Icon(Icons.person, size: 20, color: primaryColor),
                ),
                const SizedBox(width: 20),
              ],
              leading: LayoutBuilder(
                builder: (context, constraints) {
                  final width = MediaQuery.of(context).size.width;
                  final isMobile = width < 800;

                  if (isMobile) {
                    return IconButton(
                      icon: const Icon(Icons.menu),
                      onPressed: () {
                        cubit.toggleDrawer();
                      },
                    );
                  }
                  return const SizedBox.shrink();
                },
              ),
            ),
            drawer: LayoutBuilder(
              builder: (context, constraints) {
                final width = MediaQuery.of(context).size.width;
                final isMobile = width < 800;

                if (isMobile) {
                  return _buildNavigationDrawer(context, cubit, primaryColor);
                }
                return const SizedBox();
              },
            ),
            body: LayoutBuilder(
              builder: (context, constraints) {
                final width = MediaQuery.of(context).size.width;
                final isMobile = width < 800;

                return Row(
                  children: [
                    // Side navigation (desktop only)
                    if (!isMobile)
                      _buildSideNavigation(context, cubit, primaryColor),

                    // Main content area
                    Expanded(
                      child: Container(
                        color: Colors.grey.shade100,
                        child: SingleChildScrollView(
                          child: Padding(
                            padding: const EdgeInsets.all(20.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                // Page title and actions
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      'Dashboard Overview',
                                      style: TextStyle(
                                        fontSize: isMobile ? 20 : 24,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    if (!isMobile)
                                      Row(
                                        children: [
                                          OutlinedButton.icon(
                                            onPressed: () {},
                                            icon: const Icon(Icons.download),
                                            label: const Text('Export Report'),
                                            style: OutlinedButton.styleFrom(
                                              foregroundColor: primaryColor,
                                              side: BorderSide(
                                                  color: primaryColor),
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      horizontal: 16,
                                                      vertical: 12),
                                            ),
                                          ),
                                          const SizedBox(width: 12),
                                          ElevatedButton.icon(
                                            onPressed: () {},
                                            icon: const Icon(Icons.add),
                                            label: const Text('New Order'),
                                            style: ElevatedButton.styleFrom(
                                              backgroundColor: primaryColor,
                                              foregroundColor: Colors.white,
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      horizontal: 16,
                                                      vertical: 12),
                                            ),
                                          ),
                                        ],
                                      ),
                                  ],
                                ),
                                const SizedBox(height: 20),

                                // Stats cards
                                _buildStatsCards(
                                    context, isMobile, primaryColor),
                                const SizedBox(height: 20),

                                // Sales chart and popular items
                                if (isMobile)
                                  Column(
                                    children: [
                                      _buildSalesChart(context, cubit,
                                          primaryColor, isMobile),
                                      const SizedBox(height: 20),
                                      _buildPopularItems(context, cubit,
                                          primaryColor, isMobile),
                                    ],
                                  )
                                else
                                  Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Expanded(
                                        flex: 3,
                                        child: _buildSalesChart(context, cubit,
                                            primaryColor, isMobile),
                                      ),
                                      const SizedBox(width: 20),
                                      Expanded(
                                        flex: 2,
                                        child: _buildPopularItems(context,
                                            cubit, primaryColor, isMobile),
                                      ),
                                    ],
                                  ),
                                const SizedBox(height: 20),

                                // Recent orders
                                _buildRecentOrders(
                                    context, cubit, primaryColor, isMobile),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                );
              },
            ),
            floatingActionButton: LayoutBuilder(
              builder: (context, constraints) {
                final width = MediaQuery.of(context).size.width;
                final isMobile = width < 800;

                if (isMobile) {
                  return FloatingActionButton(
                    backgroundColor: primaryColor,
                    onPressed: () {},
                    child: const Icon(Icons.add),
                  );
                }
                return const SizedBox.shrink();
              },
            ),
          );
        },
      ),
    );
  }

  Widget _buildSideNavigation(
      BuildContext context, AdminDashboardCubit cubit, Color primaryColor) {
    final menuItems = [
      {'icon': Icons.dashboard, 'label': 'Dashboard'},
      {'icon': Icons.receipt_long, 'label': 'Orders'},
      {'icon': Icons.restaurant_menu, 'label': 'Menu Items'},
      {'icon': Icons.people, 'label': 'Customers'},
      {'icon': Icons.store, 'label': 'Inventory'},
      {'icon': Icons.insert_chart, 'label': 'Reports'},
      {'icon': Icons.settings, 'label': 'Settings'},
    ];

    return Container(
      width: 250,
      color: Colors.white,
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.symmetric(vertical: 24),
            alignment: Alignment.center,
            child: Column(
              children: [
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: primaryColor.withOpacity(0.1),
                    shape: BoxShape.circle,
                  ),
                  child: Icon(
                    Icons.restaurant,
                    size: 36,
                    color: primaryColor,
                  ),
                ),
                const SizedBox(height: 12),
                const Text(
                  'Admin Panel',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
              ],
            ),
          ),
          const Divider(height: 1),
          Expanded(
            child: ListView.builder(
              itemCount: menuItems.length,
              itemBuilder: (context, index) {
                final item = menuItems[index];
                final isSelected = cubit.selectedMenuIndex == index;

                return ListTile(
                  leading: Icon(
                    item['icon'] as IconData,
                    color: isSelected ? primaryColor : Colors.grey.shade600,
                  ),
                  title: Text(
                    item['label'] as String,
                    style: TextStyle(
                      color: isSelected ? primaryColor : Colors.grey.shade800,
                      fontWeight:
                          isSelected ? FontWeight.bold : FontWeight.normal,
                    ),
                  ),
                  selected: isSelected,
                  selectedTileColor: primaryColor.withOpacity(0.1),
                  shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.only(
                      topRight: Radius.circular(30),
                      bottomRight: Radius.circular(30),
                    ),
                  ),
                  onTap: () {
                    cubit.selectMenuItem(index);
                  },
                );
              },
            ),
          ),
          const Divider(height: 1),
          ListTile(
            leading: const Icon(Icons.logout, color: Colors.grey),
            title: const Text('Logout'),
            onTap: () {
              // Handle logout
            },
          ),
          const SizedBox(height: 20),
        ],
      ),
    );
  }

  Widget _buildNavigationDrawer(
      BuildContext context, AdminDashboardCubit cubit, Color primaryColor) {
    final menuItems = [
      {'icon': Icons.dashboard, 'label': 'Dashboard'},
      {'icon': Icons.receipt_long, 'label': 'Orders'},
      {'icon': Icons.restaurant_menu, 'label': 'Menu Items'},
      {'icon': Icons.people, 'label': 'Customers'},
      {'icon': Icons.store, 'label': 'Inventory'},
      {'icon': Icons.insert_chart, 'label': 'Reports'},
      {'icon': Icons.settings, 'label': 'Settings'},
    ];

    return Drawer(
      child: Column(
        children: [
          DrawerHeader(
            decoration: BoxDecoration(
              color: primaryColor,
            ),
            child: const Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(
                    Icons.restaurant_menu,
                    color: Colors.white,
                    size: 50,
                  ),
                  SizedBox(height: 10),
                  Text(
                    'GOURMET DELIGHT',
                    style: TextStyle(
                      fontSize: 16,
                      letterSpacing: 2,
                      fontWeight: FontWeight.w600,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: menuItems.length,
              itemBuilder: (context, index) {
                final item = menuItems[index];
                final isSelected = cubit.selectedMenuIndex == index;

                return ListTile(
                  leading: Icon(
                    item['icon'] as IconData,
                    color: isSelected ? primaryColor : Colors.grey.shade600,
                  ),
                  title: Text(
                    item['label'] as String,
                    style: TextStyle(
                      color: isSelected ? primaryColor : Colors.grey.shade800,
                      fontWeight:
                          isSelected ? FontWeight.bold : FontWeight.normal,
                    ),
                  ),
                  selected: isSelected,
                  selectedTileColor: primaryColor.withOpacity(0.1),
                  onTap: () {
                    cubit.selectMenuItem(index);
                    Navigator.pop(context); // Close drawer
                  },
                );
              },
            ),
          ),
          const Divider(height: 1),
          ListTile(
            leading: const Icon(Icons.logout, color: Colors.grey),
            title: const Text('Logout'),
            onTap: () {
              // Handle logout
              Navigator.pop(context); // Close drawer
            },
          ),
        ],
      ),
    );
  }

  Widget _buildStatsCards(
      BuildContext context, bool isMobile, Color primaryColor) {
    final stats = [
      {
        'title': 'Total Revenue',
        'value': '\$8,459.00',
        'change': '+23.5%',
        'isUp': true,
        'icon': Icons.attach_money,
        'color': Colors.green,
      },
      {
        'title': 'Total Orders',
        'value': '426',
        'change': '+18.2%',
        'isUp': true,
        'icon': Icons.shopping_bag,
        'color': Colors.blue,
      },
      {
        'title': 'Average Order',
        'value': '\$42.50',
        'change': '+5.8%',
        'isUp': true,
        'icon': Icons.calculate,
        'color': Colors.purple,
      },
      {
        'title': 'New Customers',
        'value': '124',
        'change': '-2.3%',
        'isUp': false,
        'icon': Icons.person_add,
        'color': Colors.orange,
      },
    ];

    if (isMobile) {
      return Column(
        children: stats
            .map((stat) => Padding(
                  padding: const EdgeInsets.only(bottom: 12),
                  child: _buildStatCard(stat, primaryColor),
                ))
            .toList(),
      );
    }

    return Row(
      children: stats
          .map((stat) => Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(right: 12),
                  child: _buildStatCard(stat, primaryColor),
                ),
              ))
          .toList(),
    );
  }

  Widget _buildStatCard(Map<String, dynamic> stat, Color primaryColor) {
    return Card(
      elevation: 1,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: (stat['color'] as Color).withOpacity(0.1),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Icon(
                stat['icon'] as IconData,
                color: stat['color'] as Color,
                size: 24,
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    stat['title'] as String,
                    style: TextStyle(
                      color: Colors.grey.shade600,
                      fontSize: 14,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    stat['value'] as String,
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Row(
                    children: [
                      Icon(
                        (stat['isUp'] as bool)
                            ? Icons.arrow_upward
                            : Icons.arrow_downward,
                        color:
                            (stat['isUp'] as bool) ? Colors.green : Colors.red,
                        size: 14,
                      ),
                      const SizedBox(width: 4),
                      Text(
                        stat['change'] as String,
                        style: TextStyle(
                          color: (stat['isUp'] as bool)
                              ? Colors.green
                              : Colors.red,
                          fontSize: 12,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSalesChart(BuildContext context, AdminDashboardCubit cubit,
      Color primaryColor, bool isMobile) {
    return Card(
      elevation: 1,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Sales Overview',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                DropdownButton<String>(
                  value: 'This Week',
                  underline: const SizedBox.shrink(),
                  items: ['This Week', 'Last Week', 'This Month', 'Last Month']
                      .map<DropdownMenuItem<String>>(
                        (value) => DropdownMenuItem<String>(
                          value: value,
                          child: Text(value),
                        ),
                      )
                      .toList(),
                  onChanged: (value) {},
                ),
              ],
            ),
            const SizedBox(height: 20),
            SizedBox(
              height: 250,
              child: BarChart(
                BarChartData(
                  alignment: BarChartAlignment.spaceAround,
                  maxY: 10000,
                  barTouchData: BarTouchData(
                    enabled: true,
                    touchTooltipData: BarTouchTooltipData(
                      getTooltipItem: (group, groupIndex, rod, rodIndex) {
                        return BarTooltipItem(
                          '\$${cubit.salesData[groupIndex].amount.toStringAsFixed(2)}',
                          const TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        );
                      },
                    ),
                  ),
                  titlesData: FlTitlesData(
                    show: true,
                    bottomTitles: AxisTitles(
                      sideTitles: SideTitles(
                        showTitles: true,
                        getTitlesWidget: (value, meta) {
                          return Padding(
                            padding: const EdgeInsets.only(top: 8),
                            child: Text(
                              cubit.salesData[value.toInt()].day,
                              style: TextStyle(
                                color: Colors.grey.shade600,
                                fontWeight: FontWeight.bold,
                                fontSize: 12,
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                    leftTitles: AxisTitles(
                      sideTitles: SideTitles(
                        showTitles: true,
                        reservedSize: 40,
                        getTitlesWidget: (value, meta) {
                          String text;
                          if (value == 0) {
                            text = '\$0';
                          } else if (value == 2500) {
                            text = '\$2.5K';
                          } else if (value == 5000) {
                            text = '\$5K';
                          } else if (value == 7500) {
                            text = '\$7.5K';
                          } else if (value == 10000) {
                            text = '\$10K';
                          } else {
                            return const SizedBox.shrink();
                          }
                          return Padding(
                            padding: const EdgeInsets.only(right: 8),
                            child: Text(
                              text,
                              style: TextStyle(
                                color: Colors.grey.shade600,
                                fontSize: 10,
                              ),
                              textAlign: TextAlign.right,
                            ),
                          );
                        },
                      ),
                    ),
                    topTitles:  AxisTitles(
                      sideTitles: SideTitles(showTitles: false),
                    ),
                    rightTitles:  AxisTitles(
                      sideTitles: SideTitles(showTitles: false),
                    ),
                  ),
                  gridData: FlGridData(
                    show: true,
                    drawVerticalLine: false,
                    getDrawingHorizontalLine: (value) {
                      return FlLine(
                        color: Colors.grey.shade200,
                        strokeWidth: 1,
                      );
                    },
                  ),
                  borderData: FlBorderData(
                    show: false,
                  ),
                  barGroups: cubit.salesData.asMap().entries.map((entry) {
                    final index = entry.key;
                    final data = entry.value;
                    return BarChartGroupData(
                      x: index,
                      barRods: [
                        BarChartRodData(
                          toY: data.amount,
                          color: primaryColor,
                          width: 20,
                          borderRadius: const BorderRadius.only(
                            topLeft: Radius.circular(6),
                            topRight: Radius.circular(6),
                          ),
                        ),
                      ],
                    );
                  }).toList(),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPopularItems(BuildContext context, AdminDashboardCubit cubit,
      Color primaryColor, bool isMobile) {
    return Card(
      elevation: 1,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Popular Items',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Icon(Icons.more_vert),
              ],
            ),
            const SizedBox(height: 20),
            ...cubit.popularItems
                .map((item) => Padding(
                      padding: const EdgeInsets.only(bottom: 16),
                      child: Row(
                        children: [
                          Container(
                            width: 50,
                            height: 50,
                            decoration: BoxDecoration(
                              color: Colors.grey.shade100,
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: const Icon(Icons.restaurant,
                                color: Colors.grey),
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  item.name,
                                  style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16,
                                  ),
                                ),
                                Text(
                                  item.category,
                                  style: TextStyle(
                                    color: Colors.grey.shade600,
                                    fontSize: 14,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Text(
                                '${item.orders} orders',
                                style: const TextStyle(
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              Text(
                                '\$${item.revenue.toStringAsFixed(2)}',
                                style: TextStyle(
                                  color: primaryColor,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ))
                .toList(),
            const SizedBox(height: 12),
            SizedBox(
              width: double.infinity,
              child: OutlinedButton(
                onPressed: () {},
                style: OutlinedButton.styleFrom(
                  foregroundColor: primaryColor,
                  side: BorderSide(color: primaryColor),
                  padding: const EdgeInsets.symmetric(vertical: 12),
                ),
                child: const Text('View All Items'),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildRecentOrders(BuildContext context, AdminDashboardCubit cubit,
      Color primaryColor, bool isMobile) {
    return Card(
      elevation: 1,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Recent Orders',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  'View All',
                  style: TextStyle(
                    color: Colors.blue,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child:DataTable(
                columnSpacing: 20,
                horizontalMargin: 0,
                columns: const [
                  DataColumn(label: Text('Order ID')),
                  DataColumn(label: Text('Customer')),
                  DataColumn(label: Text('Amount')),
                  DataColumn(label: Text('Status')),
                  DataColumn(label: Text('Time')),
                  DataColumn(label: Text('Actions')),
                ],
                rows: cubit.recentOrders.map((order) {
                  return DataRow(
                    cells: [
                      DataCell(Text(
                        order.id,
                        style: const TextStyle(fontWeight: FontWeight.w500),
                      )),
                      DataCell(Text(order.customer)),
                      DataCell(Text('\$${order.amount.toStringAsFixed(2)}')),
                      DataCell(
                        Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 8, vertical: 4),
                          decoration: BoxDecoration(
                            color: _getStatusColor(order.status).withOpacity(0.1),
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Text(
                            order.status,
                            style: TextStyle(
                              color: _getStatusColor(order.status),
                              fontWeight: FontWeight.w500,
                              fontSize: 12,
                            ),
                          ),
                        ),
                      ),
                      DataCell(Text(order.time)),
                      DataCell(
                        Row(
                          children: [
                            IconButton(
                              icon: const Icon(Icons.visibility, size: 20),
                              onPressed: () {},
                              color: Colors.blue,
                              // BoxDecorationcolor: Colors.blue,
                            ),
                            IconButton(
                              icon: const Icon(Icons.edit, size: 20),
                              onPressed: () {},
                              color: Colors.green,
                            ),
                          ],
                        ),
                      ),
                    ],
                  );
                }).toList(), // Added .toList() here
              ),
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  Color _getStatusColor(String status) {
    switch (status) {
      case 'Completed':
        return Colors.green;
      case 'Pending':
        return Colors.orange;
      case 'Processing':
        return Colors.blue;
      case 'Cancelled':
        return Colors.red;
      default:
        return Colors.grey;
    }
  }
}
