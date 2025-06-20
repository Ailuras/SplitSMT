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

(declare-sort var3121 0)
(declare-sort var465 0)
(declare-sort var2872 0)
(declare-sort var2828 0)
(declare-sort var2840 0)
(declare-sort var3918 0)
(declare-sort var1273 0)
(declare-sort var3346 0)
(declare-sort var3083 0)
(declare-sort var387 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun var2872-init () var2872)
(declare-fun <init>/-325640736 (var2872) void)
(declare-fun extensionLoader/2049024158 (var3121) var2828)
(declare-fun var3918_getUrl/938756954 (var3918) var2840)
(declare-fun cast-from-var465-to-var3918 (var465) var3918)
(declare-fun getActivateExtension/-62970668 (var2828 var2840 String) var1273)
(declare-fun var3346_isNotEmpty/-572947236 (var3083) Bool)
(declare-fun cast-from-var1273-to-var3083 (var1273) var3083)
(declare-fun String-init () String)
(define-fun <init>/1968657023 () String "")
(define-fun append/672562846 ((s String) (tail String)) String (str.++ s tail))
(declare-fun var387_toList/-27661134 (var1273) String)
(declare-fun cast-from-var2872-to-var1273 (var2872) var1273)
(define-fun toString/-2075883882 ((s String)) String s)
(declare-const null-var3121 var3121)
(declare-const null-var465 var465)
(declare-const var2178 var3121) ; Statement: r1 := @this: org.apache.dubbo.remoting.telnet.support.command.HelpTelnetHandler 
(assert (not (= var2178 null-var3121)))
(declare-const var3720 var465) ; Statement: r2 := @parameter0: org.apache.dubbo.remoting.Channel 
(assert (not (= var3720 null-var465)))
(define-const var684 var2872 var2872-init) ; Statement: $r0 = new java.util.ArrayList 
(assert true)
;(assert (<init>/-325640736 var684)) ; Statement: specialinvoke $r0.<java.util.ArrayList: void <init>()>() 

(declare-const var684!1 var2872)
(define-const var3452 var2828 (extensionLoader/2049024158 var2178)) ; Statement: $r3 = r1.<org.apache.dubbo.remoting.telnet.support.command.HelpTelnetHandler: org.apache.dubbo.common.extension.ExtensionLoader extensionLoader> 
(define-const var3093 var2840 (var3918_getUrl/938756954 (cast-from-var465-to-var3918 var3720))) ; Statement: $r4 = interfaceinvoke r2.<org.apache.dubbo.remoting.Channel: org.apache.dubbo.common.URL getUrl()>() 
(assert true)
(define-const var1489 var1273 (getActivateExtension/-62970668 var3452 var3093 "telnet")) ; Statement: r5 = virtualinvoke $r3.<org.apache.dubbo.common.extension.ExtensionLoader: java.util.List getActivateExtension(org.apache.dubbo.common.URL,java.lang.String)>($r4, "telnet") 
(define-const var1639 Bool (var3346_isNotEmpty/-572947236 (cast-from-var1273-to-var3083 var1489))) ; Statement: $z0 = staticinvoke <org.apache.dubbo.common.utils.CollectionUtils: boolean isNotEmpty(java.util.Collection)>(r5) 
 ; Statement: if $z0 == 0 goto $r6 = new java.lang.StringBuilder 
(assert (= (ite var1639 1 0) 0)) ; Cond: $z0 == 0 
(define-const var2495 String String-init) ; Statement: $r6 = new java.lang.StringBuilder 
(assert true)
;(assert (<init>/1968657023 var2495)) ; Statement: specialinvoke $r6.<java.lang.StringBuilder: void <init>()>() 
(declare-const var2495!1 String)
(assert (= var2495!1 ""))
(assert true)
(define-const var1994 String (append/672562846 var2495!1 "Please input \u0022help [command]\u0022 show detail.\r\n")) ; Statement: $r8 = virtualinvoke $r6.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("Please input \"help [command]\" show detail.\r\n") 
(declare-const var2495!2 String)
(assert (= var2495!2 (str.++ var2495!1 "Please input \u0022help [command]\u0022 show detail.\r\n")))
(define-const var1192 String (var387_toList/-27661134 (cast-from-var2872-to-var1273 var684!1))) ; Statement: $r7 = staticinvoke <org.apache.dubbo.remoting.telnet.support.TelnetUtils: java.lang.String toList(java.util.List)>($r0) 
(assert true)
(define-const var962 String (append/672562846 var1994 var1192)) ; Statement: $r9 = virtualinvoke $r8.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>($r7) 
(declare-const var1994!1 String)
(assert (= var1994!1 (str.++ var1994 var1192)))
(assert true)
(define-const var2487 String (toString/-2075883882 var962)) ; Statement: $r10 = virtualinvoke $r9.<java.lang.StringBuilder: java.lang.String toString()>() 
 ; Statement: return $r10 
(check-sat)
; {var2872-init=([], java.util.ArrayList), <init>/-325640736=([java.util.ArrayList], void), extensionLoader/2049024158=([org.apache.dubbo.remoting.telnet.support.command.HelpTelnetHandler], org.apache.dubbo.common.extension.ExtensionLoader), var3918_getUrl/938756954=([org.apache.dubbo.remoting.Endpoint], org.apache.dubbo.common.URL), cast-from-var465-to-var3918=([org.apache.dubbo.remoting.Channel], org.apache.dubbo.remoting.Endpoint), getActivateExtension/-62970668=([org.apache.dubbo.common.extension.ExtensionLoader, org.apache.dubbo.common.URL, java.lang.String], java.util.List), var3346_isNotEmpty/-572947236=([java.util.Collection], boolean), cast-from-var1273-to-var3083=([java.util.List], java.util.Collection), String-init=([], java.lang.StringBuilder), <init>/1968657023=([java.lang.StringBuilder], void), append/672562846=([java.lang.StringBuilder, java.lang.String], java.lang.StringBuilder), var387_toList/-27661134=([java.util.List], java.lang.String), cast-from-var2872-to-var1273=([java.util.ArrayList], java.util.List), toString/-2075883882=([java.lang.StringBuilder], java.lang.String)}
; {var3121=org.apache.dubbo.remoting.telnet.support.command.HelpTelnetHandler, var2178=r1, var465=org.apache.dubbo.remoting.Channel, var3720=r2, var2872=java.util.ArrayList, var684=$r0, var2828=org.apache.dubbo.common.extension.ExtensionLoader, var3452=$r3, var2840=org.apache.dubbo.common.URL, var3918=org.apache.dubbo.remoting.Endpoint, var3093=$r4, var1273=java.util.List, var1489=r5, var3346=org.apache.dubbo.common.utils.CollectionUtils, var3083=java.util.Collection, var1639=$z0, var2495=$r6, var1994=$r8, var387=org.apache.dubbo.remoting.telnet.support.TelnetUtils, var1192=$r7, var962=$r9, var2487=$r10}
; {org.apache.dubbo.remoting.telnet.support.command.HelpTelnetHandler=var3121, r1=var2178, org.apache.dubbo.remoting.Channel=var465, r2=var3720, java.util.ArrayList=var2872, $r0=var684, org.apache.dubbo.common.extension.ExtensionLoader=var2828, $r3=var3452, org.apache.dubbo.common.URL=var2840, org.apache.dubbo.remoting.Endpoint=var3918, $r4=var3093, java.util.List=var1273, r5=var1489, org.apache.dubbo.common.utils.CollectionUtils=var3346, java.util.Collection=var3083, $z0=var1639, $r6=var2495, $r8=var1994, org.apache.dubbo.remoting.telnet.support.TelnetUtils=var387, $r7=var1192, $r9=var962, $r10=var2487}
;seq <java.lang.StringBuilder: void <init>()>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.String toString()>
;cnt {"<java.lang.StringBuilder: void <init>()>": 1,"<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>": 2,"<java.lang.StringBuilder: java.lang.String toString()>": 1}
;stmts r1 := @this: org.apache.dubbo.remoting.telnet.support.command.HelpTelnetHandler;	r2 := @parameter0: org.apache.dubbo.remoting.Channel;	$r0 = new java.util.ArrayList;	specialinvoke $r0.<java.util.ArrayList: void <init>()>();	$r3 = r1.<org.apache.dubbo.remoting.telnet.support.command.HelpTelnetHandler: org.apache.dubbo.common.extension.ExtensionLoader extensionLoader>;	$r4 = interfaceinvoke r2.<org.apache.dubbo.remoting.Channel: org.apache.dubbo.common.URL getUrl()>();	r5 = virtualinvoke $r3.<org.apache.dubbo.common.extension.ExtensionLoader: java.util.List getActivateExtension(org.apache.dubbo.common.URL,java.lang.String)>($r4, "telnet");	$z0 = staticinvoke <org.apache.dubbo.common.utils.CollectionUtils: boolean isNotEmpty(java.util.Collection)>(r5);	if $z0 == 0 goto $r6 = new java.lang.StringBuilder;	$r6 = new java.lang.StringBuilder;	specialinvoke $r6.<java.lang.StringBuilder: void <init>()>();	$r8 = virtualinvoke $r6.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("Please input \"help [command]\" show detail.\r\n");	$r7 = staticinvoke <org.apache.dubbo.remoting.telnet.support.TelnetUtils: java.lang.String toList(java.util.List)>($r0);	$r9 = virtualinvoke $r8.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>($r7);	$r10 = virtualinvoke $r9.<java.lang.StringBuilder: java.lang.String toString()>();	return $r10
;block_num 2