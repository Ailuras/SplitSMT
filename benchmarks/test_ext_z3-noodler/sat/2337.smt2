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

(declare-sort var1196 0)
(declare-sort var426 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun String_valueOf/-107395227 (Int) String)
(declare-fun addParameter/1929860173 (var1196 String String) var1196)
(declare-const null-var1196 var1196)
(declare-const null-String String)
(declare-const null-Int Int)
(declare-const var2028 var1196) ; Statement: r0 := @this: org.apache.dubbo.common.URLBuilder 
(assert (not (= var2028 null-var1196)))
(declare-const var3608 String) ; Statement: r1 := @parameter0: java.lang.String 
(assert (not (= var3608 null-String)))
(declare-const var2252 Int) ; Statement: l0 := @parameter1: long 
(assert (not (= var2252 null-Int)))
(define-const var2406 String (String_valueOf/-107395227 var2252)) ; Statement: $r2 = staticinvoke <java.lang.String: java.lang.String valueOf(long)>(l0) 
(assert true)
(define-const var551 var1196 (addParameter/1929860173 var2028 var3608 var2406)) ; Statement: $r3 = virtualinvoke r0.<org.apache.dubbo.common.URLBuilder: org.apache.dubbo.common.URLBuilder addParameter(java.lang.String,java.lang.String)>(r1, $r2) 
 ; Statement: return $r3 
(check-sat)
; {String_valueOf/-107395227=([long], java.lang.String), addParameter/1929860173=([org.apache.dubbo.common.URLBuilder, java.lang.String, java.lang.String], org.apache.dubbo.common.URLBuilder)}
; {var1196=org.apache.dubbo.common.URLBuilder, var2028=r0, var3608=r1, var426=null_type, var2252=l0, var2406=$r2, var551=$r3}
; {org.apache.dubbo.common.URLBuilder=var1196, r0=var2028, r1=var3608, null_type=var426, l0=var2252, $r2=var2406, $r3=var551}
;seq <java.lang.String: java.lang.String valueOf(long)>
;cnt {"<java.lang.String: java.lang.String valueOf(long)>": 1}
;stmts r0 := @this: org.apache.dubbo.common.URLBuilder;	r1 := @parameter0: java.lang.String;	l0 := @parameter1: long;	$r2 = staticinvoke <java.lang.String: java.lang.String valueOf(long)>(l0);	$r3 = virtualinvoke r0.<org.apache.dubbo.common.URLBuilder: org.apache.dubbo.common.URLBuilder addParameter(java.lang.String,java.lang.String)>(r1, $r2);	return $r3
;block_num 1