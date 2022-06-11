import 'dart:io';

import 'package:effigy/api/firebase_api.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:path/path.dart';

import '../../providers/google_sign_in_provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  File? file;

  @override
  Widget build(BuildContext context) {
    /// [ FirebaseAuth.instance.currentUser ] to get the current user.
    final user = FirebaseAuth.instance.currentUser!;

    /// [fileName] to get the file name.
    final fileName =
        file != null ? basename(file?.path ?? '') : "No file selected";

    return Scaffold(
      appBar: AppBar(
        title: const Text('Home Page'),
        centerTitle: true,
        actions: [
          TextButton(
            onPressed: () {
              final provider =
                  Provider.of<GoogleSignInProvider>(context, listen: false);

              provider.googleLogout();
            },
            child: const Text(
              "Logout",
              style: TextStyle(
                color: Colors.white,
              ),
            ),
          ),
        ],
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(
            child: Text(
              'Welcome\n${user.displayName!}',
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          const SizedBox(height: 20),
          CircleAvatar(
            radius: 50,
            backgroundImage: NetworkImage(
              user.photoURL!,
            ),
          ),
          const SizedBox(height: 20),
          Text(
            'Email: ${user.email!}',
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w500,
            ),
          ),
          const SizedBox(height: 20),
          ElevatedButton.icon(
            onPressed: selectFile,
            icon: const Icon(Icons.attach_file),
            label: const Text("Select File"),
          ),
          const SizedBox(height: 20),
          Text(
            'File Name: $fileName',
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w500,
            ),
          ),
          ElevatedButton.icon(
            onPressed: uploadFile,
            icon: const Icon(Icons.upload_file),
            label: const Text("Upload File"),
          ),
        ],
      ),
    );
  }

  Future selectFile() async {
    debugPrint("Selecting file");
    final result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['jpg', 'png'],
      allowMultiple: false,
    );

    if (result == null) {
      return;
    }

    final path = result.files.single.path!;

    setState(() {
      file = File(path);
    });
    debugPrint("File selected");
  }

  Future uploadFile() async {
    debugPrint("Uploading file");
    if (file == null) {
      return;
    }
    final fileName = basename(file?.path ?? '');
    final destination = 'files/images/$fileName';

    FirebaseApi.uploadFile(file!, destination);

    debugPrint("File uploaded");
  }
}
