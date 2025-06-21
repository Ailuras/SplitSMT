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

(declare-sort var3068 0)
(declare-sort var497 0)
(declare-sort var252 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun cast-from-var497-to-String (var497) String)
(declare-fun var252_isNotEmpty/-1251449450 (String) Bool)
(declare-const null-var3068 var3068)
(declare-const null-var497 var497)
(declare-const var3441 var3068) ; Statement: $r0 := @this: org.apache.dubbo.metadata.ServiceNameMapping$isNotEmpty__637 
(assert (not (= var3441 null-var3068)))
(declare-const var1652 var497) ; Statement: $r1 := @parameter0: java.lang.Object 
(assert (not (= var1652 null-var497)))
(define-const var347 String (cast-from-var497-to-String var1652)) ; Statement: $r2 = (java.lang.String) $r1 
(define-const var46 Bool (var252_isNotEmpty/-1251449450 var347)) ; Statement: $z0 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: boolean isNotEmpty(java.lang.String)>($r2) 
 ; Statement: return $z0 
(check-sat)
; {cast-from-var497-to-String=([java.lang.Object], java.lang.String), var252_isNotEmpty/-1251449450=([java.lang.String], boolean)}
; {var3068=org.apache.dubbo.metadata.ServiceNameMapping$isNotEmpty__637, var3441=$r0, var497=java.lang.Object, var1652=$r1, var347=$r2, var252=org.apache.dubbo.common.utils.StringUtils, var46=$z0}
; {org.apache.dubbo.metadata.ServiceNameMapping$isNotEmpty__637=var3068, $r0=var3441, java.lang.Object=var497, $r1=var1652, $r2=var347, org.apache.dubbo.common.utils.StringUtils=var252, $z0=var46}
;seq <org.apache.dubbo.common.utils.StringUtils: boolean isNotEmpty(java.lang.String)>
;cnt {"<org.apache.dubbo.common.utils.StringUtils: boolean isNotEmpty(java.lang.String)>": 1}
;stmts $r0 := @this: org.apache.dubbo.metadata.ServiceNameMapping$isNotEmpty__637;	$r1 := @parameter0: java.lang.Object;	$r2 = (java.lang.String) $r1;	$z0 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: boolean isNotEmpty(java.lang.String)>($r2);	return $z0
;block_num 1