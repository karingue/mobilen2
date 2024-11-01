import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'wishlist_provider.dart';

class AddItemScreen extends StatelessWidget {
  final TextEditingController titleController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>(); // Chave para o formulário

  AddItemScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Add Item')),
      body: Padding(
        padding: EdgeInsets.all(MediaQuery.of(context).size.width * 0.05), // Padding responsivo
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch, // Estica os filhos para a largura máxima
            children: [
              TextFormField(
                controller: titleController,
                decoration: const InputDecoration(labelText: 'Title'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor, insira um título.';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 20),
              TextFormField(
                controller: descriptionController,
                decoration: const InputDecoration(labelText: 'Description'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor, insira uma descrição.';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    final title = titleController.text;
                    final description = descriptionController.text;
                    Provider.of<WishlistProvider>(context, listen: false)
                        .addItem(title, description)
                        .then((_) {
                          // Exibe um aviso de sucesso
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(content: Text('Item adicionado com sucesso!')),
                          );
                          Navigator.pop(context);
                        }).catchError((error) {
                          // Exibe um aviso de erro
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text('Erro ao adicionar o item: $error')),
                          );
                        });
                  }
                },
                child: const Text('Add Item'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
