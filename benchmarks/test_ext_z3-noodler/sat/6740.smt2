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

(declare-sort var1915 0)
(declare-sort var3807 0)
(declare-sort var2817 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun var2817_isEmpty/-813097145 (String) Bool)
(declare-const null-var1915 var1915)
(declare-const null-String String)
(declare-const var3039 var1915) ; Statement: r6 := @this: org.apache.dubbo.config.ServiceConfigBase 
(assert (not (= var3039 null-var1915)))
(declare-const var1801 String) ; Statement: r0 := @parameter0: java.lang.String 
(assert (not (= var1801 null-String)))
(define-const var859 Bool (var2817_isEmpty/-813097145 var1801)) ; Statement: $z0 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: boolean isEmpty(java.lang.String)>(r0) 
 ; Statement: if $z0 == 0 goto $z1 = staticinvoke <org.apache.dubbo.rpc.support.ProtocolUtils: boolean isValidGenericValue(java.lang.String)>(r0) 
(assert (not (= (ite var859 1 0) 0))) ; Negate: Cond: $z0 == 0  
 ; Statement: return 
(check-sat)
; {var2817_isEmpty/-813097145=([java.lang.String], boolean)}
; {var1915=org.apache.dubbo.config.ServiceConfigBase, var3039=r6, var1801=r0, var3807=null_type, var2817=org.apache.dubbo.common.utils.StringUtils, var859=$z0}
; {org.apache.dubbo.config.ServiceConfigBase=var1915, r6=var3039, r0=var1801, null_type=var3807, org.apache.dubbo.common.utils.StringUtils=var2817, $z0=var859}
;seq <org.apache.dubbo.common.utils.StringUtils: boolean isEmpty(java.lang.String)>
;cnt {"<org.apache.dubbo.common.utils.StringUtils: boolean isEmpty(java.lang.String)>": 1}
;stmts r6 := @this: org.apache.dubbo.config.ServiceConfigBase;	r0 := @parameter0: java.lang.String;	$z0 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: boolean isEmpty(java.lang.String)>(r0);	if $z0 == 0 goto $z1 = staticinvoke <org.apache.dubbo.rpc.support.ProtocolUtils: boolean isValidGenericValue(java.lang.String)>(r0);	return
;block_num 2