import 'dart:io';

import 'package:effigy/api/firebase_api.dart';
import 'package:effigy/screens/home/widgets/custom_avatar.dart';

import 'package:file_picker/file_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:path/path.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  UploadTask? task;
  File? file;

  @override
  Widget build(BuildContext context) {
    /// [ FirebaseAuth.instance.currentUser ] to get the current user.
    final user = FirebaseAuth.instance.currentUser!;

    /// [fileName] to get the file name.
    final fileName =
        file != null ? basename(file?.path ?? '') : "No file selected";

    return Scaffold(
      body: SafeArea(
        child: Container(
          color: Colors.black,
          child: Column(
            children: [
              CustomAvatar(user: user),
              const SizedBox(height: 20),
              Text(
                'Email: ${user.email!}',
                style: const TextStyle(
                  fontSize: 18,
                  color: Colors.white,
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
                  color: Colors.white,
                  fontWeight: FontWeight.w500,
                ),
              ),
              ElevatedButton.icon(
                onPressed: uploadFile,
                icon: const Icon(Icons.upload_file),
                label: const Text("Upload File"),
              ),
              const SizedBox(height: 10),
              task != null
                  ? buildUploadStatus(task!)
                  : Container(
                      color: Colors.red,
                    ),
            ],
          ),
        ),
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

    task = FirebaseApi.uploadFile(file!, destination);

    debugPrint("File uploaded");
  }

  Future fileDownload() async {
    debugPrint("Downloading file");
    if (task == null) {
      return;
    }

    final snapshot = await task!.whenComplete(() {});

    final urlDownload = await snapshot.ref.getDownloadURL();

    debugPrint("Donwload URL: $urlDownload");

    debugPrint("File downloaded");
  }

  buildUploadStatus(UploadTask task) => StreamBuilder<TaskSnapshot>(
        stream: task.snapshotEvents,
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Text("Error: ${snapshot.error}");
          }
          if (snapshot.hasData) {
            final event = snapshot.data!;
            final progress = event.bytesTransferred / event.totalBytes;

            return Text('Uploaded: ${(progress * 100).toStringAsFixed(2)}%');
          } else {
            return const Text("waiting for the upload");
          }
        },
      );
}
