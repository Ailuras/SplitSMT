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

(declare-sort var3218 0)
(declare-sort var3323 0)
(declare-sort var840 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun var840_isEmpty/-813097145 (String) Bool)
(declare-const null-var3218 var3218)
(declare-const null-String String)
(declare-const var1668 var3218) ; Statement: r1 := @this: org.apache.dubbo.registry.client.InstanceAddressURL 
(assert (not (= var1668 null-var3218)))
(declare-const var510 String) ; Statement: r0 := @parameter0: java.lang.String 
(assert (not (= var510 null-String)))
(declare-const var1201 String) ; Statement: r2 := @parameter1: java.lang.String 
(assert (not (= var1201 null-String)))
(define-const var1858 Bool (var840_isEmpty/-813097145 var510)) ; Statement: $z0 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: boolean isEmpty(java.lang.String)>(r0) 
 ; Statement: if $z0 != 0 goto return r1 
(assert (not (= (ite var1858 1 0) 0))) ; Cond: $z0 != 0 
 ; Statement: return r1 
(check-sat)
; {var840_isEmpty/-813097145=([java.lang.String], boolean)}
; {var3218=org.apache.dubbo.registry.client.InstanceAddressURL, var1668=r1, var510=r0, var3323=null_type, var1201=r2, var840=org.apache.dubbo.common.utils.StringUtils, var1858=$z0}
; {org.apache.dubbo.registry.client.InstanceAddressURL=var3218, r1=var1668, r0=var510, null_type=var3323, r2=var1201, org.apache.dubbo.common.utils.StringUtils=var840, $z0=var1858}
;seq <org.apache.dubbo.common.utils.StringUtils: boolean isEmpty(java.lang.String)>
;cnt {"<org.apache.dubbo.common.utils.StringUtils: boolean isEmpty(java.lang.String)>": 1}
;stmts r1 := @this: org.apache.dubbo.registry.client.InstanceAddressURL;	r0 := @parameter0: java.lang.String;	r2 := @parameter1: java.lang.String;	$z0 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: boolean isEmpty(java.lang.String)>(r0);	if $z0 != 0 goto return r1;	return r1
;block_num 2