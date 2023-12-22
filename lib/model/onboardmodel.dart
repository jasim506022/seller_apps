class OnboardModel {
  String img;
  String text;
  String desc;

  OnboardModel({
    required this.img,
    required this.text,
    required this.desc,
  });
}

List<OnboardModel> onboardModeList = [
  OnboardModel(
    img: "asset/onboard/grocery.png",
    text: "Welcome",
    desc:
        "Welcome to best online grocery store. Here you will find all the groceries at one place.",
  ),
  OnboardModel(
    img: "asset/onboard/all_grocery.png",
    text: "Fresh Fruits & Vegetables",
    desc:
        "Buy farm fresh fruits & vegetables online at the best & affordable prices.",
  ),
  OnboardModel(
    img: "asset/onboard/delivery.png",
    text: "Quick & Fast Delivery",
    desc:
        "We offers speedy delivery of your groceries, bathroom supplies, baby care products, pet care items, stationary, etc within 30minutes at your doorstep.",
  )
];
