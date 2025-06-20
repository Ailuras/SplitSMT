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

(declare-sort var2640 0)
(declare-sort var2274 0)
(declare-sort var297 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun var297_isEmpty/-813097145 (String) Bool)
(declare-const null-var2640 var2640)
(declare-const null-String String)
(declare-const var268 var2640) ; Statement: r1 := @this: org.apache.dubbo.registry.client.InstanceAddressURL 
(assert (not (= var268 null-var2640)))
(declare-const var107 String) ; Statement: r3 := @parameter0: java.lang.String 
(assert (not (= var107 null-String)))
(declare-const var1316 String) ; Statement: r0 := @parameter1: java.lang.String 
(assert (not (= var1316 null-String)))
(declare-const var2095 String) ; Statement: r2 := @parameter2: java.lang.String 
(assert (not (= var2095 null-String)))
(define-const var43 Bool (var297_isEmpty/-813097145 var1316)) ; Statement: $z0 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: boolean isEmpty(java.lang.String)>(r0) 
 ; Statement: if $z0 != 0 goto return r1 
(assert (not (= (ite var43 1 0) 0))) ; Cond: $z0 != 0 
 ; Statement: return r1 
(check-sat)
; {var297_isEmpty/-813097145=([java.lang.String], boolean)}
; {var2640=org.apache.dubbo.registry.client.InstanceAddressURL, var268=r1, var107=r3, var2274=null_type, var1316=r0, var2095=r2, var297=org.apache.dubbo.common.utils.StringUtils, var43=$z0}
; {org.apache.dubbo.registry.client.InstanceAddressURL=var2640, r1=var268, r3=var107, null_type=var2274, r0=var1316, r2=var2095, org.apache.dubbo.common.utils.StringUtils=var297, $z0=var43}
;seq <org.apache.dubbo.common.utils.StringUtils: boolean isEmpty(java.lang.String)>
;cnt {"<org.apache.dubbo.common.utils.StringUtils: boolean isEmpty(java.lang.String)>": 1}
;stmts r1 := @this: org.apache.dubbo.registry.client.InstanceAddressURL;	r3 := @parameter0: java.lang.String;	r0 := @parameter1: java.lang.String;	r2 := @parameter2: java.lang.String;	$z0 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: boolean isEmpty(java.lang.String)>(r0);	if $z0 != 0 goto return r1;	return r1
;block_num 2