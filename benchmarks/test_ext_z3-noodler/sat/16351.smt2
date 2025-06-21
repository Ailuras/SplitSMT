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

(declare-sort var264 0)
(declare-sort var1635 0)
(declare-sort var3284 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun var3284_isEmpty/-813097145 (String) Bool)
(declare-const null-var264 var264)
(declare-const null-String String)
(declare-const var700 var264) ; Statement: r1 := @this: org.apache.dubbo.registry.client.InstanceAddressURL 
(assert (not (= var700 null-var264)))
(declare-const var1859 String) ; Statement: r3 := @parameter0: java.lang.String 
(assert (not (= var1859 null-String)))
(declare-const var2155 String) ; Statement: r0 := @parameter1: java.lang.String 
(assert (not (= var2155 null-String)))
(declare-const var714 String) ; Statement: r2 := @parameter2: java.lang.String 
(assert (not (= var714 null-String)))
(define-const var2316 Bool (var3284_isEmpty/-813097145 var2155)) ; Statement: $z0 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: boolean isEmpty(java.lang.String)>(r0) 
 ; Statement: if $z0 != 0 goto return r1 
(assert (not (= (ite var2316 1 0) 0))) ; Cond: $z0 != 0 
 ; Statement: return r1 
(check-sat)
; {var3284_isEmpty/-813097145=([java.lang.String], boolean)}
; {var264=org.apache.dubbo.registry.client.InstanceAddressURL, var700=r1, var1859=r3, var1635=null_type, var2155=r0, var714=r2, var3284=org.apache.dubbo.common.utils.StringUtils, var2316=$z0}
; {org.apache.dubbo.registry.client.InstanceAddressURL=var264, r1=var700, r3=var1859, null_type=var1635, r0=var2155, r2=var714, org.apache.dubbo.common.utils.StringUtils=var3284, $z0=var2316}
;seq <org.apache.dubbo.common.utils.StringUtils: boolean isEmpty(java.lang.String)>
;cnt {"<org.apache.dubbo.common.utils.StringUtils: boolean isEmpty(java.lang.String)>": 1}
;stmts r1 := @this: org.apache.dubbo.registry.client.InstanceAddressURL;	r3 := @parameter0: java.lang.String;	r0 := @parameter1: java.lang.String;	r2 := @parameter2: java.lang.String;	$z0 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: boolean isEmpty(java.lang.String)>(r0);	if $z0 != 0 goto return r1;	return r1
;block_num 2