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

(declare-sort var3292 0)
(declare-sort var1315 0)
(declare-sort var852 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun cast-from-var1315-to-String (var1315) String)
(declare-fun var852_isNotEmpty/-1251449450 (String) Bool)
(declare-const null-var3292 var3292)
(declare-const null-var1315 var1315)
(declare-const var3213 var3292) ; Statement: $r0 := @this: org.apache.dubbo.qos.api.QosConfiguration$isNotEmpty__871 
(assert (not (= var3213 null-var3292)))
(declare-const var3209 var1315) ; Statement: $r1 := @parameter0: java.lang.Object 
(assert (not (= var3209 null-var1315)))
(define-const var2811 String (cast-from-var1315-to-String var3209)) ; Statement: $r2 = (java.lang.String) $r1 
(define-const var2012 Bool (var852_isNotEmpty/-1251449450 var2811)) ; Statement: $z0 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: boolean isNotEmpty(java.lang.String)>($r2) 
 ; Statement: return $z0 
(check-sat)
; {cast-from-var1315-to-String=([java.lang.Object], java.lang.String), var852_isNotEmpty/-1251449450=([java.lang.String], boolean)}
; {var3292=org.apache.dubbo.qos.api.QosConfiguration$isNotEmpty__871, var3213=$r0, var1315=java.lang.Object, var3209=$r1, var2811=$r2, var852=org.apache.dubbo.common.utils.StringUtils, var2012=$z0}
; {org.apache.dubbo.qos.api.QosConfiguration$isNotEmpty__871=var3292, $r0=var3213, java.lang.Object=var1315, $r1=var3209, $r2=var2811, org.apache.dubbo.common.utils.StringUtils=var852, $z0=var2012}
;seq <org.apache.dubbo.common.utils.StringUtils: boolean isNotEmpty(java.lang.String)>
;cnt {"<org.apache.dubbo.common.utils.StringUtils: boolean isNotEmpty(java.lang.String)>": 1}
;stmts $r0 := @this: org.apache.dubbo.qos.api.QosConfiguration$isNotEmpty__871;	$r1 := @parameter0: java.lang.Object;	$r2 = (java.lang.String) $r1;	$z0 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: boolean isNotEmpty(java.lang.String)>($r2);	return $z0
;block_num 1