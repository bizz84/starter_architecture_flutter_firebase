class FirestorePath {
  static String item(String uid, String itemId) => 'users/$uid/items/$itemId';
  static String items(String uid) => 'users/$uid/items';
  static String entry(String uid, String entryId) =>
      'users/$uid/entries/$entryId';
  static String entries(String uid) => 'users/$uid/entries';
  static String categories(String category, String itemId) => 'categories/$category/items/$itemId';
  static String searchCategory(String? category) => 'categories/$category/items';
}

