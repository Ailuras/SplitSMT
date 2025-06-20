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

(declare-sort var32 0)
(declare-sort var1818 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun shouldSimplified/2129308851 (var32) Bool)
(declare-fun arr-String-init () (Array Int String))
(declare-fun String_valueOf/-1973653463 (Bool) String)
(declare-fun addParameters/1592766819 (var1818 (Array Int String)) var1818)
(declare-fun registeredConsumerUrl/2129308851 (var32) var1818)
(declare-const null-var32 var32)
(declare-const null-var1818 var1818)
(declare-const null-__Array__Int__String__ (Array Int String))
(declare-const var1591 var32) ; Statement: r0 := @this: org.apache.dubbo.registry.integration.DynamicDirectory 
(assert (not (= var1591 null-var32)))
(declare-const var975 var1818) ; Statement: r1 := @parameter0: org.apache.dubbo.common.URL 
(assert (not (= var975 null-var1818)))
(define-const var554 Bool (shouldSimplified/2129308851 var1591)) ; Statement: $z0 = r0.<org.apache.dubbo.registry.integration.DynamicDirectory: boolean shouldSimplified> 
 ; Statement: if $z0 != 0 goto $r2 = <org.apache.dubbo.registry.integration.InterfaceCompatibleRegistryProtocol: java.lang.String[] DEFAULT_REGISTER_CONSUMER_KEYS> 
(assert (not (not (= (ite var554 1 0) 0)))) ; Negate: Cond: $z0 != 0  
(define-const var604 (Array Int String) arr-String-init) ; Statement: $r7 = newarray (java.lang.String)[4] 
(declare-const var604!1 (Array Int String))
(assert (not (= var604!1 null-__Array__Int__String__)))
(assert (= (select var604!1 0) "category")) ; Statement: $r7[0] = "category" 
(declare-const var604!2 (Array Int String))
(assert (not (= var604!2 null-__Array__Int__String__)))
(assert (= (select var604!2 1) "consumers")) ; Statement: $r7[1] = "consumers" 
(declare-const var604!3 (Array Int String))
(assert (not (= var604!3 null-__Array__Int__String__)))
(assert (= (select var604!3 2) "check")) ; Statement: $r7[2] = "check" 
(define-const var3873 String (String_valueOf/-1973653463 (ite (= 1 0) true false))) ; Statement: $r8 = staticinvoke <java.lang.String: java.lang.String valueOf(boolean)>(0) 
(declare-const var604!4 (Array Int String))
(assert (not (= var604!4 null-__Array__Int__String__)))
(assert (= (select var604!4 3) var3873)) ; Statement: $r7[3] = $r8 
(assert true)
(define-const var2139 var1818 (addParameters/1592766819 var975 var604!4)) ; Statement: $r9 = virtualinvoke r1.<org.apache.dubbo.common.URL: org.apache.dubbo.common.URL addParameters(java.lang.String[])>($r7) 
(declare-const var1591!1 var32)
(assert (not (= var1591!1 null-var32)))
(assert (= (registeredConsumerUrl/2129308851 var1591!1) var2139)) ; Statement: r0.<org.apache.dubbo.registry.integration.DynamicDirectory: org.apache.dubbo.common.URL registeredConsumerUrl> = $r9 
 ; Statement: goto [?= return] 
(assert true) ; Non Conditional
 ; Statement: return 
(check-sat)
; {shouldSimplified/2129308851=([org.apache.dubbo.registry.integration.DynamicDirectory], boolean), arr-String-init=([], java.lang.String[]), String_valueOf/-1973653463=([boolean], java.lang.String), addParameters/1592766819=([org.apache.dubbo.common.URL, java.lang.String[]], org.apache.dubbo.common.URL), registeredConsumerUrl/2129308851=([org.apache.dubbo.registry.integration.DynamicDirectory], org.apache.dubbo.common.URL)}
; {var32=org.apache.dubbo.registry.integration.DynamicDirectory, var1591=r0, var1818=org.apache.dubbo.common.URL, var975=r1, var554=$z0, var604=$r7, var3873=$r8, var2139=$r9}
; {org.apache.dubbo.registry.integration.DynamicDirectory=var32, r0=var1591, org.apache.dubbo.common.URL=var1818, r1=var975, $z0=var554, $r7=var604, $r8=var3873, $r9=var2139}
;seq <java.lang.String: java.lang.String valueOf(boolean)>
;cnt {"<java.lang.String: java.lang.String valueOf(boolean)>": 1}
;stmts r0 := @this: org.apache.dubbo.registry.integration.DynamicDirectory;	r1 := @parameter0: org.apache.dubbo.common.URL;	$z0 = r0.<org.apache.dubbo.registry.integration.DynamicDirectory: boolean shouldSimplified>;	if $z0 != 0 goto $r2 = <org.apache.dubbo.registry.integration.InterfaceCompatibleRegistryProtocol: java.lang.String[] DEFAULT_REGISTER_CONSUMER_KEYS>;	$r7 = newarray (java.lang.String)[4];	$r7[0] = "category";	$r7[1] = "consumers";	$r7[2] = "check";	$r8 = staticinvoke <java.lang.String: java.lang.String valueOf(boolean)>(0);	$r7[3] = $r8;	$r9 = virtualinvoke r1.<org.apache.dubbo.common.URL: org.apache.dubbo.common.URL addParameters(java.lang.String[])>($r7);	r0.<org.apache.dubbo.registry.integration.DynamicDirectory: org.apache.dubbo.common.URL registeredConsumerUrl> = $r9;	goto [?= return];	return
;block_num 3