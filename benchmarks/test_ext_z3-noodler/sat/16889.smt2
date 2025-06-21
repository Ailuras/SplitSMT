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

(declare-sort var367 0)
(declare-sort var1391 0)
(declare-sort var3127 0)
(declare-sort var417 0)
(declare-sort var3893 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun getServiceInterface/-1311863806 (var1391) String)
(declare-fun arr-String-init () (Array Int String))
(declare-fun var417_asList/1779083644 ((Array Int var3893)) var3127)
(declare-fun cast-from-__Array__Int__String__-to-__Array__Int__var3893__ ((Array Int String)) (Array Int var3893))
(declare-const null-var367 var367)
(declare-const null-var1391 var1391)
(declare-const null-__Array__Int__String__ (Array Int String))
(declare-const var1715 var367) ; Statement: r4 := @this: org.apache.dubbo.registry.nacos.NacosRegistry 
(assert (not (= var1715 null-var367)))
(declare-const var2333 var1391) ; Statement: r0 := @parameter0: org.apache.dubbo.common.URL 
(assert (not (= var2333 null-var1391)))
(define-const var3257 String "*") ; Statement: $r2 = "*" 
(assert true)
(define-const var1443 String (getServiceInterface/-1311863806 var2333)) ; Statement: $r1 = virtualinvoke r0.<org.apache.dubbo.common.URL: java.lang.String getServiceInterface()>() 
(assert true)
(define-const var2397 Bool (= var3257 var1443)) ; Statement: $z0 = virtualinvoke $r2.<java.lang.String: boolean equals(java.lang.Object)>($r1) 
 ; Statement: if $z0 == 0 goto $r3 = newarray (java.lang.String)[1] 
(assert (= (ite var2397 1 0) 0)) ; Cond: $z0 == 0 
(define-const var2168 (Array Int String) arr-String-init) ; Statement: $r3 = newarray (java.lang.String)[1] 
(declare-const var2168!1 (Array Int String))
(assert (not (= var2168!1 null-__Array__Int__String__)))
(assert (= (select var2168!1 0) "providers")) ; Statement: $r3[0] = "providers" 
(define-const var1179 var3127 (var417_asList/1779083644 (cast-from-__Array__Int__String__-to-__Array__Int__var3893__ var2168!1))) ; Statement: $r5 = staticinvoke <java.util.Arrays: java.util.List asList(java.lang.Object[])>($r3) 
(assert true) ; Non Conditional
 ; Statement: return $r5 
(check-sat)
; {getServiceInterface/-1311863806=([org.apache.dubbo.common.URL], java.lang.String), arr-String-init=([], java.lang.String[]), var417_asList/1779083644=([java.lang.Object[]], java.util.List), cast-from-__Array__Int__String__-to-__Array__Int__var3893__=([java.lang.String[]], java.lang.Object[])}
; {var367=org.apache.dubbo.registry.nacos.NacosRegistry, var1715=r4, var1391=org.apache.dubbo.common.URL, var2333=r0, var3257=$r2, var1443=$r1, var2397=$z0, var2168=$r3, var3127=java.util.List, var417=java.util.Arrays, var3893=java.lang.Object, var1179=$r5}
; {org.apache.dubbo.registry.nacos.NacosRegistry=var367, r4=var1715, org.apache.dubbo.common.URL=var1391, r0=var2333, $r2=var3257, $r1=var1443, $z0=var2397, $r3=var2168, java.util.List=var3127, java.util.Arrays=var417, java.lang.Object=var3893, $r5=var1179}
;seq <java.lang.String: boolean equals(java.lang.Object)>
;cnt {"<java.lang.String: boolean equals(java.lang.Object)>": 1}
;stmts r4 := @this: org.apache.dubbo.registry.nacos.NacosRegistry;	r0 := @parameter0: org.apache.dubbo.common.URL;	$r2 = "*";	$r1 = virtualinvoke r0.<org.apache.dubbo.common.URL: java.lang.String getServiceInterface()>();	$z0 = virtualinvoke $r2.<java.lang.String: boolean equals(java.lang.Object)>($r1);	if $z0 == 0 goto $r3 = newarray (java.lang.String)[1];	$r3 = newarray (java.lang.String)[1];	$r3[0] = "providers";	$r5 = staticinvoke <java.util.Arrays: java.util.List asList(java.lang.Object[])>($r3);	return $r5
;block_num 3