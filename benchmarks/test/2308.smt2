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

(declare-sort var850 0)
(declare-sort var1846 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun String_valueOf/1240665136 (Int) String)
(declare-fun addParameter/1929860173 (var850 String String) var850)
(declare-const null-var850 var850)
(declare-const null-String String)
(declare-const null-Int Int)
(declare-const var1751 var850) ; Statement: r0 := @this: org.apache.dubbo.common.URLBuilder 
(assert (not (= var1751 null-var850)))
(declare-const var1109 String) ; Statement: r1 := @parameter0: java.lang.String 
(assert (not (= var1109 null-String)))
(declare-const var2230 Int) ; Statement: i0 := @parameter1: int 
(assert (not (= var2230 null-Int)))
(define-const var291 String (String_valueOf/1240665136 var2230)) ; Statement: $r2 = staticinvoke <java.lang.String: java.lang.String valueOf(int)>(i0) 
(assert true)
(define-const var20 var850 (addParameter/1929860173 var1751 var1109 var291)) ; Statement: $r3 = virtualinvoke r0.<org.apache.dubbo.common.URLBuilder: org.apache.dubbo.common.URLBuilder addParameter(java.lang.String,java.lang.String)>(r1, $r2) 
 ; Statement: return $r3 
(check-sat)
; {String_valueOf/1240665136=([int], java.lang.String), addParameter/1929860173=([org.apache.dubbo.common.URLBuilder, java.lang.String, java.lang.String], org.apache.dubbo.common.URLBuilder)}
; {var850=org.apache.dubbo.common.URLBuilder, var1751=r0, var1109=r1, var1846=null_type, var2230=i0, var291=$r2, var20=$r3}
; {org.apache.dubbo.common.URLBuilder=var850, r0=var1751, r1=var1109, null_type=var1846, i0=var2230, $r2=var291, $r3=var20}
;seq <java.lang.String: java.lang.String valueOf(int)>
;cnt {"<java.lang.String: java.lang.String valueOf(int)>": 1}
;stmts r0 := @this: org.apache.dubbo.common.URLBuilder;	r1 := @parameter0: java.lang.String;	i0 := @parameter1: int;	$r2 = staticinvoke <java.lang.String: java.lang.String valueOf(int)>(i0);	$r3 = virtualinvoke r0.<org.apache.dubbo.common.URLBuilder: org.apache.dubbo.common.URLBuilder addParameter(java.lang.String,java.lang.String)>(r1, $r2);	return $r3
;block_num 1