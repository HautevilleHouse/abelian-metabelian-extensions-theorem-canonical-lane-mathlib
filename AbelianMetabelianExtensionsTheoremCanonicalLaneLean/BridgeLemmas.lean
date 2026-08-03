import AbelianMetabelianExtensionsTheoremCanonicalLaneLean.AdmissibleClass

namespace HautevilleHouse
namespace AbelianMetabelianExtensionsTheoremCanonicalLaneLean

def bridgeClosed (A : AdmissibleClass) : Prop :=
  AbelianMetabelianWitnessClosed A.object

theorem bridge_from_admissible_class (A : AdmissibleClass) :
    bridgeClosed A := by
  exact A.object.conclusionTerm

end AbelianMetabelianExtensionsTheoremCanonicalLaneLean
end HautevilleHouse