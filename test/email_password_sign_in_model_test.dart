import 'package:starter_architecture_flutter_firebase/app/sign_in/email_password/email_password_sign_in_model.dart';
import 'package:starter_architecture_flutter_firebase/services/mock_auth_service.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  MockAuthService mockAuthService;
  EmailPasswordSignInModel model;

  setUp(() {
    mockAuthService = MockAuthService();
    model = EmailPasswordSignInModel(auth: mockAuthService);
  });

  tearDown(() {
    model.dispose();
  });

  test('updateEmail', () async {
    const sampleEmail = 'email@email.com';
    var didNotifyListeners = false;
    model.addListener(() => didNotifyListeners = true);

    model.updateEmail(sampleEmail);
    expect(model.email, sampleEmail);
    expect(didNotifyListeners, true);
  });
}
