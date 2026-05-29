import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'dart:ui';
import '../view_models/auth_view_model.dart';
import '../../../core/theme/miki_design_system.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _isRegistering = false;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _submit(AuthViewModel authViewModel) {
    final email = _emailController.text.trim();
    final password = _passwordController.text;
    if (email.isEmpty || password.isEmpty) return;

    if (_isRegistering) {
      authViewModel.createUserWithEmailAndPassword(email, password);
    } else {
      authViewModel.signInWithEmailAndPassword(email, password);
    }
  }

  @override
  Widget build(BuildContext context) {
    final authViewModel = context.watch<AuthViewModel>();

    return Scaffold(
      backgroundColor: MikiColors.background,
      body: Stack(
        children: [
          // Background blobs
          Positioned(
            top: -100,
            left: -100,
            child: Container(
              width: 300,
              height: 300,
              decoration: const BoxDecoration(
                color: MikiColors.lavender,
                shape: BoxShape.circle,
              ),
            ),
          ),
          Positioned(
            bottom: -50,
            right: -50,
            child: Container(
              width: 250,
              height: 250,
              decoration: const BoxDecoration(
                color: MikiColors.iceBlue,
                shape: BoxShape.circle,
              ),
            ),
          ),
          // Blur effect
          BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 50.0, sigmaY: 50.0),
            child: Container(color: Colors.transparent),
          ),
          // Content
          Center(
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 24.0),
              child: Container(
                padding: const EdgeInsets.all(32.0),
                decoration: MikiDecorations.glassMorphism(),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      _isRegistering ? 'Criar Conta' : 'Bem-vindo',
                      style: MikiTextStyles.headlineLg(),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      _isRegistering 
                        ? 'Junte-se ao FonoKit'
                        : 'Acesse para continuar',
                      style: MikiTextStyles.bodyMd(),
                    ),
                    const SizedBox(height: 32),
                    
                    if (authViewModel.errorMessage != null) ...[
                      Text(
                        authViewModel.errorMessage!,
                        style: MikiTextStyles.labelMd(color: Colors.redAccent),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 16),
                    ],

                    TextField(
                      controller: _emailController,
                      decoration: InputDecoration(
                        hintText: 'E-mail',
                        hintStyle: MikiTextStyles.bodyMd(color: MikiColors.outline),
                        filled: true,
                        fillColor: Colors.white.withOpacity(0.5),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: BorderSide.none,
                        ),
                      ),
                      keyboardType: TextInputType.emailAddress,
                    ),
                    const SizedBox(height: 16),
                    TextField(
                      controller: _passwordController,
                      decoration: InputDecoration(
                        hintText: 'Senha',
                        hintStyle: MikiTextStyles.bodyMd(color: MikiColors.outline),
                        filled: true,
                        fillColor: Colors.white.withOpacity(0.5),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: BorderSide.none,
                        ),
                      ),
                      obscureText: true,
                    ),
                    const SizedBox(height: 24),

                    if (authViewModel.isLoading)
                      const CircularProgressIndicator(color: MikiColors.primary)
                    else ...[
                      SizedBox(
                        width: double.infinity,
                        height: 50,
                        child: ElevatedButton(
                          onPressed: () => _submit(authViewModel),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: MikiColors.primary,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                          ),
                          child: Text(
                            _isRegistering ? 'Cadastrar' : 'Entrar',
                            style: MikiTextStyles.labelMd(color: Colors.white),
                          ),
                        ),
                      ),
                      const SizedBox(height: 16),
                      // Google Sign In Button
                      SizedBox(
                        width: double.infinity,
                        height: 50,
                        child: OutlinedButton.icon(
                          onPressed: () => authViewModel.signInWithGoogle(),
                          icon: const Icon(Icons.g_mobiledata, size: 24, color: MikiColors.text),
                          label: Text(
                            'Entrar com Google',
                            style: MikiTextStyles.labelMd(),
                          ),
                          style: OutlinedButton.styleFrom(
                            backgroundColor: Colors.white,
                            side: const BorderSide(color: MikiColors.outlineVariant),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 16),
                      TextButton(
                        onPressed: () {
                          setState(() {
                            _isRegistering = !_isRegistering;
                            authViewModel.clearError();
                          });
                        },
                        child: Text(
                          _isRegistering
                              ? 'Já tem uma conta? Entre'
                              : 'Não tem conta? Cadastre-se',
                          style: MikiTextStyles.labelMd(color: MikiColors.primary),
                        ),
                      ),
                    ],
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
