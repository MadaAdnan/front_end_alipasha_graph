import 'package:ali_pasha_graph/Global/main_controller.dart';
import 'package:ali_pasha_graph/models/setting_model.dart';
import 'package:get/get.dart';
import 'package:dio/dio.dart' as dio;

class GoldLogic extends GetxController {
  MainController mainController = Get.find<MainController>();

  RxBool loading = RxBool(false);
  Rxn<SettingModel> setting = Rxn<SettingModel>(null);

  @override
  void onReady() {
    // TODO: implement onReady
    super.onReady();
    if(setting.value==null){
      getGold();
    }

  }

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();

  }

  getGold() async {
    loading.value = true;
    mainController.query.value = '''
query Settings {
    settings {
        gold {
            izaz {
                gold24 {
                    sale
                    bay
                }
                gold21 {
                    sale
                    bay
                }
                gold18 {
                    sale
                    bay
                }
                sliver {
                    sale
                    bay
                }
            }
            idlib {
                gold24 {
                    sale
                    bay
                }
                gold21 {
                    sale
                    bay
                }
                gold18 {
                    sale
                    bay
                }
                sliver {
                    sale
                    bay
                }
            }
        }
        dollar {
            idlib {
                usd {
                    sale
                    bay
                }
                eur {
                    sale
                    bay
                }
                syr {
                    sale
                    bay
                }
            }
            izaz {
                usd {
                    sale
                    bay
                }
                eur {
                    sale
                    bay
                }
                syr {
                    sale
                    bay
                }
            }
        }
        created_at
        material_izaz {
            name
            bay
            sale
        }
        material_idlib {
            name
            bay
            sale
        }
    }
}


  ''';
    try {
      dio.Response? res = await mainController.fetchData();
      //mainController.logger.e(res?.data);
      if (res?.data?['data']?['settings'] != null) {
        setting.value =
            SettingModel.fromJson(res?.data?['data']?['settings']);
      }
    } catch (e) {
      mainController.logger.e("Error get Gold Exchange $e");
    }
    loading.value = false;
  }
}
