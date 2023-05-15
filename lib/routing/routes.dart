const rootRoute = "/";

const addProduct = "addProduct";
const addProductRoute = "/addProduct";


const overviewPageDisplayName = "الرئيسية";
const overviewPageRoute = "/overview";

const driversPageDisplayName = "الأقسام";
const driversPageRoute = "/drivers";

const productsPageDisplayName = "المنتجات";
const productsPageRoute = "/products";

const brandsPageDisplayName = "Brands";
const brandsPageRoute = "/brands";

const carModelsPageDisplayName = "مودل السيارات";
const carModelsPageRoute = "/carModels";

const slidersPageDisplayName = "البانر";
const slidersPageRoute = "/sliders";

const workshopsPageDisplayName = "الورش";
const workshopsPageRoute = "/workshops";

const postsPageDisplayName = "الخدمات";
const postsPageRoute = "/posts";

const ordersPageDisplayName = "الطلبات";
const ordersPageRoute = "/orders";

const clientsPageDisplayName = "العملاء";
const clientsPageRoute = "/clients";

const suggestionsPageDisplayName = "الاقتراحات والشكاوى";
const suggestionsPageRoute = "/suggestions";


const sittingPageDisplayName = "الاعدادات";
const sittingPageRoute = "/sitting";

const messagesPageDisplayName = "الرسائل";
const messagesPageRoute = "/messages";

const authenticationPageDisplayName = "خروج";
const authenticationPageRoute = "/auth";

class MenuItem {
  final String name;
  final String route;

  MenuItem(this.name, this.route);
}



List<MenuItem> sideMenuItemRoutes = [
 MenuItem(overviewPageDisplayName, overviewPageRoute),
 MenuItem(driversPageDisplayName, driversPageRoute),
  MenuItem(productsPageDisplayName, productsPageRoute),
  MenuItem(brandsPageDisplayName, brandsPageRoute),
  MenuItem(carModelsPageDisplayName, carModelsPageRoute),
  MenuItem(slidersPageDisplayName, slidersPageRoute),
  MenuItem(ordersPageDisplayName, ordersPageRoute),
   MenuItem(workshopsPageDisplayName, workshopsPageRoute),
    MenuItem(postsPageDisplayName, postsPageRoute),
 MenuItem(clientsPageDisplayName, clientsPageRoute),
  MenuItem(suggestionsPageDisplayName, suggestionsPageRoute),
  MenuItem(sittingPageDisplayName, sittingPageRoute),
  MenuItem(messagesPageDisplayName, messagesPageRoute),
 MenuItem(authenticationPageDisplayName, authenticationPageRoute),
];
