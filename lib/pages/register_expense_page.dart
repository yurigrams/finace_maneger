import 'package:finace_maneger/components/app_colors.dart';
import 'package:finace_maneger/components/custom_imput_register.dart';
import 'package:finace_maneger/pages/expense_page.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';
import '../components/base_page.dart';
import '../components/custom_button.dart';
import '../service/firestore_service.dart';

class RegisterExpensePage extends StatefulWidget {
  final String? documentId;

  RegisterExpensePage({this.documentId});

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

  final FirestoreService firestoreService = FirestoreService();
  final NumberFormat _currencyFormat = NumberFormat.currency(locale: 'pt_BR', symbol: 'R\$');

  @override
  void initState() {
    super.initState();
    _expenseTypeController = TextEditingController();
    _amountController = TextEditingController();
    _categoryController = TextEditingController();
    _dateController = TextEditingController();
    _notesController = TextEditingController();

    if (widget.documentId != null) {
      _loadExpenseData(widget.documentId!);
    }
  }

  void _loadExpenseData(String expenseId) async {
    print(expenseId);
    try {
      DocumentSnapshot doc = await firestoreService.getExpenseById(expenseId);
      print(doc);
      if (doc.exists) {
        Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
        setState(() {
          _expenseTypeController.text = data['tipo'] ?? '';
          _amountController.text = _currencyFormat.format(data['valor'] ?? 0.0);
          _categoryController.text = data['categoria'] ?? '';
          _dateController.text = DateFormat('dd/MM/yyyy').format((data['data'] as Timestamp).toDate());
          _notesController.text = data['notas'] ?? '';
        });
      }
    } catch (e) {
      print('Erro ao carregar dados da despesa: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return BasePage(
      titles: widget.documentId == null ? 'Registrar Despesa' : 'Editar Despesa',
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
              CustomButton(
                titleButton: widget.documentId == null ? "Cadastrar" : "Salvar Alterações",
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    widget.documentId == null ? _createExpense() : _updateExpense();
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
      child: CustomInputRegister(
        labelText: label,
        controller: controller,
        obscure: false,
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
          filled: true,
          fillColor: AppColors.white,
          border: OutlineInputBorder(),
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
                  colorScheme: ColorScheme.light(primary: Colors.blue),
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

  void _createExpense() async {
    try {
      await firestoreService.postExpense(
        _expenseTypeController.text,
        double.tryParse(_amountController.text.replaceAll(RegExp(r'[^0-9]'), '')) ?? 0.0,
        _categoryController.text,
        Timestamp.now(),
        _notesController.text,
      );
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Despesa cadastrada com sucesso!')),
      );
      Navigator.push(context, MaterialPageRoute(builder: (context) => ExpensePage()));
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Erro ao cadastrar despesa: $e')),
      );
    }
  }

  void _updateExpense() async {
    try {
      await firestoreService.updateExpense(
        widget.documentId!,
        _expenseTypeController.text,
        double.tryParse(_amountController.text.replaceAll(RegExp(r'[^0-9]'), '')) ?? 0.0,
        _categoryController.text,
        Timestamp.now(),
        _notesController.text,
      );
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Despesa atualizada com sucesso!')),
      );
      Navigator.push(context, MaterialPageRoute(builder: (context) => ExpensePage()));
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Erro ao atualizar despesa: $e')),
      );
    }
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
