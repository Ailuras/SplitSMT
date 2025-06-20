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

(declare-sort var1563 0)
(declare-sort var2 0)
(declare-sort var1574 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun cast-from-var2-to-String (var2) String)
(declare-fun var1574_isNotEmpty/-1251449450 (String) Bool)
(declare-const null-var1563 var1563)
(declare-const null-var2 var2)
(declare-const var226 var1563) ; Statement: $r0 := @this: org.apache.dubbo.registry.client.metadata.ServiceInstanceMetadataUtils$isNotEmpty__1046 
(assert (not (= var226 null-var1563)))
(declare-const var1803 var2) ; Statement: $r1 := @parameter0: java.lang.Object 
(assert (not (= var1803 null-var2)))
(define-const var3597 String (cast-from-var2-to-String var1803)) ; Statement: $r2 = (java.lang.String) $r1 
(define-const var2649 Bool (var1574_isNotEmpty/-1251449450 var3597)) ; Statement: $z0 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: boolean isNotEmpty(java.lang.String)>($r2) 
 ; Statement: return $z0 
(check-sat)
; {cast-from-var2-to-String=([java.lang.Object], java.lang.String), var1574_isNotEmpty/-1251449450=([java.lang.String], boolean)}
; {var1563=org.apache.dubbo.registry.client.metadata.ServiceInstanceMetadataUtils$isNotEmpty__1046, var226=$r0, var2=java.lang.Object, var1803=$r1, var3597=$r2, var1574=org.apache.dubbo.common.utils.StringUtils, var2649=$z0}
; {org.apache.dubbo.registry.client.metadata.ServiceInstanceMetadataUtils$isNotEmpty__1046=var1563, $r0=var226, java.lang.Object=var2, $r1=var1803, $r2=var3597, org.apache.dubbo.common.utils.StringUtils=var1574, $z0=var2649}
;seq <org.apache.dubbo.common.utils.StringUtils: boolean isNotEmpty(java.lang.String)>
;cnt {"<org.apache.dubbo.common.utils.StringUtils: boolean isNotEmpty(java.lang.String)>": 1}
;stmts $r0 := @this: org.apache.dubbo.registry.client.metadata.ServiceInstanceMetadataUtils$isNotEmpty__1046;	$r1 := @parameter0: java.lang.Object;	$r2 = (java.lang.String) $r1;	$z0 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: boolean isNotEmpty(java.lang.String)>($r2);	return $z0
;block_num 1