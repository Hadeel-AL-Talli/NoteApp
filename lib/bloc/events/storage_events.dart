abstract class StorageEvents {}

class CreateEvent extends StorageEvents {
  String filePath;
  CreateEvent(this.filePath);
}

class ReadEvent extends StorageEvents {}

class DeleteEvent extends StorageEvents {
  String filPath;
  DeleteEvent(this.filPath);
}
