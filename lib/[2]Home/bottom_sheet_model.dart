class UnbordingContent {
  String image;
  String title;

  UnbordingContent({
    required this.image,
    required this.title,
  });
}

List<UnbordingContent> bottomSheetContents = [
  UnbordingContent(
    title: "Dự án xanh",
    image: "images/home/flower.png",
  ),
  UnbordingContent(
    title: "Dự án môi trường ",
    image: "images/home/seeding.png",
  ),
  UnbordingContent(
    title: "Dự án chăn nuôi",
    image: "images/home/farmer.png",
  ),
  UnbordingContent(
    title: "Dự án Smart Home",
    image: "images/home/home.png",
  ),
];
