import 'package:file_saver/file_saver.dart';
import 'package:flutter/foundation.dart';
import 'package:trishaheed/repository/file_repo.dart';
import 'package:trishaheed/utilities/download_enums.dart';
import 'package:trishaheed/utilities/file_path_remover.dart';

class DownloadState with ChangeNotifier {
  List<String> selectedDownloads = <String>[];
  Downloads _selectedFolder = Downloads.routine;
  int totalPage = 1;
  int currentPage = 1;

  set selectedFolder(Downloads d) {
    _selectedFolder = d;
    // notifyListeners();
  }

  Downloads get selectedFolder => _selectedFolder;

  Future<void> getFiles() async {
    final downloadData = await FileRepo().listFiles(selectedFolder.name);
    if (downloadData != null) {
      final chunks = chunk(downloadData.files, 5);
      if (chunks.isNotEmpty) {
        int index = currentPage - 1;
        selectedDownloads = chunks.elementAt(index);
        totalPage = chunks.length;
      } else {
        selectedDownloads.clear();
      }
    }
  }

  Future<void> refreshFiles() async {
    print("Selected Folder:$selectedFolder");
    await getFiles();
    notifyListeners();
  }

  List<List<String>> chunk(List<String> array, int size) {
    List<List<String>> chunks = [];
    int i = 0;
    while (i < array.length) {
      int j = i + size;
      chunks.add(array.sublist(i, j > array.length ? array.length : j));
      i = j;
    }
    return chunks;
  }

  Future<void> downloadFile(String path) async {
    final file = await FileRepo().downloadFile(path);
    if (file != null) {
      final message =
          await FileSaver.instance.saveFile(name: removeDir(path), bytes: file);
      print("Message: $message");
    }
  }
}
