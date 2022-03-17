//class for managing SliderModel properties

class SliderModel {
  String imageAssetPath;
  String title;
  String desc;

  //constructor
  SliderModel({this.imageAssetPath, this.title, this.desc});

  //method for setting asset path
  void setImageAssetPath(String getImageAssetPath) {
    imageAssetPath = getImageAssetPath;
  }

  //method for setting asset title
  void setTitle(String getTitle) {
    title = getTitle;
  }

  //method for setting description
  void setDesc(String getDesc) {
    desc = getDesc;
  }

  //method for getting image asset path
  String getImageAssetPath() {
    return imageAssetPath;
  }

  //method for getting title
  String getTitle() {
    return title;
  }

  //method for getting description
  String getDesc() {
    return desc;
  }
}

//method for getting slides
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
