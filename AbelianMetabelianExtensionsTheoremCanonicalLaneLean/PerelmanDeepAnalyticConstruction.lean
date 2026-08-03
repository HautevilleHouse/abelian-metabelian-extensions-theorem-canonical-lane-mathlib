import AbelianMetabelianExtensionsTheoremCanonicalLaneLean.FoundationalTheoremInhabitants

/-!
# Abelian Metabelian Extensions Deep Construction

This module refines the foundational inhabitants into a deeper algebraic
construction interface. The construction names the group-extension, cohomology,
Schur multiplier, central extension, and lifting ingredients that feed the
already checked abelian metabelian extensions theorem route.

The module is intentionally term-level: each algebraic construction supplies
Lean inhabitants for its named components and maps them into the foundational
theorem inhabitants used by the route closure.
-/

namespace HautevilleHouse
namespace AbelianMetabelianExtensionsTheoremCanonicalLaneLean

structure AbelianMetabelianExtensionConstruction where
  groupExtension : Prop
  kernelAbelian : Prop
  quotientAbelian : Prop
  commutatorSubgroupAbelian : Prop
  extensionClassDefined : Prop
  cocycleCondition : Prop
  coboundaryEquivalence : Prop
  centralExtensionReduction : Prop
  liftingProperty : Prop
  universalProperty : Prop
  fiveTermExactSequence : Prop
  inflationRestrictionSequence : Prop
  classificationTheoremConclusion : Prop
  groupExtensionTerm : groupExtension
  kernelAbelianTerm : kernelAbelian
  quotientAbelianTerm : quotientAbelian
  commutatorSubgroupAbelianTerm : commutatorSubgroupAbelian
  extensionClassDefinedTerm : extensionClassDefined
  cocycleConditionTerm : cocycleCondition
  coboundaryEquivalenceTerm : coboundaryEquivalence
  centralExtensionReductionTerm : centralExtensionReduction
  liftingPropertyTerm : liftingProperty
  universalPropertyTerm : universalProperty
  fiveTermExactSequenceTerm : fiveTermExactSequence
  inflationRestrictionSequenceTerm : inflationRestrictionSequence
  classificationTheoremConclusionTerm : classificationTheoremConclusion
  metabelianClassFromConstruction :
    groupExtension -> kernelAbelian -> quotientAbelian -> commutatorSubgroupAbelian
  cohomologyClassFromConstruction :
    extensionClassDefined -> cocycleCondition -> coboundaryEquivalence -> extensionClassDefined
  centralExtensionFromConstruction :
    centralExtensionReduction -> liftingProperty -> universalProperty -> centralExtensionReduction
  exactSequencesFromConstruction :
    fiveTermExactSequence -> inflationRestrictionSequence -> fiveTermExactSequence
  classificationTheoremFromConstruction :
    commutatorSubgroupAbelian -> extensionClassDefined -> classificationTheoremConclusion

def AbelianMetabelianExtensionConstruction.toMetabelian
    (C : AbelianMetabelianExtensionConstruction) : MetabelianFoundationalInhabitants := {
  commutatorSubgroupAbelian := C.commutatorSubgroupAbelian
  cohomologyClass := C.extensionClassDefined
  centralExtension := C.centralExtensionReduction
  commutatorSubgroupAbelianTerm := C.metabelianClassFromConstruction
    C.groupExtensionTerm C.kernelAbelianTerm C.quotientAbelianTerm C.commutatorSubgroupAbelianTerm
  cohomologyClassTerm := C.cohomologyClassFromConstruction
    C.extensionClassDefinedTerm C.cocycleConditionTerm C.coboundaryEquivalenceTerm
  centralExtensionTerm := C.centralExtensionFromConstruction
    C.centralExtensionReductionTerm C.liftingPropertyTerm C.universalPropertyTerm
}

structure SchurMultiplierLiftingConstruction where
  stemExtension : Prop
  coveringGroup : Prop
  schurMultiplierIso : Prop
  centralSubgroup : Prop
  freePresentation : Prop
  hopfFormula : Prop
  derivedSubgroupIso : Prop
  stemExtensionTerm : stemExtension
  coveringGroupTerm : coveringGroup
  schurMultiplierIsoTerm : schurMultiplierIso
  centralSubgroupTerm : centralSubgroup
  freePresentationTerm : freePresentation
  hopfFormulaTerm : hopfFormula
  derivedSubgroupIsoTerm : derivedSubgroupIso
  stemFromConstruction :
    stemExtension -> coveringGroup -> stemExtension
  schurMultiplierFromConstruction :
    coveringGroup -> schurMultiplierIso -> centralSubgroup -> schurMultiplierIso
  presentationFromConstruction :
    freePresentation -> hopfFormula -> derivedSubgroupIso -> hopfFormula

def SchurMultiplierLiftingConstruction.toSchurMultiplier
    (C : SchurMultiplierLiftingConstruction) : SchurMultiplierFoundationalInhabitants := {
  schurMultiplierResult := C.schurMultiplierIso
  coveringGroup := C.coveringGroup
  freePresentation := C.freePresentation
  exactSequence := C.stemExtension
  schurMultiplierResultTerm := C.schurMultiplierFromConstruction
    C.coveringGroupTerm C.schurMultiplierIsoTerm C.centralSubgroupTerm
  coveringGroupTerm := C.coveringGroupTerm
  freePresentationTerm := C.freePresentationTerm
  exactSequenceTerm := C.stemFromConstruction C.stemExtensionTerm C.coveringGroupTerm
}

structure AbelianMetabelianExtensionsTheoremConstruction where
  extensionConstruction : AbelianMetabelianExtensionConstruction
  liftingConstruction : SchurMultiplierLiftingConstruction
  admissibleBridge : Prop
  effectiveCohomology : Prop
  admissibleBridgeTerm : admissibleBridge
  effectiveCohomologyTerm : effectiveCohomology
  bridgeFromConstructions :
    MetabelianFoundationalInhabitants -> SchurMultiplierFoundationalInhabitants ->
      admissibleBridge -> effectiveCohomology

def AbelianMetabelianExtensionsTheoremConstruction.toFoundational
    (C : AbelianMetabelianExtensionsTheoremConstruction) : AbelianMetabelianExtensionsTheoremFoundationalInhabitants := {
  classificationTheorem := C.admissibleBridge
  effectiveCohomology := C.effectiveCohomology
  admissibleClassBridge := C.admissibleBridge
  classificationTheoremTerm := C.bridgeFromConstructions
    (C.extensionConstruction.toMetabelian)
    (C.liftingConstruction.toSchurMultiplier)
    C.admissibleBridgeTerm C.effectiveCohomologyTerm
  effectiveCohomologyTerm := C.effectiveCohomologyTerm
  admissibleClassBridgeTerm := C.admissibleBridgeTerm
}

end AbelianMetabelianExtensionsTheoremCanonicalLaneLean
end HautevilleHouse