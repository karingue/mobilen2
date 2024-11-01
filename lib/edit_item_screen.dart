import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'wishlist_provider.dart';
import 'wishlist_item.dart';

class EditItemScreen extends StatelessWidget {
  final WishlistItem item;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>(); // Chave para o formulário

  EditItemScreen({super.key, required this.item});

  @override
  Widget build(BuildContext context) {
    final TextEditingController titleController = TextEditingController(text: item.title);
    final TextEditingController descriptionController = TextEditingController(text: item.description);

    return Scaffold(
      appBar: AppBar(title: const Text('Edit Item')),
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
                        .updateItem(item.id, title, description)
                        .then((_) {
                          // Exibe um aviso de sucesso
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(content: Text('Item atualizado com sucesso!')),
                          );
                          Navigator.pop(context);
                        }).catchError((error) {
                          // Exibe um aviso de erro
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text('Erro ao atualizar o item: $error')),
                          );
                        });
                  }
                },
                child: const Text('Save Changes'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
