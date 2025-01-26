class VaccinesInformation {
  // For checking if vaccines are taken
  String bcgOption;
  String hepatitisBOption;
  String opv1Option;
  String opv2Option;
  String opv3Option;
  String ipv1Option;
  String ipv2Option;
  String pcv1Option;
  String pcv2Option;
  String pcv3Option;
  String pentavalent1stDoseOption;
  String pentavalent2ndDoseOption;
  String pentavalent3rdDoseOption;
  String mmrOption;

  DateTime? bcgDate;
  DateTime? hepatitisBDate;
  DateTime? opv1Date;
  DateTime? opv2Date;
  DateTime? opv3Date;
  DateTime? ipv1Date;
  DateTime? ipv2Date;
  DateTime? pcv1Date;
  DateTime? pcv2Date;
  DateTime? pcv3Date;
  DateTime? pentavalent1stDate;
  DateTime? pentavalent2ndDate;
  DateTime? pentavalent3rdDate;
  DateTime? mmrDate;

  VaccinesInformation(
    this.bcgOption,
    this.hepatitisBOption,
    this.opv1Option,
    this.opv2Option,
    this.opv3Option,
    this.ipv1Option,
    this.ipv2Option,
    this.pcv1Option,
    this.pcv2Option,
    this.pcv3Option,
    this.pentavalent1stDoseOption,
    this.pentavalent2ndDoseOption,
    this.pentavalent3rdDoseOption,
    this.mmrOption, {
    this.bcgDate,
    this.hepatitisBDate,
    this.opv1Date,
    this.opv2Date,
    this.opv3Date,
    this.ipv1Date,
    this.ipv2Date,
    this.pcv1Date,
    this.pcv2Date,
    this.pcv3Date,
    this.pentavalent1stDate,
    this.pentavalent2ndDate,
    this.pentavalent3rdDate,
    this.mmrDate,
  });

  // Resetting Model

  void reset() {
    bcgOption = "No";
    hepatitisBOption = "No";
    opv1Option = "No";
    opv2Option = "No";
    opv3Option = "No";
    ipv1Option = "No";
    ipv2Option = "No";
    pcv1Option = "No";
    pcv2Option = "No";
    pcv3Option = "No";
    pentavalent1stDoseOption = "No";
    pentavalent2ndDoseOption = "No";
    pentavalent3rdDoseOption = "No";
    mmrOption = "No";

    bcgDate = null;
    hepatitisBDate = null;
    opv1Date = null;
    opv2Date = null;
    opv3Date = null;
    ipv1Date = null;
    ipv2Date = null;
    pcv1Date = null;
    pcv2Date = null;
    pcv3Date = null;
    pentavalent1stDate = null;
    pentavalent2ndDate = null;
    pentavalent3rdDate = null;
    mmrDate = null;
  }
}
