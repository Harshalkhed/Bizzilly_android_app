class SliderModel {
  String imageAssetPath;
  String title;
  String desc;

  SliderModel({this.imageAssetPath, this.title, this.desc});

  void setImageAssetPath(String getImageAssetPath) {
    imageAssetPath = getImageAssetPath;
  }

  void setTitle(String getTitle) {
    title = getTitle;
  }

  void setDesc(String getDesc) {
    desc = getDesc;
  }

  String getImageAssetPath() {
    return imageAssetPath;
  }

  String getTitle() {
    return title;
  }

  String getDesc() {
    return desc;
  }
}

List<SliderModel> getSlides() {
  List<SliderModel> slides = new List<SliderModel>();
  SliderModel sliderModel = new SliderModel();

  //1
  sliderModel.setDesc("Choose from languages !");
  sliderModel.setTitle("Select Language");
  sliderModel.setImageAssetPath("assets/images/support.png");
  slides.add(sliderModel);

  sliderModel = new SliderModel();

  //2
  sliderModel
      .setDesc("Large number of categories to choose from for ease of use");
  sliderModel.setTitle("Select Category");
  sliderModel.setImageAssetPath("assets/images/search.png");
  slides.add(sliderModel);

  sliderModel = new SliderModel();

  //3
  sliderModel.setDesc("Get necessary information.");
  sliderModel.setTitle("Boom ! There you go !");
  sliderModel.setImageAssetPath("assets/images/login.png");
  slides.add(sliderModel);

  sliderModel = new SliderModel();

  return slides;
}
