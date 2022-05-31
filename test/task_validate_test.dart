import 'package:test/test.dart';
import 'package:to_do_manabie/util/validator/task_field_validator.dart';

void main() {
  group("task field validator", () {
    test("empty-0 task returns error string", () {
      String? result = TaskFieldValidator.validate(null);
      expect(result, 'Please enter your task');
    });

    test("empty-1 task returns error string", () {
      String? result = TaskFieldValidator.validate('');
      expect(result, 'Please enter your task');
    });

    test("empty-2 task returns error string", () {
      String? result = TaskFieldValidator.validate('  ');
      expect(result, 'Please enter your task');
    });

    test("none-empty task returns error string", () {
      String? result = TaskFieldValidator.validate('New task');
      expect(result, null);
    });
  });
}
