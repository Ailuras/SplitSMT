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

(declare-sort var3678 0)
(declare-sort var3814 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun var3814_isBlank/1495335909 (String) Bool)
(define-fun cast-from-String-to-String ((arg String)) String arg)
(declare-const null-String String)
(declare-const var1216 String) ; Statement: r0 := @parameter0: java.lang.String 
(assert (not (= var1216 null-String)))
(define-const var568 Bool (var3814_isBlank/1495335909 (cast-from-String-to-String var1216))) ; Statement: $z0 = staticinvoke <org.apache.hc.core5.util.TextUtils: boolean isBlank(java.lang.CharSequence)>(r0) 
 ; Statement: if $z0 == 0 goto $r1 = virtualinvoke r0.<java.lang.String: java.lang.String[] split(java.lang.String)>(" *, *") 
(assert (= (ite var568 1 0) 0)) ; Cond: $z0 == 0 
; split operation: var100 = var1216.split(" *, *") ; Statement: $r1 = virtualinvoke r0.<java.lang.String: java.lang.String[] split(java.lang.String)>(" *, *") 
 ; Statement: return $r1 
(check-sat)
; {var3814_isBlank/1495335909=([java.lang.CharSequence], boolean), cast-from-String-to-String=([java.lang.String], java.lang.CharSequence)}
; {var1216=r0, var3678=null_type, var3814=org.apache.hc.core5.util.TextUtils, var568=$z0, var100=$r1}
; {r0=var1216, null_type=var3678, org.apache.hc.core5.util.TextUtils=var3814, $z0=var568, $r1=var100}
;seq <java.lang.String: java.lang.String[] split(java.lang.String)>
;cnt {"<java.lang.String: java.lang.String[] split(java.lang.String)>": 1}
;stmts r0 := @parameter0: java.lang.String;	$z0 = staticinvoke <org.apache.hc.core5.util.TextUtils: boolean isBlank(java.lang.CharSequence)>(r0);	if $z0 == 0 goto $r1 = virtualinvoke r0.<java.lang.String: java.lang.String[] split(java.lang.String)>(" *, *");	$r1 = virtualinvoke r0.<java.lang.String: java.lang.String[] split(java.lang.String)>(" *, *");	return $r1
;block_num 2