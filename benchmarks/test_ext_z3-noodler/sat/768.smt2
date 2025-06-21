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

(declare-sort var3575 0)
(declare-sort var1107 0)
(declare-sort var3709 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun var3709_isNotEmpty/-1251449450 (String) Bool)
(declare-const null-var3575 var3575)
(declare-const null-String String)
(declare-const var1148 var3575) ; Statement: r1 := @this: org.apache.dubbo.rpc.cluster.configurator.AbstractConfigurator 
(assert (not (= var1148 null-var3575)))
(declare-const var3964 String) ; Statement: r0 := @parameter0: java.lang.String 
(assert (not (= var3964 null-String)))
(define-const var3168 Bool (var3709_isNotEmpty/-1251449450 var3964)) ; Statement: $z0 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: boolean isNotEmpty(java.lang.String)>(r0) 
 ; Statement: if $z0 == 0 goto $z2 = 0 
(assert (= (ite var3168 1 0) 0)) ; Cond: $z0 == 0 
(define-const var60 Bool (ite (= 1 0) true false)) ; Statement: $z2 = 0 
(assert true) ; Non Conditional
 ; Statement: return $z2 
(check-sat)
; {var3709_isNotEmpty/-1251449450=([java.lang.String], boolean)}
; {var3575=org.apache.dubbo.rpc.cluster.configurator.AbstractConfigurator, var1148=r1, var3964=r0, var1107=null_type, var3709=org.apache.dubbo.common.utils.StringUtils, var3168=$z0, var60=$z2}
; {org.apache.dubbo.rpc.cluster.configurator.AbstractConfigurator=var3575, r1=var1148, r0=var3964, null_type=var1107, org.apache.dubbo.common.utils.StringUtils=var3709, $z0=var3168, $z2=var60}
;seq <org.apache.dubbo.common.utils.StringUtils: boolean isNotEmpty(java.lang.String)>
;cnt {"<org.apache.dubbo.common.utils.StringUtils: boolean isNotEmpty(java.lang.String)>": 1}
;stmts r1 := @this: org.apache.dubbo.rpc.cluster.configurator.AbstractConfigurator;	r0 := @parameter0: java.lang.String;	$z0 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: boolean isNotEmpty(java.lang.String)>(r0);	if $z0 == 0 goto $z2 = 0;	$z2 = 0;	return $z2
;block_num 3