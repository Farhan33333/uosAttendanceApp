class Content {
  late int id;
  late int subject_id;
  late String title;
  late String file;

  Content(pro_list) {
    this.id = pro_list['id'];
    this.subject_id = pro_list['subject_id'];
    this.title = pro_list['title'];
    this.file = pro_list['file'];
  }
}
