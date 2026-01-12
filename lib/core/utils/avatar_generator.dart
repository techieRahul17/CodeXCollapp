class AvatarGenerator {
  static String generateInitials(String name) {
    if (name.isEmpty) return "??";
    List<String> nameParts = name.trim().split(" ");
    if (nameParts.length > 1) {
      return "${nameParts[0][0]}${nameParts[1][0]}".toUpperCase();
    } else {
      return name.substring(0, name.length > 1 ? 2 : 1).toUpperCase();
    }
  }

  static String getAvatarUrl(String name) {
    // Generate a placeholder URL if needed, but for now we might use a robust UI widget 
    // that takes initials. However, if we need a URL for network images:
    return "https://ui-avatars.com/api/?name=${Uri.encodeComponent(name)}&background=FF007F&color=fff&size=128";
  }
}
