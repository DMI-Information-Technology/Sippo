import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:sippo/core/header_api.dart';

class MyHttpClient {
  final http.Client _client;
  final String _authToken;
  final String baseUrl;

  MyHttpClient({
    required this.baseUrl,
    String authToken = "",
  })  : this._authToken = authToken,
        this._client = http.Client();

  Future<http.Response> get(
    String endpoint, {
    Map<String, dynamic>? queryParameter,
    String? resourceId,
    Map<String, String>? headers,
  }) async {
    try {
      final response = await _client.get(
        _buildUri(endpoint, resourceId: resourceId, parameters: queryParameter),
        headers: headers ?? _buildHeaders(),
      );

      return response;
    } catch (e, s) {
      FlutterError.reportError(FlutterErrorDetails(
        exception: e,
        stack: s,
        library: 'Flutter Custom Error',
        context: ErrorSummary('while running async test code'),
      ));
      throw e;
    }
  }

  Future<http.Response> post(
    String endpoint, {
    Map<String, dynamic>? data = const {},
    Map<String, dynamic>? queryParameter,
    String? resourceId,
  }) async {
    try {
      print("HttpClient.post: the body request before encode is = $data");
      final body = jsonEncode(data);
      print("HttpClient.post: the endpoint is = $baseUrl/$endpoint");
      print("HttpClient.post: the body request after encode is = $body");
      final response = await _client.post(
        _buildUri(endpoint, resourceId: resourceId, parameters: queryParameter),
        body: body,
        headers: _buildHeaders(),
      );
      return response;
    } catch (e, s) {
      FlutterError.reportError(FlutterErrorDetails(
        exception: e,
        stack: s,
        library: 'Flutter Custom Error',
        context: ErrorSummary('while running async test code'),
      ));
      throw e;
    }
  }

  Future<http.StreamedResponse> postMultipartRequest(
    String endpoint, {
    Map<String, String?>? fields,
    http.MultipartFile? multipartFile,
    Map<String, dynamic>? queryParameter,
    String? resourceId,
  }) async {
    try {
      final request = http.MultipartRequest(
          'POST', _buildUri(endpoint, resourceId: resourceId));
      request.headers.addAll(_buildHeaders(isMultipart: true));
      if (fields != null) {
        final data = <String, String>{};
        fields.forEach((k, v) => {if (v != null) data[k] = v});
        request.fields.addAll(data);
        print("HttpClient.postMultipartRequest: fields: $data");
      }

      if (multipartFile != null) request.files.add(multipartFile);
      print(
        "HttpClient.postMultipartRequest: multipart file: ${multipartFile?.contentType}",
      );

      print("HttpClient.postMultipartRequest: file is uploaded...");
      final response = await request.send();
      print("HttpClient.postMultipartRequest: upload file is done!");
      return response;
    } catch (e, s) {
      FlutterError.reportError(FlutterErrorDetails(
        exception: e,
        stack: s,
        library: 'Flutter Custom Error',
        context: ErrorSummary('while running async test code'),
      ));
      throw e;
    }
  }

  Future<http.StreamedResponse> postMultipartRequestFromList(
    String endpoint, {
    Map<String, String?>? fields,
    List<http.MultipartFile>? multipartFiles,
    Map<String, dynamic>? queryParameter,
    String? resourceId,
  }) async {
    try {
      final request = http.MultipartRequest(
        'POST',
        _buildUri(endpoint, resourceId: resourceId),
      );
      request.headers.addAll(_buildHeaders(isMultipart: true));
      if (fields != null) {
        final data = <String, String>{};
        fields.forEach((k, v) => {if (v != null) data[k] = v});
        request.fields.addAll(data);
        print("HttpClient.postMultipartRequest: fields: $data");
      }

      if (multipartFiles != null)
        for (final file in multipartFiles) {
          print(file.field);
          print(file.length);
          request.files.add(file);
        }
      print("HttpClient.postMultipartRequest: files is uploaded...");
      final response = await request.send();
      print("HttpClient.postMultipartRequest: upload files is done!");
      return response;
    } catch (e, s) {
      FlutterError.reportError(FlutterErrorDetails(
        exception: e,
        stack: s,
        library: 'Flutter Custom Error',
        context: ErrorSummary('while running async test code'),
      ));
      throw e;
    }
  }

  Future<http.StreamedResponse> putMultipartRequest(
    String endpoint, {
    Map<String, String?>? fields,
    http.MultipartFile? multipartFile,
    Map<String, dynamic>? queryParameter,
    String? resourceId,
  }) async {
    try {
      final request = http.MultipartRequest(
        'PUT',
        _buildUri(endpoint, resourceId: resourceId),
      );
      request.headers.addAll(_buildHeaders(isMultipart: true));
      if (fields != null) {
        final data = <String, String>{};
        fields.forEach((k, v) => {if (v != null) data[k] = v});
        request.fields.addAll(data);
        print("HttpClient.postMultipartRequest: fields: $data");
      }

      if (multipartFile != null) request.files.add(multipartFile);
      print(
        "HttpClient.postMultipartRequest: multipart file: ${multipartFile?.contentType}",
      );

      print("HttpClient.postMultipartRequest: file is uploaded...");
      final response = await request.send();
      print("HttpClient.postMultipartRequest: upload file is done!");
      return response;
    } catch (e, s) {
      FlutterError.reportError(FlutterErrorDetails(
        exception: e,
        stack: s,
        library: 'Flutter Custom Error',
        context: ErrorSummary('while running async test code'),
      ));
      throw e;
    }
  }

  Future<http.Response> put(
    String endpoint, {
    Map<String, dynamic>? data,
    Map<String, dynamic>? queryParameter,
    String? resourceId,
  }) async {
    try {
      print("HttpClient.put: the body request before encode is = $data");
      final body = jsonEncode(data);
      // print("HttpClient.put: the endpoint is = $baseUrl/$endpoint");
      print("HttpClient.put: the body request after encode is = $body");
      print('request starting...');
      final response = await _client.put(
        _buildUri(endpoint, resourceId: resourceId, parameters: queryParameter),
        body: body,
        headers: _buildHeaders(),
      );
      print('request end.');

      return response;
    } catch (e, s) {
      FlutterError.reportError(FlutterErrorDetails(
        exception: e,
        stack: s,
        library: 'Flutter Custom Error',
        context: ErrorSummary('while running async test code'),
      ));
      throw e;
    }
  }

  Future<http.Response> delete(
    String endpoint, {
    Map<String, dynamic>? queryParameter,
    Map<String, dynamic>? data,
    String? resourceId,
  }) async {
    String? body;
    if (!(data?.values.where((e) => e != null).length == 0))
      body = jsonEncode(data);
    final response = await _client.delete(
      _buildUri(endpoint, resourceId: resourceId, parameters: queryParameter),
      body: body,
      headers: _buildHeaders(),
    );
    return response;
  }

  Uri _buildUri(
    String endpoint, {
    String? resourceId,
    Map<String, dynamic>? parameters,
  }) {
    final url = [baseUrl, endpoint];
    if (resourceId != null && resourceId.trim().isNotEmpty) url.add(resourceId);
    if (parameters != null) {
      final query =
          parameters.keys.map((key) => "$key=${parameters[key]}").join("&");
      url.last = "${url.last}?$query";
    }
    print("HttpClient._buildUri: the endpoint is = ${url.join("/")}");
    return Uri.parse(url.join("/"));
  }

  Map<String, String> _buildHeaders({bool isMultipart = false}) {
    if (_authToken.trim().isNotEmpty) {
      print(
          "HttpClient._buildHeaders: secureHeader is built - the token is = $_authToken / is multipart ? $isMultipart");
      return isMultipart
          ? Header.secureMultipartHeader(_authToken)
          : Header.secureHeader(_authToken);
    }
    print("HttpClient._buildHeaders: auth token is empty.");
    print("HttpClient._buildHeaders: defaultHeader is built.");
    return !isMultipart ? Header.defaultHeader : Header.defaultMultipartHeader;
  }

  void close() {
    _client.close();
  }
}
