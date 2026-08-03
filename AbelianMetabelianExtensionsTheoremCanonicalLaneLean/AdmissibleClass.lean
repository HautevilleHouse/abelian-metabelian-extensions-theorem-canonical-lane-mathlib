namespace HautevilleHouse
namespace AbelianMetabelianExtensionsTheoremCanonicalLaneLean

structure AbelianMetabelianExtensionObject where
  kernel : Type
  total : Type
  quotient : Type
  kernelAbelian : Prop
  totalMetabelian : Prop
  extensionShortExact : Prop
  conclusion : Prop
  conclusionTerm : conclusion

structure AdmissibleClass where
  object : AbelianMetabelianExtensionObject
  endpointSatisfied : Prop
  remainderRecorded : Prop
  gateWitness : endpointSatisfied ∨ remainderRecorded

def AbelianMetabelianWitnessClosed (O : AbelianMetabelianExtensionObject) : Prop :=
  O.conclusion

def admittedClosure (A : AdmissibleClass) : Prop :=
  AbelianMetabelianWitnessClosed A.object ∧ (A.endpointSatisfied ∨ A.remainderRecorded)

end AbelianMetabelianExtensionsTheoremCanonicalLaneLean
end HautevilleHouse