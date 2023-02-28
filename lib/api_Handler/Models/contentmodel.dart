class Album {
  late int id;
  late String name;

  Album(content_list) {
    this.id = content_list['id'];
    this.name = content_list['name'];
  }
}
