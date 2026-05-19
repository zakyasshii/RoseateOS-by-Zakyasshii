import '../models/contact.dart';
import '../services/encrypted_hive_service.dart';

class ContactController {
  static const String contactBoxName = 'contacts_box';

  Future<void> addContact(Contact contact) async {
    final box =
        await EncryptedHiveService.openEncryptedBox<Contact>(contactBoxName);
    await box.add(contact);
  }

  Future<List<Contact>> getContacts() async {
    final box =
        await EncryptedHiveService.openEncryptedBox<Contact>(contactBoxName);
    return box.values.toList();
  }

  Future<void> updateContact(Contact contact) async {
    await contact.save();
  }

  Future<void> deleteContact(Contact contact) async {
    await contact.delete();
  }
}
