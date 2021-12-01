import 'package:flutter_test/flutter_test.dart';
import 'package:mocci/app/data/mixins/validation_mixins.dart';

void main() {
  group('Email Test', () {
    test('Empty email', () {
      expect(ValidationMixin().validateEmail(''), '*Required Field');
    });

    test('Email format', () {
      var wrongEmail = ValidationMixin().validateEmail('adva');
      expect(wrongEmail, 'Incorrect email');
    });

    test('Correct email Format', () {
      var correctEmail = ValidationMixin().validateEmail('abc@gmail.co');
      expect(correctEmail, null);
    });
  });
}
