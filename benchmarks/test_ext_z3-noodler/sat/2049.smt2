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

(declare-sort var769 0)
(declare-sort var1918 0)
(declare-sort var3604 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun getMethodParameter/2069355293 (var769 String String) String)
(declare-fun var3604_isEmpty/-813097145 (String) Bool)
(declare-const null-var769 var769)
(declare-const null-String String)
(declare-const var2265 var769) ; Statement: r0 := @this: org.apache.dubbo.common.Parameters 
(assert (not (= var2265 null-var769)))
(declare-const var5 String) ; Statement: r1 := @parameter0: java.lang.String 
(assert (not (= var5 null-String)))
(declare-const var2437 String) ; Statement: r2 := @parameter1: java.lang.String 
(assert (not (= var2437 null-String)))
(declare-const var2325 String) ; Statement: r4 := @parameter2: java.lang.String 
(assert (not (= var2325 null-String)))
(assert true)
(define-const var2350 String (getMethodParameter/2069355293 var2265 var5 var2437)) ; Statement: r3 = virtualinvoke r0.<org.apache.dubbo.common.Parameters: java.lang.String getMethodParameter(java.lang.String,java.lang.String)>(r1, r2) 
(define-const var1002 Bool (var3604_isEmpty/-813097145 var2350)) ; Statement: $z0 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: boolean isEmpty(java.lang.String)>(r3) 
 ; Statement: if $z0 == 0 goto return r3 
(assert (not (= (ite var1002 1 0) 0))) ; Negate: Cond: $z0 == 0  
 ; Statement: return r4 
(check-sat)
; {getMethodParameter/2069355293=([org.apache.dubbo.common.Parameters, java.lang.String, java.lang.String], java.lang.String), var3604_isEmpty/-813097145=([java.lang.String], boolean)}
; {var769=org.apache.dubbo.common.Parameters, var2265=r0, var5=r1, var1918=null_type, var2437=r2, var2325=r4, var2350=r3, var3604=org.apache.dubbo.common.utils.StringUtils, var1002=$z0}
; {org.apache.dubbo.common.Parameters=var769, r0=var2265, r1=var5, null_type=var1918, r2=var2437, r4=var2325, r3=var2350, org.apache.dubbo.common.utils.StringUtils=var3604, $z0=var1002}
;seq <org.apache.dubbo.common.utils.StringUtils: boolean isEmpty(java.lang.String)>
;cnt {"<org.apache.dubbo.common.utils.StringUtils: boolean isEmpty(java.lang.String)>": 1}
;stmts r0 := @this: org.apache.dubbo.common.Parameters;	r1 := @parameter0: java.lang.String;	r2 := @parameter1: java.lang.String;	r4 := @parameter2: java.lang.String;	r3 = virtualinvoke r0.<org.apache.dubbo.common.Parameters: java.lang.String getMethodParameter(java.lang.String,java.lang.String)>(r1, r2);	$z0 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: boolean isEmpty(java.lang.String)>(r3);	if $z0 == 0 goto return r3;	return r4
;block_num 2