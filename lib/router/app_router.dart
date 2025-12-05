import 'package:go_router/go_router.dart';
import '../screens/products_screen.dart';
import '../screens/cart_screen.dart';

final router = GoRouter(
  routes: [
    GoRoute(
      path: '/products',
      builder: (context, state) => const ProductsScreen(),
    ),
    GoRoute(path: '/cart', builder: (context, state) => const CartScreen()),
  ],
  initialLocation: '/products',
);
