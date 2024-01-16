import 'dart:io';

import 'package:flutter/services.dart';

class Update {
  Future<void> downloadAndSaveFile(Function(double) onProgress) async {
    const url =
        'https://drive.google.com/uc?export=download&id=1O-3ReIHH0Jn39Id5esDJAunoxsuCdx0i';

    try {
      final httpClient = HttpClient();
      final request = await httpClient.getUrl(Uri.parse(url));
      final response = await request.close();

      if (response.statusCode == 200) {
        final contentLength = response.headers.contentLength;
        final documentsDirectory = await Directory.systemTemp.createTemp();
        final filePath = '${documentsDirectory.path}/listPerikopa.json';

        final file = File(filePath);
        final sink = file.openWrite();

        int received = 0;
        final List<int> buffer = Uint8List(1024);

        await for (List<int> chunk in response) {
          sink.add(chunk);
          received += chunk.length;

          final progress = received / contentLength;
          print(progress);
          onProgress(progress);
                }

        print("DOWNLOAD SUCCESSFUL");
        await sink.close();

        await displayFileContent(filePath);
      } else {
        throw Exception(
            'Failed to download file. Status Code: ${response.statusCode}');
      }
    } catch (e) {
      print('Error during file download: $e');
      throw Exception('Failed to download file. Error: $e');
    }
  }

  Future<void> moveToAssets() async {
    try {
      final documentsDirectory = await Directory.systemTemp.createTemp();
      final sourcePath = '${documentsDirectory.path}/listPerikopa.json';
      const destinationPath = 'assets/listPerikopa.json';

      final sourceFile = File(sourcePath);
      final destinationFile = File(destinationPath);

      await sourceFile.copy(destinationFile.path);
    } catch (e) {
      print('Error moving file to assets: $e');
      throw Exception('Failed to move file to assets. Error: $e');
    }
  }

  Future<void> displayFileContent(String filePath) async {
    try {
      final file = File(filePath);
      final content = await file.readAsString();
      print("File Content:\n$content");
    } catch (e) {
      print('Error reading file content: $e');
    }
  }
}
