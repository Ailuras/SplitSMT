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

(declare-sort var886 0)
(declare-sort var1237 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun String_valueOf/-987357574 (Float64) String)
(declare-fun addParameter/1929860173 (var886 String String) var886)
(declare-const null-var886 var886)
(declare-const null-String String)
(declare-const null-Float64 Float64)
(declare-const var3651 var886) ; Statement: r0 := @this: org.apache.dubbo.common.URLBuilder 
(assert (not (= var3651 null-var886)))
(declare-const var1348 String) ; Statement: r1 := @parameter0: java.lang.String 
(assert (not (= var1348 null-String)))
(declare-const var3369 Float64) ; Statement: d0 := @parameter1: double 
(assert (not (= var3369 null-Float64)))
(define-const var3752 String (String_valueOf/-987357574 var3369)) ; Statement: $r2 = staticinvoke <java.lang.String: java.lang.String valueOf(double)>(d0) 
(assert true)
(define-const var1966 var886 (addParameter/1929860173 var3651 var1348 var3752)) ; Statement: $r3 = virtualinvoke r0.<org.apache.dubbo.common.URLBuilder: org.apache.dubbo.common.URLBuilder addParameter(java.lang.String,java.lang.String)>(r1, $r2) 
 ; Statement: return $r3 
(check-sat)
; {String_valueOf/-987357574=([double], java.lang.String), addParameter/1929860173=([org.apache.dubbo.common.URLBuilder, java.lang.String, java.lang.String], org.apache.dubbo.common.URLBuilder)}
; {var886=org.apache.dubbo.common.URLBuilder, var3651=r0, var1348=r1, var1237=null_type, var3369=d0, var3752=$r2, var1966=$r3}
; {org.apache.dubbo.common.URLBuilder=var886, r0=var3651, r1=var1348, null_type=var1237, d0=var3369, $r2=var3752, $r3=var1966}
;seq <java.lang.String: java.lang.String valueOf(double)>
;cnt {"<java.lang.String: java.lang.String valueOf(double)>": 1}
;stmts r0 := @this: org.apache.dubbo.common.URLBuilder;	r1 := @parameter0: java.lang.String;	d0 := @parameter1: double;	$r2 = staticinvoke <java.lang.String: java.lang.String valueOf(double)>(d0);	$r3 = virtualinvoke r0.<org.apache.dubbo.common.URLBuilder: org.apache.dubbo.common.URLBuilder addParameter(java.lang.String,java.lang.String)>(r1, $r2);	return $r3
;block_num 1