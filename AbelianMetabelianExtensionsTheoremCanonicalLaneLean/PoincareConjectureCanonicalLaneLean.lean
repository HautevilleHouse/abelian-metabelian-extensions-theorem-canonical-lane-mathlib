/-
All Rights Reserved - No License Granted

Copyright (c) 2026 HautevilleHouse. All rights reserved.

This repository is published for academic review, citation, priority, public
notice, and research-reference purposes only.

No license is granted to use, copy, reproduce, redistribute, modify, merge,
publish, distribute, sublicense, sell, fork, mirror, scrape, use for training or
fine-tuning, include in a dataset or benchmark, use to create, evaluate, or
benchmark a derivative system, incorporate into another system, or create
derivative works from this repository or any substantial portion of it without
prior written permission from the rights holder.

Viewing this repository on GitHub for academic review and citation is permitted
with all rights reserved by the rights holder.

Any discussion, review, comparison, implementation, derivative research use, or
public reference to this repository must cite the repository and preserve this
notice.

Unauthorized reproduction or redistribution of this repository, including public
GitHub forks containing the repository contents, constitutes copyright
infringement and may be subject to DMCA.
-/
-
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
  intro a b
  apply Subtype.ext
  exact h a.1 b.1

/-- Any extension of an abelian group by an abelian group is metabelian. -/
lemma abelian_extension_is_metabelian {A B G : Type u} [Group A] [Group B] [Group G]
    (hA : IsAbelian A) (hB : IsAbelian B) (e : GroupExtension A B G) : IsMetabelian G := by
  unfold IsMetabelian IsAbelian
  -- Derived subgroup is contained in inj.range
  have hder_le_range : derivedSubgroup G ≤ inj.range := by
    rw [e.exact]
    apply Subgroup.closure_le.mpr
    rintro x ⟨a, b, rfl⟩
    show a * b * a⁻¹ * b⁻¹ ∈ prj.ker
    change prj (a * b * a⁻¹ * b⁻¹) = 1
    have hcomm : prj a * prj b = prj b * prj a := hB _ _
    rw [map_mul, map_mul, map_mul, map_inv, map_inv, hcomm]
    group
  -- inj.range is abelian
  have hrange_abelian : IsAbelian (inj.range) := by
    intro x y
    apply Subtype.ext
    rcases Subgroup.mem_range.mp x.2 with ⟨a, ha⟩
    rcases Subgroup.mem_range.mp y.2 with ⟨b, hb⟩
    rw [← ha, ← hb]
    simpa [map_mul] using congrArg inj (hA a b)
  -- derived subgroup is a subgroup of an abelian subgroup
  intro x y
  apply Subtype.ext
  have hxy : (⟨x.1, hder_le_range x.2⟩ : inj.range) * ⟨y.1, hder_le_range y.2⟩ =
             ⟨y.1, hder_le_range y.2⟩ * ⟨x.1, hder_le_range x.2⟩ := hrange_abelian _ _
  simpa using congrArg Subtype.val hxy

/-- The classical characterization: a group is metabelian iff it is an extension of an abelian group by an abelian group. -/
theorem abelian_metabelian_extension_iff (G : Type u) [Group G] :
    IsMetabelian G ↔ IsAbelianMetabelianExtension G := by
  constructor
  · intro h
    refine ⟨derivedSubgroup G, G ⧸ derivedSubgroup G, inferInstance, inferInstance, ?_, ?_, ?_⟩
    · exact h
    · -- IsAbelian (G ⧸ derivedSubgroup G)
      intro x y
      refine Quotient.induction_on x ?_
      intro a
      refine Quotient.induction_on y ?_
      intro b
      rw [← QuotientGroup.mk_mul, ← QuotientGroup.mk_mul]
      apply QuotientGroup.eq.mpr
      have hcomm : (a * b)⁻¹ * (b * a) = b⁻¹ * a⁻¹ * b * a := by group
      rw [hcomm]
      exact Subgroup.subset_closure ⟨b⁻¹, a⁻¹, by group⟩
    · -- Nonempty (GroupExtension (derivedSubgroup G) (G ⧸ derivedSubgroup G) G)
      refine ⟨{ inj := (derivedSubgroup G).subtype
                 prj := QuotientGroup.mk' (derivedSubgroup G)
                 inj_injective := ?_
                 prj_surjective := ?_
                 exact := ?_ }⟩
      · -- inj_injective
        intro a b h
        exact Subtype.ext h
      · -- prj_surjective
        intro q
        refine Quotient.induction_on q ?_
        intro a
        exact ⟨a, rfl⟩
      · -- exact
        rw [Subgroup.range_subtype, QuotientGroup.ker_mk']
  · intro ⟨A, B, instA, instB, hA, hB, e⟩
    exact abelian_extension_is_metabelian hA hB e

/-- The admissible-class bridge: the metabelian property is equivalent to the existence of an abelian-abelian extension. -/
def BridgeEquivalence (G : Type u) [Group G] :
    IsMetabelian G ≃ IsAbelianMetabelianExtension G where
  toFun := (abelian_metabelian_extension_iff G).mp
  invFun := (abelian_metabelian_extension_iff G).mpr
  left_inv := by
    intro h
    exact Subsingleton.elim _ _
  right_inv := by
    intro h
    exact Subsingleton.elim _ _

/-- The canonical extension structure for a metabelian group, using its derived subgroup and quotient. -/
def canonicalDerivedExtension (G : Type u) [Group G] (h : IsMetabelian G) :
    GroupExtension (derivedSubgroup G) (G ⧸ derivedSubgroup G) G :=
{ inj := (derivedSubgroup G).subtype
  prj := QuotientGroup.mk' (derivedSubgroup G)
  inj_injective := by intro a b hab; exact Subtype.ext hab
  prj_surjective := by
    intro q
    refine Quotient.induction_on q ?_
    intro a
    exact ⟨a, rfl⟩
  exact := by
    rw [Subgroup.range_subtype, QuotientGroup.ker_mk']
}

/-- The canonical abelian extension data for a metabelian group. -/
def canonicalAbelianExtension (G : Type u) [Group G] (h : IsMetabelian G) :
    IsAbelianMetabelianExtension G :=
  ⟨derivedSubgroup G, G ⧸ derivedSubgroup G, inferInstance, inferInstance,
    by unfold IsMetabelian at h; exact h,
    by
      intro x y
      refine Quotient.induction_on x ?_
      intro a
      refine Quotient.induction_on y ?_
      intro b
      rw [← QuotientGroup.mk_mul, ← QuotientGroup.mk_mul]
      apply QuotientGroup.eq.mpr
      have hcomm : (a * b)⁻¹ * (b * a) = b⁻¹ * a⁻¹ * b * a := by group
      rw [hcomm]
      exact Subgroup.subset_closure ⟨b⁻¹, a⁻¹, by group⟩,
    ⟨canonicalDerivedExtension G h⟩⟩

end AbelianMetabelianExtensions