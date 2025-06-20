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

(declare-sort var1960 0)
(declare-sort var3686 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun getId/1260671200 (var3686) String)
(declare-const null-String String)
(declare-const null-var3686 var3686)
(declare-const var891 String) ; Statement: r1 := @parameter0: java.lang.String 
(assert (not (= var891 null-String)))
(declare-const var2845 var3686) ; Statement: r0 := @parameter1: org.apache.dubbo.config.RegistryConfig 
(assert (not (= var2845 null-var3686)))
(assert true)
(define-const var2203 String (getId/1260671200 var2845)) ; Statement: $r2 = virtualinvoke r0.<org.apache.dubbo.config.RegistryConfig: java.lang.String getId()>() 
(assert true)
(define-const var3119 Bool (= var2203 var891)) ; Statement: $z0 = virtualinvoke $r2.<java.lang.String: boolean equals(java.lang.Object)>(r1) 
 ; Statement: return $z0 
(check-sat)
; {getId/1260671200=([org.apache.dubbo.config.RegistryConfig], java.lang.String)}
; {var891=r1, var1960=null_type, var3686=org.apache.dubbo.config.RegistryConfig, var2845=r0, var2203=$r2, var3119=$z0}
; {r1=var891, null_type=var1960, org.apache.dubbo.config.RegistryConfig=var3686, r0=var2845, $r2=var2203, $z0=var3119}
;seq <java.lang.String: boolean equals(java.lang.Object)>
;cnt {"<java.lang.String: boolean equals(java.lang.Object)>": 1}
;stmts r1 := @parameter0: java.lang.String;	r0 := @parameter1: org.apache.dubbo.config.RegistryConfig;	$r2 = virtualinvoke r0.<org.apache.dubbo.config.RegistryConfig: java.lang.String getId()>();	$z0 = virtualinvoke $r2.<java.lang.String: boolean equals(java.lang.Object)>(r1);	return $z0
;block_num 1