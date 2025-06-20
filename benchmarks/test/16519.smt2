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

(declare-sort var249 0)
(declare-sort var3135 0)
(declare-sort var228 0)
(declare-sort var3421 0)
(declare-sort var3780 0)
(declare-sort var1095 0)
(declare-sort var2121 0)
(declare-sort var1298 0)
(declare-sort var161 0)
(declare-sort var285 0)
(declare-sort var3353 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-const var285!class ClassObject)
(declare-fun var3780_getUrl/938756954 (var3780) var3421)
(declare-fun cast-from-var3135-to-var3780 (var3135) var3780)
(declare-fun getScopeModel/-1957927771 (var3421) var1095)
(declare-fun var1298_getApplicationModel/75536413 (var1095) var2121)
(declare-fun getExtensionLoader/-514331157 (var3353 ClassObject) var161)
(declare-fun cast-from-var2121-to-var3353 (var2121) var3353)
(define-fun length/-134980193 ((s String)) Int (str.len s))
(declare-fun String-init () String)
(define-fun <init>/1968657023 () String "")
(define-fun append/672562846 ((s String) (tail String)) String (str.++ s tail))
(define-fun toString/-2075883882 ((s String)) String s)
(declare-const null-var249 var249)
(declare-const null-var3135 var3135)
(declare-const null-String String)
(declare-const var684 var249) ; Statement: r45 := @this: org.apache.dubbo.remoting.telnet.support.command.StatusTelnetHandler 
(assert (not (= var684 null-var249)))
(declare-const var676 var3135) ; Statement: r0 := @parameter0: org.apache.dubbo.remoting.Channel 
(assert (not (= var676 null-var3135)))
(declare-const var2343 String) ; Statement: r5 := @parameter1: java.lang.String 
(assert (not (= var2343 null-String)))
(define-const var761 var3421 (var3780_getUrl/938756954 (cast-from-var3135-to-var3780 var676))) ; Statement: $r1 = interfaceinvoke r0.<org.apache.dubbo.remoting.Channel: org.apache.dubbo.common.URL getUrl()>() 
(assert true)
(define-const var3294 var1095 (getScopeModel/-1957927771 var761)) ; Statement: $r2 = virtualinvoke $r1.<org.apache.dubbo.common.URL: org.apache.dubbo.rpc.model.ScopeModel getScopeModel()>() 
(define-const var3597 var2121 (var1298_getApplicationModel/75536413 var3294)) ; Statement: r3 = staticinvoke <org.apache.dubbo.rpc.model.ScopeModelUtil: org.apache.dubbo.rpc.model.ApplicationModel getApplicationModel(org.apache.dubbo.rpc.model.ScopeModel)>($r2) 
(assert true)
(define-const var2550 var161 (getExtensionLoader/-514331157 (cast-from-var2121-to-var3353 var3597) var285!class)) ; Statement: r4 = virtualinvoke r3.<org.apache.dubbo.rpc.model.ApplicationModel: org.apache.dubbo.common.extension.ExtensionLoader getExtensionLoader(java.lang.Class)>(class "Lorg/apache/dubbo/common/status/StatusChecker;") 
(define-const var3771 String "-l") ; Statement: $r6 = "-l" 
(assert true)
(define-const var2609 Bool (= var3771 var2343)) ; Statement: $z0 = virtualinvoke $r6.<java.lang.String: boolean equals(java.lang.Object)>(r5) 
 ; Statement: if $z0 == 0 goto $i0 = virtualinvoke r5.<java.lang.String: int length()>() 
(assert (= (ite var2609 1 0) 0)) ; Cond: $z0 == 0 
(assert true)
(define-const var2382 Int (length/-134980193 var2343)) ; Statement: $i0 = virtualinvoke r5.<java.lang.String: int length()>() 
 ; Statement: if $i0 <= 0 goto $r7 = interfaceinvoke r0.<org.apache.dubbo.remoting.Channel: org.apache.dubbo.common.URL getUrl()>() 
(assert (not (<= var2382 0))) ; Negate: Cond: $i0 <= 0  
(define-const var137 String String-init) ; Statement: $r14 = new java.lang.StringBuilder 
(assert true)
;(assert (<init>/1968657023 var137)) ; Statement: specialinvoke $r14.<java.lang.StringBuilder: void <init>()>() 
(declare-const var137!1 String)
(assert (= var137!1 ""))
(assert true)
(define-const var1860 String (append/672562846 var137!1 "Unsupported parameter ")) ; Statement: $r15 = virtualinvoke $r14.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("Unsupported parameter ") 
(declare-const var137!2 String)
(assert (= var137!2 (str.++ var137!1 "Unsupported parameter ")))
(assert true)
(define-const var391 String (append/672562846 var1860 var2343)) ; Statement: $r16 = virtualinvoke $r15.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(r5) 
(declare-const var1860!1 String)
(assert (= var1860!1 (str.++ var1860 var2343)))
(assert true)
(define-const var3414 String (append/672562846 var391 " for status.")) ; Statement: $r17 = virtualinvoke $r16.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(" for status.") 
(declare-const var391!1 String)
(assert (= var391!1 (str.++ var391 " for status.")))
(assert true)
(define-const var3884 String (toString/-2075883882 var3414)) ; Statement: $r18 = virtualinvoke $r17.<java.lang.StringBuilder: java.lang.String toString()>() 
 ; Statement: return $r18 
(check-sat)
; {var3780_getUrl/938756954=([org.apache.dubbo.remoting.Endpoint], org.apache.dubbo.common.URL), cast-from-var3135-to-var3780=([org.apache.dubbo.remoting.Channel], org.apache.dubbo.remoting.Endpoint), getScopeModel/-1957927771=([org.apache.dubbo.common.URL], org.apache.dubbo.rpc.model.ScopeModel), var1298_getApplicationModel/75536413=([org.apache.dubbo.rpc.model.ScopeModel], org.apache.dubbo.rpc.model.ApplicationModel), getExtensionLoader/-514331157=([org.apache.dubbo.common.extension.ExtensionAccessor, java.lang.Class], org.apache.dubbo.common.extension.ExtensionLoader), cast-from-var2121-to-var3353=([org.apache.dubbo.rpc.model.ApplicationModel], org.apache.dubbo.common.extension.ExtensionAccessor), length/-134980193=([java.lang.String], int), String-init=([], java.lang.StringBuilder), <init>/1968657023=([java.lang.StringBuilder], void), append/672562846=([java.lang.StringBuilder, java.lang.String], java.lang.StringBuilder), toString/-2075883882=([java.lang.StringBuilder], java.lang.String)}
; {var249=org.apache.dubbo.remoting.telnet.support.command.StatusTelnetHandler, var684=r45, var3135=org.apache.dubbo.remoting.Channel, var676=r0, var2343=r5, var228=null_type, var3421=org.apache.dubbo.common.URL, var3780=org.apache.dubbo.remoting.Endpoint, var761=$r1, var1095=org.apache.dubbo.rpc.model.ScopeModel, var3294=$r2, var2121=org.apache.dubbo.rpc.model.ApplicationModel, var1298=org.apache.dubbo.rpc.model.ScopeModelUtil, var3597=r3, var161=org.apache.dubbo.common.extension.ExtensionLoader, var285=org.apache.dubbo.common.status.StatusChecker, var3353=org.apache.dubbo.common.extension.ExtensionAccessor, var2550=r4, var3771=$r6, var2609=$z0, var2382=$i0, var137=$r14, var1860=$r15, var391=$r16, var3414=$r17, var3884=$r18}
; {org.apache.dubbo.remoting.telnet.support.command.StatusTelnetHandler=var249, r45=var684, org.apache.dubbo.remoting.Channel=var3135, r0=var676, r5=var2343, null_type=var228, org.apache.dubbo.common.URL=var3421, org.apache.dubbo.remoting.Endpoint=var3780, $r1=var761, org.apache.dubbo.rpc.model.ScopeModel=var1095, $r2=var3294, org.apache.dubbo.rpc.model.ApplicationModel=var2121, org.apache.dubbo.rpc.model.ScopeModelUtil=var1298, r3=var3597, org.apache.dubbo.common.extension.ExtensionLoader=var161, org.apache.dubbo.common.status.StatusChecker=var285, org.apache.dubbo.common.extension.ExtensionAccessor=var3353, r4=var2550, $r6=var3771, $z0=var2609, $i0=var2382, $r14=var137, $r15=var1860, $r16=var391, $r17=var3414, $r18=var3884}
;seq <java.lang.String: boolean equals(java.lang.Object)>;	<java.lang.String: int length()>;	<java.lang.StringBuilder: void <init>()>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.String toString()>
;cnt {"<java.lang.String: boolean equals(java.lang.Object)>": 1,"<java.lang.String: int length()>": 1,"<java.lang.StringBuilder: void <init>()>": 1,"<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>": 3,"<java.lang.StringBuilder: java.lang.String toString()>": 1}
;stmts r45 := @this: org.apache.dubbo.remoting.telnet.support.command.StatusTelnetHandler;	r0 := @parameter0: org.apache.dubbo.remoting.Channel;	r5 := @parameter1: java.lang.String;	$r1 = interfaceinvoke r0.<org.apache.dubbo.remoting.Channel: org.apache.dubbo.common.URL getUrl()>();	$r2 = virtualinvoke $r1.<org.apache.dubbo.common.URL: org.apache.dubbo.rpc.model.ScopeModel getScopeModel()>();	r3 = staticinvoke <org.apache.dubbo.rpc.model.ScopeModelUtil: org.apache.dubbo.rpc.model.ApplicationModel getApplicationModel(org.apache.dubbo.rpc.model.ScopeModel)>($r2);	r4 = virtualinvoke r3.<org.apache.dubbo.rpc.model.ApplicationModel: org.apache.dubbo.common.extension.ExtensionLoader getExtensionLoader(java.lang.Class)>(class "Lorg/apache/dubbo/common/status/StatusChecker;");	$r6 = "-l";	$z0 = virtualinvoke $r6.<java.lang.String: boolean equals(java.lang.Object)>(r5);	if $z0 == 0 goto $i0 = virtualinvoke r5.<java.lang.String: int length()>();	$i0 = virtualinvoke r5.<java.lang.String: int length()>();	if $i0 <= 0 goto $r7 = interfaceinvoke r0.<org.apache.dubbo.remoting.Channel: org.apache.dubbo.common.URL getUrl()>();	$r14 = new java.lang.StringBuilder;	specialinvoke $r14.<java.lang.StringBuilder: void <init>()>();	$r15 = virtualinvoke $r14.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("Unsupported parameter ");	$r16 = virtualinvoke $r15.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(r5);	$r17 = virtualinvoke $r16.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(" for status.");	$r18 = virtualinvoke $r17.<java.lang.StringBuilder: java.lang.String toString()>();	return $r18
;block_num 3