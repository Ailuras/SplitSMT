(set-option :produce-unsat-cores true) ; enable generation of unsat cores
(set-option :produce-models true) ; enable model generation
(set-logic ALL)

; 统一获取长度的函数
(define-fun get_split_length ((x String) (d String) (limit Int)) Int
  (ite
    (> limit 0)
    (ite (< (str.num_splits x d) limit)
         (str.num_splits x d)
         limit)
    (str.num_splits x d)
  )
)

; 统一获取元素的函数
(define-fun get_split_element ((x String) (d String) (limit Int) (i Int)) String
  (ite
    (and (> limit 0)
         (= i (- limit 1))
         (>= (str.num_splits x d) limit))
    (str.split_rest x d (- limit 1))
    (str.split_at x d i)
  )
)

(declare-sort var3151 0)
(declare-sort var3291 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun String_valueOf/-1973653463 (Bool) String)
(declare-fun addParameter/-1629709269 (var3151 String String) var3151)
(declare-const null-var3151 var3151)
(declare-const null-String String)
(declare-const null-Bool Bool)
(declare-const var3968 var3151) ; Statement: r0 := @this: org.apache.dubbo.common.URL 
(assert (not (= var3968 null-var3151)))
(declare-const var85 String) ; Statement: r1 := @parameter0: java.lang.String 
(assert (not (= var85 null-String)))
(declare-const var1012 Bool) ; Statement: z0 := @parameter1: boolean 
(assert (not (= var1012 null-Bool)))
(define-const var3713 String (String_valueOf/-1973653463 var1012)) ; Statement: $r2 = staticinvoke <java.lang.String: java.lang.String valueOf(boolean)>(z0) 
(assert true)
(define-const var2551 var3151 (addParameter/-1629709269 var3968 var85 var3713)) ; Statement: $r3 = virtualinvoke r0.<org.apache.dubbo.common.URL: org.apache.dubbo.common.URL addParameter(java.lang.String,java.lang.String)>(r1, $r2) 
 ; Statement: return $r3 
(check-sat)
; {String_valueOf/-1973653463=([boolean], java.lang.String), addParameter/-1629709269=([org.apache.dubbo.common.URL, java.lang.String, java.lang.String], org.apache.dubbo.common.URL)}
; {var3151=org.apache.dubbo.common.URL, var3968=r0, var85=r1, var3291=null_type, var1012=z0, var3713=$r2, var2551=$r3}
; {org.apache.dubbo.common.URL=var3151, r0=var3968, r1=var85, null_type=var3291, z0=var1012, $r2=var3713, $r3=var2551}
;seq <java.lang.String: java.lang.String valueOf(boolean)>
;cnt {"<java.lang.String: java.lang.String valueOf(boolean)>": 1}
;stmts r0 := @this: org.apache.dubbo.common.URL;	r1 := @parameter0: java.lang.String;	z0 := @parameter1: boolean;	$r2 = staticinvoke <java.lang.String: java.lang.String valueOf(boolean)>(z0);	$r3 = virtualinvoke r0.<org.apache.dubbo.common.URL: org.apache.dubbo.common.URL addParameter(java.lang.String,java.lang.String)>(r1, $r2);	return $r3
;block_num 1