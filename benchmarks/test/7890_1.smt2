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

(declare-sort var3222 0)
(declare-sort var3665 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun name/-1125446676 (var3222) String)
(declare-fun var3665_isEmpty/-813097145 (String) Bool)
(declare-const null-var3222 var3222)
(declare-const var3754 var3222) ; Statement: r0 := @this: org.apache.dubbo.config.ApplicationConfig 
(assert (not (= var3754 null-var3222)))
(define-const var3301 String (name/-1125446676 var3754)) ; Statement: $r1 = r0.<org.apache.dubbo.config.ApplicationConfig: java.lang.String name> 
(define-const var2426 Bool (var3665_isEmpty/-813097145 var3301)) ; Statement: $z0 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: boolean isEmpty(java.lang.String)>($r1) 
 ; Statement: if $z0 != 0 goto $z1 = 0 
(assert (not (not (= (ite var2426 1 0) 0)))) ; Negate: Cond: $z0 != 0  
(define-const var1873 Bool (ite (= 1 1) true false)) ; Statement: $z1 = 1 
 ; Statement: goto [?= return $z1] 
(assert true) ; Non Conditional
 ; Statement: return $z1 
(check-sat)
; {name/-1125446676=([org.apache.dubbo.config.ApplicationConfig], java.lang.String), var3665_isEmpty/-813097145=([java.lang.String], boolean)}
; {var3222=org.apache.dubbo.config.ApplicationConfig, var3754=r0, var3301=$r1, var3665=org.apache.dubbo.common.utils.StringUtils, var2426=$z0, var1873=$z1}
; {org.apache.dubbo.config.ApplicationConfig=var3222, r0=var3754, $r1=var3301, org.apache.dubbo.common.utils.StringUtils=var3665, $z0=var2426, $z1=var1873}
;seq <org.apache.dubbo.common.utils.StringUtils: boolean isEmpty(java.lang.String)>
;cnt {"<org.apache.dubbo.common.utils.StringUtils: boolean isEmpty(java.lang.String)>": 1}
;stmts r0 := @this: org.apache.dubbo.config.ApplicationConfig;	$r1 = r0.<org.apache.dubbo.config.ApplicationConfig: java.lang.String name>;	$z0 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: boolean isEmpty(java.lang.String)>($r1);	if $z0 != 0 goto $z1 = 0;	$z1 = 1;	goto [?= return $z1];	return $z1
;block_num 3