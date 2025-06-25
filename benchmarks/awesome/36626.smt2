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

(declare-sort var3560 0)
(declare-sort var1108 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun getProperty/1391780669 (var1108 String) String)
(declare-fun cast-from-var3560-to-var1108 (var3560) var1108)
(declare-const null-var3560 var3560)
(declare-const var2992 var3560) ; Statement: r0 := @this: edu.stanford.nlp.tagger.maxent.TaggerConfig 
(assert (not (= var2992 null-var3560)))
(assert true)
(define-const var3418 String (getProperty/1391780669 (cast-from-var3560-to-var1108 var2992) "outputFormatOptions")) ; Statement: $r1 = virtualinvoke r0.<edu.stanford.nlp.tagger.maxent.TaggerConfig: java.lang.String getProperty(java.lang.String)>("outputFormatOptions") 
; split operation: var2431 = var3418.split("\u005cs*,\u005cs*") ; Statement: $r2 = virtualinvoke $r1.<java.lang.String: java.lang.String[] split(java.lang.String)>("\\s*,\\s*") 
 ; Statement: return $r2 
(check-sat)
; {getProperty/1391780669=([java.util.Properties, java.lang.String], java.lang.String), cast-from-var3560-to-var1108=([edu.stanford.nlp.tagger.maxent.TaggerConfig], java.util.Properties)}
; {var3560=edu.stanford.nlp.tagger.maxent.TaggerConfig, var2992=r0, var1108=java.util.Properties, var3418=$r1, var2431=$r2}
; {edu.stanford.nlp.tagger.maxent.TaggerConfig=var3560, r0=var2992, java.util.Properties=var1108, $r1=var3418, $r2=var2431}
;seq <java.lang.String: java.lang.String[] split(java.lang.String)>
;cnt {"<java.lang.String: java.lang.String[] split(java.lang.String)>": 1}
;stmts r0 := @this: edu.stanford.nlp.tagger.maxent.TaggerConfig;	$r1 = virtualinvoke r0.<edu.stanford.nlp.tagger.maxent.TaggerConfig: java.lang.String getProperty(java.lang.String)>("outputFormatOptions");	$r2 = virtualinvoke $r1.<java.lang.String: java.lang.String[] split(java.lang.String)>("\\s*,\\s*");	return $r2
;block_num 1