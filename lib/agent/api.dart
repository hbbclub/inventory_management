import 'package:dio/dio.dart';
import 'package:inventory_management/agent/agent.dart';
import 'package:inventory_management/agent/api_model.dart';
import 'package:inventory_management/welcome_page/model/cache_model.dart';
import 'package:multi_image_picker/multi_image_picker.dart';
export 'package:inventory_management/agent/api_model.dart';

class Api {
  //登录
  Future<ApiModel> login({username, password, linkWord}) async {
    return httpUtil.post(
      '/auth/login',
      params: {
        'username': username,
        'password': password,
        'cmp_code': linkWord,
      },
    );
  }

  //物料搜索
  Future<ApiModel> materialList({
    keyword,
  }) async {
    return httpUtil.get(
      '/mm/materials/list',
      params: {
        'keyword': keyword ?? '',
      },
    );
  }

  //物料详情
  Future<ApiModel> materialDetail({
    partNo,
  }) async {
    return httpUtil.get(
      '/mm/material/' + partNo,
      params: {},
    );
  }

//标签列表
  Future<ApiModel> labelList() async {
    return httpUtil.get(
      '/mm/labels/list',
      params: {},
    );
  }

  //添加记录
  Future<ApiModel> addNote(Map<String, dynamic> note) async {
    note.addAll({'user': cacheModel.user.toJson()});
    return httpUtil.post(
      '/mm/note',
      params: note,
    );
  }

  //修改记录
  Future<ApiModel> updateNote(Map<String, dynamic> note) async {
    note.addAll({'user': cacheModel.user.toJson()});
    return httpUtil.patch(
      '/mm/note',
      params: note,
    );
  }

  //删除记录
  Future<ApiModel> deleteNote(String id) async {
    return httpUtil.delete(
      '/mm/note/' + id,
    );
  }

  //获取note列表
  Future<ApiModel> noteList() async {
    return httpUtil.get(
      '/mm/notes/list',
      params: {},
    );
  }

  //获取note categories列表
  Future<ApiModel> noteCategories() async {
    return httpUtil.get(
      '/mm/dict/categories',
      params: {},
    );
  }

  //上传文件
  Future<ApiModel> fileUpload(List<Asset> files) async {
    List<UploadFileInfo> infos = List.generate(files.length, (index) {
      return UploadFileInfo.fromBytes(
          files[index].thumbData?.buffer?.asUint8List(), 'file');
    });
    FormData formData = FormData.from({
      "file": infos,
    });
    return httpUtil.post(
      '/mm/file/upload',
      params: formData,
    );
  }
}

final Api api = Api();
