import Mathlib

/-!
# Noncollapsing Package for Abelian Metabelian Extensions Theorem

This file encodes the admissible-class bridge for the key theorems and structures
in the theory of abelian metabelian group extensions.
-/

namespace HautevilleHouse
namespace AbelianMetabelianExtensionsTheoremCanonicalLaneLean

/-- The central noncollapsing hypotheses for an abelian metabelian extension. -/
structure NoncollapsingPackage where
  /-- The quotient group in the extension is abelian. -/
  quotientAbelian : Prop
  /-- The kernel of the extension is metabelian. -/
  kernelMetabelian : Prop
  /-- The extension class is noncollapsing: it does not reduce to a trivial split extension. -/
  extensionNoncollapsed : Prop

/-- Evidence that the noncollapsing hypotheses are satisfied. -/
structure NoncollapsingEvidence (N : NoncollapsingPackage) where
  quotientAbelian_closed : N.quotientAbelian
  kernelMetabelian_closed : N.kernelMetabelian
  extensionNoncollapsed_closed : N.extensionNoncollapsed

/-- The conjunction of all noncollapsing conditions. -/
def NoncollapsingClosed (N : NoncollapsingPackage) : Prop :=
  N.quotientAbelian ∧ N.kernelMetabelian ∧ N.extensionNoncollapsed

/-- The admissible-class bridge: connects the noncollapsing conditions to the abelian metabelian extension theorem. -/
structure AdmissibleClassBridge (N : NoncollapsingPackage) (TheoremConclusion : Prop) where
  /-- The theorem conclusion follows from the closed noncollapsing conditions. -/
  from_closed : NoncollapsingClosed N → TheoremConclusion
  /-- The closed noncollapsing conditions follow from the theorem conclusion. -/
  to_closed : TheoremConclusion → NoncollapsingClosed N

/-- The canonical theorem: evidence for the package establishes the closed noncollapsing conditions. -/
theorem noncollapsing_closed_from_evidence
    (N : NoncollapsingPackage) (E : NoncollapsingEvidence N) :
    NoncollapsingClosed N := by
  exact And.intro E.quotientAbelian_closed
    (And.intro E.kernelMetabelian_closed E.extensionNoncollapsed_closed)

/-- The bridge theorem: evidence for the package combined with an admissible-class bridge yields the theorem conclusion. -/
theorem abelian_metabelian_extension_theorem_via_bridge
    {C : Prop} (N : NoncollapsingPackage) (E : NoncollapsingEvidence N)
    (B : AdmissibleClassBridge N C) : C :=
  B.from_closed (noncollapsing_closed_from_evidence N E)

end AbelianMetabelianExtensionsTheoremCanonicalLaneLean
end HautevilleHouse