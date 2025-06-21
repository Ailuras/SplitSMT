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

(declare-sort var2318 0)
(declare-sort var2988 0)
(declare-sort var3819 0)
(declare-sort var1217 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun String_valueOf/-333372740 (var1217) String)
(declare-fun cast-from-var3819-to-var1217 (var3819) var1217)
(declare-fun addParameter/-1629709269 (var2318 String String) var2318)
(declare-const null-var2318 var2318)
(declare-const null-String String)
(declare-const null-var3819 var3819)
(declare-const var833 var2318) ; Statement: r1 := @this: org.apache.dubbo.common.URL 
(assert (not (= var833 null-var2318)))
(declare-const var2500 String) ; Statement: r2 := @parameter0: java.lang.String 
(assert (not (= var2500 null-String)))
(declare-const var879 var3819) ; Statement: r0 := @parameter1: java.lang.Enum 
(assert (not (= var879 null-var3819)))
 ; Statement: if r0 != null goto $r3 = staticinvoke <java.lang.String: java.lang.String valueOf(java.lang.Object)>(r0) 
(assert (not (= var879 null-var3819))) ; Cond: r0 != null 
(define-const var2494 String (String_valueOf/-333372740 (cast-from-var3819-to-var1217 var879))) ; Statement: $r3 = staticinvoke <java.lang.String: java.lang.String valueOf(java.lang.Object)>(r0) 
(assert true)
(define-const var231 var2318 (addParameter/-1629709269 var833 var2500 var2494)) ; Statement: $r4 = virtualinvoke r1.<org.apache.dubbo.common.URL: org.apache.dubbo.common.URL addParameter(java.lang.String,java.lang.String)>(r2, $r3) 
 ; Statement: return $r4 
(check-sat)
; {String_valueOf/-333372740=([java.lang.Object], java.lang.String), cast-from-var3819-to-var1217=([java.lang.Enum], java.lang.Object), addParameter/-1629709269=([org.apache.dubbo.common.URL, java.lang.String, java.lang.String], org.apache.dubbo.common.URL)}
; {var2318=org.apache.dubbo.common.URL, var833=r1, var2500=r2, var2988=null_type, var3819=java.lang.Enum, var879=r0, var1217=java.lang.Object, var2494=$r3, var231=$r4}
; {org.apache.dubbo.common.URL=var2318, r1=var833, r2=var2500, null_type=var2988, java.lang.Enum=var3819, r0=var879, java.lang.Object=var1217, $r3=var2494, $r4=var231}
;seq <java.lang.String: java.lang.String valueOf(java.lang.Object)>
;cnt {"<java.lang.String: java.lang.String valueOf(java.lang.Object)>": 1}
;stmts r1 := @this: org.apache.dubbo.common.URL;	r2 := @parameter0: java.lang.String;	r0 := @parameter1: java.lang.Enum;	if r0 != null goto $r3 = staticinvoke <java.lang.String: java.lang.String valueOf(java.lang.Object)>(r0);	$r3 = staticinvoke <java.lang.String: java.lang.String valueOf(java.lang.Object)>(r0);	$r4 = virtualinvoke r1.<org.apache.dubbo.common.URL: org.apache.dubbo.common.URL addParameter(java.lang.String,java.lang.String)>(r2, $r3);	return $r4
;block_num 2