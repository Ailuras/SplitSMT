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

(declare-sort var2546 0)
(declare-sort var412 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun String_valueOf/-1973653463 (Bool) String)
(declare-fun addParameter/1929860173 (var2546 String String) var2546)
(declare-const null-var2546 var2546)
(declare-const null-String String)
(declare-const null-Bool Bool)
(declare-const var1084 var2546) ; Statement: r0 := @this: org.apache.dubbo.common.URLBuilder 
(assert (not (= var1084 null-var2546)))
(declare-const var3923 String) ; Statement: r1 := @parameter0: java.lang.String 
(assert (not (= var3923 null-String)))
(declare-const var3869 Bool) ; Statement: z0 := @parameter1: boolean 
(assert (not (= var3869 null-Bool)))
(define-const var2120 String (String_valueOf/-1973653463 var3869)) ; Statement: $r2 = staticinvoke <java.lang.String: java.lang.String valueOf(boolean)>(z0) 
(assert true)
(define-const var2737 var2546 (addParameter/1929860173 var1084 var3923 var2120)) ; Statement: $r3 = virtualinvoke r0.<org.apache.dubbo.common.URLBuilder: org.apache.dubbo.common.URLBuilder addParameter(java.lang.String,java.lang.String)>(r1, $r2) 
 ; Statement: return $r3 
(check-sat)
; {String_valueOf/-1973653463=([boolean], java.lang.String), addParameter/1929860173=([org.apache.dubbo.common.URLBuilder, java.lang.String, java.lang.String], org.apache.dubbo.common.URLBuilder)}
; {var2546=org.apache.dubbo.common.URLBuilder, var1084=r0, var3923=r1, var412=null_type, var3869=z0, var2120=$r2, var2737=$r3}
; {org.apache.dubbo.common.URLBuilder=var2546, r0=var1084, r1=var3923, null_type=var412, z0=var3869, $r2=var2120, $r3=var2737}
;seq <java.lang.String: java.lang.String valueOf(boolean)>
;cnt {"<java.lang.String: java.lang.String valueOf(boolean)>": 1}
;stmts r0 := @this: org.apache.dubbo.common.URLBuilder;	r1 := @parameter0: java.lang.String;	z0 := @parameter1: boolean;	$r2 = staticinvoke <java.lang.String: java.lang.String valueOf(boolean)>(z0);	$r3 = virtualinvoke r0.<org.apache.dubbo.common.URLBuilder: org.apache.dubbo.common.URLBuilder addParameter(java.lang.String,java.lang.String)>(r1, $r2);	return $r3
;block_num 1