import 'package:finace_maneger/components/app_colors.dart';
import 'package:finace_maneger/components/base_page.dart';
import 'package:finace_maneger/components/base_page_logout.dart';
import 'package:finace_maneger/service/auth_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class UserRegistrationPage extends StatefulWidget {
  @override
  _UserRegistrationPageState createState() => _UserRegistrationPageState();
}

class _UserRegistrationPageState extends State<UserRegistrationPage> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _cpfController = TextEditingController();
  final TextEditingController _birthDateController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController = TextEditingController();

  final FireAuthService _authService = FireAuthService();

  @override
  Widget build(BuildContext context) {
    return BasePageLogout(
      titles: "Cadastro de Usuário",
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              _buildTextField("Nome", _nameController, TextInputType.name),
              _buildTextField("Email", _emailController, TextInputType.emailAddress),
              _buildDateField("Data de Nascimento", _birthDateController),
              _buildTextField("CPF", _cpfController, TextInputType.number, formatter: _cpfFormatter),
              _buildTextField("Senha", _passwordController, TextInputType.visiblePassword, obscureText: true),
              _buildTextField("Confirmação de Senha", _confirmPasswordController, TextInputType.visiblePassword, obscureText: true),
              const SizedBox(height: 20),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primarygroundColor,
                  padding: const EdgeInsets.symmetric(vertical: 16.0),
                ),
                onPressed: _registerUser,
                child: Text("Cadastrar"),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _registerUser() async {
    if (_formKey.currentState!.validate()) {
      final name = _nameController.text;
      final email = _emailController.text;
      final cpf = _cpfController.text;
      final birthDate = _birthDateController.text;
      final password = _passwordController.text;

      final user = await _authService.register(email, password, name, cpf, birthDate);

      if (user != null) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Cadastro realizado com sucesso!')),
        );
        Navigator.pop(context); // Voltar para a tela anterior após o cadastro
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Erro ao realizar o cadastro. Tente novamente.')),
        );
      }
    }
  }

  Widget _buildDateField(String label, TextEditingController controller) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: TextFormField(
        style: TextStyle(color: AppColors.black),
        controller: controller,
        readOnly: true,
        decoration: InputDecoration(
          labelText: label,
          filled: true,
          fillColor: AppColors.white,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide.none,
          ),
          suffixIcon: IconButton(
            icon: Icon(Icons.calendar_today, color: Colors.grey[700]),
            onPressed: () => _selectDate(controller),
          ),
        ),
        validator: (value) {
          if (value == null || value.isEmpty) {
            return 'Por favor, insira $label';
          }
          if (!_isValidDate(value)) {
            return 'Data de nascimento inválida';
          }
          return null;
        },
      ),
    );
  }

  Future<void> _selectDate(TextEditingController controller) async {
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
    );
    if (pickedDate != null) {
      final formattedDate = "${pickedDate.day.toString().padLeft(2, '0')}/${pickedDate.month.toString().padLeft(2, '0')}/${pickedDate.year}";
      controller.text = formattedDate;
    }
  }

  Widget _buildTextField(
      String label,
      TextEditingController controller,
      TextInputType keyboardType, {
        bool obscureText = false,
        TextInputFormatter? formatter,
      }) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: TextFormField(
        style: TextStyle(color: AppColors.black),
        controller: controller,
        keyboardType: keyboardType,
        obscureText: obscureText,
        inputFormatters: formatter != null ? [formatter] : null,
        decoration: InputDecoration(
          labelText: label,
          filled: true,
          fillColor: AppColors.white,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide.none,
          ),
        ),
        validator: (value) {
          if (value == null || value.isEmpty) {
            return 'Por favor, insira $label';
          }
          if (label == "Email" && !_isValidEmail(value)) {
            return 'Insira um email válido';
          }
          if (label == "Confirmação de Senha" && value != _passwordController.text) {
            return 'As senhas não correspondem';
          }
          if (label == "CPF" && !_isValidCpf(value)) {
            return 'CPF inválido';
          }
          return null;
        },
      ),
    );
  }

  bool _isValidEmail(String value) {
    final emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
    return emailRegex.hasMatch(value);
  }

  bool _isValidCpf(String value) {
    final cpfRegex = RegExp(r'^\d{3}\.\d{3}\.\d{3}-\d{2}$');
    return cpfRegex.hasMatch(value);
  }

  bool _isValidDate(String value) {
    final dateRegex = RegExp(r'^\d{2}/\d{2}/\d{4}$');
    if (dateRegex.hasMatch(value)) {
      final parts = value.split('/');
      final day = int.tryParse(parts[0]);
      final month = int.tryParse(parts[1]);
      final year = int.tryParse(parts[2]);
      if (day != null && month != null && year != null) {
        return day > 0 && day <= 31 && month > 0 && month <= 12 && year > 1900 && year <= DateTime.now().year;
      }
    }
    return false;
  }

  final _cpfFormatter = TextInputFormatter.withFunction((oldValue, newValue) {
    var text = newValue.text.replaceAll(RegExp(r'[^0-9]'), '');
    if (text.length > 11) text = text.substring(0, 11);
    final buffer = StringBuffer();
    for (int i = 0; i < text.length; i++) {
      if (i == 3 || i == 6) buffer.write('.');
      if (i == 9) buffer.write('-');
      buffer.write(text[i]);
    }
    return TextEditingValue(
      text: buffer.toString(),
      selection: TextSelection.collapsed(offset: buffer.length),
    );
  });

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _cpfController.dispose();
    _birthDateController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }
}
