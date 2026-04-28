import 'package:flutter/material.dart';

import '../services/auth_service.dart';
import '../utils/app_strings.dart';
import '../utils/validators.dart';
import '../widgets/app_text_field.dart';
import '../widgets/primary_button.dart';

class RegisterView extends StatefulWidget {
  const RegisterView({super.key});

  @override
  State<RegisterView> createState() => _RegisterViewState();
}

class _RegisterViewState extends State<RegisterView> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _obscurePassword = true;
  bool _isSubmitting = false;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  Future<void> _submit() async {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    setState(() {
      _isSubmitting = true;
    });

    try {
      await AuthService.controller.register(
        email: _emailController.text,
        password: _passwordController.text,
      );
      if (!mounted) {
        return;
      }
      Navigator.of(context).pop();
    } on Exception catch (error) {
      if (!mounted) {
        return;
      }
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(_errorMessage(error))),
      );
    } finally {
      if (mounted) {
        setState(() {
          _isSubmitting = false;
        });
      }
    }
  }

  String _errorMessage(Object error) {
    final message = error.toString();
    if (message.contains('email-already-in-use')) {
      return 'Email đã được sử dụng';
    }
    if (message.contains('weak-password')) {
      return 'Mật khẩu quá yếu, hãy nhập ít nhất 6 ký tự';
    }
    if (message.contains('invalid-email')) {
      return 'Email không hợp lệ';
    }
    if (message.contains('network-request-failed')) {
      return 'Kiểm tra kết nối mạng';
    }
    if (message.contains('operation-not-allowed')) {
      return 'Phương thức đăng nhập này chưa được bật trên Firebase';
    }
    return 'Đăng ký thất bại. Lỗi: $message';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text(AppStrings.registerTitle)),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const SizedBox(height: 24),
              Text(
                'Tạo tài khoản mới',
                style: Theme.of(context).textTheme.headlineSmall,
              ),
              const SizedBox(height: 32),
              AppTextField(
                controller: _emailController,
                labelText: 'Email',
                validator: Validators.validateEmail,
                keyboardType: TextInputType.emailAddress,
              ),
              const SizedBox(height: 16),
              AppTextField(
                controller: _passwordController,
                labelText: 'Mật khẩu',
                validator: Validators.validatePassword,
                obscureText: _obscurePassword,
                suffixIcon: Icon(
                  _obscurePassword ? Icons.visibility : Icons.visibility_off,
                ),
                onSuffixIconPressed: () {
                  setState(() {
                    _obscurePassword = !_obscurePassword;
                  });
                },
              ),
              const SizedBox(height: 24),
              PrimaryButton(
                label: 'Đăng ký',
                isLoading: _isSubmitting,
                onPressed: _submit,
              ),
            ],
          ),
        ),
      ),
    );
  }
}