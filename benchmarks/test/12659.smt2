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

(declare-sort var2904 0)
(declare-sort var2621 0)
(declare-sort var2202 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun getServiceParameter/1782298180 (var2904 String String) String)
(declare-fun var2202_isEmpty/-813097145 (String) Bool)
(declare-const null-var2904 var2904)
(declare-const null-String String)
(declare-const null-Float64 Float64)
(declare-const var1353 var2904) ; Statement: r0 := @this: org.apache.dubbo.common.URL 
(assert (not (= var1353 null-var2904)))
(declare-const var1449 String) ; Statement: r1 := @parameter0: java.lang.String 
(assert (not (= var1449 null-String)))
(declare-const var3885 String) ; Statement: r2 := @parameter1: java.lang.String 
(assert (not (= var3885 null-String)))
(declare-const var3927 Float64) ; Statement: d1 := @parameter2: double 
(assert (not (= var3927 null-Float64)))
(assert true)
(define-const var3239 String (getServiceParameter/1782298180 var1353 var1449 var3885)) ; Statement: r3 = virtualinvoke r0.<org.apache.dubbo.common.URL: java.lang.String getServiceParameter(java.lang.String,java.lang.String)>(r1, r2) 
(define-const var2668 Bool (var2202_isEmpty/-813097145 var3239)) ; Statement: $z0 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: boolean isEmpty(java.lang.String)>(r3) 
 ; Statement: if $z0 == 0 goto $d0 = staticinvoke <java.lang.Double: double parseDouble(java.lang.String)>(r3) 
(assert (not (= (ite var2668 1 0) 0))) ; Negate: Cond: $z0 == 0  
 ; Statement: return d1 
(check-sat)
; {getServiceParameter/1782298180=([org.apache.dubbo.common.URL, java.lang.String, java.lang.String], java.lang.String), var2202_isEmpty/-813097145=([java.lang.String], boolean)}
; {var2904=org.apache.dubbo.common.URL, var1353=r0, var1449=r1, var2621=null_type, var3885=r2, var3927=d1, var3239=r3, var2202=org.apache.dubbo.common.utils.StringUtils, var2668=$z0}
; {org.apache.dubbo.common.URL=var2904, r0=var1353, r1=var1449, null_type=var2621, r2=var3885, d1=var3927, r3=var3239, org.apache.dubbo.common.utils.StringUtils=var2202, $z0=var2668}
;seq <org.apache.dubbo.common.utils.StringUtils: boolean isEmpty(java.lang.String)>
;cnt {"<org.apache.dubbo.common.utils.StringUtils: boolean isEmpty(java.lang.String)>": 1}
;stmts r0 := @this: org.apache.dubbo.common.URL;	r1 := @parameter0: java.lang.String;	r2 := @parameter1: java.lang.String;	d1 := @parameter2: double;	r3 = virtualinvoke r0.<org.apache.dubbo.common.URL: java.lang.String getServiceParameter(java.lang.String,java.lang.String)>(r1, r2);	$z0 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: boolean isEmpty(java.lang.String)>(r3);	if $z0 == 0 goto $d0 = staticinvoke <java.lang.Double: double parseDouble(java.lang.String)>(r3);	return d1
;block_num 2