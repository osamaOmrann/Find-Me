import 'package:find_me_ii/base/base.dart';
import 'package:find_me_ii/data_base/missing_person.dart';
import 'package:find_me_ii/data_base/my_database.dart';
import 'package:find_me_ii/shared_data.dart';

import 'insert_lost_person_screen.dart';

abstract class InsertLostPersonNavigator extends BaseNavigator {
  void whenNotEnoughData();

  void thenMessage();

  void onErrorMessage();

  void timeOutMessage();
}

class InsertLostPersonViewModel
    extends BaseViewModel<InsertLostPersonNavigator> {
  void onAddMissingPersonClicked(
      String name,
      String age,
      String desc,
      String gov,
      String userId,
      String address,
      void thenFun,
      void errorFun,
      void timeOutFun) {
    MissingPerson missingPerson = MissingPerson(
        name: name,
        age: age,
        desc: desc,
        gov: gov,
        userId: userId,
        adress: address,
        dateTime: DateTime.now(),
        isFound: false);
    MyDataBase.insertMissingPerson(missingPerson).then((value) {
      //called when future is completed
      thenFun;
      InsertLostPersonScreen.id = missingPerson.id!;
      SharedData.user?.userMissingList?.add(missingPerson);
    }).onError((error, stackTrace) {
      //called when future fails
      errorFun;
    }).timeout(Duration(seconds: 15), onTimeout: () {
      //save changes in cache
      timeOutFun;
      InsertLostPersonScreen.id = missingPerson.id!;
      SharedData.user?.userMissingList?.add(missingPerson);
    });
  }
}
