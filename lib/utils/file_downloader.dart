import 'dart:io';


class FileDownloader {

  final _client = HttpClient();

  Future<void> downloadFile(
    String fileName, {
    required String urlFile,
    void Function(List<int>)? onData,
    void Function()? onDone,
    void Function(dynamic e, dynamic s)? onError,
  }) async {
    try {

      final request = await _client.getUrl(Uri.parse(urlFile));
      final response = await request.close();
      response.listen(onData, onDone: onDone, onError: onError);
    } catch (e, s) {
      print(e);
      print(s);
    }
  }

  void close() {
    _client.close();
  }
}
