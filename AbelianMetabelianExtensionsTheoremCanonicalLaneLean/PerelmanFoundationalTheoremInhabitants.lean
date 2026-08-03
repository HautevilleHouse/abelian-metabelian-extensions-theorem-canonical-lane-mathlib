import AbelianMetabelianExtensionsTheoremCanonicalLaneLean.AbelianMetabelianEvidenceTerms

/-!
# Abelian Metabelian Extensions Theorem Inhabitants

This module gives the term-level interface for the foundational theorem
inhabitants. A complete formalization of abelian metabelian extensions
supplies these records; the records then construct the admissible-class
bridge, route cohomological evidence, and establish the metabelian
classification.
-/

namespace HautevilleHouse
namespace AbelianMetabelianExtensionsTheoremCanonicalLaneLean

structure MinimalGroupExtensionInhabitants where
  extensionDefined : Prop
  kernelAbelian : Prop
  quotientAbelian : Prop
  exactnessHolds : Prop
  extensionDefinedTerm : extensionDefined
  kernelAbelianTerm : kernelAbelian
  quotientAbelianTerm : quotientAbelian
  exactnessHoldsTerm : exactnessHolds

structure MetabelianBridgeInhabitants where
  derivedSubgroup : Prop
  derivedSubgroupAbelian : Prop
  derivedSubgroupNormal : Prop
  quotientDerivedAbelian : Prop
  metabelianEquivalence : Prop
  derivedSubgroupTerm : derivedSubgroup
  derivedSubgroupAbelianTerm : derivedSubgroupAbelian
  derivedSubgroupNormalTerm : derivedSubgroupNormal
  quotientDerivedAbelianTerm : quotientDerivedAbelian
  metabelianEquivalenceTerm : metabelianEquivalence

structure CohomologyExtensionInhabitants where
  groupCohomologyDefined : Prop
  cocycleSpace : Prop
  coboundarySpace : Prop
  secondCohomologyGroup : Prop
  extensionCohomologyClass : Prop
  actionCompatibility : Prop
  groupCohomologyDefinedTerm : groupCohomologyDefined
  cocycleSpaceTerm : cocycleSpace
  coboundarySpaceTerm : coboundarySpace
  secondCohomologyGroupTerm : secondCohomologyGroup
  extensionCohomologyClassTerm : extensionCohomologyClass
  actionCompatibilityTerm : actionCompatibility

structure AdmissibleClassBridgeInhabitants where
  extensionToClass : Prop
  classToExtension : Prop
  classWellDefined : Prop
  extensionWellDefined : Prop
  inverseOnExtensions : Prop
  inverseOnClasses : Prop
  bijectionEstablished : Prop
  extensionToClassTerm : extensionToClass
  classToExtensionTerm : classToExtension
  classWellDefinedTerm : classWellDefined
  extensionWellDefinedTerm : extensionWellDefined
  inverseOnExtensionsTerm : inverseOnExtensions
  inverseOnClassesTerm : inverseOnClasses
  bijectionEstablishedTerm : bijectionEstablished

structure AbelianMetabelianExtensionsTheoremInhabitants where
  extension : MinimalGroupExtensionInhabitants
  metabelian : MetabelianBridgeInhabitants
  cohomology : CohomologyExtensionInhabitants
  bridge : AdmissibleClassBridgeInhabitants

end AbelianMetabelianExtensionsTheoremCanonicalLaneLean
end HautevilleHouse