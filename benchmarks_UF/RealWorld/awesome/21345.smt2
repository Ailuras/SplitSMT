(set-option :produce-unsat-cores true) ; enable generation of unsat cores
(set-option :produce-models true) ; enable model generation
(set-logic ALL)
(declare-fun split_at (String String Int) String)
(declare-fun split_rest (String String Int) String)
(declare-fun num_splits (String String) Int)
(declare-fun split_at_re (String RegLan Int) String)
(declare-fun split_rest_re (String RegLan Int) String)
(declare-fun num_splits_re (String RegLan) Int)

(define-fun get_split_length ((x String) (d String) (limit Int)) Int
  (ite
    (> limit 0)
    (ite (< (num_splits x d) limit)
         (num_splits x d)
         limit)
    (num_splits x d)
  )
)

(define-fun get_split_element ((x String) (d String) (limit Int) (i Int)) String
  (ite
    (and (> limit 0)
         (= i (- limit 1))
         (>= (num_splits x d) limit))
    (split_rest x d (- limit 1))
    (split_at x d i)
  )
)

(define-fun get_split_length_re ((x String) (d RegLan) (limit Int)) Int
  (ite
    (> limit 0)
    (ite (< (num_splits_re x d) limit)
         (num_splits_re x d)
         limit)
    (num_splits_re x d)
  )
)

(define-fun get_split_element_re ((x String) (d RegLan) (limit Int) (i Int)) String
  (ite
    (and (> limit 0)
         (= i (- limit 1))
         (>= (num_splits_re x d) limit))
    (split_rest_re x d (- limit 1))
    (split_at_re x d i)
  )
)

(declare-sort var2680 0)
(declare-sort var3031 0)
(declare-sort var290 0)
(declare-sort var1894 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun getPhrase/-292787131 (var290) String)
(declare-fun var3031_containsKey/1421819118 (var3031 var1894) Bool)
(declare-fun cast-from-var290-to-var1894 (var290) var1894)
(declare-fun var3031_getCount/958668014 (var3031 var1894) Float64)
(declare-const null-var2680 var2680)
(declare-const null-var3031 var3031)
(declare-const null-var290 var290)
(declare-const null-Float64 Float64)
(declare-const var886 var2680) ; Statement: r3 := @this: edu.stanford.nlp.patterns.PhraseScorer 
(assert (not (= var886 null-var2680)))
(declare-const var3592 var3031) ; Statement: r6 := @parameter0: edu.stanford.nlp.stats.Counter 
(assert (not (= var3592 null-var3031)))
(declare-const var795 var290) ; Statement: r0 := @parameter1: edu.stanford.nlp.patterns.CandidatePhrase 
(assert (not (= var795 null-var290)))
(declare-const var1760 Float64) ; Statement: d2 := @parameter2: double 
(assert (not (= var1760 null-Float64)))
(assert true)
(define-const var3246 String (getPhrase/-292787131 var795)) ; Statement: $r1 = virtualinvoke r0.<edu.stanford.nlp.patterns.CandidatePhrase: java.lang.String getPhrase()>() 
; split operation: var2202 = var3246.split("\u005cs+") ; Statement: r2 = virtualinvoke $r1.<java.lang.String: java.lang.String[] split(java.lang.String)>("\\s+") 
(define-const var3086 Int (get_split_length_re var3246 (re.+ (re.union (str.to_re " ") (str.to_re "\u{09}"))) (- 1))) ; Statement: $i0 = lengthof r2 
 ; Statement: if $i0 >= 2 goto d4 = 0.0 
(assert (not (>= var3086 2))) ; Negate: Cond: $i0 >= 2  
(define-const var732 Bool (var3031_containsKey/1421819118 var3592 (cast-from-var290-to-var1894 var795))) ; Statement: $z2 = interfaceinvoke r6.<edu.stanford.nlp.stats.Counter: boolean containsKey(java.lang.Object)>(r0) 
 ; Statement: if $z2 == 0 goto return d2 
(assert (not (= (ite var732 1 0) 0))) ; Negate: Cond: $z2 == 0  
(define-const var120 Float64 (var3031_getCount/958668014 var3592 (cast-from-var290-to-var1894 var795))) ; Statement: $d3 = interfaceinvoke r6.<edu.stanford.nlp.stats.Counter: double getCount(java.lang.Object)>(r0) 
 ; Statement: return $d3 
; {getPhrase/-292787131=([edu.stanford.nlp.patterns.CandidatePhrase], java.lang.String), var3031_containsKey/1421819118=([edu.stanford.nlp.stats.Counter, java.lang.Object], boolean), cast-from-var290-to-var1894=([edu.stanford.nlp.patterns.CandidatePhrase], java.lang.Object), var3031_getCount/958668014=([edu.stanford.nlp.stats.Counter, java.lang.Object], double)}
; {var2680=edu.stanford.nlp.patterns.PhraseScorer, var886=r3, var3031=edu.stanford.nlp.stats.Counter, var3592=r6, var290=edu.stanford.nlp.patterns.CandidatePhrase, var795=r0, var1760=d2, var3246=$r1, var2202=r2, var3086=$i0, var1894=java.lang.Object, var732=$z2, var120=$d3}
; {edu.stanford.nlp.patterns.PhraseScorer=var2680, r3=var886, edu.stanford.nlp.stats.Counter=var3031, r6=var3592, edu.stanford.nlp.patterns.CandidatePhrase=var290, r0=var795, d2=var1760, $r1=var3246, r2=var2202, $i0=var3086, java.lang.Object=var1894, $z2=var732, $d3=var120}
;seq <java.lang.String: java.lang.String[] split(java.lang.String)>
;cnt {"<java.lang.String: java.lang.String[] split(java.lang.String)>": 1}
;stmts r3 := @this: edu.stanford.nlp.patterns.PhraseScorer;	r6 := @parameter0: edu.stanford.nlp.stats.Counter;	r0 := @parameter1: edu.stanford.nlp.patterns.CandidatePhrase;	d2 := @parameter2: double;	$r1 = virtualinvoke r0.<edu.stanford.nlp.patterns.CandidatePhrase: java.lang.String getPhrase()>();	r2 = virtualinvoke $r1.<java.lang.String: java.lang.String[] split(java.lang.String)>("\\s+");	$i0 = lengthof r2;	if $i0 >= 2 goto d4 = 0.0;	$z2 = interfaceinvoke r6.<edu.stanford.nlp.stats.Counter: boolean containsKey(java.lang.Object)>(r0);	if $z2 == 0 goto return d2;	$d3 = interfaceinvoke r6.<edu.stanford.nlp.stats.Counter: double getCount(java.lang.Object)>(r0);	return $d3
;block_num 3
(check-sat)
(exit)
