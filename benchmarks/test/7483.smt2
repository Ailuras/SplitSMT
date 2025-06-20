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

(declare-sort var20 0)
(declare-sort var2510 0)
(declare-sort var117 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun getConfigName/84468241 (var20 var117) String)
(declare-const null-var20 var20)
(declare-const null-String String)
(declare-const null-var117 var117)
(declare-const var1706 var20) ; Statement: r1 := @this: org.apache.dubbo.config.context.AbstractConfigManager 
(assert (not (= var1706 null-var20)))
(declare-const var2511 String) ; Statement: r0 := @parameter0: java.lang.String 
(assert (not (= var2511 null-String)))
(declare-const var3811 var117) ; Statement: r2 := @parameter1: org.apache.dubbo.config.AbstractConfig 
(assert (not (= var3811 null-var117)))
(assert true)
(define-const var1141 String (getConfigName/84468241 var1706 var3811)) ; Statement: $r3 = specialinvoke r1.<org.apache.dubbo.config.context.AbstractConfigManager: java.lang.String getConfigName(org.apache.dubbo.config.AbstractConfig)>(r2) 
(assert true)
(define-const var3278 Bool (= var2511 var1141)) ; Statement: $z0 = virtualinvoke r0.<java.lang.String: boolean equals(java.lang.Object)>($r3) 
 ; Statement: return $z0 
(check-sat)
; {getConfigName/84468241=([org.apache.dubbo.config.context.AbstractConfigManager, org.apache.dubbo.config.AbstractConfig], java.lang.String)}
; {var20=org.apache.dubbo.config.context.AbstractConfigManager, var1706=r1, var2511=r0, var2510=null_type, var117=org.apache.dubbo.config.AbstractConfig, var3811=r2, var1141=$r3, var3278=$z0}
; {org.apache.dubbo.config.context.AbstractConfigManager=var20, r1=var1706, r0=var2511, null_type=var2510, org.apache.dubbo.config.AbstractConfig=var117, r2=var3811, $r3=var1141, $z0=var3278}
;seq <java.lang.String: boolean equals(java.lang.Object)>
;cnt {"<java.lang.String: boolean equals(java.lang.Object)>": 1}
;stmts r1 := @this: org.apache.dubbo.config.context.AbstractConfigManager;	r0 := @parameter0: java.lang.String;	r2 := @parameter1: org.apache.dubbo.config.AbstractConfig;	$r3 = specialinvoke r1.<org.apache.dubbo.config.context.AbstractConfigManager: java.lang.String getConfigName(org.apache.dubbo.config.AbstractConfig)>(r2);	$z0 = virtualinvoke r0.<java.lang.String: boolean equals(java.lang.Object)>($r3);	return $z0
;block_num 1