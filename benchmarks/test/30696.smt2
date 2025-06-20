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

(declare-sort var235 0)
(declare-sort var1936 0)
(declare-sort var80 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun cast-from-var1936-to-String (var1936) String)
(declare-fun var80_isNotEmpty/-1251449450 (String) Bool)
(declare-const null-var235 var235)
(declare-const null-var1936 var1936)
(declare-const var2267 var235) ; Statement: $r0 := @this: org.apache.dubbo.qos.permission.DefaultAnonymousAccessPermissionChecker$isNotEmpty__923 
(assert (not (= var2267 null-var235)))
(declare-const var442 var1936) ; Statement: $r1 := @parameter0: java.lang.Object 
(assert (not (= var442 null-var1936)))
(define-const var1237 String (cast-from-var1936-to-String var442)) ; Statement: $r2 = (java.lang.String) $r1 
(define-const var3628 Bool (var80_isNotEmpty/-1251449450 var1237)) ; Statement: $z0 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: boolean isNotEmpty(java.lang.String)>($r2) 
 ; Statement: return $z0 
(check-sat)
; {cast-from-var1936-to-String=([java.lang.Object], java.lang.String), var80_isNotEmpty/-1251449450=([java.lang.String], boolean)}
; {var235=org.apache.dubbo.qos.permission.DefaultAnonymousAccessPermissionChecker$isNotEmpty__923, var2267=$r0, var1936=java.lang.Object, var442=$r1, var1237=$r2, var80=org.apache.dubbo.common.utils.StringUtils, var3628=$z0}
; {org.apache.dubbo.qos.permission.DefaultAnonymousAccessPermissionChecker$isNotEmpty__923=var235, $r0=var2267, java.lang.Object=var1936, $r1=var442, $r2=var1237, org.apache.dubbo.common.utils.StringUtils=var80, $z0=var3628}
;seq <org.apache.dubbo.common.utils.StringUtils: boolean isNotEmpty(java.lang.String)>
;cnt {"<org.apache.dubbo.common.utils.StringUtils: boolean isNotEmpty(java.lang.String)>": 1}
;stmts $r0 := @this: org.apache.dubbo.qos.permission.DefaultAnonymousAccessPermissionChecker$isNotEmpty__923;	$r1 := @parameter0: java.lang.Object;	$r2 = (java.lang.String) $r1;	$z0 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: boolean isNotEmpty(java.lang.String)>($r2);	return $z0
;block_num 1