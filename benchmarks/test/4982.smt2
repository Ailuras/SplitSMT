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

(declare-sort var1516 0)
(declare-sort var135 0)
(declare-sort var1463 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun var1463_isEmpty/-813097145 (String) Bool)
(declare-const null-var1516 var1516)
(declare-const null-String String)
(declare-const var3373 var1516) ; Statement: r6 := @this: org.apache.dubbo.config.AbstractReferenceConfig 
(assert (not (= var3373 null-var1516)))
(declare-const var3543 String) ; Statement: r0 := @parameter0: java.lang.String 
(assert (not (= var3543 null-String)))
(define-const var907 Bool (var1463_isEmpty/-813097145 var3543)) ; Statement: $z0 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: boolean isEmpty(java.lang.String)>(r0) 
 ; Statement: if $z0 == 0 goto $z1 = staticinvoke <org.apache.dubbo.rpc.support.ProtocolUtils: boolean isValidGenericValue(java.lang.String)>(r0) 
(assert (not (= (ite var907 1 0) 0))) ; Negate: Cond: $z0 == 0  
 ; Statement: return 
(check-sat)
; {var1463_isEmpty/-813097145=([java.lang.String], boolean)}
; {var1516=org.apache.dubbo.config.AbstractReferenceConfig, var3373=r6, var3543=r0, var135=null_type, var1463=org.apache.dubbo.common.utils.StringUtils, var907=$z0}
; {org.apache.dubbo.config.AbstractReferenceConfig=var1516, r6=var3373, r0=var3543, null_type=var135, org.apache.dubbo.common.utils.StringUtils=var1463, $z0=var907}
;seq <org.apache.dubbo.common.utils.StringUtils: boolean isEmpty(java.lang.String)>
;cnt {"<org.apache.dubbo.common.utils.StringUtils: boolean isEmpty(java.lang.String)>": 1}
;stmts r6 := @this: org.apache.dubbo.config.AbstractReferenceConfig;	r0 := @parameter0: java.lang.String;	$z0 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: boolean isEmpty(java.lang.String)>(r0);	if $z0 == 0 goto $z1 = staticinvoke <org.apache.dubbo.rpc.support.ProtocolUtils: boolean isValidGenericValue(java.lang.String)>(r0);	return
;block_num 2