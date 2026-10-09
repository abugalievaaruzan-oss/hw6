
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'User Registration',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.black,
        ),
        useMaterial3: true,
      ),
      home: const RegistrationScreen(),
    );
  }
}

class RegistrationScreen extends StatefulWidget {
  const RegistrationScreen({super.key});

  @override
  State<RegistrationScreen> createState() =>
      _RegistrationScreenState();
}

class _RegistrationScreenState
    extends State<RegistrationScreen> {
  final _formKey = GlobalKey<FormState>();

  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmController = TextEditingController();

  bool _acceptTerms = false;
  bool _showTermsError = false;
  bool _hidePassword = true;
  String _selectedRole = 'Student';

  void _register() {
    final isValid = _formKey.currentState!.validate();

    setState(() {
      _showTermsError = !_acceptTerms;
    });

    if (!isValid || !_acceptTerms) {
      return;
    }

    debugPrint('Registration successful!');
    debugPrint('Name: ${_nameController.text.trim()}');
    debugPrint('Email: ${_emailController.text.trim()}');
    debugPrint('Role: $_selectedRole');
    debugPrint('Password: Validated successfully');

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Registration Successful!'),
        backgroundColor: Colors.black,
        duration: Duration(seconds: 3),
      ),
    );
  }

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _confirmController.dispose();
    super.dispose();
  }

  InputDecoration fieldStyle(
    String label,
    IconData icon,
  ) {
    return InputDecoration(
      labelText: label,
      prefixIcon: Icon(icon, color: Colors.black),
      labelStyle: const TextStyle(
        color: Colors.black54,
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(
          color: Colors.black26,
        ),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(
          color: Colors.black,
          width: 1.5,
        ),
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(
          color: Colors.red,
        ),
      ),
      focusedErrorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(
          color: Colors.red,
          width: 1.5,
        ),
      ),
      contentPadding: const EdgeInsets.symmetric(
        horizontal: 16,
        vertical: 18,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F5F5),
      appBar: AppBar(
        title: const Text(
          'Create Account',
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.w600,
          ),
        ),
        centerTitle: true,
        backgroundColor: Colors.white,
      ),
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20),
          child: ConstrainedBox(
            constraints: const BoxConstraints(
              maxWidth: 450,
            ),
            child: Card(
              elevation: 2,
              color: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
              child: Padding(
                padding: const EdgeInsets.all(24),
                child: Form(
                  key: _formKey,
                  autovalidateMode:
                      AutovalidateMode.onUserInteraction,
                  child: Column(
                    crossAxisAlignment:
                        CrossAxisAlignment.stretch,
                    children: [
                      // Profile Icon
                      const Icon(
                        Icons.person_add_alt_1,
                        size: 65,
                        color: Colors.black,
                      ),

                      const SizedBox(height: 12),

                      // Title
                      const Text(
                        'Welcome!',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 26,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),

                      const SizedBox(height: 6),

                      const Text(
                        'Create your profile to get started',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Colors.black54,
                          fontSize: 14,
                        ),
                      ),

                      const SizedBox(height: 28),

                      // Full Name
                      TextFormField(
                        controller: _nameController,
                        textCapitalization:
                            TextCapitalization.words,
                        decoration: fieldStyle(
                          'Full Name',
                          Icons.person_outline,
                        ),
                        validator: (value) {
                          if (value == null ||
                              value.trim().isEmpty) {
                            return 'Please enter your full name';
                          }
                          return null;
                        },
                      ),

                      const SizedBox(height: 18),

                      // Email
                      TextFormField(
                        controller: _emailController,
                        keyboardType:
                            TextInputType.emailAddress,
                        decoration: fieldStyle(
                          'Email Address',
                          Icons.email_outlined,
                        ),
                        validator: (value) {
                          if (value == null ||
                              value.trim().isEmpty) {
                            return 'Email is required';
                          }

                          final email = value.trim();

                          if (!RegExp(
                            r'^[^\s@]+@[^\s@]+\.[^\s@]+$',
                          ).hasMatch(email)) {
                            return 'Please enter a valid email';
                          }

                          return null;
                        },
                      ),

                      const SizedBox(height: 18),

                      // Password
                      TextFormField(
                        controller: _passwordController,
                        obscureText: _hidePassword,
                        decoration: fieldStyle(
                          'Password',
                          Icons.lock_outline,
                        ).copyWith(
                          suffixIcon: IconButton(
                            icon: Icon(
                              _hidePassword
                                  ? Icons.visibility_off
                                  : Icons.visibility,
                              color: Colors.black,
                            ),
                            onPressed: () {
                              setState(() {
                                _hidePassword = !_hidePassword;
                              });
                            },
                          ),
                        ),
                        onChanged: (_) {
                          if (_confirmController.text.isNotEmpty) {
                            _formKey.currentState?.validate();
                          }
                        },
                        validator: (value) {
                          if (value == null ||
                              value.isEmpty) {
                            return 'Password is required';
                          }

                          if (value.length < 6) {
                            return 'Minimum 6 characters required';
                          }

                          return null;
                        },
                      ),

                      const SizedBox(height: 18),

                      // Confirm Password
                      TextFormField(
                        controller: _confirmController,
                        obscureText: true,
                        decoration: fieldStyle(
                          'Confirm Password',
                          Icons.lock_reset,
                        ),
                        validator: (value) {
                          if (value == null ||
                              value.isEmpty) {
                            return 'Please confirm your password';
                          }

                          if (value !=
                              _passwordController.text) {
                            return 'Passwords do not match';
                          }

                          return null;
                        },
                      ),

                      const SizedBox(height: 18),

                      // Role Dropdown
                      DropdownButtonFormField<String>(
                        initialValue: _selectedRole,
                        decoration: fieldStyle(
                          'Select Your Role',
                          Icons.school_outlined,
                        ),
                        items: [
                          'Student',
                          'Teacher',
                          'Developer',
                        ].map((role) {
                          return DropdownMenuItem<String>(
                            value: role,
                            child: Text(role),
                          );
                        }).toList(),
                        onChanged: (value) {
                          if (value != null) {
                            setState(() {
                              _selectedRole = value;
                            });
                          }
                        },
                      ),

                      const SizedBox(height: 14),

                      // Terms Checkbox
                      CheckboxListTile(
                        contentPadding: EdgeInsets.zero,
                        title: const Text(
                          'I accept the Terms and Conditions',
                          style: TextStyle(
                            fontSize: 14,
                            color: Colors.black,
                          ),
                        ),
                        value: _acceptTerms,
                        activeColor: Colors.black,
                        checkColor: Colors.white,
                        controlAffinity:
                            ListTileControlAffinity.leading,
                        onChanged: (value) {
                          setState(() {
                            _acceptTerms = value ?? false;
                            _showTermsError =
                                !_acceptTerms &&
                                _showTermsError;
                          });
                        },
                      ),

                      if (_showTermsError)
                        const Padding(
                          padding: EdgeInsets.only(
                            left: 12,
                            bottom: 12,
                          ),
                          child: Text(
                            'You must accept the Terms and Conditions',
                            style: TextStyle(
                              color: Colors.red,
                              fontSize: 12,
                            ),
                          ),
                        ),

                      const SizedBox(height: 15),

                      // Register Button
                      SizedBox(
                        height: 52,
                        child: ElevatedButton(
                          onPressed: _register,
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.black,
                            foregroundColor: Colors.white,
                            shape: RoundedRectangleBorder(
                              borderRadius:
                                  BorderRadius.circular(12),
                            ),
                          ),
                          child: const Text(
                            'REGISTER',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              letterSpacing: 1,
                            ),
                          ),
                        ),
                      ),

                      const SizedBox(height: 14),

                      const Text(
                        'Already have an account? Sign in',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Colors.black54,
                          fontSize: 13,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
