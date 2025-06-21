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

(declare-sort var495 0)
(declare-sort var820 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun String_valueOf/-987357574 (Float64) String)
(declare-fun addParameter/-1629709269 (var495 String String) var495)
(declare-const null-var495 var495)
(declare-const null-String String)
(declare-const null-Float64 Float64)
(declare-const var1120 var495) ; Statement: r0 := @this: org.apache.dubbo.common.URL 
(assert (not (= var1120 null-var495)))
(declare-const var214 String) ; Statement: r1 := @parameter0: java.lang.String 
(assert (not (= var214 null-String)))
(declare-const var2037 Float64) ; Statement: d0 := @parameter1: double 
(assert (not (= var2037 null-Float64)))
(define-const var3482 String (String_valueOf/-987357574 var2037)) ; Statement: $r2 = staticinvoke <java.lang.String: java.lang.String valueOf(double)>(d0) 
(assert true)
(define-const var3847 var495 (addParameter/-1629709269 var1120 var214 var3482)) ; Statement: $r3 = virtualinvoke r0.<org.apache.dubbo.common.URL: org.apache.dubbo.common.URL addParameter(java.lang.String,java.lang.String)>(r1, $r2) 
 ; Statement: return $r3 
(check-sat)
; {String_valueOf/-987357574=([double], java.lang.String), addParameter/-1629709269=([org.apache.dubbo.common.URL, java.lang.String, java.lang.String], org.apache.dubbo.common.URL)}
; {var495=org.apache.dubbo.common.URL, var1120=r0, var214=r1, var820=null_type, var2037=d0, var3482=$r2, var3847=$r3}
; {org.apache.dubbo.common.URL=var495, r0=var1120, r1=var214, null_type=var820, d0=var2037, $r2=var3482, $r3=var3847}
;seq <java.lang.String: java.lang.String valueOf(double)>
;cnt {"<java.lang.String: java.lang.String valueOf(double)>": 1}
;stmts r0 := @this: org.apache.dubbo.common.URL;	r1 := @parameter0: java.lang.String;	d0 := @parameter1: double;	$r2 = staticinvoke <java.lang.String: java.lang.String valueOf(double)>(d0);	$r3 = virtualinvoke r0.<org.apache.dubbo.common.URL: org.apache.dubbo.common.URL addParameter(java.lang.String,java.lang.String)>(r1, $r2);	return $r3
;block_num 1