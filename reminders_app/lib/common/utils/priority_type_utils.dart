import '../enums/priority_type.dart';

String priorityTypeUtil(PriorityType type) {
  switch(type) {
    case PriorityType.LOW:
      return 'Low';
    case PriorityType.MEDIUM:
      return "Medium";
    case PriorityType.HIGH:
      return'High';
    default:
      return 'None';
  }
}