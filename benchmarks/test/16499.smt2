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

(declare-sort var1626 0)
(declare-sort var867 0)
(declare-sort var1894 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun extensionLoader/2049024158 (var1626) var1894)
(declare-fun hasExtension/-1450549355 (var1894 String) Bool)
(declare-fun String-init () String)
(define-fun <init>/1968657023 () String "")
(define-fun append/672562846 ((s String) (tail String)) String (str.++ s tail))
(define-fun toString/-2075883882 ((s String)) String s)
(declare-const null-var1626 var1626)
(declare-const null-String String)
(declare-const var44 var1626) ; Statement: r0 := @this: org.apache.dubbo.remoting.telnet.support.command.HelpTelnetHandler 
(assert (not (= var44 null-var1626)))
(declare-const var1291 String) ; Statement: r1 := @parameter0: java.lang.String 
(assert (not (= var1291 null-String)))
(define-const var3005 var1894 (extensionLoader/2049024158 var44)) ; Statement: $r2 = r0.<org.apache.dubbo.remoting.telnet.support.command.HelpTelnetHandler: org.apache.dubbo.common.extension.ExtensionLoader extensionLoader> 
(assert true)
(define-const var343 Bool (hasExtension/-1450549355 var3005 var1291)) ; Statement: $z0 = virtualinvoke $r2.<org.apache.dubbo.common.extension.ExtensionLoader: boolean hasExtension(java.lang.String)>(r1) 
 ; Statement: if $z0 != 0 goto $r3 = r0.<org.apache.dubbo.remoting.telnet.support.command.HelpTelnetHandler: org.apache.dubbo.common.extension.ExtensionLoader extensionLoader> 
(assert (not (not (= (ite var343 1 0) 0)))) ; Negate: Cond: $z0 != 0  
(define-const var3472 String String-init) ; Statement: $r25 = new java.lang.StringBuilder 
(assert true)
;(assert (<init>/1968657023 var3472)) ; Statement: specialinvoke $r25.<java.lang.StringBuilder: void <init>()>() 
(declare-const var3472!1 String)
(assert (= var3472!1 ""))
(assert true)
(define-const var927 String (append/672562846 var3472!1 "No such command ")) ; Statement: $r26 = virtualinvoke $r25.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("No such command ") 
(declare-const var3472!2 String)
(assert (= var3472!2 (str.++ var3472!1 "No such command ")))
(assert true)
(define-const var2694 String (append/672562846 var927 var1291)) ; Statement: $r27 = virtualinvoke $r26.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(r1) 
(declare-const var927!1 String)
(assert (= var927!1 (str.++ var927 var1291)))
(assert true)
(define-const var1614 String (toString/-2075883882 var2694)) ; Statement: $r28 = virtualinvoke $r27.<java.lang.StringBuilder: java.lang.String toString()>() 
 ; Statement: return $r28 
(check-sat)
; {extensionLoader/2049024158=([org.apache.dubbo.remoting.telnet.support.command.HelpTelnetHandler], org.apache.dubbo.common.extension.ExtensionLoader), hasExtension/-1450549355=([org.apache.dubbo.common.extension.ExtensionLoader, java.lang.String], boolean), String-init=([], java.lang.StringBuilder), <init>/1968657023=([java.lang.StringBuilder], void), append/672562846=([java.lang.StringBuilder, java.lang.String], java.lang.StringBuilder), toString/-2075883882=([java.lang.StringBuilder], java.lang.String)}
; {var1626=org.apache.dubbo.remoting.telnet.support.command.HelpTelnetHandler, var44=r0, var1291=r1, var867=null_type, var1894=org.apache.dubbo.common.extension.ExtensionLoader, var3005=$r2, var343=$z0, var3472=$r25, var927=$r26, var2694=$r27, var1614=$r28}
; {org.apache.dubbo.remoting.telnet.support.command.HelpTelnetHandler=var1626, r0=var44, r1=var1291, null_type=var867, org.apache.dubbo.common.extension.ExtensionLoader=var1894, $r2=var3005, $z0=var343, $r25=var3472, $r26=var927, $r27=var2694, $r28=var1614}
;seq <java.lang.StringBuilder: void <init>()>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.String toString()>
;cnt {"<java.lang.StringBuilder: void <init>()>": 1,"<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>": 2,"<java.lang.StringBuilder: java.lang.String toString()>": 1}
;stmts r0 := @this: org.apache.dubbo.remoting.telnet.support.command.HelpTelnetHandler;	r1 := @parameter0: java.lang.String;	$r2 = r0.<org.apache.dubbo.remoting.telnet.support.command.HelpTelnetHandler: org.apache.dubbo.common.extension.ExtensionLoader extensionLoader>;	$z0 = virtualinvoke $r2.<org.apache.dubbo.common.extension.ExtensionLoader: boolean hasExtension(java.lang.String)>(r1);	if $z0 != 0 goto $r3 = r0.<org.apache.dubbo.remoting.telnet.support.command.HelpTelnetHandler: org.apache.dubbo.common.extension.ExtensionLoader extensionLoader>;	$r25 = new java.lang.StringBuilder;	specialinvoke $r25.<java.lang.StringBuilder: void <init>()>();	$r26 = virtualinvoke $r25.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("No such command ");	$r27 = virtualinvoke $r26.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(r1);	$r28 = virtualinvoke $r27.<java.lang.StringBuilder: java.lang.String toString()>();	return $r28
;block_num 2