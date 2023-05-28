class Content {
  late int id;
  late int subject_id;
  late String title;
  late String file;
  late String link;
  late String description;

  Content(pro_list) {
    this.id = pro_list['id'];
    this.subject_id = pro_list['subject_id'];
    this.title = pro_list['title'];
    this.file = pro_list['file'];
    this.link = pro_list['link'];
    this.description = pro_list['description'];
  }
}
