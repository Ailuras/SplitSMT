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

(declare-sort var3953 0)
(declare-sort var3990 0)
(declare-sort var3883 0)
(declare-sort var1152 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun String_valueOf/-333372740 (var1152) String)
(declare-fun cast-from-var3883-to-var1152 (var3883) var1152)
(declare-fun addParameter/1929860173 (var3953 String String) var3953)
(declare-const null-var3953 var3953)
(declare-const null-String String)
(declare-const null-var3883 var3883)
(declare-const var2838 var3953) ; Statement: r1 := @this: org.apache.dubbo.common.URLBuilder 
(assert (not (= var2838 null-var3953)))
(declare-const var311 String) ; Statement: r2 := @parameter0: java.lang.String 
(assert (not (= var311 null-String)))
(declare-const var1313 var3883) ; Statement: r0 := @parameter1: java.lang.Number 
(assert (not (= var1313 null-var3883)))
 ; Statement: if r0 != null goto $r3 = staticinvoke <java.lang.String: java.lang.String valueOf(java.lang.Object)>(r0) 
(assert (not (= var1313 null-var3883))) ; Cond: r0 != null 
(define-const var44 String (String_valueOf/-333372740 (cast-from-var3883-to-var1152 var1313))) ; Statement: $r3 = staticinvoke <java.lang.String: java.lang.String valueOf(java.lang.Object)>(r0) 
(assert true)
(define-const var253 var3953 (addParameter/1929860173 var2838 var311 var44)) ; Statement: $r4 = virtualinvoke r1.<org.apache.dubbo.common.URLBuilder: org.apache.dubbo.common.URLBuilder addParameter(java.lang.String,java.lang.String)>(r2, $r3) 
 ; Statement: return $r4 
(check-sat)
; {String_valueOf/-333372740=([java.lang.Object], java.lang.String), cast-from-var3883-to-var1152=([java.lang.Number], java.lang.Object), addParameter/1929860173=([org.apache.dubbo.common.URLBuilder, java.lang.String, java.lang.String], org.apache.dubbo.common.URLBuilder)}
; {var3953=org.apache.dubbo.common.URLBuilder, var2838=r1, var311=r2, var3990=null_type, var3883=java.lang.Number, var1313=r0, var1152=java.lang.Object, var44=$r3, var253=$r4}
; {org.apache.dubbo.common.URLBuilder=var3953, r1=var2838, r2=var311, null_type=var3990, java.lang.Number=var3883, r0=var1313, java.lang.Object=var1152, $r3=var44, $r4=var253}
;seq <java.lang.String: java.lang.String valueOf(java.lang.Object)>
;cnt {"<java.lang.String: java.lang.String valueOf(java.lang.Object)>": 1}
;stmts r1 := @this: org.apache.dubbo.common.URLBuilder;	r2 := @parameter0: java.lang.String;	r0 := @parameter1: java.lang.Number;	if r0 != null goto $r3 = staticinvoke <java.lang.String: java.lang.String valueOf(java.lang.Object)>(r0);	$r3 = staticinvoke <java.lang.String: java.lang.String valueOf(java.lang.Object)>(r0);	$r4 = virtualinvoke r1.<org.apache.dubbo.common.URLBuilder: org.apache.dubbo.common.URLBuilder addParameter(java.lang.String,java.lang.String)>(r2, $r3);	return $r4
;block_num 2