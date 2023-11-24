class Pages {
  String pagepath;
  String pagename;

  Pages({
    required this.pagename,
    required this.pagepath,
  });

  static List<Pages> getPages() {
    List<Pages> pages = [];
    pages.add(
        Pages(pagename: 'Home', pagepath: 'package:lvlmindbeta/homepage.dart'));
    pages.add(
        Pages(pagename: 'EDT', pagepath: 'package:lvlmindbeta/pages/edt.dart'));
    pages.add(Pages(
        pagename: 'Files', pagepath: 'package:lvlmindbeta/pages/files.dart'));
    pages.add(Pages(
        pagename: 'Profile',
        pagepath: 'package:lvlmindbeta/pages/profile.dart'));
    return pages;
  }
}
