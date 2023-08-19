class Api {
  static const _baseServer = "http://103.150.93.77:1339/api";

  String getProducts = "$_baseServer/products";
  String getProduct = "$_baseServer/restaurants";
  String authLogin = "$_baseServer/auth/local";
  String authRegiser = "$_baseServer/auth/local/register";
}
