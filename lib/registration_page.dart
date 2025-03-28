import 'package:flutter/material.dart';

class RegistrationPage extends StatefulWidget {
  @override
  _RegistrationPageState createState() => _RegistrationPageState();
}

class _RegistrationPageState extends State<RegistrationPage> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  
  bool _isPasswordVisible = false;
  bool _isConfirmPasswordVisible = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Регистрация"),
        centerTitle: true,
        backgroundColor: Colors.blue.shade900,
      ),
      body: Container(
        padding: EdgeInsets.all(20),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.blue.shade900, Colors.purpleAccent.shade700],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Center(
          child: SingleChildScrollView(
            child: Center(
              child: Form(
                key: _formKey,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    ConstrainedBox(
                      constraints: BoxConstraints(maxWidth: 400),
                      child: Column(
                        children: [
                          _buildTextField("Имя", Icons.person, _nameController, "Введите имя (минимум 2 буквы)", minLength: 2),
                          SizedBox(height: 15),
                          _buildTextField("Email", Icons.email, _emailController, "Введите корректный email", isEmail: true),
                          SizedBox(height: 15),
                          _buildPasswordField("Пароль", _passwordController, _isPasswordVisible, () {
                            setState(() => _isPasswordVisible = !_isPasswordVisible);
                          }),
                          SizedBox(height: 15),
                          _buildPasswordField("Подтвердите пароль", _confirmPasswordController, _isConfirmPasswordVisible, () {
                            setState(() => _isConfirmPasswordVisible = !_isConfirmPasswordVisible);
                          }),
                          SizedBox(height: 15),
                          _buildTextField("Телефон", Icons.phone, _phoneController, "Введите номер телефона (10-12 цифр)", isPhone: true),
                          SizedBox(height: 20),
                          ElevatedButton(
                            onPressed: () {
                              if (_formKey.currentState!.validate()) {
                                print("Регистрация успешна: ${_emailController.text}");
                              }
                            },
                            child: Text("Зарегистрироваться"),
                          ),
                        ],
                      ),
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

  Widget _buildTextField(String label, IconData icon, TextEditingController controller, String errorText, {bool isEmail = false, bool isPhone = false, int minLength = 1}) {
    return TextFormField(
      controller: controller,
      style: TextStyle(color: Colors.white),
      keyboardType: isPhone ? TextInputType.phone : (isEmail ? TextInputType.emailAddress : TextInputType.text),
      decoration: InputDecoration(
        labelText: label,
        prefixIcon: Icon(icon, color: Colors.white),
        border: OutlineInputBorder(),
      ),
      validator: (value) {
        if (value == null || value.isEmpty) return errorText;
        if (value.length < minLength) return "Минимальная длина: $minLength";
        if (isEmail && !value.contains("@")) return "Неверный Email";
        if (isPhone && !RegExp(r'^[0-9]{10,12}\$').hasMatch(value)) return "Введите корректный номер (10-12 цифр)";
        return null;
      },
    );
  }

  Widget _buildPasswordField(String label, TextEditingController controller, bool isVisible, VoidCallback toggleVisibility) {
    return TextFormField(
      controller: controller,
      obscureText: !isVisible,
      style: TextStyle(color: Colors.white),
      decoration: InputDecoration(
        labelText: label,
        prefixIcon: Icon(Icons.lock, color: Colors.white),
        suffixIcon: IconButton(
          icon: Icon(
            isVisible ? Icons.visibility : Icons.visibility_off,
            color: Colors.white,
          ),
          onPressed: toggleVisibility,
        ),
        border: OutlineInputBorder(),
      ),
      validator: (value) {
        if (value == null || value.length < 6) return "Пароль должен быть от 6 символов";
        if (label == "Подтвердите пароль" && value != _passwordController.text) return "Пароли не совпадают";
        return null;
      },
    );
  }
}
