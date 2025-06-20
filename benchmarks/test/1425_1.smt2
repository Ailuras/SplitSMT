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

(declare-sort var1714 0)
(declare-sort var3301 0)
(declare-sort var2507 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun getenv/1640117676 (var1714 String) String)
(declare-fun var2507_isEmpty/-813097145 (String) Bool)
(declare-const null-var1714 var1714)
(declare-const null-String String)
(declare-const var693 var1714) ; Statement: r0 := @this: org.apache.dubbo.common.config.EnvironmentConfiguration 
(assert (not (= var693 null-var1714)))
(declare-const var2025 String) ; Statement: r1 := @parameter0: java.lang.String 
(assert (not (= var2025 null-String)))
(assert true)
(define-const var3941 String (getenv/1640117676 var693 var2025)) ; Statement: r3 = virtualinvoke r0.<org.apache.dubbo.common.config.EnvironmentConfiguration: java.lang.String getenv(java.lang.String)>(r1) 
(define-const var2389 Bool (var2507_isEmpty/-813097145 var3941)) ; Statement: $z0 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: boolean isEmpty(java.lang.String)>(r3) 
 ; Statement: if $z0 == 0 goto return r3 
(assert (= (ite var2389 1 0) 0)) ; Cond: $z0 == 0 
 ; Statement: return r3 
(check-sat)
; {getenv/1640117676=([org.apache.dubbo.common.config.EnvironmentConfiguration, java.lang.String], java.lang.String), var2507_isEmpty/-813097145=([java.lang.String], boolean)}
; {var1714=org.apache.dubbo.common.config.EnvironmentConfiguration, var693=r0, var2025=r1, var3301=null_type, var3941=r3, var2507=org.apache.dubbo.common.utils.StringUtils, var2389=$z0}
; {org.apache.dubbo.common.config.EnvironmentConfiguration=var1714, r0=var693, r1=var2025, null_type=var3301, r3=var3941, org.apache.dubbo.common.utils.StringUtils=var2507, $z0=var2389}
;seq <org.apache.dubbo.common.utils.StringUtils: boolean isEmpty(java.lang.String)>
;cnt {"<org.apache.dubbo.common.utils.StringUtils: boolean isEmpty(java.lang.String)>": 1}
;stmts r0 := @this: org.apache.dubbo.common.config.EnvironmentConfiguration;	r1 := @parameter0: java.lang.String;	r3 = virtualinvoke r0.<org.apache.dubbo.common.config.EnvironmentConfiguration: java.lang.String getenv(java.lang.String)>(r1);	$z0 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: boolean isEmpty(java.lang.String)>(r3);	if $z0 == 0 goto return r3;	return r3
;block_num 2