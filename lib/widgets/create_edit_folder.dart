import 'package:flutter/material.dart';
import 'package:vaultify_app/database/folder_db.dart';
import 'package:vaultify_app/model/folder.dart';

class CreateEditFolderWidget extends StatefulWidget {
  final Folder? folder;
  final int userId;

  const CreateEditFolderWidget({
    super.key,
    this.folder,
    required this.userId,
  });

  @override
  State<CreateEditFolderWidget> createState() => _CreateEditFolderWidgetState();
}

class _CreateEditFolderWidgetState extends State<CreateEditFolderWidget> {
  final nameController = TextEditingController();
  final formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    nameController.text = widget.folder?.name ?? '';
  }

  @override
  Widget build(BuildContext context) {
    final isEditing = widget.folder != null;
    return Center(
      child: AlertDialog(
        title: Text(isEditing ? 'Edit Folder' : 'Tambah Folder'),
        content: Form(
          key: formKey,
          child: TextFormField(
            autofocus: true,
            controller: nameController,
            decoration: const InputDecoration(hintText: 'Nama'),
            validator: (value) =>
                value != null && value.isEmpty ? 'Nama wajib diisi' : null,
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              if (formKey.currentState!.validate()) {
                if (isEditing) {
                  FolderDB()
                      .updateFolder(nameController.text, widget.folder?.id)
                      .whenComplete(() {
                    Navigator.of(context).pop(true);
                  });
                } else {
                  FolderDB()
                      .create(
                    Folder(
                      name: nameController.text,
                      createdAt: DateTime.now().toIso8601String(),
                      userId: widget.userId,
                    ),
                  )
                      .whenComplete(() {
                    Navigator.of(context).pop(true);
                  });
                }
              }
            },
            child: const Text('OK'),
          ),
        ],
      ),
    );
  }
}
