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

(declare-sort var201 0)
(declare-sort var6 0)
(declare-sort var279 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun cast-from-var6-to-String (var6) String)
(declare-fun var279_isNotEmpty/-1251449450 (String) Bool)
(declare-const null-var201 var201)
(declare-const null-var6 var6)
(declare-const var181 var201) ; Statement: $r0 := @this: org.apache.dubbo.common.utils.PathUtils$isNotEmpty__272 
(assert (not (= var181 null-var201)))
(declare-const var2751 var6) ; Statement: $r1 := @parameter0: java.lang.Object 
(assert (not (= var2751 null-var6)))
(define-const var682 String (cast-from-var6-to-String var2751)) ; Statement: $r2 = (java.lang.String) $r1 
(define-const var3139 Bool (var279_isNotEmpty/-1251449450 var682)) ; Statement: $z0 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: boolean isNotEmpty(java.lang.String)>($r2) 
 ; Statement: return $z0 
(check-sat)
; {cast-from-var6-to-String=([java.lang.Object], java.lang.String), var279_isNotEmpty/-1251449450=([java.lang.String], boolean)}
; {var201=org.apache.dubbo.common.utils.PathUtils$isNotEmpty__272, var181=$r0, var6=java.lang.Object, var2751=$r1, var682=$r2, var279=org.apache.dubbo.common.utils.StringUtils, var3139=$z0}
; {org.apache.dubbo.common.utils.PathUtils$isNotEmpty__272=var201, $r0=var181, java.lang.Object=var6, $r1=var2751, $r2=var682, org.apache.dubbo.common.utils.StringUtils=var279, $z0=var3139}
;seq <org.apache.dubbo.common.utils.StringUtils: boolean isNotEmpty(java.lang.String)>
;cnt {"<org.apache.dubbo.common.utils.StringUtils: boolean isNotEmpty(java.lang.String)>": 1}
;stmts $r0 := @this: org.apache.dubbo.common.utils.PathUtils$isNotEmpty__272;	$r1 := @parameter0: java.lang.Object;	$r2 = (java.lang.String) $r1;	$z0 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: boolean isNotEmpty(java.lang.String)>($r2);	return $z0
;block_num 1