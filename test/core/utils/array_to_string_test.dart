import 'package:flutter_test/flutter_test.dart';
import 'package:my_books_ntt/core/utils/array_to_string.dart';

void main() {
  test('should return empty string if array is empty', () {
    // arrange

    // act
    final result = arrayToString([], '');

    // expect
    expect(result, '');
  });

  test('should return valid string if array is not empty', () {
    // arrange
    final array = ['Value 1', 'Value 2'];
    const seperator = ', ';

    // act
    final result = arrayToString(array, seperator);

    // expect
    expect(result, 'Value 1, Value 2');
  });
}
