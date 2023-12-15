import 'package:flutter/material.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:vaultify_app/core/app_export.dart';
import 'package:vaultify_app/database/folder_db.dart';
import 'package:vaultify_app/model/folder.dart';
import 'package:vaultify_app/model/user.dart';
import 'package:vaultify_app/pages/file_page.dart';
import 'package:vaultify_app/pages/login_page.dart';
import 'package:vaultify_app/widgets/create_edit_folder.dart';

class DashboardPage extends StatefulWidget {
  final User? user;
  const DashboardPage({super.key, this.user});

  @override
  State<DashboardPage> createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  late Future<List<Folder>> folders;
  final folderDB = FolderDB();

  @override
  void initState() {
    folders = folderDB.fetchUserFolders(widget.user!.id ?? 0);
    super.initState();
  }

  Future<void> _refresh() async {
    setState(() {
      folders = folderDB.fetchUserFolders(widget.user!.id ?? 0);
    });
  }

  @override
  Widget build(BuildContext context) {
    mediaQueryData = MediaQuery.of(context);

    return Scaffold(
      floatingActionButton: SpeedDial(
        icon: Icons.add,
        backgroundColor: Colors.white,
        children: [
          SpeedDialChild(
              child: const Icon(Icons.add),
              shape: const CircleBorder(),
              label: 'Tambah Folder',
              onTap: () {
                showDialog(
                    context: context,
                    builder: (_) => CreateEditFolderWidget(
                          userId: widget.user!.id ?? 0,
                        )).then((value) {
                  if (value) {
                    _refresh();
                  }
                });
              }),
          SpeedDialChild(
            child: const Icon(Icons.file_copy_rounded),
            shape: const CircleBorder(),
            label: 'Tambah File',
          ),
        ],
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Column(
            children: [
              const SizedBox(height: 25),
              Image.asset('assets/images/vaultify_logo2.png'),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color.fromRGBO(241, 172, 70, 1),
                  padding: const EdgeInsets.symmetric(
                    horizontal: 40,
                    vertical: 30,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30.0),
                  ),
                ),
                child: const Text(
                  'Logout',
                  style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                onPressed: () => Navigator.pushReplacement(context,
                    MaterialPageRoute(builder: (context) => const LoginPage())),
              ),
              Expanded(
                child: FutureBuilder<List<Folder>>(
                  future: folders,
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const CircularProgressIndicator(
                          color: Colors.white);
                    } else if (snapshot.hasData && snapshot.data!.isEmpty) {
                      return const Center(
                        child: Text(
                          "No data",
                          style: TextStyle(color: Colors.white),
                        ),
                      );
                    } else if (snapshot.hasError) {
                      return Text(snapshot.error.toString());
                    } else {
                      final items = snapshot.data ?? <Folder>[];
                      return GridView.builder(
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                        ),
                        itemCount: items.length,
                        itemBuilder: (context, index) {
                          return Stack(
                            alignment: Alignment.center,
                            children: [
                              const Icon(
                                Icons.folder,
                                color: Colors.white,
                                size: 150,
                              ),
                              ListTile(
                                onTap: () async {
                                  Folder? currentFolder = await folderDB
                                      .getFolder(items[index].name);
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => FilePage(
                                        folder: currentFolder,
                                        userId: widget.user!.id ?? 0,
                                        folderName: items[index].name,
                                      ),
                                    ),
                                  );
                                },
                                contentPadding: const EdgeInsets.only(top: 140),
                                title: Padding(
                                  padding: const EdgeInsets.only(left: 25.0),
                                  child: Text(
                                    items[index].name,
                                    style: const TextStyle(color: Colors.white),
                                    // textAlign: TextAlign.end,
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                                trailing: PopupMenuButton(
                                  iconColor: Colors.white,
                                  itemBuilder: (context) => [
                                    PopupMenuItem(
                                      child: const Text("Ganti nama"),
                                      onTap: () {
                                        showDialog(
                                          context: context,
                                          builder: (_) =>
                                              CreateEditFolderWidget(
                                            userId: widget.user!.id ?? 0,
                                            folder: Folder(
                                              id: items[index].id,
                                              userId: widget.user!.id ?? 0,
                                              name: items[index].name,
                                            ),
                                          ),
                                        ).then((value) {
                                          if (value) {
                                            _refresh();
                                          }
                                        });
                                      },
                                    ),
                                    PopupMenuItem(
                                      child: const Text("Hapus"),
                                      onTap: () {
                                        showDialog(
                                          context: context,
                                          builder: (BuildContext context) {
                                            return AlertDialog(
                                              title: const Text('Konfirmasi'),
                                              content: Text(
                                                  'Apakah anda yakin ingin menghapus folder ${items[index].name}?'),
                                              actions: <Widget>[
                                                TextButton(
                                                  onPressed: () {
                                                    Navigator.of(context)
                                                        .pop(); // Dismiss the dialog
                                                  },
                                                  child: const Text(
                                                    'No',
                                                    style: TextStyle(
                                                      color: Colors.black,
                                                    ),
                                                  ),
                                                ),
                                                TextButton(
                                                  onPressed: () {
                                                    Navigator.of(context)
                                                        .pop(); // Dismiss the dialog
                                                    folderDB
                                                        .deleteFolder(
                                                            items[index].id!)
                                                        .whenComplete(() =>
                                                            _refresh()); // Perform deletion logic here
                                                  },
                                                  child: const Text(
                                                    'Yes',
                                                    style: TextStyle(
                                                      color: Colors.black,
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            );
                                          },
                                        );
                                      },
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          );
                        },
                      );
                    }
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
