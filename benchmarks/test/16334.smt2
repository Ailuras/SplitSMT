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

(declare-sort var3563 0)
(declare-sort var3553 0)
(declare-sort var2920 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun var2920_isEmpty/-813097145 (String) Bool)
(declare-const null-var3563 var3563)
(declare-const null-String String)
(declare-const var1255 var3563) ; Statement: r1 := @this: org.apache.dubbo.registry.client.InstanceAddressURL 
(assert (not (= var1255 null-var3563)))
(declare-const var3706 String) ; Statement: r0 := @parameter0: java.lang.String 
(assert (not (= var3706 null-String)))
(declare-const var2178 String) ; Statement: r2 := @parameter1: java.lang.String 
(assert (not (= var2178 null-String)))
(define-const var3914 Bool (var2920_isEmpty/-813097145 var3706)) ; Statement: $z0 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: boolean isEmpty(java.lang.String)>(r0) 
 ; Statement: if $z0 != 0 goto return r1 
(assert (not (= (ite var3914 1 0) 0))) ; Cond: $z0 != 0 
 ; Statement: return r1 
(check-sat)
; {var2920_isEmpty/-813097145=([java.lang.String], boolean)}
; {var3563=org.apache.dubbo.registry.client.InstanceAddressURL, var1255=r1, var3706=r0, var3553=null_type, var2178=r2, var2920=org.apache.dubbo.common.utils.StringUtils, var3914=$z0}
; {org.apache.dubbo.registry.client.InstanceAddressURL=var3563, r1=var1255, r0=var3706, null_type=var3553, r2=var2178, org.apache.dubbo.common.utils.StringUtils=var2920, $z0=var3914}
;seq <org.apache.dubbo.common.utils.StringUtils: boolean isEmpty(java.lang.String)>
;cnt {"<org.apache.dubbo.common.utils.StringUtils: boolean isEmpty(java.lang.String)>": 1}
;stmts r1 := @this: org.apache.dubbo.registry.client.InstanceAddressURL;	r0 := @parameter0: java.lang.String;	r2 := @parameter1: java.lang.String;	$z0 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: boolean isEmpty(java.lang.String)>(r0);	if $z0 != 0 goto return r1;	return r1
;block_num 2