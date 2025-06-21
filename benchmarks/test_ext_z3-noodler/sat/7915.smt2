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

(declare-sort var2553 0)
(declare-sort var3936 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun name/-1125446676 (var2553) String)
(declare-fun var3936_isEmpty/-813097145 (String) Bool)
(declare-const null-var2553 var2553)
(declare-const var3799 var2553) ; Statement: r0 := @this: org.apache.dubbo.config.ApplicationConfig 
(assert (not (= var3799 null-var2553)))
(define-const var2096 String (name/-1125446676 var3799)) ; Statement: $r1 = r0.<org.apache.dubbo.config.ApplicationConfig: java.lang.String name> 
(define-const var2335 Bool (var3936_isEmpty/-813097145 var2096)) ; Statement: $z0 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: boolean isEmpty(java.lang.String)>($r1) 
 ; Statement: if $z0 != 0 goto $z1 = 0 
(assert (not (= (ite var2335 1 0) 0))) ; Cond: $z0 != 0 
(define-const var3065 Bool (ite (= 1 0) true false)) ; Statement: $z1 = 0 
(assert true) ; Non Conditional
 ; Statement: return $z1 
(check-sat)
; {name/-1125446676=([org.apache.dubbo.config.ApplicationConfig], java.lang.String), var3936_isEmpty/-813097145=([java.lang.String], boolean)}
; {var2553=org.apache.dubbo.config.ApplicationConfig, var3799=r0, var2096=$r1, var3936=org.apache.dubbo.common.utils.StringUtils, var2335=$z0, var3065=$z1}
; {org.apache.dubbo.config.ApplicationConfig=var2553, r0=var3799, $r1=var2096, org.apache.dubbo.common.utils.StringUtils=var3936, $z0=var2335, $z1=var3065}
;seq <org.apache.dubbo.common.utils.StringUtils: boolean isEmpty(java.lang.String)>
;cnt {"<org.apache.dubbo.common.utils.StringUtils: boolean isEmpty(java.lang.String)>": 1}
;stmts r0 := @this: org.apache.dubbo.config.ApplicationConfig;	$r1 = r0.<org.apache.dubbo.config.ApplicationConfig: java.lang.String name>;	$z0 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: boolean isEmpty(java.lang.String)>($r1);	if $z0 != 0 goto $z1 = 0;	$z1 = 0;	return $z1
;block_num 3