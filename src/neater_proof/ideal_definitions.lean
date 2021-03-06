import neater_proof.rings_and_properties

local infixr ` + ` : 80 := plus
local infixr ` * ` : 80 := mult

/-- As with the definition of Ring, this is standard, see, e.g.:
    https://en.wikipedia.org/wiki/Ideal_(ring_theory) -/
structure Ideal (R : Ring) :=
(I : set R.R)
(ideal_axioms : (zero ∈ I
               ∧ (∀ x y : R.R, x ∈ I → y ∈ I → x + y ∈ I)
               ∧ (∀ x x' : R.R, x + x' = zero → x ∈ I → x' ∈ I))
              ∧ ((∀ x y : R.R, x ∈ I → x * y ∈ I)
               ∧ (∀ x y : R.R, x ∈ I → y * x ∈ I)))

def subgroup_under_addition {R : Ring} (I : Ideal R) :=
I.ideal_axioms.1

def multiplication_conditions {R : Ring} (I : Ideal R) :=
I.ideal_axioms.2

def zero_mem_Ideal {R : Ring} (I : Ideal R) : zero ∈ I.I :=
(subgroup_under_addition I).1

-- i am undecided about whether or not to add more definitions for the various axioms

/-- This result is fundamental to the proof, and will be used for every sub-lemma of the main
    theorem. It tells us that it is sufficient, for two Ideals to be identical, that their 
    underlying sets are identical; this is essentially a consequence of a feature of lean called 
    'proof irrelevance' - if two proofs prove the same proposition, then they are equal. -/
lemma ideal_equality_condition {R : Ring} : ∀ I I' : Ideal R, I.I = I'.I → I = I' :=
begin
 intros I I' h,
 have h' : ((zero ∈ I.I
         ∧ (∀ x y : R.R, x ∈ I.I → y ∈ I.I → x + y ∈ I.I)
         ∧ (∀ x x' : R.R, x + x' = zero → x ∈ I.I → x' ∈ I.I))
        ∧ ((∀ x y : R.R, x ∈ I.I → x * y ∈ I.I)
         ∧ (∀ x y : R.R, x ∈ I.I → y * x ∈ I.I)))
                               ↔
          ((zero ∈ I'.I
         ∧ (∀ x y : R.R, x ∈ I'.I → y ∈ I'.I → x + y ∈ I'.I)
         ∧ (∀ x x' : R.R, x + x' = zero → x ∈ I'.I → x' ∈ I'.I))
        ∧ ((∀ x y : R.R, x ∈ I'.I → x * y ∈ I'.I)
         ∧ (∀ x y : R.R, x ∈ I'.I → y * x ∈ I'.I))),
 { split,
   { intro h',
     rw ← h,
     exact h', },
   { intro h',
     rw h,
     exact h' },
 },
 have h'' := propext h',
 cases I,
 cases I',
 congr,
 assumption,
end
