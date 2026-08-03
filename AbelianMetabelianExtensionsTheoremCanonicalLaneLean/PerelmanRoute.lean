import Mathlib.GroupTheory.Subgroup
import Mathlib.GroupTheory.Solvable
import Mathlib.GroupTheory.Abelianization
import Mathlib.GroupTheory.QuotientGroup
import Mathlib.Algebra.Group.Defs
import Mathlib.Algebra.Group.Hom.Defs

/-!
# Abelian Metabelian Extensions: Admissible-Class Bridge

This module records the theorem-route obligations that connect the Abelian
Metabelian Extensions Theorem to its algebraic proof route. The route requires
a short exact sequence with an abelian kernel and a metabelian quotient, together
with splitness and cohomological vanishing conditions that ensure the admissible
class of the extension is captured.
-/

namespace AbelianMetabelianExtensionsTheoremCanonicalLaneLean

open scoped BigOperators

/-- A group is abelian when all elements commute. -/
def IsAbelianGroup (G : Type u) [Mul G] : Prop :=
  ∀ a b : G, a * b = b * a

/-- A group is metabelian when its derived subgroup is abelian. This is recorded
via the existence of a normal subgroup with abelian quotient and abelian carrier.
For the purposes of the admissible class bridge this is a formalization obligation
that can be expanded to the standard derived-series definition. -/
def IsMetabelianGroup (G : Type u) [Group G] : Prop :=
  ∃ N : Subgroup G, N.Normal ∧ IsAbelianGroup {x : G // x ∈ N} ∧ IsAbelianGroup (G ⧸ N)

/-- Data for a short exact sequence `1 → A → G → Q → 1`. -/
structure AbelianMetabelianExtensionData (A G Q : Type u) [Group A] [Group G] [Group Q] where
  f : A →* G
  g : G →* Q
  f_injective : Function.Injective f
  g_surjective : Function.Surjective g
  exact_at_G : f.range = g.ker

/-- The Admissible Class Bridge obligations for the Abelian Metabelian Extensions Theorem. -/
structure AbelianMetabelianExtensionsObligations where
  kernel_abelian : Prop
  quotient_metabelian : Prop
  exact_sequence : Prop
  admissible_extension : Prop
  split_extension : Prop
  cohomology_vanishing : Prop

/-- Closed evidence that each bridge obligation is satisfied. -/
structure AbelianMetabelianExtensionsEvidence (O : AbelianMetabelianExtensionsObligations) where
  kernel_abelian_closed : O.kernel_abelian
  quotient_metabelian_closed : O.quotient_metabelian
  exact_sequence_closed : O.exact_sequence
  admissible_extension_closed : O.admissible_extension
  split_extension_closed : O.split_extension
  cohomology_vanishing_closed : O.cohomology_vanishing

/-- The bridge is closed when every obligation has closed evidence. -/
def AbelianMetabelianExtensionsClosed (O : AbelianMetabelianExtensionsObligations) : Prop :=
  O.kernel_abelian ∧ O.quotient_metabelian ∧ O.exact_sequence ∧ O.admissible_extension ∧ O.split_extension ∧ O.cohomology_vanishing

/-- The algebraic foundation for the theorem route. The fields are the propositions
that must be established by the algebraic development. -/
structure AbelianMetabelianFoundation {G : Type u} [Group G] where
  kernel_abelian : Prop
  quotient_metabelian : Prop
  exact_sequence : Prop
  admissible_extension : Prop
  split_extension : Prop
  cohomology_vanishing : Prop

/-- Evidence for the algebraic foundation, proving each proposition. -/
structure AbelianMetabelianFoundationEvidence {G : Type u} [Group G]
    (F : AbelianMetabelianFoundation G) where
  kernel_abelian_proof : F.kernel_abelian
  quotient_metabelian_proof : F.quotient_metabelian
  exact_sequence_proof : F.exact_sequence
  admissible_extension_proof : F.admissible_extension
  split_extension_proof : F.split_extension
  cohomology_vanishing_proof : F.cohomology_vanishing

/-- Projection from the algebraic foundation into the bridge obligation set. -/
def AbelianMetabelianFoundation.toObligations {G : Type u} [Group G]
    (F : AbelianMetabelianFoundation G) : AbelianMetabelianExtensionsObligations :=
  { kernel_abelian := F.kernel_abelian
    quotient_metabelian := F.quotient_metabelian
    exact_sequence := F.exact_sequence
    admissible_extension := F.admissible_extension
    split_extension := F.split_extension
    cohomology_vanishing := F.cohomology_vanishing }

/-- The admissible class bridge itself, carrying the foundation and its evidence. -/
structure AdmissibleClassBridge {G : Type u} [Group G] where
  foundation : AbelianMetabelianFoundation G
  evidence : AbelianMetabelianFoundationEvidence foundation

/-- The formalization payload that remains to be supplied by the group-theoretic
route: concrete short exact sequences, abelian kernel proofs, metabelian quotient
proofs, and cohomological vanishing. -/
def abelianMetabelianFormalizationPayload : String :=
  "Short exact sequence data, abelian kernel proof, metabelian quotient proof, extension admissibility, splitness, and cohomology vanishing."

/-- Closed bridge evidence gives the closed bridge proposition. -/
theorem abelian_metabelian_closed_from_evidence
    (O : AbelianMetabelianExtensionsObligations)
    (E : AbelianMetabelianExtensionsEvidence O) :
    AbelianMetabelianExtensionsClosed O := by
  exact And.intro E.kernel_abelian_closed
    (And.intro E.quotient_metabelian_closed
      (And.intro E.exact_sequence_closed
        (And.intro E.admissible_extension_closed
          (And.intro E.split_extension_closed
            E.cohomology_vanishing_closed))))

/-- Build the route evidence from the algebraic foundation evidence. -/
def abelian_metabelian_route_evidence_from_foundation
    {G : Type u} [Group G]
    (F : AbelianMetabelianFoundation G)
    (E : AbelianMetabelianFoundationEvidence F) :
    AbelianMetabelianExtensionsEvidence F.toObligations :=
  { kernel_abelian_closed := E.kernel_abelian_proof
    quotient_metabelian_closed := E.quotient_metabelian_proof
    exact_sequence_closed := E.exact_sequence_proof
    admissible_extension_closed := E.admissible_extension_proof
    split_extension_closed := E.split_extension_proof
    cohomology_vanishing_closed := E.cohomology_vanishing_proof }

/-- A closed algebraic foundation closes the bridge obligation set. -/
theorem abelian_metabelian_route_closed_from_foundation
    {G : Type u} [Group G]
    (F : AbelianMetabelianFoundation G)
    (E : AbelianMetabelianFoundationEvidence F) :
    AbelianMetabelianExtensionsClosed F.toObligations := by
  exact abelian_metabelian_closed_from_evidence F.toObligations
    (abelian_metabelian_route_evidence_from_foundation F E)

/-- The admissible class bridge is closed exactly when its foundation evidence is present. -/
theorem admissible_class_bridge_closed
    {G : Type u} [Group G]
    (B : AdmissibleClassBridge G) :
    AbelianMetabelianExtensionsClosed B.foundation.toObligations := by
  exact abelian_metabelian_route_closed_from_foundation B.foundation B.evidence

end AbelianMetabelianExtensionsTheoremCanonicalLaneLean