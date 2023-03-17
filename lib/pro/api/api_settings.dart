class ApiSettings {
  static const String _baseUrl = 'http://demo-api.mr-dev.tech/api/';
  static const String users = '${_baseUrl}users';
  static const String register = '${_baseUrl}students/auth/register';
  static const String login = '${_baseUrl}students/auth/login';
  static const String logout = '${_baseUrl}students/auth/logout';
  static const String forgetPassword =
      '${_baseUrl}students/auth/forget-password';
  static const String resetPassword = '${_baseUrl}students/auth/reset-password';
  static const String images = '${_baseUrl}students/images/{id}';
}
