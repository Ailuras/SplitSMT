(set-option :produce-unsat-cores true) ; enable generation of unsat cores
(set-option :produce-models true) ; enable model generation
(set-logic ALL)

(define-fun get_split_length ((x String) (d String) (limit Int)) Int
  (ite
    (> limit 0)
    (ite (< (str.num_splits x d) limit)
         (str.num_splits x d)
         limit)
    (str.num_splits x d)
  )
)

(define-fun get_split_element ((x String) (d String) (limit Int) (i Int)) String
  (ite
    (and (> limit 0)
         (= i (- limit 1))
         (>= (str.num_splits x d) limit))
    (str.split_rest x d (- limit 1))
    (str.split_at x d i)
  )
)

(declare-sort var2781 0)
(declare-sort var3213 0)
(declare-sort var1711 0)
(declare-sort var2732 0)
(declare-sort var2514 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun constVars/1510098587 (var2781) var1711)
(declare-fun getWordClassClusters/1499979921 (var1711) var2732)
(declare-fun var2732_get/1088891777 (var2732 var2514) var2514)
(declare-fun cast-from-String-to-var2514 (String) var2514)
(declare-fun cast-from-var2514-to-Int (var2514) Int)
(declare-fun OOVExternalFeatWt/1510098587 (var2781) Float64)
(declare-const null-var2781 var2781)
(declare-const null-String String)
(declare-const null-Int Int)
(declare-const var2415 var2781) ; Statement: r0 := @this: edu.stanford.nlp.patterns.PhraseScorer 
(assert (not (= var2415 null-var2781)))
(declare-const var1907 String) ; Statement: r2 := @parameter0: java.lang.String 
(assert (not (= var1907 null-String)))
(declare-const var3083 String) ; Statement: r11 := @parameter1: java.lang.String 
(assert (not (= var3083 null-String)))
(define-const var1775 var1711 (constVars/1510098587 var2415)) ; Statement: $r1 = r0.<edu.stanford.nlp.patterns.PhraseScorer: edu.stanford.nlp.patterns.ConstantsAndVariables constVars> 
(assert true)
(define-const var2928 var2732 (getWordClassClusters/1499979921 var1775)) ; Statement: $r3 = virtualinvoke $r1.<edu.stanford.nlp.patterns.ConstantsAndVariables: java.util.Map getWordClassClusters()>() 
(define-const var854 var2514 (var2732_get/1088891777 var2928 (cast-from-String-to-var2514 var1907))) ; Statement: $r4 = interfaceinvoke $r3.<java.util.Map: java.lang.Object get(java.lang.Object)>(r2) 
(define-const var3843 Int (cast-from-var2514-to-Int var854)) ; Statement: r36 = (java.lang.Integer) $r4 
 ; Statement: if r36 != null goto (branch) 
(assert (not (= var3843 null-Int))) ; Cond: r36 != null 
 ; Statement: if r36 == null goto $r27 = virtualinvoke r2.<java.lang.String: java.lang.String[] split(java.lang.String)>("\\s+") 
(assert (= var3843 null-Int)) ; Cond: r36 == null 
; split operation: var2086 = var1907.split("\u005cs+") ; Statement: $r27 = virtualinvoke r2.<java.lang.String: java.lang.String[] split(java.lang.String)>("\\s+") 
(define-const var727 Int (get_split_length var1907 "\u005cs+" -1)) ; Statement: $i0 = lengthof $r27 
 ; Statement: if $i0 >= 2 goto d4 = 0.0 
(assert (not (>= var727 2))) ; Negate: Cond: $i0 >= 2  
(define-const var3344 Float64 (OOVExternalFeatWt/1510098587 var2415)) ; Statement: $d2 = r0.<edu.stanford.nlp.patterns.PhraseScorer: double OOVExternalFeatWt> 
 ; Statement: return $d2 
(check-sat)
; {constVars/1510098587=([edu.stanford.nlp.patterns.PhraseScorer], edu.stanford.nlp.patterns.ConstantsAndVariables), getWordClassClusters/1499979921=([edu.stanford.nlp.patterns.ConstantsAndVariables], java.util.Map), var2732_get/1088891777=([java.util.Map, java.lang.Object], java.lang.Object), cast-from-String-to-var2514=([java.lang.String], java.lang.Object), cast-from-var2514-to-Int=([java.lang.Object], java.lang.Integer), OOVExternalFeatWt/1510098587=([edu.stanford.nlp.patterns.PhraseScorer], double)}
; {var2781=edu.stanford.nlp.patterns.PhraseScorer, var2415=r0, var1907=r2, var3213=null_type, var3083=r11, var1711=edu.stanford.nlp.patterns.ConstantsAndVariables, var1775=$r1, var2732=java.util.Map, var2928=$r3, var2514=java.lang.Object, var854=$r4, var3843=r36, var2086=$r27, var727=$i0, var3344=$d2}
; {edu.stanford.nlp.patterns.PhraseScorer=var2781, r0=var2415, r2=var1907, null_type=var3213, r11=var3083, edu.stanford.nlp.patterns.ConstantsAndVariables=var1711, $r1=var1775, java.util.Map=var2732, $r3=var2928, java.lang.Object=var2514, $r4=var854, r36=var3843, $r27=var2086, $i0=var727, $d2=var3344}
;seq <java.lang.String: java.lang.String[] split(java.lang.String)>
;cnt {"<java.lang.String: java.lang.String[] split(java.lang.String)>": 1}
;stmts r0 := @this: edu.stanford.nlp.patterns.PhraseScorer;	r2 := @parameter0: java.lang.String;	r11 := @parameter1: java.lang.String;	$r1 = r0.<edu.stanford.nlp.patterns.PhraseScorer: edu.stanford.nlp.patterns.ConstantsAndVariables constVars>;	$r3 = virtualinvoke $r1.<edu.stanford.nlp.patterns.ConstantsAndVariables: java.util.Map getWordClassClusters()>();	$r4 = interfaceinvoke $r3.<java.util.Map: java.lang.Object get(java.lang.Object)>(r2);	r36 = (java.lang.Integer) $r4;	if r36 != null goto (branch);	if r36 == null goto $r27 = virtualinvoke r2.<java.lang.String: java.lang.String[] split(java.lang.String)>("\\s+");	$r27 = virtualinvoke r2.<java.lang.String: java.lang.String[] split(java.lang.String)>("\\s+");	$i0 = lengthof $r27;	if $i0 >= 2 goto d4 = 0.0;	$d2 = r0.<edu.stanford.nlp.patterns.PhraseScorer: double OOVExternalFeatWt>;	return $d2
;block_num 4
