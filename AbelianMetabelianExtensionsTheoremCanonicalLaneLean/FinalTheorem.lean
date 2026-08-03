import AbelianMetabelianExtensionsTheoremCanonicalLaneLean.GateLemmas

namespace HautevilleHouse
namespace AbelianMetabelianExtensionsTheoremCanonicalLaneLean

def ConstrainedAbelianMetabelianClosure (A : AdmissibleClass) : Prop :=
  bridgeClosed A ∧ gateClosed A

theorem constrained_abelian_metabelian_endgame (A : AdmissibleClass) :
    ConstrainedAbelianMetabelianClosure A := by
  exact And.intro (bridge_from_admissible_class A) (gate_from_admissible_class A)

end AbelianMetabelianExtensionsTheoremCanonicalLaneLean
end HautevilleHouse