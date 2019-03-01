import 'package:inventory_management/bundles/agent/agent.dart';
import 'package:inventory_management/bundles/agent/api_model.dart';
export 'package:inventory_management/bundles/agent/api_model.dart';

class Api {
  //物料搜索
  Future<ApiModel> materialList({
    keyword,
  }) async {
    return httpUtil.get(
      '/material/list',
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
      '/material/details',
      params: {
        'part_no': partNo ?? '',
      },
    );
  }

//标签列表
  Future<ApiModel> labelList() async {
    return httpUtil.get(
      '/label/list',
      params: {},
    );
  }
}

final Api api = Api();
