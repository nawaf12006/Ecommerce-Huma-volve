import 'package:ecommerce_app_huma_volve/core/enums/request_status_enum.dart';
import 'package:ecommerce_app_huma_volve/core/theme.dart';
import 'package:ecommerce_app_huma_volve/core/widgets/app_toastification.dart';
import 'package:ecommerce_app_huma_volve/core/widgets/custom_text_field.dart';
import 'package:ecommerce_app_huma_volve/core/widgets/primary_button.dart';
import 'package:ecommerce_app_huma_volve/features/auth/cubit/auth_cubit.dart';
import 'package:ecommerce_app_huma_volve/features/auth/services/auth_services.dart';
import 'package:ecommerce_app_huma_volve/features/auth/sign_up/screens/sign_up_screen.dart';
import 'package:ecommerce_app_huma_volve/features/main_navigation/screens/main_navigation_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:toastification/toastification.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  late final TextEditingController emailController;
  late final TextEditingController passwordController;

  @override
  void initState() {
    emailController = TextEditingController();
    passwordController = TextEditingController();

    super.initState();
  }

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AuthCubit(AuthServices()),
      child: BlocListener<AuthCubit, AuthState>(
        listener: (context, state) {
          if (state.status == RequestStatusEnum.loaded) {
            if (!context.mounted) return;

            Navigator.push(
              context,
              PageRouteBuilder(
                transitionDuration: const Duration(milliseconds: 500),
                pageBuilder: (context, animation, secondaryAnimation) =>
                    const MainNavigationScreen(),
                transitionsBuilder:
                    (context, animation, secondaryAnimation, child) {
                      return FadeTransition(opacity: animation, child: child);
                    },
              ),
            );
            AppToastification.coustomToastificationWidget(
              title: 'Login Successful',
              description: 'Welcome back! You have logged in successfully',
              type: ToastificationType.success,
            );
          }
        },
        child: Scaffold(
          backgroundColor: AppTheme.background,
          body: SafeArea(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(32.0),
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    const SizedBox(height: 60),
                    Icon(Icons.shopping_bag, size: 80, color: AppTheme.primary),
                    const SizedBox(height: 32),
                    Text(
                      'Welcome Back!',
                      style: Theme.of(context).textTheme.displayLarge
                          ?.copyWith(fontSize: 32),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'Login to continue your shopping',
                      style: Theme.of(context).textTheme.bodyMedium
                          ?.copyWith(fontSize: 16),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 64),
                    CustomTextField(
                      controller: emailController,
                      hintText: 'Email Address',
                      prefixIcon: Icons.email_outlined,
                      keyboardType: TextInputType.emailAddress,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter your email';
                        }
                        if (!value.contains('@')) {
                          return 'Please enter a valid email';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 20),
                    CustomTextField(
                      controller: passwordController,
                      keyboardType: TextInputType.visiblePassword,
                      hintText: 'Password',
                      prefixIcon: Icons.lock_outline,
                      isPassword: true,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter your password';
                        }
                        if (value.length < 6) {
                          return 'Password must be at least 6 characters';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 16),
                    Align(
                      alignment: Alignment.centerRight,
                      child: Text(
                        'Forgot Password?',
                        style: TextStyle(
                          color: AppTheme.primary,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                    const SizedBox(height: 32),
                    BlocBuilder<AuthCubit, AuthState>(
                      builder: (context, state) {
                        return PrimaryButton(
                          text: 'Login',
                          status: state.status,
                          onPressed: () async {
                            if (state.status == RequestStatusEnum.loading) {
                              return;
                            }

                            if (_formKey.currentState?.validate() ?? false) {
                              context.read<AuthCubit>().login(
                                email: emailController.text.trim(),
                                password: passwordController.text.trim(),
                              );
                            }
                          },
                        );
                      },
                    ),
                    const SizedBox(height: 24),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text('Don\'t have an account? '),
                        GestureDetector(
                          onTap: () {
                            Navigator.pushReplacement(
                              context,
                              PageRouteBuilder(
                                pageBuilder: (
                                  context,
                                  animation,
                                  secondaryAnimation,
                                ) => const SignUpScreen(),
                                transitionsBuilder:
                                    (
                                      context,
                                      animation,
                                      secondaryAnimation,
                                      child,
                                    ) {
                                      return FadeTransition(
                                        opacity: animation,
                                        child: child,
                                      );
                                    },
                              ),
                            );
                          },
                          child: Text(
                            'Sign Up',
                            style: TextStyle(
                              color: AppTheme.primary,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
