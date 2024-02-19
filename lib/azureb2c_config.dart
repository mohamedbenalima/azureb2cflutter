class AzureB2cConfig {
  static const tenantName = '<tenant-name>';
  static const policyName = '<policy-name>';
  static const tenantBaseUrl = 'https://$tenantName.b2clogin.com';
  static const clientId = '<client_id>';
  static const redirectURL = '<redirect_url>';
  static const List<String> scopes = ['<scopes>'];

  static const String authorizationEndpoint =
      '$tenantBaseUrl/$tenantName.onmicrosoft.com/$policyName/oauth2/v2.0/authorize';
  static const String responseType = 'code';
  static const String tokenUrl =
      '$tenantBaseUrl/$tenantName.onmicrosoft.com/$policyName/oauth2/v2.0/token';

  String scopesToString(List<String> scopeList) {
    return scopeList.join(' ');
  }
}
