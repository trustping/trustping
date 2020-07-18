import 'package:freezed_annotation/freezed_annotation.dart';
part 'user_profile_v2.freezed.dart';

@freezed
abstract class UserProfileV2 implements _$UserProfileV2 {
  const UserProfileV2._();
  const factory UserProfileV2({
    String id,
    // general
    String name,
    int yearOfBirth,
    // diagnosis
    List<Item> diagnosisCancerType,
    List<Item> diagnosisCancerProperties,
    List<Item> diagnosisPhase,
    // therapy
    List<Item> therapyMethods,
    List<Item> therapySideEffects,
    // situation
    List<Item> situationGeneral,
    List<Item> situationInterests,
  }) = _UserProfileV2;

  Map<String, dynamic> toMap() {
    return {
      "name": name,
      "yearOfBirth": yearOfBirth,
      "diagnosisCancerType": diagnosisCancerType,
      "diagnosisCancerProperties": diagnosisCancerProperties,
      "diagnosisPhase": diagnosisPhase,
      "therapyMethods": therapyMethods,
      "therapySideEffects": therapySideEffects,
      "situationGeneral": situationGeneral,
      "situationInterests": situationInterests,
    };
  }

  factory UserProfileV2.fromMap(Map<String, dynamic> data, String documentID) {
    assert(documentID != null);

    if (data == null) {
      return UserProfileV2(
        id: documentID,
        name: "Dummy :)",
        yearOfBirth: null,
        diagnosisCancerType: [],
        diagnosisCancerProperties: [],
        diagnosisPhase: [],
        therapyMethods: [],
        therapySideEffects: [],
        situationGeneral: [],
        situationInterests: [],
      );
    }

    return UserProfileV2(
      id: documentID,
      name: data["name"] ?? "",
      yearOfBirth: data["yearOfBirth"],
      diagnosisCancerType: [],
      diagnosisCancerProperties: [],
      diagnosisPhase: [],
      therapyMethods: [],
      therapySideEffects: [],
      situationGeneral: [],
      situationInterests: [],
    );
  }
}

// =============================================================================
// DATA MODELLING
/// Generic Item used for the onbording information of the user.
/// The ID is what's stored in the DB and must not change.
/// The text can change.
class Item {
  const Item(this.id, this.text)
      : assert(id != null),
        assert(text != null);
  final String id;
  final String text;
}

// =============================================================================
// DIAGNOSE / CANCER
// The order of this list detemines the order in the view.
const List<Item> CANCER_TYPES = [
  Item("0", "Brustkrebs"),
  Item("1", "Andere"),
  Item("99", "Keine Angabe"),
];

const List<Item> CANCER_PROPERTIES = [
  Item("0", "Vorstufe / DCIS"),
  Item("1", "Hormonsensitiv"),
  Item("2", "HER2+"),
  Item("3", "Triple negative+"),
  Item("4", "Fortgeschritten / Metastasen"),
];

const List<Item> CANCER_PHASES = [
  Item("0", "Diagnose gerade bekommen"),
  Item("1", "in Behandlung"),
  Item("2", "Rezidiv"),
  Item("3", "Akutbehandlung abgeschlossen"),
  Item("4", "in Dauerbehandlung"),
  Item("5", "Leben nach Krebs (Survivorship)"),
];

// =============================================================================
// THERAPY
// The order of this list detemines the order in the view.
const List<Item> THERAPY_METHODS = [
  Item("0", "Chemotherapie"),
  Item("1", "Immuntherapie"),
  Item("2", "Operation"),
  Item("3", "Hormontherapie"),
  Item("4", "Strahlentherapie"),
  Item("5", "Psychotherapie"),
  Item("6", "Komplementäre Medizin"),
];

const List<Item> THERAPY_SIDE_EFFECTS = [
  Item("0", "Schlaf"),
  Item("1", "Übelkeit"),
  Item("2", "Fatigue"),
  Item("3", "Depression"),
  Item("4", "Haut"),
  Item("5", "Neuropathie"),
  Item("6", "Gewicht"),
  Item("7", "Fruchtbarkeit"),
  Item("8", "Haarausfall"),
  Item("9", "weitere"),
];

// =============================================================================
// Situation
// The order of this list detemines the order in the view.
const List<Item> SITUATION_GENERAL = [
  Item("0", "Single"),
  Item("1", "in Partnerschaft / verheiratet"),
  Item("2", "in Ausbildung / Studium"),
  Item("3", "berufstätig"),
  Item("4", "pensioniert"),
  Item("5", "schwanger"),
  Item("6", "mit Familie"),
];

const List<Item> SITUATION_INTERESTS = [
  Item("0", "Sport"),
  Item("1", "Yoga"),
  Item("2", "Meditation"),
  Item("3", "Entspannung"),
  Item("4", "Ernährung"),
  Item("5", "Job"),
  Item("6", "Selbsthilfe"),
  Item("7", "Reha"),
  Item("8", "Sozialrecht"),
  Item("9", "Politik"),
  Item("10", "Kultur"),
  Item("11", "Kosmetik"),
  Item("12", "Sexualität"),
  Item("13", "Nebenwirkungen"),
];
