import 'package:azureb2cflutter/azureb2c_config.dart';
import 'package:azureb2cflutter/model/azure_token_response.dart';
import 'package:dio/dio.dart';

class AzureB2cClient {
  Future<AzureTokenResponse?> exchangeIdTokenForAccessToken(String code) async {
    Dio dio = Dio();

    try {
      Response response = await dio.post(
        AzureB2cConfig.tokenUrl,
        options: Options(
          headers: {
            'Content-Type': 'application/x-www-form-urlencoded',
          },
        ),
        data: {
          'grant_type': 'authorization_code',
          'client_id': AzureB2cConfig.clientId,
          'scope': AzureB2cConfig().scopesToString(AzureB2cConfig.scopes),
          'redirect_uri': AzureB2cConfig.redirectURL,
          'code': code,
        },
      );

      return AzureTokenResponse.fromJson(response.data);
    } catch (e) {
      throw ('Error: $e');
    }
  }
}
