import 'package:flutter/material.dart';

class AIAssistantController with ChangeNotifier {
  var _isDiagnosisChecked = false;
  get isDiagnosisChecked => _isDiagnosisChecked;
  var _isClinicalPlanChecked = false;
  get isClinicalPlanChecked => _isClinicalPlanChecked;
  var _isPatientEduChecked = false;
  get isPatientEduChecked => _isPatientEduChecked;

  isCheckedPerform(value, action) {
    print(action);
    if (action == "diagnosis") {
      _isDiagnosisChecked = value;
    } else if (action == "clinicalPlan") {
      _isClinicalPlanChecked = value;
    } else if (action == "patientEducation") {
      _isPatientEduChecked = value;
    }

    notifyListeners();
  }
}
