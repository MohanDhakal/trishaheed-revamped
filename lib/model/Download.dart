class Download {
  List<String> files;
  Download(this.files);
  factory Download.fromJson(Map<String, dynamic> data) {
    List<String> local = [];
    for (String element in data["data"]) {
      final fileName = element;
      local.add(fileName);
    }
    return Download(local);
  }
}
