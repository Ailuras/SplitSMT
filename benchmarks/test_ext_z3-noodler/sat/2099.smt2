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

(declare-sort var1996 0)
(declare-sort var3812 0)
(declare-sort var3707 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun getMethodParameter/2069355293 (var1996 String String) String)
(declare-fun var3707_isEmpty/-813097145 (String) Bool)
(declare-const null-var1996 var1996)
(declare-const null-String String)
(declare-const var1426 var1996) ; Statement: r0 := @this: org.apache.dubbo.common.Parameters 
(assert (not (= var1426 null-var1996)))
(declare-const var602 String) ; Statement: r1 := @parameter0: java.lang.String 
(assert (not (= var602 null-String)))
(declare-const var568 String) ; Statement: r2 := @parameter1: java.lang.String 
(assert (not (= var568 null-String)))
(declare-const var1075 String) ; Statement: r4 := @parameter2: java.lang.String 
(assert (not (= var1075 null-String)))
(assert true)
(define-const var3503 String (getMethodParameter/2069355293 var1426 var602 var568)) ; Statement: r3 = virtualinvoke r0.<org.apache.dubbo.common.Parameters: java.lang.String getMethodParameter(java.lang.String,java.lang.String)>(r1, r2) 
(define-const var1625 Bool (var3707_isEmpty/-813097145 var3503)) ; Statement: $z0 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: boolean isEmpty(java.lang.String)>(r3) 
 ; Statement: if $z0 == 0 goto return r3 
(assert (= (ite var1625 1 0) 0)) ; Cond: $z0 == 0 
 ; Statement: return r3 
(check-sat)
; {getMethodParameter/2069355293=([org.apache.dubbo.common.Parameters, java.lang.String, java.lang.String], java.lang.String), var3707_isEmpty/-813097145=([java.lang.String], boolean)}
; {var1996=org.apache.dubbo.common.Parameters, var1426=r0, var602=r1, var3812=null_type, var568=r2, var1075=r4, var3503=r3, var3707=org.apache.dubbo.common.utils.StringUtils, var1625=$z0}
; {org.apache.dubbo.common.Parameters=var1996, r0=var1426, r1=var602, null_type=var3812, r2=var568, r4=var1075, r3=var3503, org.apache.dubbo.common.utils.StringUtils=var3707, $z0=var1625}
;seq <org.apache.dubbo.common.utils.StringUtils: boolean isEmpty(java.lang.String)>
;cnt {"<org.apache.dubbo.common.utils.StringUtils: boolean isEmpty(java.lang.String)>": 1}
;stmts r0 := @this: org.apache.dubbo.common.Parameters;	r1 := @parameter0: java.lang.String;	r2 := @parameter1: java.lang.String;	r4 := @parameter2: java.lang.String;	r3 = virtualinvoke r0.<org.apache.dubbo.common.Parameters: java.lang.String getMethodParameter(java.lang.String,java.lang.String)>(r1, r2);	$z0 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: boolean isEmpty(java.lang.String)>(r3);	if $z0 == 0 goto return r3;	return r3
;block_num 2