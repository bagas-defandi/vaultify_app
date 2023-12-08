import 'package:flutter/material.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:intl/intl.dart';
import 'package:vaultify_app/core/app_export.dart';
import 'package:vaultify_app/database/folder_db.dart';
import 'package:vaultify_app/model/folder.dart';
import 'package:vaultify_app/model/user.dart';
import 'package:vaultify_app/pages/login_page.dart';
import 'package:vaultify_app/widgets/create_edit_folder.dart';
import 'package:vaultify_app/widgets/custom_elevated_button.dart';

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
              const Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    'tes',
                    style: TextStyle(color: Colors.white),
                  ),
                ],
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
                              TextButton(
                                onPressed: () {},
                                child: const Icon(
                                  Icons.folder,
                                  color: Colors.white,
                                  size: 150,
                                ),
                              ),
                              ListTile(
                                contentPadding: const EdgeInsets.only(top: 130),
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
                                                  child: const Text('No'),
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
                                                  child: const Text('Yes'),
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

  /// Section Widget
  Widget _buildChooseFileButton(BuildContext context) {
    return CustomElevatedButton(
      height: 30.v,
      width: 95.h,
      text: "Choose File",
      margin: EdgeInsets.only(bottom: 1.v),
      buttonStyle: CustomButtonStyles.fillBlueGray,
      buttonTextStyle: theme.textTheme.bodySmall!,
    );
  }

  /// Section Widget
  Widget _buildOneRow(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(right: 1.h),
      padding: EdgeInsets.symmetric(
        horizontal: 9.h,
        vertical: 7.v,
      ),
      decoration: AppDecoration.outlinePrimary.copyWith(
        borderRadius: BorderRadiusStyle.roundedBorder5,
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildChooseFileButton(context),
          Padding(
            padding: EdgeInsets.only(
              left: 8.h,
              top: 7.v,
              bottom: 8.v,
            ),
            child: Text(
              "File Name",
              style: theme.textTheme.bodySmall,
            ),
          ),
        ],
      ),
    );
  }

  /// Section Widget
  Widget _buildUploadButton(BuildContext context) {
    return CustomElevatedButton(
      height: 29.v,
      width: 83.h,
      text: "Upload",
      buttonStyle: CustomButtonStyles.fillBlueGray,
      buttonTextStyle: theme.textTheme.bodySmall!,
    );
  }

  /// Section Widget
  Widget _buildThreeRow(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(right: 1.h),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          _buildUploadButton(context),
          Container(
            decoration: AppDecoration.fillBlueGray.copyWith(
              borderRadius: BorderRadiusStyle.roundedBorder5,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: EdgeInsets.only(
                    top: 5.v,
                    bottom: 7.v,
                  ),
                  child: Text(
                    "Search",
                    style: theme.textTheme.bodySmall,
                  ),
                ),
                CustomImageView(
                  imagePath: ImageConstant.imgGroup4,
                  height: 29.v,
                  width: 30.h,
                  margin: EdgeInsets.only(left: 6.h),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  /// Section Widget
  Widget _buildListOfFilesButton(BuildContext context) {
    return CustomElevatedButton(
      height: 43.v,
      text: "List of Files",
      buttonStyle: CustomButtonStyles.outlinePrimary,
      buttonTextStyle: theme.textTheme.bodyMedium!,
    );
  }

  /// Section Widget
  Widget _buildDelete(BuildContext context) {
    return CustomElevatedButton(
      width: 55.h,
      text: "Delete",
    );
  }

  /// Section Widget
  Widget _buildDelete1(BuildContext context) {
    return CustomElevatedButton(
      width: 55.h,
      text: "Delete",
    );
  }

  /// Section Widget
  Widget _buildDelete2(BuildContext context) {
    return CustomElevatedButton(
      width: 55.h,
      text: "Delete",
    );
  }

  /// Section Widget
  Widget _buildAndroidSmallColumn(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(right: 1.h),
      decoration: AppDecoration.outlinePrimary.copyWith(
        borderRadius: BorderRadiusStyle.roundedBorder5,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          _buildListOfFilesButton(context),
          SizedBox(height: 21.v),
          Padding(
            padding: EdgeInsets.only(
              left: 15.h,
              right: 12.h,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Daftar Belanja November",
                      style: theme.textTheme.bodySmall,
                    ),
                    SizedBox(height: 1.v),
                    Text(
                      "10/10/23",
                      textAlign: TextAlign.center,
                      style: CustomTextStyles.bodySmall10,
                    ),
                    SizedBox(height: 28.v),
                    Text(
                      "Latihan Coding",
                      style: theme.textTheme.bodySmall,
                    ),
                    Text(
                      "18/11/23",
                      textAlign: TextAlign.center,
                      style: CustomTextStyles.bodySmall10,
                    ),
                    SizedBox(height: 28.v),
                    Text(
                      "Tugas Mobile Deveploment",
                      style: theme.textTheme.bodySmall,
                    ),
                    SizedBox(height: 1.v),
                    Padding(
                      padding: EdgeInsets.only(left: 2.h),
                      child: Text(
                        "18/11/23",
                        textAlign: TextAlign.center,
                        style: CustomTextStyles.bodySmall10,
                      ),
                    ),
                  ],
                ),
                Padding(
                  padding: EdgeInsets.only(
                    top: 5.v,
                    bottom: 8.v,
                  ),
                  child: Column(
                    children: [
                      _buildDelete(context),
                      SizedBox(height: 34.v),
                      _buildDelete1(context),
                      SizedBox(height: 42.v),
                      _buildDelete2(context),
                    ],
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 54.v),
        ],
      ),
    );
  }
}
