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

(declare-sort var746 0)
(declare-sort var1419 0)
(declare-sort var641 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun configuratorUrl/338141869 (var746) var641)
(declare-fun getHost/-1506772130 (var641) String)
(declare-fun isV27ConditionMatchOrUnset/2023844721 (var746 var641) Bool)
(declare-const null-var746 var746)
(declare-const null-String String)
(declare-const null-var641 var641)
(declare-const var3255 var746) ; Statement: r0 := @this: org.apache.dubbo.rpc.cluster.configurator.AbstractConfigurator 
(assert (not (= var3255 null-var746)))
(declare-const var2502 String) ; Statement: r17 := @parameter0: java.lang.String 
(assert (not (= var2502 null-String)))
(declare-const var1307 var641) ; Statement: r4 := @parameter1: org.apache.dubbo.common.URL 
(assert (not (= var1307 null-var641)))
(define-const var558 String "0.0.0.0") ; Statement: $r3 = "0.0.0.0" 
(define-const var3197 var641 (configuratorUrl/338141869 var3255)) ; Statement: $r1 = r0.<org.apache.dubbo.rpc.cluster.configurator.AbstractConfigurator: org.apache.dubbo.common.URL configuratorUrl> 
(assert true)
(define-const var1608 String (getHost/-1506772130 var3197)) ; Statement: $r2 = virtualinvoke $r1.<org.apache.dubbo.common.URL: java.lang.String getHost()>() 
(assert true)
(define-const var2848 Bool (= var558 var1608)) ; Statement: $z0 = virtualinvoke $r3.<java.lang.String: boolean equals(java.lang.Object)>($r2) 
 ; Statement: if $z0 != 0 goto $z1 = specialinvoke r0.<org.apache.dubbo.rpc.cluster.configurator.AbstractConfigurator: boolean isV27ConditionMatchOrUnset(org.apache.dubbo.common.URL)>(r4) 
(assert (not (= (ite var2848 1 0) 0))) ; Cond: $z0 != 0 
(assert true)
(define-const var132 Bool (isV27ConditionMatchOrUnset/2023844721 var3255 var1307)) ; Statement: $z1 = specialinvoke r0.<org.apache.dubbo.rpc.cluster.configurator.AbstractConfigurator: boolean isV27ConditionMatchOrUnset(org.apache.dubbo.common.URL)>(r4) 
 ; Statement: if $z1 == 0 goto return r4 
(assert (= (ite var132 1 0) 0)) ; Cond: $z1 == 0 
 ; Statement: return r4 
(check-sat)
; {configuratorUrl/338141869=([org.apache.dubbo.rpc.cluster.configurator.AbstractConfigurator], org.apache.dubbo.common.URL), getHost/-1506772130=([org.apache.dubbo.common.URL], java.lang.String), isV27ConditionMatchOrUnset/2023844721=([org.apache.dubbo.rpc.cluster.configurator.AbstractConfigurator, org.apache.dubbo.common.URL], boolean)}
; {var746=org.apache.dubbo.rpc.cluster.configurator.AbstractConfigurator, var3255=r0, var2502=r17, var1419=null_type, var641=org.apache.dubbo.common.URL, var1307=r4, var558=$r3, var3197=$r1, var1608=$r2, var2848=$z0, var132=$z1}
; {org.apache.dubbo.rpc.cluster.configurator.AbstractConfigurator=var746, r0=var3255, r17=var2502, null_type=var1419, org.apache.dubbo.common.URL=var641, r4=var1307, $r3=var558, $r1=var3197, $r2=var1608, $z0=var2848, $z1=var132}
;seq <java.lang.String: boolean equals(java.lang.Object)>
;cnt {"<java.lang.String: boolean equals(java.lang.Object)>": 1}
;stmts r0 := @this: org.apache.dubbo.rpc.cluster.configurator.AbstractConfigurator;	r17 := @parameter0: java.lang.String;	r4 := @parameter1: org.apache.dubbo.common.URL;	$r3 = "0.0.0.0";	$r1 = r0.<org.apache.dubbo.rpc.cluster.configurator.AbstractConfigurator: org.apache.dubbo.common.URL configuratorUrl>;	$r2 = virtualinvoke $r1.<org.apache.dubbo.common.URL: java.lang.String getHost()>();	$z0 = virtualinvoke $r3.<java.lang.String: boolean equals(java.lang.Object)>($r2);	if $z0 != 0 goto $z1 = specialinvoke r0.<org.apache.dubbo.rpc.cluster.configurator.AbstractConfigurator: boolean isV27ConditionMatchOrUnset(org.apache.dubbo.common.URL)>(r4);	$z1 = specialinvoke r0.<org.apache.dubbo.rpc.cluster.configurator.AbstractConfigurator: boolean isV27ConditionMatchOrUnset(org.apache.dubbo.common.URL)>(r4);	if $z1 == 0 goto return r4;	return r4
;block_num 3