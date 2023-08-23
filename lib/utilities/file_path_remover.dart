String removeDir(String path) {
  // Find the last occurrence of '/' in the file path
  int lastIndex = path.lastIndexOf('/');

  if (lastIndex != -1) {
    // Extract the substring starting from the position after the last '/'
    String fileName = path.substring(lastIndex + 1);
    // print("File Name: $fileName");

    return fileName;
  } else {
    // If there is no '/', the file path does not contain any directories.
    // So the entire string is the file name.
    // print("File Name: $path");
    return path;
  }
}
