import 'package:app_ignitemanager/app/data/models/tag.dart';
import 'package:app_ignitemanager/app/data/provider/api.dart';

class TagsRepository {
  final Api _api;

  TagsRepository(this._api);

  Future<List<TagModel>> getTags() {
    return _api.getTags();
  }

  Future<TagModel> getTagById(int tagId) {
    return _api.getTagById(tagId);
  }

  Future<TagModel> registerTag(TagModel tag) => _api.registerTag(tag);

  Future<TagModel> updateTag(TagModel tag) => _api.putTag(tag);
}
