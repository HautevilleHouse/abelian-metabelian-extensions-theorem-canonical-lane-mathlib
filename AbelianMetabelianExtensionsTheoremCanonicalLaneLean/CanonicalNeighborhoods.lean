import Mathlib

/-!
# Canonical Neighborhoods for Abelian Metabelian Extensions

This file encodes the admissible-class bridge for the Abelian Metabelian Extensions Theorem.
-/

namespace CanonicalLane
namespace AbelianMetabelianExtensionsTheorem

-- We assume groups N, G, Q with a short exact sequence 1 -> N -> G -> Q -> 1.
structure ExtensionData (N G Q : Type*) [Group N] [Group G] [Group Q] where
  incl : N →* G
  proj : G →* Q
  injective_incl : Function.Injective incl
  surjective_proj : Function.Surjective proj
  exact_image : incl.range = proj.ker

-- The canonical package for an extension.
structure CanonicalNeighborhoodsPackage {N G Q : Type*} [Group N] [Group G] [Group Q]
    (E : ExtensionData N G Q) where
  abelianKernel : Prop
  metabelianQuotient : Prop
  extensionSolvable : Prop
  admissibleClass : Prop

-- Evidence that the package is closed.
structure CanonicalNeighborhoodsEvidence {N G Q : Type*} [Group N] [Group G] [Group Q]
    {E : ExtensionData N G Q} (C : CanonicalNeighborhoodsPackage E) where
  abelianKernel_closed : C.abelianKernel
  metabelianQuotient_closed : C.metabelianQuotient
  extensionSolvable_closed : C.extensionSolvable
  admissibleClass_closed : C.admissibleClass

-- The closed condition as a conjunction.
def CanonicalNeighborhoodsClosed {N G Q : Type*} [Group N] [Group G] [Group Q]
    {E : ExtensionData N G Q} (C : CanonicalNeighborhoodsPackage E) : Prop :=
  C.abelianKernel ∧ C.metabelianQuotient ∧ C.extensionSolvable ∧ C.admissibleClass

-- Bridge theorem: from evidence we obtain the closed condition.
theorem canonicalNeighborhoods_closed_from_evidence
    {N G Q : Type*} [Group N] [Group G] [Group Q]
    {E : ExtensionData N G Q} (C : CanonicalNeighborhoodsPackage E)
    (Ev : CanonicalNeighborhoodsEvidence C) :
    CanonicalNeighborhoodsClosed C := by
  exact And.intro Ev.abelianKernel_closed
    (And.intro Ev.metabelianQuotient_closed
      (And.intro Ev.extensionSolvable_closed Ev.admissibleClass_closed))

end AbelianMetabelianExtensionsTheorem
end CanonicalLane