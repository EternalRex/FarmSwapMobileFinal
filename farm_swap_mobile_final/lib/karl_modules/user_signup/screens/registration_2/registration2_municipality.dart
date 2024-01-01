import "dart:convert";
import "package:flutter/services.dart";
import "package:flutter/material.dart";

class Registration2LocationDropDown extends StatefulWidget {
  const Registration2LocationDropDown({
    super.key,
    required this.selectedMunicipality,
  });

  final String selectedMunicipality;

  @override
  State<Registration2LocationDropDown> createState() => _Registration2LocationDropDownState();
}

class _Registration2LocationDropDownState extends State<Registration2LocationDropDown> {
  List<String> barangay = [];
  /*Mao ni atong default value para sa atong dropdown, gi mark as late lang nato kay adto man tani
  assignan og value solod sa atong Future<void> na method */
  late String selectedBarangay = '';

  @override
  void initState() {
    super.initState();
    loadBarangay();
  }

/*Reloads the class so that the classs will receive the lates changes in the selectedMunicipality variable, from the calling class
which actually is under the setState function, So ngadto sa calling class, everytime mag ilis ang value sa aton dropdown btn para sa municipalities
 ato ni e reload na page, para ang value sa atong widget.selectedMunicipality kay ang newly selected na municipality*/
  @override
  void didUpdateWidget(Registration2LocationDropDown oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.selectedMunicipality != widget.selectedMunicipality) {
      loadBarangay(); // Reload barangays if the selected municipality changes
    }
  }

  Future<void> loadBarangay() async {
    /*Gi decode nato ang jsong file */
    String jsonString = await rootBundle.loadString(
        'assets/karl_assets/json/philippine_provinces_cities_municipalities_and_barangays_2016.json');
    var data = json.decode(jsonString);
    /*Gi kuha nato ang data nga nag wrap sa atong municipalities */
    var regionData = data?["07"];
    /*Check nato og naa ba jud na nga data sa atong json */
    if (regionData != null) {
      /*Atong gi traverse ang atong json file tapos gi assign nato ang mga pronvince_list sa province entry na variable */
      for (var provinceEntry in regionData['province_list'].entries) {
        /*Tapos gi traverse nato ang provinceEntry nga nag contain sa atong municipality na mga pangalan, tapos kini na mga 
        pangalan e solod nato sa temporary variable na municipalityEntry*/
        for (var municipalityEntry in provinceEntry.value['municipality_list']) {
          /*Dayon taga municipality name na mosolod sa municiplaity entry ato e anam anam og solod sa municipalityName na variable */
          var municipalityName = municipalityEntry.keys.first;
          /*Then ato e check kung ang bagohay lang ni solod na municipality name sa atong municipalityName na variable kay equal ba sa atong
          widget.selectedMunicipality*/
          if (municipalityName == widget.selectedMunicipality) {
            /*Kuhaon  nato ang kaakibat na barangy sa selected na munisipyo, key value pairs maning [][] */
            var barangayList = municipalityEntry[municipalityName]['barangay_list'];
            setState(() {
              barangay = List<String>.from(barangayList);
              /*So diri ang initial value sa atong dropdown is ang pinaka first na brangay sa selected na municiplaity */
              selectedBarangay = barangay.isNotEmpty ? barangay[0] : 'BUTONG';
            });
            break;
          }
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return DropdownButton<String>(
      hint: Text('Select a Barangay'),
      value: selectedBarangay,
      onChanged: (String? newValue) {
        setState(() {
          selectedBarangay = newValue.toString();
        });
      },
      items: barangay.map((barangay) {
        return DropdownMenuItem<String>(
          value: barangay,
          child: Text(barangay),
        );
      }).toList(),
    );
  }
}
