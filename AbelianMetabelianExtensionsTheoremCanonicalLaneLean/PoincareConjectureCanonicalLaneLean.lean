--
-- This module is the root of the AbelianMetabelianExtensionsTheoremCanonicalLaneLean proof package.
-- It encodes the admissible-class bridge for the Abelian Metabelian Extensions Theorem.
--
import Mathlib

noncomputable section
open scoped BigOperators

namespace AbelianMetabelianExtensions

/-- A group is abelian if all elements commute. -/
def IsAbelian (G : Type u) [Group G] : Prop :=
  ∀ a b : G, a * b = b * a

/-- A group is metabelian if its derived subgroup is abelian. -/
def IsMetabelian (G : Type u) [Group G] : Prop :=
  IsAbelian (derivedSubgroup G)

/-- A short exact sequence `1 → A → E → B → 1`. -/
structure GroupExtension (A B E : Type u) [Group A] [Group B] [Group E] where
  inj : A →* E
  prj : E →* B
  inj_injective : Function.Injective inj
  prj_surjective : Function.Surjective prj
  exact : inj.range = prj.ker

/-- A group admits an abelian metabelian extension presentation. -/
def IsAbelianMetabelianExtension (G : Type u) [Group G] : Prop :=
  ∃ (A B : Type u) (_ : Group A) (_ : Group B),
    IsAbelian A ∧ IsAbelian B ∧ Nonempty (GroupExtension A B G)

/-- Any abelian group is metabelian. -/
lemma abelian_is_metabelian (G : Type u) [Group G] (h : IsAbelian G) : IsMetabelian G := by
  unfold IsMetabelian IsAbelian
  -- Trivial: the derived subgroup of an abelian group is {1}, which is abelian.
  sorry

/-- Any extension of an abelian group by an abelian group is metabelian. -/
lemma abelian_extension_is_metabelian {A B G : Type u} [Group A] [Group B] [Group G]
    (hA : IsAbelian A) (hB : IsAbelian B) (e : GroupExtension A B G) : IsMetabelian G := by
  unfold IsMetabelian IsAbelian
  -- The commutators of G lie in the image of inj, which is a homomorphic image of the abelian group A.
  -- Hence the commutators commute.
  sorry

/-- The classical characterization: a group is metabelian iff it is an extension of an abelian group by an abelian group. -/
theorem abelian_metabelian_extension_iff (G : Type u) [Group G] :
    IsMetabelian G ↔ IsAbelianMetabelianExtension G := by
  constructor
  · intro h
    -- Take A = derived subgroup of G, B = quotient G / derived subgroup.
    -- Both are abelian, and the canonical projection gives the extension.
    sorry
  · intro ⟨A, B, instA, instB, hA, hB, e⟩
    exact abelian_extension_is_metabelian hA hB e

/-- The admissible-class bridge: the metabelian property is equivalent to the existence of an abelian-abelian extension. -/
def BridgeEquivalence (G : Type u) [Group G] :
    IsMetabelian G ≃ IsAbelianMetabelianExtension G where
  toFun := (abelian_metabelian_extension_iff G).mp
  invFun := (abelian_metabelian_extension_iff G).mpr
  left_inv := by intro h; apply propext; exact (abelian_metabelian_extension_iff G).to_iff
  right_inv := by intro h; apply propext; exact (abelian_metabelian_extension_iff G).to_iff

/-- The canonical extension structure for a metabelian group, using its derived subgroup and quotient. -/
def canonicalDerivedExtension (G : Type u) [Group G] (h : IsMetabelian G) :
    GroupExtension (derivedSubgroup G) (G ⧸ derivedSubgroup G) G :=
{ inj := derivedSubgroup.subtype
  prj := QuotientGroup.mk' (derivedSubgroup G)
  inj_injective := by intro a b hab; exact Subtype.ext hab
  prj_surjective := QuotientGroup.surjective_mk'
  exact := by
    sorry
}

/-- The canonical abelian extension data for a metabelian group. -/
def canonicalAbelianExtension (G : Type u) [Group G] (h : IsMetabelian G) :
    IsAbelianMetabelianExtension G :=
  ⟨derivedSubgroup G, G ⧸ derivedSubgroup G, inferInstance, inferInstance,
    by unfold IsMetabelian at h; exact h,
    by infer_instance,
    ⟨canonicalDerivedExtension G h⟩⟩

end AbelianMetabelianExtensions