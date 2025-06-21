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

(declare-sort var3642 0)
(declare-sort var2309 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun namingService/-1481231732 (var3642) var2309)
(declare-fun getServerStatus/668810862 (var2309) String)
(declare-const null-var3642 var3642)
(declare-const var2168 var3642) ; Statement: r0 := @this: org.apache.dubbo.registry.nacos.NacosRegistry 
(assert (not (= var2168 null-var3642)))
(define-const var3855 String "UP") ; Statement: $r3 = "UP" 
(define-const var3320 var2309 (namingService/-1481231732 var2168)) ; Statement: $r1 = r0.<org.apache.dubbo.registry.nacos.NacosRegistry: org.apache.dubbo.registry.nacos.NacosNamingServiceWrapper namingService> 
(assert true)
(define-const var3489 String (getServerStatus/668810862 var3320)) ; Statement: $r2 = virtualinvoke $r1.<org.apache.dubbo.registry.nacos.NacosNamingServiceWrapper: java.lang.String getServerStatus()>() 
(assert true)
(define-const var3787 Bool (= var3855 var3489)) ; Statement: $z0 = virtualinvoke $r3.<java.lang.String: boolean equals(java.lang.Object)>($r2) 
 ; Statement: return $z0 
(check-sat)
; {namingService/-1481231732=([org.apache.dubbo.registry.nacos.NacosRegistry], org.apache.dubbo.registry.nacos.NacosNamingServiceWrapper), getServerStatus/668810862=([org.apache.dubbo.registry.nacos.NacosNamingServiceWrapper], java.lang.String)}
; {var3642=org.apache.dubbo.registry.nacos.NacosRegistry, var2168=r0, var3855=$r3, var2309=org.apache.dubbo.registry.nacos.NacosNamingServiceWrapper, var3320=$r1, var3489=$r2, var3787=$z0}
; {org.apache.dubbo.registry.nacos.NacosRegistry=var3642, r0=var2168, $r3=var3855, org.apache.dubbo.registry.nacos.NacosNamingServiceWrapper=var2309, $r1=var3320, $r2=var3489, $z0=var3787}
;seq <java.lang.String: boolean equals(java.lang.Object)>
;cnt {"<java.lang.String: boolean equals(java.lang.Object)>": 1}
;stmts r0 := @this: org.apache.dubbo.registry.nacos.NacosRegistry;	$r3 = "UP";	$r1 = r0.<org.apache.dubbo.registry.nacos.NacosRegistry: org.apache.dubbo.registry.nacos.NacosNamingServiceWrapper namingService>;	$r2 = virtualinvoke $r1.<org.apache.dubbo.registry.nacos.NacosNamingServiceWrapper: java.lang.String getServerStatus()>();	$z0 = virtualinvoke $r3.<java.lang.String: boolean equals(java.lang.Object)>($r2);	return $z0
;block_num 1