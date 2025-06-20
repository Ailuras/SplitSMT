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

(declare-sort var1853 0)
(declare-sort var2222 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun getGeneric/-2144873936 (var1853) String)
(declare-fun var2222_isEmpty/-813097145 (String) Bool)
(declare-const null-var1853 var1853)
(declare-const var3783 var1853) ; Statement: r0 := @this: org.apache.dubbo.config.AbstractReferenceConfig 
(assert (not (= var3783 null-var1853)))
(assert true)
(define-const var1594 String (getGeneric/-2144873936 var3783)) ; Statement: $r1 = virtualinvoke r0.<org.apache.dubbo.config.AbstractReferenceConfig: java.lang.String getGeneric()>() 
(define-const var764 Bool (var2222_isEmpty/-813097145 var1594)) ; Statement: $z0 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: boolean isEmpty(java.lang.String)>($r1) 
 ; Statement: return $z0 
(check-sat)
; {getGeneric/-2144873936=([org.apache.dubbo.config.AbstractReferenceConfig], java.lang.String), var2222_isEmpty/-813097145=([java.lang.String], boolean)}
; {var1853=org.apache.dubbo.config.AbstractReferenceConfig, var3783=r0, var1594=$r1, var2222=org.apache.dubbo.common.utils.StringUtils, var764=$z0}
; {org.apache.dubbo.config.AbstractReferenceConfig=var1853, r0=var3783, $r1=var1594, org.apache.dubbo.common.utils.StringUtils=var2222, $z0=var764}
;seq <org.apache.dubbo.common.utils.StringUtils: boolean isEmpty(java.lang.String)>
;cnt {"<org.apache.dubbo.common.utils.StringUtils: boolean isEmpty(java.lang.String)>": 1}
;stmts r0 := @this: org.apache.dubbo.config.AbstractReferenceConfig;	$r1 = virtualinvoke r0.<org.apache.dubbo.config.AbstractReferenceConfig: java.lang.String getGeneric()>();	$z0 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: boolean isEmpty(java.lang.String)>($r1);	return $z0
;block_num 1