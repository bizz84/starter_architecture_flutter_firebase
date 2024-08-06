import 'package:flutter_starter_base_app/src/api/api.dart';
import 'package:flutter_starter_base_app/src/api/base_api.dart';
import 'package:flutter_starter_base_app/src/api/mock_api.dart';
import 'package:flutter_starter_base_app/src/constants/env_constants.dart';

/// selects the appropriate API
class APIFacade {
  Future<BaseAPI> getApi() async {
    if (EnvValues.env == EnvValues.developmentEnv) {
      return APIMock();
    } else {
      return API();
    }
  }
}
