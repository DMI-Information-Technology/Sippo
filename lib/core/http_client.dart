import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:jobspot/core/header_api.dart';

class HttpClient {
  final http.Client _client;
  final String _authToken;
  final String baseUrl;

  HttpClient({
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
    final response = await _client.get(
      _buildUri(endpoint, resourceId: resourceId, parameters: queryParameter),
      headers: headers ?? _buildHeaders(),
    );
    return response;
  }

  Future<http.Response> post(
    String endpoint, {
    Map<String, dynamic>? data,
    Map<String, dynamic>? queryParameter,
    String? resourceId,
  }) async {
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
  }

  Future<http.Response> put(
    String endpoint, {
    Map<String, dynamic>? data,
    Map<String, dynamic>? queryParameter,
    String? resourceId,
  }) async {
    print("HttpClient.put: the body request before encode is = $data");
    final body = jsonEncode(data);
    print("HttpClient.put: the endpoint is = $baseUrl/$endpoint");
    print("HttpClient.put: the body request after encode is = $body");
    final response = await _client.put(
      _buildUri(endpoint, resourceId: resourceId, parameters: queryParameter),
      body: body,
      headers: _buildHeaders(),
    );
    return response;
  }

  Future<http.Response> delete(
    String endpoint, {
    Map<String, dynamic>? queryParameter,
    String? resourceId,
  }) async {
    final response = await _client.delete(
      _buildUri(endpoint, resourceId: resourceId, parameters: queryParameter),
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

  Map<String, String> _buildHeaders() {
    if (_authToken.trim().isNotEmpty) {
      print(
          "HttpClient._buildHeaders: secureHeader is built - the token is = $_authToken.");
      return Header.secureHeader(_authToken);
    }
    print("HttpClient._buildHeaders: auth token is empty.");
    print("HttpClient._buildHeaders: defaultHeader is built.");
    return Header.defaultHeader;
  }
}
