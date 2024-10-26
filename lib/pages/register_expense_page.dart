import 'package:finace_maneger/components/base_page.dart';
import 'package:finace_maneger/components/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../components/app_colors.dart';

class RegisterExpensePage extends StatefulWidget {
  final Map<String, dynamic>? expenseData; // Dados da despesa para edição

  RegisterExpensePage({this.expenseData});

  @override
  _RegisterExpensePageState createState() => _RegisterExpensePageState();
}

class _RegisterExpensePageState extends State<RegisterExpensePage> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _expenseTypeController;
  late TextEditingController _amountController;
  late TextEditingController _categoryController;
  late TextEditingController _dateController;
  late TextEditingController _notesController;

  final NumberFormat _currencyFormat = NumberFormat.currency(locale: 'pt_BR', symbol: 'R\$');

  @override
  void initState() {
    super.initState();

    // Inicializar controladores com valores existentes, se houver
    _expenseTypeController = TextEditingController(text: widget.expenseData?['tipoDespesa'] ?? '');
    _amountController = TextEditingController(
      text: widget.expenseData?['valor'] != null
          ? _currencyFormat.format(widget.expenseData!['valor'])
          : '',
    );
    _categoryController = TextEditingController(text: widget.expenseData?['categoria'] ?? '');
    _dateController = TextEditingController(
      text: widget.expenseData?['data'] != null
          ? DateFormat('dd/MM/yyyy').format(widget.expenseData!['data'])
          : '',
    );
    _notesController = TextEditingController(text: widget.expenseData?['notas'] ?? '');
  }

  @override
  Widget build(BuildContext context) {
    return BasePage(titles: 'Registrar Despesa',
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              _buildTextField("Tipo da Despesa", _expenseTypeController),
              _buildTextField(
                "Valor",
                _amountController,
                keyboardType: TextInputType.number,
                onChanged: _formatAmount,
              ),
              _buildTextField("Categoria", _categoryController),
              _buildDateField("Data", _dateController),
              _buildTextField("Notas Adicionais", _notesController, maxLines: 3),
              const SizedBox(height: 20),
              CustomButton(titleButton: widget.expenseData != null ? "Atualizar" : "Cadastrar",
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    if (widget.expenseData != null) {
                      _updateExpense();
                    } else {
                      _createExpense();
                    }
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTextField(
      String label,
      TextEditingController controller, {
        TextInputType keyboardType = TextInputType.text,
        int maxLines = 1,
        void Function(String)? onChanged,
      }) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: TextFormField(
        controller: controller,
        keyboardType: keyboardType,
        maxLines: maxLines,
        onChanged: onChanged,
        style: TextStyle(color: Colors.grey[700]),
        decoration: InputDecoration(
          labelText: label,
          labelStyle: TextStyle(color: Colors.grey[700]),
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
          return null;
        },
      ),
    );
  }

  Widget _buildDateField(String label, TextEditingController controller) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: TextFormField(
        controller: controller,
        readOnly: true,
        style: TextStyle(color: Colors.grey[700]),
        decoration: InputDecoration(
          labelText: label,
          labelStyle: TextStyle(color: Colors.grey[700]),
          filled: true,
          fillColor: AppColors.white,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide.none,
          ),
          suffixIcon: Icon(Icons.calendar_today, color: Colors.grey[700]),
        ),
        onTap: () async {
          DateTime? pickedDate = await showDatePicker(
            context: context,
            initialDate: DateTime.now(),
            firstDate: DateTime(2000),
            lastDate: DateTime(2100),
            builder: (context, child) {
              return Theme(
                data: Theme.of(context).copyWith(
                  colorScheme: ColorScheme.light(
                    primary: AppColors.primarygroundColor,
                    onPrimary: AppColors.white,
                    onSurface: Colors.grey[700]!,
                  ),
                ),
                child: child!,
              );
            },
          );
          if (pickedDate != null) {
            String formattedDate = DateFormat('dd/MM/yyyy').format(pickedDate);
            setState(() {
              controller.text = formattedDate;
            });
          }
        },
        validator: (value) {
          if (value == null || value.isEmpty) {
            return 'Por favor, selecione a $label';
          }
          return null;
        },
      ),
    );
  }

  void _formatAmount(String value) {
    if (value.isEmpty) return;

    final parsedValue = double.tryParse(value.replaceAll(RegExp(r'[^0-9]'), '')) ?? 0.0;
    _amountController.value = TextEditingValue(
      text: _currencyFormat.format(parsedValue / 100),
      selection: TextSelection.collapsed(offset: _currencyFormat.format(parsedValue / 100).length),
    );
  }

  void _updateExpense() {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Despesa atualizada com sucesso!')),
    );
  }

  void _createExpense() {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Despesa cadastrada com sucesso!')),
    );
  }

  @override
  void dispose() {
    _expenseTypeController.dispose();
    _amountController.dispose();
    _categoryController.dispose();
    _dateController.dispose();
    _notesController.dispose();
    super.dispose();
  }
}
