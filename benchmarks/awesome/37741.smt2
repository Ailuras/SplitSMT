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

(declare-sort var3186 0)
(declare-sort var1643 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun var1643_isNullOrEmpty/-1157300856 (String) Bool)
(declare-const null-String String)
(declare-const var660 String) ; Statement: r0 := @parameter0: java.lang.String 
(assert (not (= var660 null-String)))
(define-const var2295 Bool (var1643_isNullOrEmpty/-1157300856 var660)) ; Statement: $z0 = staticinvoke <edu.stanford.nlp.util.StringUtils: boolean isNullOrEmpty(java.lang.String)>(r0) 
 ; Statement: if $z0 == 0 goto $r1 = virtualinvoke r0.<java.lang.String: java.lang.String[] split(java.lang.String)>("\\s+") 
(assert (= (ite var2295 1 0) 0)) ; Cond: $z0 == 0 
; split operation: var3292 = var660.split("\u005cs+") ; Statement: $r1 = virtualinvoke r0.<java.lang.String: java.lang.String[] split(java.lang.String)>("\\s+") 
 ; Statement: return $r1 
(check-sat)
; {var1643_isNullOrEmpty/-1157300856=([java.lang.String], boolean)}
; {var660=r0, var3186=null_type, var1643=edu.stanford.nlp.util.StringUtils, var2295=$z0, var3292=$r1}
; {r0=var660, null_type=var3186, edu.stanford.nlp.util.StringUtils=var1643, $z0=var2295, $r1=var3292}
;seq <edu.stanford.nlp.util.StringUtils: boolean isNullOrEmpty(java.lang.String)>;	<java.lang.String: java.lang.String[] split(java.lang.String)>
;cnt {"<edu.stanford.nlp.util.StringUtils: boolean isNullOrEmpty(java.lang.String)>": 1,"<java.lang.String: java.lang.String[] split(java.lang.String)>": 1}
;stmts r0 := @parameter0: java.lang.String;	$z0 = staticinvoke <edu.stanford.nlp.util.StringUtils: boolean isNullOrEmpty(java.lang.String)>(r0);	if $z0 == 0 goto $r1 = virtualinvoke r0.<java.lang.String: java.lang.String[] split(java.lang.String)>("\\s+");	$r1 = virtualinvoke r0.<java.lang.String: java.lang.String[] split(java.lang.String)>("\\s+");	return $r1
;block_num 2