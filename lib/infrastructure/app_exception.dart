/// Base class for all all client-side errors
sealed class AppException implements Exception {
  AppException(this.code, this.message);
  final String code;
  final String message;

  @override
  String toString() => message;
}

/// Group
class GroupNotFoundException extends AppException {
  GroupNotFoundException() : super('group-not-found', 'Group not found');
}

/// item
 class ItemNotFoundException extends AppException {
   ItemNotFoundException() : super('item-not-found', 'Item not found');
 }
