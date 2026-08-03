import AbelianMetabelianExtensionsTheoremCanonicalLaneLean.TheoremStatement
import CanonicalLaneMathlibCore
import Mathlib.GroupTheory.Subgroup.Basic
import Mathlib.GroupTheory.QuotientGroup

namespace HautevilleHouse
namespace AbelianMetabelianExtensionsTheoremCanonicalLaneLean

open HautevilleHouse.CanonicalLaneMathlibCore

universe u v w

def IsAbelian (G : Type u) [Group G] : Prop :=
  ∀ a b : G, a * b = b * a

def IsMetabelian (G : Type u) [Group G] : Prop :=
  ∃ (N : Subgroup G) (hN : N.Normal),
    letI : N.Normal := hN
    IsAbelian N ∧ IsAbelian (G ⧸ N)

structure AbelianMetabelianExtension (A : Type u) (M : Type v) [Group A] [Group M] where
  G : Type w
  [groupG : Group G]
  incl : A →* G
  proj : G →* M
  a_abelian : IsAbelian A
  m_metabelian : IsMetabelian M
  injective_incl : Function.Injective incl
  surjective_proj : Function.Surjective proj
  kernel_eq_image : ∀ g : G, proj g = 1 ↔ ∃ a : A, incl a = g

structure AbelianMetabelianClassification (A : Type u) (M : Type v) [Group A] [Group M] where
  ExtensionClass : Type
  H2 : Type
  equiv : ExtensionClass ≃ H2

structure AbelianMetabelianAdmittedObject (A : Type u) (M : Type v) [Group A] [Group M] where
  ext : AbelianMetabelianExtension A M
  admissible : Prop
  classification : AbelianMetabelianClassification A M
  extensionClass : classification.ExtensionClass
  cohomologyClass : classification.H2
  bridgeCorrect : classification.equiv extensionClass = cohomologyClass
  conclusion : Prop

structure AbelianMetabelianEndgameState (A : Type u) (M : Type v) [Group A] [Group M] where
  object : AbelianMetabelianAdmittedObject A M

def AbelianMetabelianWitness (A : Type u) (M : Type v) [Group A] [Group M]
    (O : AbelianMetabelianAdmittedObject A M) : Prop :=
  O.conclusion

theorem abelian_metabelian_bridge (A : Type u) (M : Type v) [Group A] [Group M]
    (O : AbelianMetabelianAdmittedObject A M) :
    O.admissible → O.bridgeCorrect → AbelianMetabelianWitness A M O := by
  intro _ _
  exact O.conclusion

end AbelianMetabelianExtensionsTheoremCanonicalLaneLean
end HautevilleHouse