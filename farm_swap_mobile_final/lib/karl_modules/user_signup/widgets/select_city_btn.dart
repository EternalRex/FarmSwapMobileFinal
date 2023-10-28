import 'package:farm_swap_mobile_final/karl_modules/user_signup/others/barrangay_lists.dart';
import 'package:farm_swap_mobile_final/provider/user_details_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../common/poppins_text.dart';

class SelectCityBtn extends StatefulWidget {
  const SelectCityBtn({super.key});

  @override
  State<SelectCityBtn> createState() => _SelectCityBtnState();
}

class _SelectCityBtnState extends State<SelectCityBtn> {
  final CebuMunicipalities municipalities = CebuMunicipalities();

  String? selectedValue = "ALCANTARA";

  @override
  Widget build(BuildContext context) {
    return DropdownButton<String>(
      value: selectedValue,
      hint: poppinsText(
        "Select City/Municipality",
        Colors.white,
        15,
        FontWeight.w600,
      ),
      onChanged: (value) {
        setState(() {
          selectedValue = value;
          Provider.of<UserDetailsProvider>(context, listen: false).setCityMunicipality(
            selectedValue.toString(),
          );
        });
      },
      items: [
        /*Alcantara City */
        DropdownMenuItem(
          value: municipalities.alcantara.toUpperCase(),
          child: Text(municipalities.alcantara),
        ),
        /*Alcoy City */
        DropdownMenuItem(
          value: municipalities.alcoy.toUpperCase(),
          child: Text(municipalities.alcoy),
        ),
        /*Aloguinsan City */
        DropdownMenuItem(
          value: municipalities.aloguinsan.toUpperCase(),
          child: Text(municipalities.aloguinsan),
        ),
        /*Alegria City */
        DropdownMenuItem(
          value: municipalities.alegria.toUpperCase(),
          child: Text(municipalities.alegria),
        ),
        /*Argao City */
        DropdownMenuItem(
          value: municipalities.argao.toUpperCase(),
          child: Text(municipalities.argao),
        ),
        /*Asturias City */
        DropdownMenuItem(
          value: municipalities.asturias.toUpperCase(),
          child: Text(municipalities.asturias),
        ),
        /*Badian City */
        DropdownMenuItem(
          value: municipalities.badian.toUpperCase(),
          child: Text(municipalities.badian),
        ),
        /*Balamban City */
        DropdownMenuItem(
          value: municipalities.balamban.toUpperCase(),
          child: Text(municipalities.balamban),
        ),
        /*Bantayan City */
        DropdownMenuItem(
          value: municipalities.bantayan.toUpperCase(),
          child: Text(municipalities.bantayan),
        ),
        /*Barili City */
        DropdownMenuItem(
          value: municipalities.barili.toUpperCase(),
          child: Text(municipalities.barili),
        ),
        /*Boljoon City */
        DropdownMenuItem(
          value: municipalities.boljoon.toUpperCase(),
          child: Text(municipalities.boljoon),
        ),
        /*Borbon City */
        DropdownMenuItem(
          value: municipalities.borbon.toUpperCase(),
          child: Text(municipalities.borbon),
        ),
        /*CarCar City */
        DropdownMenuItem(
          value: municipalities.carcar.toUpperCase(),
          child: Text(municipalities.carcar),
        ),
        /*Cebu City */
        DropdownMenuItem(
          value: municipalities.cebu.toUpperCase(),
          child: Text(municipalities.cebu),
        ),
        /*Catmon City */
        DropdownMenuItem(
          value: municipalities.catmon.toUpperCase(),
          child: Text(municipalities.catmon),
        ),
        /*Compostela */
        DropdownMenuItem(
          value: municipalities.compostela.toUpperCase(),
          child: Text(municipalities.compostela),
        ),
        /*Consolacion City */
        DropdownMenuItem(
          value: municipalities.consolacion.toUpperCase(),
          child: Text(municipalities.consolacion),
        ),
        /*Cordova City */
        DropdownMenuItem(
          value: municipalities.cordova.toUpperCase(),
          child: Text(municipalities.cordova),
        ),
        /*Daan Bantayan City */
        DropdownMenuItem(
          value: municipalities.daanbantayan.toUpperCase(),
          child: Text(municipalities.daanbantayan),
        ),
        /*Dumanjug City */
        DropdownMenuItem(
          value: municipalities.dumanjug.toUpperCase(),
          child: Text(municipalities.dumanjug),
        ),
        /*Ginatilan City */
        DropdownMenuItem(
          value: municipalities.ginatilan.toUpperCase(),
          child: Text(municipalities.ginatilan),
        ),
        /*Guadalupe City */
        DropdownMenuItem(
          value: municipalities.guadalupe.toUpperCase(),
          child: Text(municipalities.guadalupe),
        ),
        /*Kawit City */
        DropdownMenuItem(
          value: municipalities.kawit.toUpperCase(),
          child: Text(municipalities.kawit),
        ),
        /*Liloan City */
        DropdownMenuItem(
          value: municipalities.liloan.toUpperCase(),
          child: Text(municipalities.liloan),
        ),
        /*Lapu Lapu City */
        DropdownMenuItem(
          value: municipalities.lapulapu.toUpperCase(),
          child: Text(municipalities.lapulapu),
        ),
        /*Madridijos */
        DropdownMenuItem(
          value: municipalities.madridejos.toUpperCase(),
          child: Text(municipalities.madridejos),
        ),
        /*Malabo */
        DropdownMenuItem(
          value: municipalities.malabo.toUpperCase(),
          child: Text(municipalities.malabo),
        ),
        /*Mandaue */
        DropdownMenuItem(
          value: municipalities.mandaue.toUpperCase(),
          child: Text(municipalities.mandaue),
        ),
        /*Medellin */
        DropdownMenuItem(
          value: municipalities.medellin.toUpperCase(),
          child: Text(municipalities.medellin),
        ),
        /*Minglanilla */
        DropdownMenuItem(
          value: municipalities.minglanilla.toUpperCase(),
          child: Text(municipalities.minglanilla),
        ),
        /*Moalboal */
        DropdownMenuItem(
          value: municipalities.moalboal.toUpperCase(),
          child: Text(municipalities.moalboal),
        ),
        /*Oslob*/
        DropdownMenuItem(
          value: municipalities.oslob.toUpperCase(),
          child: Text(municipalities.oslob),
        ),
        /*Pilar*/
        DropdownMenuItem(
          value: municipalities.pilar.toUpperCase(),
          child: Text(municipalities.pilar),
        ),
        /*Pinamungajan*/
        DropdownMenuItem(
          value: municipalities.pinamungajan.toUpperCase(),
          child: Text(municipalities.pinamungajan),
        ),
        /*Romda */
        DropdownMenuItem(
          value: municipalities.ronda.toUpperCase(),
          child: Text(municipalities.ronda),
        ),
        /*Poro */
        DropdownMenuItem(
          value: municipalities.poro.toUpperCase(),
          child: Text(municipalities.poro),
        ),
        /*Sam Francisco */
        DropdownMenuItem(
          value: municipalities.sanFrancisco.toUpperCase(),
          child: Text(municipalities.sanFrancisco),
        ),
        /*San Fernando */
        DropdownMenuItem(
          value: municipalities.sanFernando.toUpperCase(),
          child: Text(municipalities.sanFernando),
        ),
        /*Sam Remegio */
        DropdownMenuItem(
          value: municipalities.sanRemegio.toUpperCase(),
          child: Text(municipalities.sanRemegio),
        ),
        /*Santa Fe */
        DropdownMenuItem(
          value: municipalities.santaFe.toUpperCase(),
          child: Text(municipalities.santaFe),
        ),
        /*Santander*/
        DropdownMenuItem(
          value: municipalities.santander.toUpperCase(),
          child: Text(municipalities.santander),
        ),
        /*Sibonga */
        DropdownMenuItem(
          value: municipalities.sibonga.toUpperCase(),
          child: Text(municipalities.sibonga),
        ),
        /*Sogod */
        DropdownMenuItem(
          value: municipalities.sogod.toUpperCase(),
          child: Text(municipalities.sogod),
        ),
        /*Tabogon */
        DropdownMenuItem(
          value: municipalities.tabogon.toUpperCase(),
          child: Text(municipalities.tabogon),
        ),
        /*Tabuelan */
        DropdownMenuItem(
          value: municipalities.tabuelan.toUpperCase(),
          child: Text(municipalities.tabuelan),
        ),
        /*Talisay */
        DropdownMenuItem(
          value: municipalities.talisay.toUpperCase(),
          child: Text(municipalities.talisay),
        ),
        /*Toledo */
        DropdownMenuItem(
          value: municipalities.toledo.toUpperCase(),
          child: Text(municipalities.toledo),
        ),
        /*Tuburan */
        DropdownMenuItem(
          value: municipalities.tuburan.toUpperCase(),
          child: Text(municipalities.tuburan),
        ),
        /*Tudela */
        DropdownMenuItem(
          value: municipalities.tudela.toUpperCase(),
          child: Text(municipalities.tudela),
        ),
      ],
    );
  }
}
