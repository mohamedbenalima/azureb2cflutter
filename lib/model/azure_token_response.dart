class AzureTokenResponse {
  String? accessToken;
  String? idToken;
  String? tokenType;
  int? notBefore;
  int? expiresIn;
  int? expiresOn;
  String? resource;
  int? idTokenExpiresIn;
  String? profileInfo;
  String? scope;

  AzureTokenResponse({
    this.accessToken,
    this.idToken,
    this.tokenType,
    this.notBefore,
    this.expiresIn,
    this.expiresOn,
    this.resource,
    this.idTokenExpiresIn,
    this.profileInfo,
    this.scope,
  });

  factory AzureTokenResponse.fromJson(Map<String, dynamic> json) {
    return AzureTokenResponse(
      accessToken: json['access_token'],
      idToken: json['id_token'],
      tokenType: json['token_type'],
      notBefore: json['not_before'],
      expiresIn: json['expires_in'],
      expiresOn: json['expires_on'],
      resource: json['resource'],
      idTokenExpiresIn: json['id_token_expires_in'],
      profileInfo: json['profile_info'],
      scope: json['scope'],
    );
  }
}
