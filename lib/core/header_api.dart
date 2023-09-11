class Header {
  // SECURE HEADER
  static Map<String, String> secureHeader(String? token) => {
        "Authorization": "Bearer $token",
        'Accept': 'application/json',
        'Content-Type': 'application/json',
      };

  // DEFAULT HEADER
  static const Map<String, String> defaultHeader = {
    'Accept': 'application/json',
    'Content-Type': 'application/json',
  };

  // DEFAULT MULTIPART-HEADER
  static const Map<String, String> defaultMultipartHeader = {
    'Accept': 'application/json',
    'Content-Type': 'multipart/form-data',
  };

  // SECURE MULTIPART HEADER
  static Map<String, String> secureMultipartHeader(String? token)=> {
    "Authorization": "Bearer $token",
    'Accept': 'application/json',
    'Content-Type': 'multipart/form-data',
  };
}
