import PoincareConjectureCanonicalLaneLean.Surgery

/-!
# Abelian Metabelian Extensions Theorem Package
-/

namespace HautevilleHouse
namespace AbelianMetabelianExtensionsTheoremCanonicalLaneLean

structure AbelianMetabelianExtensionsPackage where
  abelianKernel : Prop
  metabelianQuotient : Prop
  extensionExact : Prop
  admissibleBridge : Prop

structure AbelianMetabelianExtensionsEvidence (Z : AbelianMetabelianExtensionsPackage) where
  abelianKernelClosed : Z.abelianKernel
  metabelianQuotientClosed : Z.metabelianQuotient
  extensionExactClosed : Z.extensionExact
  admissibleBridgeClosed : Z.admissibleBridge

def AbelianMetabelianExtensionsClosed (Z : AbelianMetabelianExtensionsPackage) : Prop :=
  Z.abelianKernel ∧ Z.metabelianQuotient ∧ Z.extensionExact ∧ Z.admissibleBridge

theorem abelian_metabelian_extensions_closed_from_evidence
    (Z : AbelianMetabelianExtensionsPackage)
    (E : AbelianMetabelianExtensionsEvidence Z) :
    AbelianMetabelianExtensionsClosed Z := by
  exact And.intro E.abelianKernelClosed
    (And.intro E.metabelianQuotientClosed
      (And.intro E.extensionExactClosed E.admissibleBridgeClosed))

end AbelianMetabelianExtensionsTheoremCanonicalLaneLean
end HautevilleHouse