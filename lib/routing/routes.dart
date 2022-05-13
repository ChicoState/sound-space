// List all necessary routes for page
const rootRoute = "/";

const homePageDisplayName = "Home";
const uploadPageDisplayName = "Upload";
const musicPageDisplayName = "Music";
const accountPageDisplayName = "Account";
const trendingPageDisplayName = "Trending";
const approvalPageDisplayName = "Approval";

const homePageRoute = "/home";
const uploadPageRoute = "/upload";
const musicPageRoute = "/music";
const accountPageRoute = "/account";
const trendingPageRoute = "/trending";
const approvalPageRoute = "/approval";

// These are the routes displayed in our right drawer

class MenuItem {
  final String name;
  final String route;

  MenuItem(this.name, this.route);
}

List<MenuItem> sideMenuItems = [
  MenuItem(homePageDisplayName, homePageRoute),
  MenuItem(trendingPageDisplayName, trendingPageRoute),
  MenuItem(musicPageDisplayName, musicPageRoute),
  MenuItem(uploadPageDisplayName, uploadPageRoute),
  MenuItem(accountPageDisplayName, accountPageRoute),
  MenuItem(approvalPageDisplayName, approvalPageRoute),
];
