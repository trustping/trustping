import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:trust_ping_app/utils.dart';
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
      "diagnosisCancerType": _ids(diagnosisCancerType),
      "diagnosisCancerProperties": _ids(diagnosisCancerProperties),
      "diagnosisPhase": _ids(diagnosisPhase),
      "therapyMethods": _ids(therapyMethods),
      "therapySideEffects": _ids(therapySideEffects),
      "situationGeneral": _ids(situationGeneral),
      "situationInterests": _ids(situationInterests),
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
      name: data.get("name", ""),
      yearOfBirth: data.get("yearOfBirth", null),
      diagnosisCancerType: _items(CANCER_TYPES, data["diagnosisCancerType"]),
      diagnosisCancerProperties:
          _items(CANCER_PROPERTIES, data["diagnosisCancerProperties"]),
      diagnosisPhase: _items(CANCER_PHASES, data["diagnosisPhase"]),
      therapyMethods: _items(THERAPY_METHODS, data["therapyMethods"]),
      therapySideEffects:
          _items(THERAPY_SIDE_EFFECTS, data["therapySideEffects"]),
      situationGeneral: _items(SITUATION_GENERAL, data["situationGeneral"]),
      situationInterests:
          _items(SITUATION_INTERESTS, data["situationInterests"]),
    );
  }

  List<String> get diagnosisCancerTypeIDs => _ids(diagnosisCancerType);
  List<String> get diagnosisCancerPropertiesIDs =>
      _ids(diagnosisCancerProperties);
  List<String> get diagnosisPhaseIDs => _ids(diagnosisPhase);
  List<String> get therapyMethodsIDs => _ids(therapyMethods);
  List<String> get therapySideEffectsIDs => _ids(therapySideEffects);
  List<String> get situationGeneralIDs => _ids(situationGeneral);
  List<String> get situationInterestsIDs => _ids(situationInterests);

  // Low-level helpers
  List<String> _ids(List<Item> items) {
    return (items == null) ? [] : items.map((e) => e.id).toList();
  }

  static List<Item> _items(List<Item> items, dynamic ids) {
    final _ids = Set<String>.from(ids);
    return items.where((item) => _ids.contains(item.id)).toList();
  }
}

// =============================================================================
// DATA MODELLING
/// Generic Item used for the onbording information of the user.
/// The ID is what's stored in the DB and must not change.
/// The text can change.
@freezed
abstract class Item implements _$Item {
  const factory Item(
    String id,
    String text,
  ) = _Item;
  const Item._();
}

// =============================================================================
// DIAGNOSE / CANCER
// The order of this list detemines the order in the view.
const List<Item> CANCER_TYPES = [
  const Item("0", "Brustkrebs"),
  const Item("1", "Andere"),
  const Item("99", "Keine Angabe"),
];

const List<Item> CANCER_PROPERTIES = [
  const Item("0", "Vorstufe / DCIS"),
  const Item("1", "Hormonsensitiv"),
  const Item("2", "HER2+"),
  const Item("3", "Triple negative+"),
  const Item("4", "Fortgeschritten / Metastasen"),
];

const List<Item> CANCER_PHASES = [
  const Item("0", "Diagnose gerade bekommen"),
  const Item("1", "in Behandlung"),
  const Item("2", "Rezidiv"),
  const Item("3", "Akutbehandlung abgeschlossen"),
  const Item("4", "in Dauerbehandlung"),
  const Item("5", "Leben nach Krebs (Survivorship)"),
];

// =============================================================================
// THERAPY
// The order of this list detemines the order in the view.
const List<Item> THERAPY_METHODS = [
  const Item("0", "Chemotherapie"),
  const Item("1", "Immuntherapie"),
  const Item("2", "Operation"),
  const Item("3", "Hormontherapie"),
  const Item("4", "Strahlentherapie"),
  const Item("5", "Psychotherapie"),
  const Item("6", "Komplementäre Medizin"),
];

const List<Item> THERAPY_SIDE_EFFECTS = [
  const Item("0", "Schlaf"),
  const Item("1", "Übelkeit"),
  const Item("2", "Fatigue"),
  const Item("3", "Depression"),
  const Item("4", "Haut"),
  const Item("5", "Neuropathie"),
  const Item("6", "Gewicht"),
  const Item("7", "Fruchtbarkeit"),
  const Item("8", "Haarausfall"),
  const Item("9", "weitere"),
];

// =============================================================================
// Situation
// The order of this list detemines the order in the view.
const List<Item> SITUATION_GENERAL = [
  const Item("0", "Single"),
  const Item("1", "in Partnerschaft / verheiratet"),
  const Item("2", "in Ausbildung / Studium"),
  const Item("3", "berufstätig"),
  const Item("4", "pensioniert"),
  const Item("5", "schwanger"),
  const Item("6", "mit Familie"),
];

const List<Item> SITUATION_INTERESTS = [
  const Item("0", "Sport"),
  const Item("1", "Yoga"),
  const Item("2", "Meditation"),
  const Item("3", "Entspannung"),
  const Item("4", "Ernährung"),
  const Item("5", "Job"),
  const Item("6", "Selbsthilfe"),
  const Item("7", "Reha"),
  const Item("8", "Sozialrecht"),
  const Item("9", "Politik"),
  const Item("10", "Kultur"),
  const Item("11", "Kosmetik"),
  const Item("12", "Sexualität"),
  const Item("13", "Nebenwirkungen"),
];
