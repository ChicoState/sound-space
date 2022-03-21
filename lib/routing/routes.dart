// List all necessary routes for page
const rootRoute = "/";

const HomePageDisplayName = "Home";
const UploadPageDisplayName = "Upload";
const MusicPageDisplayName = "Music";
const AccountPageDisplayName = "Account";
const TrendingPageDisplayName = "Trending";

const HomePageRoute = "/home";
const UploadPageRoute = "/upload";
const MusicPageRoute = "/music";
const AccountPageRoute = "/account";
const TrendingPageRoute = "/trending";

// These are the routes displayed in our right drawer

class MenuItem {
  final String name;
  final String route;

  MenuItem(this.name, this.route);
}

List<MenuItem> sideMenuItems = [
  MenuItem(HomePageDisplayName, HomePageRoute),
  MenuItem(TrendingPageDisplayName, TrendingPageRoute),
  MenuItem(MusicPageDisplayName, MusicPageRoute),
  MenuItem(UploadPageDisplayName, UploadPageRoute),
  MenuItem(AccountPageDisplayName, AccountPageRoute),
];
