import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:web1/presentation/AuthPage/cubit/authpage_cubit.dart';

class AuthPage extends StatelessWidget {
  AuthPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AuthpageCubit(context),
      child: BlocBuilder<AuthpageCubit, AuthpageState>(
        builder: (context, state) {
          final cubit = context.read<AuthpageCubit>();
          final primaryColor = cubit.primaryColor;
          final isLogin = cubit.isLogin;

          return Scaffold(
            body: LayoutBuilder(
              builder: (context, constraints) {
                bool isMobile = constraints.maxWidth < 800;

                return Container(
                  decoration: BoxDecoration(
                    image: isMobile
                        ? const DecorationImage(
                            image: NetworkImage(
                                'https://media.istockphoto.com/id/1428412216/photo/a-male-chef-pouring-sauce-on-meal.jpg?s=612x612&w=0&k=20&c=8U3mrgWsuB7pB8axtGj89MXRkHDKodEli9F6wKgPT4A='),
                            fit: BoxFit.cover,
                          )
                        : null,
                  ),
                  child: Row(
                    children: [
                      if (!isMobile)
                        Expanded(
                          child: Container(
                            decoration: BoxDecoration(
                              image: const DecorationImage(
                                image: NetworkImage(
                                    'https://media.istockphoto.com/id/1428412216/photo/a-male-chef-pouring-sauce-on-meal.jpg?s=612x612&w=0&k=20&c=8U3mrgWsuB7pB8axtGj89MXRkHDKodEli9F6wKgPT4A='),
                                fit: BoxFit.cover,
                              ),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withOpacity(0.3),
                                  blurRadius: 15,
                                  spreadRadius: 5,
                                )
                              ],
                            ),
                            child: Container(
                              decoration: BoxDecoration(
                                gradient: LinearGradient(
                                  begin: Alignment.centerLeft,
                                  end: Alignment.centerRight,
                                  colors: [
                                    Colors.black.withOpacity(0.8),
                                    Colors.black.withOpacity(0.5),
                                  ],
                                ),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(32.0),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Icon(
                                      Icons.restaurant_menu,
                                      color: primaryColor,
                                      size: 60,
                                    ),
                                    const SizedBox(height: 30),
                                    const Text(
                                      'GOURMET DELIGHT',
                                      style: TextStyle(
                                        fontSize: 16,
                                        letterSpacing: 3,
                                        fontWeight: FontWeight.w600,
                                        color: Colors.white,
                                      ),
                                    ),
                                    const SizedBox(height: 30),
                                    Text(
                                      isLogin
                                          ? 'Welcome Back!'
                                          : 'Experience Culinary Excellence',
                                      style: const TextStyle(
                                        fontSize: 32,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white,
                                      ),
                                      textAlign: TextAlign.center,
                                    ),
                                    const SizedBox(height: 20),
                                    Container(
                                      width: 80,
                                      height: 4,
                                      decoration: BoxDecoration(
                                        color: primaryColor,
                                        borderRadius: BorderRadius.circular(2),
                                      ),
                                    ),
                                    const SizedBox(height: 30),
                                    Text(
                                      isLogin
                                          ? 'Experience the finest culinary creations from top chefs. Your personal dining journey continues here.'
                                          : 'Join our exclusive community of food enthusiasts and get personalized dining recommendations, special offers, and access to chef-curated events.',
                                      textAlign: TextAlign.center,
                                      style: const TextStyle(
                                        color: Colors.white70,
                                        fontSize: 16,
                                        height: 1.6,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                      Expanded(
                        child: Container(
                          color: isMobile ? Colors.transparent : Colors.white,
                          child: Container(
                            decoration: isMobile
                                ? BoxDecoration(
                                    gradient: LinearGradient(
                                      begin: Alignment.topCenter,
                                      end: Alignment.bottomCenter,
                                      colors: [
                                        Colors.black.withOpacity(0.7),
                                        Colors.black.withOpacity(0.6),
                                      ],
                                    ),
                                  )
                                : null,
                            child: Center(
                              child: SingleChildScrollView(
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 40, vertical: 20),
                                  child: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      if (isMobile) ...[
                                        const Center(
                                          child: Column(
                                            children: [
                                              Icon(
                                                Icons.restaurant_menu,
                                                color: Colors.white,
                                                size: 50,
                                              ),
                                              SizedBox(height: 15),
                                              Text(
                                                'GOURMET DELIGHT',
                                                style: TextStyle(
                                                  fontSize: 16,
                                                  letterSpacing: 3,
                                                  fontWeight: FontWeight.w600,
                                                  color: Colors.white,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        const SizedBox(height: 30),
                                      ],
                                      if (!isMobile) ...[
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.end,
                                          children: [
                                            Text(
                                              isLogin
                                                  ? "Don't have an account?"
                                                  : "Already have an account?",
                                              style: const TextStyle(
                                                  color: Colors.black54),
                                            ),
                                            const SizedBox(width: 5),
                                            TextButton(
                                              onPressed: () {
                                                cubit.toggleAuthMode();
                                              },
                                              style: TextButton.styleFrom(
                                                padding: EdgeInsets.zero,
                                                foregroundColor: primaryColor,
                                              ),
                                              child: Text(
                                                isLogin ? "Sign Up" : "Sign In",
                                                style: const TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                        const SizedBox(height: 40),
                                      ],
                                      Text(
                                        isLogin
                                            ? 'Sign In'
                                            : 'Create Your Account',
                                        style: TextStyle(
                                          fontSize: 28,
                                          fontWeight: FontWeight.bold,
                                          color: isMobile
                                              ? Colors.white
                                              : const Color(0xFF333333),
                                        ),
                                      ),
                                      const SizedBox(height: 10),
                                      Text(
                                        isLogin
                                            ? 'Welcome back! Please login to your account'
                                            : 'Fill in your details to get started',
                                        style: TextStyle(
                                          fontSize: 16,
                                          color: isMobile
                                              ? Colors.white70
                                              : Colors.black54,
                                        ),
                                      ),
                                      const SizedBox(height: 30),

                                      // Registration fields
                                      if (!isLogin) ...[
                                        Row(
                                          children: [
                                            Expanded(
                                              child: _buildTextField(context,
                                                  'First Name', Icons.person,
                                                  isMobile: isMobile),
                                            ),
                                            const SizedBox(width: 15),
                                            Expanded(
                                              child: _buildTextField(
                                                  context,
                                                  'Last Name',
                                                  Icons.person_outline,
                                                  isMobile: isMobile),
                                            ),
                                          ],
                                        ),
                                        const SizedBox(height: 20),
                                        _buildTextField(
                                            context, 'Group Name', Icons.group,
                                            isMobile: isMobile),
                                        const SizedBox(height: 20),
                                        _buildTextField(context, 'Username',
                                            Icons.account_circle,
                                            isMobile: isMobile),
                                        const SizedBox(height: 20),
                                        _buildTextField(
                                            context, 'Mobile', Icons.phone,
                                            isMobile: isMobile),
                                        const SizedBox(height: 20),
                                      ],

                                      // Common fields for both login and registration
                                      _buildTextField(
                                          context, 'Email', Icons.email,
                                          isMobile: isMobile),
                                      const SizedBox(height: 20),
                                      TextFormField(
                                        obscureText: cubit.obscurePassword,
                                        decoration: InputDecoration(
                                          labelText: 'Password',
                                          labelStyle: TextStyle(
                                            color: isMobile
                                                ? Colors.white70
                                                : Colors.black54,
                                          ),
                                          hintStyle: TextStyle(
                                            color: isMobile
                                                ? Colors.white60
                                                : Colors.black38,
                                          ),
                                          prefixIcon: Icon(
                                            Icons.lock_outline,
                                            color: isMobile
                                                ? Colors.white70
                                                : primaryColor,
                                          ),
                                          suffixIcon: IconButton(
                                            icon: Icon(
                                              cubit.obscurePassword
                                                  ? Icons.visibility_off
                                                  : Icons.visibility,
                                              color: isMobile
                                                  ? Colors.white70
                                                  : primaryColor,
                                            ),
                                            onPressed: () {
                                              cubit.togglePasswordVisibility();
                                            },
                                          ),
                                          enabledBorder: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(15),
                                            borderSide: BorderSide(
                                              color: isMobile
                                                  ? Colors.white30
                                                  : Colors.grey.shade300,
                                            ),
                                          ),
                                          focusedBorder: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(15),
                                            borderSide: BorderSide(
                                              color: isMobile
                                                  ? Colors.white
                                                  : primaryColor,
                                              width: 2,
                                            ),
                                          ),
                                          filled: true,
                                          fillColor: isMobile
                                              ? Colors.white.withOpacity(0.1)
                                              : Colors.grey.shade50,
                                        ),
                                        style: TextStyle(
                                          color: isMobile
                                              ? Colors.white
                                              : Colors.black,
                                        ),
                                      ),

                                      // Login-specific elements
                                      if (isLogin) ...[
                                        const SizedBox(height: 15),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.end,
                                          children: [
                                            TextButton(
                                              onPressed: () {},
                                              style: TextButton.styleFrom(
                                                foregroundColor: isMobile
                                                    ? Colors.white
                                                    : primaryColor,
                                                padding: EdgeInsets.zero,
                                              ),
                                              child: const Text(
                                                'Forgot Password?',
                                                style: TextStyle(
                                                  fontWeight: FontWeight.w600,
                                                  fontSize: 14,
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],

                                      const SizedBox(height: 30),
                                      Container(
                                        width: double.infinity,
                                        height: 55,
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(15),
                                          boxShadow: [
                                            BoxShadow(
                                              color:
                                                  primaryColor.withOpacity(0.3),
                                              spreadRadius: 1,
                                              blurRadius: 8,
                                              offset: const Offset(0, 4),
                                            ),
                                          ],
                                        ),
                                        child: ElevatedButton(
                                          onPressed: () {},
                                          style: ElevatedButton.styleFrom(
                                            backgroundColor: primaryColor,
                                            foregroundColor: Colors.white,
                                            elevation: 0,
                                            shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(15),
                                            ),
                                          ),
                                          child: Text(
                                            isLogin
                                                ? 'Sign In'
                                                : 'Create Account',
                                            style: const TextStyle(
                                              fontSize: 16,
                                              fontWeight: FontWeight.bold,
                                              letterSpacing: 1,
                                            ),
                                          ),
                                        ),
                                      ),

                                      const SizedBox(height: 25),
                                      if (isMobile)
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Text(
                                              isLogin
                                                  ? "Don't have an account?"
                                                  : "Already have an account?",
                                              style: TextStyle(
                                                color: isMobile
                                                    ? Colors.white70
                                                    : Colors.black54,
                                              ),
                                            ),
                                            TextButton(
                                              onPressed: () {
                                                cubit.toggleAuthMode();
                                              },
                                              style: TextButton.styleFrom(
                                                foregroundColor: isMobile
                                                    ? Colors.white
                                                    : primaryColor,
                                              ),
                                              child: Text(
                                                isLogin ? 'Sign Up' : 'Sign In',
                                                style: const TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),

                                      // Social login section (shown only on desktop)
                                      if (!isMobile && isLogin) ...[
                                        const SizedBox(height: 20),
                                        const Row(
                                          children: [
                                            Expanded(
                                              child: Divider(
                                                  color: Colors.black12),
                                            ),
                                            Padding(
                                              padding: EdgeInsets.symmetric(
                                                  horizontal: 16),
                                              child: Text(
                                                'Or continue with',
                                                style: TextStyle(
                                                    color: Colors.black54,
                                                    fontSize: 14),
                                              ),
                                            ),
                                            Expanded(
                                              child: Divider(
                                                  color: Colors.black12),
                                            ),
                                          ],
                                        ),
                                        const SizedBox(height: 25),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            _socialButton(
                                                Icons.facebook, Colors.blue),
                                            const SizedBox(width: 15),
                                            _socialButton(
                                                Icons.g_mobiledata_rounded,
                                                Colors.red),
                                            const SizedBox(width: 15),
                                            _socialButton(
                                                Icons.apple, Colors.black),
                                          ],
                                        ),
                                      ],
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          );
        },
      ),
    );
  }

  Widget _buildTextField(BuildContext context, String label, IconData icon,
      {bool isMobile = false}) {
    final cubit = context.read<AuthpageCubit>();
    final primaryColor = cubit.primaryColor;

    return TextFormField(
      decoration: InputDecoration(
        labelText: label,
        labelStyle: TextStyle(
          color: isMobile ? Colors.white70 : Colors.black54,
        ),
        hintStyle: TextStyle(
          color: isMobile ? Colors.white60 : Colors.black38,
        ),
        prefixIcon: Icon(
          icon,
          color: isMobile ? Colors.white70 : primaryColor,
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15),
          borderSide: BorderSide(
            color: isMobile ? Colors.white30 : Colors.grey.shade300,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15),
          borderSide: BorderSide(
            color: isMobile ? Colors.white : primaryColor,
            width: 2,
          ),
        ),
        filled: true,
        fillColor:
            isMobile ? Colors.white.withOpacity(0.1) : Colors.grey.shade50,
      ),
      style: TextStyle(
        color: isMobile ? Colors.white : Colors.black,
      ),
    );
  }

  Widget _socialButton(IconData icon, Color color) {
    return Container(
      width: 60,
      height: 60,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        border: Border.all(color: Colors.grey.shade200),
        color: Colors.white,
      ),
      child: Icon(
        icon,
        color: color,
        size: 30,
      ),
    );
  }
}
