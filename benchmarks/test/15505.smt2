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

(declare-sort var1927 0)
(declare-sort var556 0)
(declare-sort var252 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun shouldSimplified/2129308851 (var1927) Bool)
(declare-fun var556_valueOf/40125469 (var556 (Array Int String) (Array Int String)) var556)
(declare-fun arr-String-init () (Array Int String))
(declare-fun String_valueOf/-1973653463 (Bool) String)
(declare-fun addParameters/1592766819 (var556 (Array Int String)) var556)
(declare-fun registeredConsumerUrl/2129308851 (var1927) var556)
(declare-const null-var1927 var1927)
(declare-const null-var556 var556)
(declare-const var252-DEFAULT_REGISTER_CONSUMER_KEYS (Array Int String))
(declare-const null-__Array__Int__String__ (Array Int String))
(declare-const var3789 var1927) ; Statement: r0 := @this: org.apache.dubbo.registry.integration.DynamicDirectory 
(assert (not (= var3789 null-var1927)))
(declare-const var428 var556) ; Statement: r1 := @parameter0: org.apache.dubbo.common.URL 
(assert (not (= var428 null-var556)))
(define-const var1592 Bool (shouldSimplified/2129308851 var3789)) ; Statement: $z0 = r0.<org.apache.dubbo.registry.integration.DynamicDirectory: boolean shouldSimplified> 
 ; Statement: if $z0 != 0 goto $r2 = <org.apache.dubbo.registry.integration.InterfaceCompatibleRegistryProtocol: java.lang.String[] DEFAULT_REGISTER_CONSUMER_KEYS> 
(assert (not (= (ite var1592 1 0) 0))) ; Cond: $z0 != 0 
(define-const var635 (Array Int String) var252-DEFAULT_REGISTER_CONSUMER_KEYS) ; Statement: $r2 = <org.apache.dubbo.registry.integration.InterfaceCompatibleRegistryProtocol: java.lang.String[] DEFAULT_REGISTER_CONSUMER_KEYS> 
(define-const var3590 var556 (var556_valueOf/40125469 var428 var635 null-__Array__Int__String__)) ; Statement: $r5 = staticinvoke <org.apache.dubbo.common.URL: org.apache.dubbo.common.URL valueOf(org.apache.dubbo.common.URL,java.lang.String[],java.lang.String[])>(r1, $r2, null) 
(define-const var1368 (Array Int String) arr-String-init) ; Statement: $r3 = newarray (java.lang.String)[4] 
(declare-const var1368!1 (Array Int String))
(assert (not (= var1368!1 null-__Array__Int__String__)))
(assert (= (select var1368!1 0) "category")) ; Statement: $r3[0] = "category" 
(declare-const var1368!2 (Array Int String))
(assert (not (= var1368!2 null-__Array__Int__String__)))
(assert (= (select var1368!2 1) "consumers")) ; Statement: $r3[1] = "consumers" 
(declare-const var1368!3 (Array Int String))
(assert (not (= var1368!3 null-__Array__Int__String__)))
(assert (= (select var1368!3 2) "check")) ; Statement: $r3[2] = "check" 
(define-const var3380 String (String_valueOf/-1973653463 (ite (= 1 0) true false))) ; Statement: $r4 = staticinvoke <java.lang.String: java.lang.String valueOf(boolean)>(0) 
(declare-const var1368!4 (Array Int String))
(assert (not (= var1368!4 null-__Array__Int__String__)))
(assert (= (select var1368!4 3) var3380)) ; Statement: $r3[3] = $r4 
(assert true)
(define-const var2555 var556 (addParameters/1592766819 var3590 var1368!4)) ; Statement: $r6 = virtualinvoke $r5.<org.apache.dubbo.common.URL: org.apache.dubbo.common.URL addParameters(java.lang.String[])>($r3) 
(declare-const var3789!1 var1927)
(assert (not (= var3789!1 null-var1927)))
(assert (= (registeredConsumerUrl/2129308851 var3789!1) var2555)) ; Statement: r0.<org.apache.dubbo.registry.integration.DynamicDirectory: org.apache.dubbo.common.URL registeredConsumerUrl> = $r6 
(assert true) ; Non Conditional
 ; Statement: return 
(check-sat)
; {shouldSimplified/2129308851=([org.apache.dubbo.registry.integration.DynamicDirectory], boolean), var556_valueOf/40125469=([org.apache.dubbo.common.URL, java.lang.String[], java.lang.String[]], org.apache.dubbo.common.URL), arr-String-init=([], java.lang.String[]), String_valueOf/-1973653463=([boolean], java.lang.String), addParameters/1592766819=([org.apache.dubbo.common.URL, java.lang.String[]], org.apache.dubbo.common.URL), registeredConsumerUrl/2129308851=([org.apache.dubbo.registry.integration.DynamicDirectory], org.apache.dubbo.common.URL)}
; {var1927=org.apache.dubbo.registry.integration.DynamicDirectory, var3789=r0, var556=org.apache.dubbo.common.URL, var428=r1, var1592=$z0, var252=org.apache.dubbo.registry.integration.InterfaceCompatibleRegistryProtocol, var635=$r2, var3590=$r5, var1368=$r3, var3380=$r4, var2555=$r6}
; {org.apache.dubbo.registry.integration.DynamicDirectory=var1927, r0=var3789, org.apache.dubbo.common.URL=var556, r1=var428, $z0=var1592, org.apache.dubbo.registry.integration.InterfaceCompatibleRegistryProtocol=var252, $r2=var635, $r5=var3590, $r3=var1368, $r4=var3380, $r6=var2555}
;seq <java.lang.String: java.lang.String valueOf(boolean)>
;cnt {"<java.lang.String: java.lang.String valueOf(boolean)>": 1}
;stmts r0 := @this: org.apache.dubbo.registry.integration.DynamicDirectory;	r1 := @parameter0: org.apache.dubbo.common.URL;	$z0 = r0.<org.apache.dubbo.registry.integration.DynamicDirectory: boolean shouldSimplified>;	if $z0 != 0 goto $r2 = <org.apache.dubbo.registry.integration.InterfaceCompatibleRegistryProtocol: java.lang.String[] DEFAULT_REGISTER_CONSUMER_KEYS>;	$r2 = <org.apache.dubbo.registry.integration.InterfaceCompatibleRegistryProtocol: java.lang.String[] DEFAULT_REGISTER_CONSUMER_KEYS>;	$r5 = staticinvoke <org.apache.dubbo.common.URL: org.apache.dubbo.common.URL valueOf(org.apache.dubbo.common.URL,java.lang.String[],java.lang.String[])>(r1, $r2, null);	$r3 = newarray (java.lang.String)[4];	$r3[0] = "category";	$r3[1] = "consumers";	$r3[2] = "check";	$r4 = staticinvoke <java.lang.String: java.lang.String valueOf(boolean)>(0);	$r3[3] = $r4;	$r6 = virtualinvoke $r5.<org.apache.dubbo.common.URL: org.apache.dubbo.common.URL addParameters(java.lang.String[])>($r3);	r0.<org.apache.dubbo.registry.integration.DynamicDirectory: org.apache.dubbo.common.URL registeredConsumerUrl> = $r6;	return
;block_num 3