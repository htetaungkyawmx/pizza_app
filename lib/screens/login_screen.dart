import 'package:flutter/material.dart';

import 'main_wrapper.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  String _phone = '';
  String _password = '';

  void _submit() {
    if (_formKey.currentState?.validate() ?? false) {
      _formKey.currentState?.save();
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) => MainWrapper()),
      );
    }
  }

  void _loginWithApple() {
    // TODO: Add Apple login logic here
    print("Login with Apple");
  }

  // void _loginWithFacebook() {
  //   // TODO: Add Facebook login logic here
  //   print("Login with Facebook");
  // }

  void _loginWithEmail() {
    // TODO: Add Email login screen or logic
    print("Login with Email");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: [
          Image.asset(
            'assets/images/login_bg.png',
            fit: BoxFit.cover,
          ),

          Container(
            color: Colors.black.withOpacity(0.5),
          ),

          Center(
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 32.0, vertical: 16.0),
              child: Form(
                key: _formKey,
                child: Column(
                  children: [
                    const Text(
                      'Welcome Back!',
                      style: TextStyle(
                        fontSize: 32,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 40),

                    TextFormField(
                      decoration: const InputDecoration(
                        labelText: 'Phone Number',
                        labelStyle: TextStyle(color: Colors.white),
                        enabledBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.white54),
                        ),
                        focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.white),
                        ),
                      ),
                      style: const TextStyle(color: Colors.white),
                      keyboardType: TextInputType.phone,
                      validator: (value) {
                        if (value == null || value.trim().isEmpty) {
                          return 'Phone number is required';
                        } else if (!RegExp(r'^\d{7,15}$').hasMatch(value.trim())) {
                          return 'Enter a valid phone number';
                        }
                        return null;
                      },
                      onSaved: (value) => _phone = value?.trim() ?? '',
                    ),
                    const SizedBox(height: 20),

                    TextFormField(
                      decoration: const InputDecoration(
                        labelText: 'Password',
                        labelStyle: TextStyle(color: Colors.white),
                        enabledBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.white54),
                        ),
                        focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.white),
                        ),
                      ),
                      style: const TextStyle(color: Colors.white),
                      obscureText: true,
                      validator: (value) => value != null && value.length >= 6
                          ? null
                          : 'Password must be at least 6 characters',
                      onSaved: (value) => _password = value ?? '',
                    ),
                    const SizedBox(height: 30),

                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: _submit,
                        style: ElevatedButton.styleFrom(
                          padding: const EdgeInsets.symmetric(vertical: 16),
                          backgroundColor: Colors.deepOrange,
                          elevation: 6,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30),
                          ),
                          textStyle: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        child: const Text('Login'),
                      ),
                    ),

                    const SizedBox(height: 30),

                    const Row(
                      children: [
                        Expanded(child: Divider(color: Colors.white54)),
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 12),
                          child: Text(
                            'OR',
                            style: TextStyle(color: Colors.white70),
                          ),
                        ),
                        Expanded(child: Divider(color: Colors.white54)),
                      ],
                    ),

                    const SizedBox(height: 20),

                    SocialLoginButton(
                      icon: Icons.apple,
                      text: "Sign in with Apple",
                      onTap: _loginWithApple,
                    ),
                    const SizedBox(height: 12),
                    SocialLoginButton(
                      icon: Icons.mail,
                      text: "Sign in with Email",
                      onTap: _loginWithEmail,
                    ),
                    // const SizedBox(height: 12),
                    // SocialLoginButton(
                    //   icon: Icons.facebook,
                    //   text: "Sign in with Facebook",
                    //   onTap: _loginWithFacebook,
                    //   color: Colors.blueAccent,
                    // ),
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

class SocialLoginButton extends StatelessWidget {
  final IconData icon;
  final String text;
  final VoidCallback onTap;
  final Color color;

  const SocialLoginButton({
    super.key,
    required this.icon,
    required this.text,
    required this.onTap,
    this.color = Colors.white24,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: OutlinedButton.icon(
        onPressed: onTap,
        icon: Icon(icon, color: Colors.white),
        label: Padding(
          padding: const EdgeInsets.symmetric(vertical: 12),
          child: Text(
            text,
            style: const TextStyle(color: Colors.white),
          ),
        ),
        style: OutlinedButton.styleFrom(
          side: BorderSide(color: Colors.white38),
          backgroundColor: color,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30),
          ),
        ),
      ),
    );
  }
}
