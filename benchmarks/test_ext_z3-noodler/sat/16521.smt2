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

(declare-sort var3331 0)
(declare-sort var1228 0)
(declare-sort var836 0)
(declare-sort var138 0)
(declare-sort var368 0)
(declare-sort var3360 0)
(declare-sort var2152 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-const var2152!class ClassObject)
(declare-fun extensionLoader/2049024158 (var3331) var836)
(declare-fun hasExtension/-1450549355 (var836 String) Bool)
(declare-fun getExtension/-1809037860 (var836 String) var138)
(declare-fun cast-from-var138-to-var368 (var138) var368)
(declare-fun var138_getClass/1258963082 (var138) ClassObject)
(declare-fun cast-from-var368-to-var138 (var368) var138)
(declare-fun getAnnotation/-664766848 (ClassObject ClassObject) var3360)
(declare-fun cast-from-var3360-to-var2152 (var3360) var2152)
(declare-fun String-init () String)
(define-fun <init>/1968657023 () String "")
(define-fun append/672562846 ((s String) (tail String)) String (str.++ s tail))
(declare-fun var2152_parameter/370439902 (var2152) String)
(define-fun replace/2138489945 ((s String) (old String) (new String)) String (str.replace_all s old new))
(define-fun cast-from-String-to-String ((arg String)) String arg)
(define-fun toString/-2075883882 ((s String)) String s)
(declare-fun var2152_summary/1988038721 (var2152) String)
(declare-fun var2152_detail/-1621729822 (var2152) String)
(declare-const null-var3331 var3331)
(declare-const null-String String)
(declare-const var1303 var3331) ; Statement: r0 := @this: org.apache.dubbo.remoting.telnet.support.command.HelpTelnetHandler 
(assert (not (= var1303 null-var3331)))
(declare-const var824 String) ; Statement: r1 := @parameter0: java.lang.String 
(assert (not (= var824 null-String)))
(define-const var3840 var836 (extensionLoader/2049024158 var1303)) ; Statement: $r2 = r0.<org.apache.dubbo.remoting.telnet.support.command.HelpTelnetHandler: org.apache.dubbo.common.extension.ExtensionLoader extensionLoader> 
(assert true)
(define-const var3472 Bool (hasExtension/-1450549355 var3840 var824)) ; Statement: $z0 = virtualinvoke $r2.<org.apache.dubbo.common.extension.ExtensionLoader: boolean hasExtension(java.lang.String)>(r1) 
 ; Statement: if $z0 != 0 goto $r3 = r0.<org.apache.dubbo.remoting.telnet.support.command.HelpTelnetHandler: org.apache.dubbo.common.extension.ExtensionLoader extensionLoader> 
(assert (not (= (ite var3472 1 0) 0))) ; Cond: $z0 != 0 
(define-const var2669 var836 (extensionLoader/2049024158 var1303)) ; Statement: $r3 = r0.<org.apache.dubbo.remoting.telnet.support.command.HelpTelnetHandler: org.apache.dubbo.common.extension.ExtensionLoader extensionLoader> 
(assert true)
(define-const var279 var138 (getExtension/-1809037860 var2669 var824)) ; Statement: $r4 = virtualinvoke $r3.<org.apache.dubbo.common.extension.ExtensionLoader: java.lang.Object getExtension(java.lang.String)>(r1) 
(define-const var3221 var368 (cast-from-var138-to-var368 var279)) ; Statement: r5 = (org.apache.dubbo.remoting.telnet.TelnetHandler) $r4 
(define-const var3205 ClassObject (var138_getClass/1258963082 (cast-from-var368-to-var138 var3221))) ; Statement: $r6 = interfaceinvoke r5.<org.apache.dubbo.remoting.telnet.TelnetHandler: java.lang.Class getClass()>() 
(assert true)
(define-const var2693 var3360 (getAnnotation/-664766848 var3205 var2152!class)) ; Statement: $r7 = virtualinvoke $r6.<java.lang.Class: java.lang.'annotation'.Annotation getAnnotation(java.lang.Class)>(class "Lorg/apache/dubbo/remoting/telnet/support/Help;") 
(define-const var1733 var2152 (cast-from-var3360-to-var2152 var2693)) ; Statement: r8 = (org.apache.dubbo.remoting.telnet.support.Help) $r7 
(define-const var2815 String String-init) ; Statement: $r9 = new java.lang.StringBuilder 
(assert true)
;(assert (<init>/1968657023 var2815)) ; Statement: specialinvoke $r9.<java.lang.StringBuilder: void <init>()>() 
(declare-const var2815!1 String)
(assert (= var2815!1 ""))
(assert true)
;(assert (append/672562846 var2815!1 "Command:\r\n    ")) ; Statement: virtualinvoke $r9.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("Command:\r\n    ") 
(declare-const var2815!2 String)
(assert (= var2815!2 (str.++ var2815!1 "Command:\r\n    ")))
(define-const var1999 String String-init) ; Statement: $r10 = new java.lang.StringBuilder 
(assert true)
;(assert (<init>/1968657023 var1999)) ; Statement: specialinvoke $r10.<java.lang.StringBuilder: void <init>()>() 
(declare-const var1999!1 String)
(assert (= var1999!1 ""))
(assert true)
(define-const var1240 String (append/672562846 var1999!1 var824)) ; Statement: $r11 = virtualinvoke $r10.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(r1) 
(declare-const var1999!2 String)
(assert (= var1999!2 (str.++ var1999!1 var824)))
(assert true)
(define-const var1609 String (append/672562846 var1240 " ")) ; Statement: $r15 = virtualinvoke $r11.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(" ") 
(declare-const var1240!1 String)
(assert (= var1240!1 (str.++ var1240 " ")))
(define-const var3827 String (var2152_parameter/370439902 var1733)) ; Statement: $r12 = interfaceinvoke r8.<org.apache.dubbo.remoting.telnet.support.Help: java.lang.String parameter()>() 
(assert true)
(define-const var3932 String (replace/2138489945 var3827 (cast-from-String-to-String "\r\n") (cast-from-String-to-String " "))) ; Statement: $r13 = virtualinvoke $r12.<java.lang.String: java.lang.String replace(java.lang.CharSequence,java.lang.CharSequence)>("\r\n", " ") 
(assert true)
(define-const var3743 String (replace/2138489945 var3932 (cast-from-String-to-String "\n") (cast-from-String-to-String " "))) ; Statement: $r14 = virtualinvoke $r13.<java.lang.String: java.lang.String replace(java.lang.CharSequence,java.lang.CharSequence)>("\n", " ") 
(assert true)
(define-const var841 String (append/672562846 var1609 var3743)) ; Statement: $r16 = virtualinvoke $r15.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>($r14) 
(declare-const var1609!1 String)
(assert (= var1609!1 (str.++ var1609 var3743)))
(assert true)
(define-const var666 String (toString/-2075883882 var841)) ; Statement: $r17 = virtualinvoke $r16.<java.lang.StringBuilder: java.lang.String toString()>() 
(assert true)
;(assert (append/672562846 var2815!2 var666)) ; Statement: virtualinvoke $r9.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>($r17) 
(declare-const var2815!3 String)
(assert (= var2815!3 (str.++ var2815!2 var666)))
(assert true)
;(assert (append/672562846 var2815!3 "\r\nSummary:\r\n    ")) ; Statement: virtualinvoke $r9.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("\r\nSummary:\r\n    ") 
(declare-const var2815!4 String)
(assert (= var2815!4 (str.++ var2815!3 "\r\nSummary:\r\n    ")))
(define-const var3100 String (var2152_summary/1988038721 var1733)) ; Statement: $r18 = interfaceinvoke r8.<org.apache.dubbo.remoting.telnet.support.Help: java.lang.String summary()>() 
(assert true)
(define-const var721 String (replace/2138489945 var3100 (cast-from-String-to-String "\r\n") (cast-from-String-to-String " "))) ; Statement: $r19 = virtualinvoke $r18.<java.lang.String: java.lang.String replace(java.lang.CharSequence,java.lang.CharSequence)>("\r\n", " ") 
(assert true)
(define-const var3535 String (replace/2138489945 var721 (cast-from-String-to-String "\n") (cast-from-String-to-String " "))) ; Statement: $r20 = virtualinvoke $r19.<java.lang.String: java.lang.String replace(java.lang.CharSequence,java.lang.CharSequence)>("\n", " ") 
(assert true)
;(assert (append/672562846 var2815!4 var3535)) ; Statement: virtualinvoke $r9.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>($r20) 
(declare-const var2815!5 String)
(assert (= var2815!5 (str.++ var2815!4 var3535)))
(assert true)
;(assert (append/672562846 var2815!5 "\r\nDetail:\r\n    ")) ; Statement: virtualinvoke $r9.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("\r\nDetail:\r\n    ") 
(declare-const var2815!6 String)
(assert (= var2815!6 (str.++ var2815!5 "\r\nDetail:\r\n    ")))
(define-const var2996 String (var2152_detail/-1621729822 var1733)) ; Statement: $r21 = interfaceinvoke r8.<org.apache.dubbo.remoting.telnet.support.Help: java.lang.String detail()>() 
(assert true)
(define-const var3200 String (replace/2138489945 var2996 (cast-from-String-to-String "\r\n") (cast-from-String-to-String "    \r\n"))) ; Statement: $r22 = virtualinvoke $r21.<java.lang.String: java.lang.String replace(java.lang.CharSequence,java.lang.CharSequence)>("\r\n", "    \r\n") 
(assert true)
(define-const var818 String (replace/2138489945 var3200 (cast-from-String-to-String "\n") (cast-from-String-to-String "    \n"))) ; Statement: $r23 = virtualinvoke $r22.<java.lang.String: java.lang.String replace(java.lang.CharSequence,java.lang.CharSequence)>("\n", "    \n") 
(assert true)
;(assert (append/672562846 var2815!6 var818)) ; Statement: virtualinvoke $r9.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>($r23) 
(declare-const var2815!7 String)
(assert (= var2815!7 (str.++ var2815!6 var818)))
(assert true)
(define-const var2761 String (toString/-2075883882 var2815!7)) ; Statement: $r24 = virtualinvoke $r9.<java.lang.StringBuilder: java.lang.String toString()>() 
 ; Statement: return $r24 
(check-sat)
; {extensionLoader/2049024158=([org.apache.dubbo.remoting.telnet.support.command.HelpTelnetHandler], org.apache.dubbo.common.extension.ExtensionLoader), hasExtension/-1450549355=([org.apache.dubbo.common.extension.ExtensionLoader, java.lang.String], boolean), getExtension/-1809037860=([org.apache.dubbo.common.extension.ExtensionLoader, java.lang.String], java.lang.Object), cast-from-var138-to-var368=([java.lang.Object], org.apache.dubbo.remoting.telnet.TelnetHandler), var138_getClass/1258963082=([java.lang.Object], java.lang.Class), cast-from-var368-to-var138=([org.apache.dubbo.remoting.telnet.TelnetHandler], java.lang.Object), getAnnotation/-664766848=([java.lang.Class, java.lang.Class], java.lang.annotation.Annotation), cast-from-var3360-to-var2152=([java.lang.annotation.Annotation], org.apache.dubbo.remoting.telnet.support.Help), String-init=([], java.lang.StringBuilder), <init>/1968657023=([java.lang.StringBuilder], void), append/672562846=([java.lang.StringBuilder, java.lang.String], java.lang.StringBuilder), var2152_parameter/370439902=([org.apache.dubbo.remoting.telnet.support.Help], java.lang.String), replace/2138489945=([java.lang.String, java.lang.CharSequence, java.lang.CharSequence], java.lang.String), cast-from-String-to-String=([java.lang.String], java.lang.CharSequence), toString/-2075883882=([java.lang.StringBuilder], java.lang.String), var2152_summary/1988038721=([org.apache.dubbo.remoting.telnet.support.Help], java.lang.String), var2152_detail/-1621729822=([org.apache.dubbo.remoting.telnet.support.Help], java.lang.String)}
; {var3331=org.apache.dubbo.remoting.telnet.support.command.HelpTelnetHandler, var1303=r0, var824=r1, var1228=null_type, var836=org.apache.dubbo.common.extension.ExtensionLoader, var3840=$r2, var3472=$z0, var2669=$r3, var138=java.lang.Object, var279=$r4, var368=org.apache.dubbo.remoting.telnet.TelnetHandler, var3221=r5, var3205=$r6, var3360=java.lang.annotation.Annotation, var2152=org.apache.dubbo.remoting.telnet.support.Help, var2693=$r7, var1733=r8, var2815=$r9, var1999=$r10, var1240=$r11, var1609=$r15, var3827=$r12, var3932=$r13, var3743=$r14, var841=$r16, var666=$r17, var3100=$r18, var721=$r19, var3535=$r20, var2996=$r21, var3200=$r22, var818=$r23, var2761=$r24}
; {org.apache.dubbo.remoting.telnet.support.command.HelpTelnetHandler=var3331, r0=var1303, r1=var824, null_type=var1228, org.apache.dubbo.common.extension.ExtensionLoader=var836, $r2=var3840, $z0=var3472, $r3=var2669, java.lang.Object=var138, $r4=var279, org.apache.dubbo.remoting.telnet.TelnetHandler=var368, r5=var3221, $r6=var3205, java.lang.annotation.Annotation=var3360, org.apache.dubbo.remoting.telnet.support.Help=var2152, $r7=var2693, r8=var1733, $r9=var2815, $r10=var1999, $r11=var1240, $r15=var1609, $r12=var3827, $r13=var3932, $r14=var3743, $r16=var841, $r17=var666, $r18=var3100, $r19=var721, $r20=var3535, $r21=var2996, $r22=var3200, $r23=var818, $r24=var2761}
;seq <java.lang.StringBuilder: void <init>()>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: void <init>()>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.String: java.lang.String replace(java.lang.CharSequence,java.lang.CharSequence)>;	<java.lang.String: java.lang.String replace(java.lang.CharSequence,java.lang.CharSequence)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.String toString()>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.String: java.lang.String replace(java.lang.CharSequence,java.lang.CharSequence)>;	<java.lang.String: java.lang.String replace(java.lang.CharSequence,java.lang.CharSequence)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.String: java.lang.String replace(java.lang.CharSequence,java.lang.CharSequence)>;	<java.lang.String: java.lang.String replace(java.lang.CharSequence,java.lang.CharSequence)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.String toString()>
;cnt {"<java.lang.StringBuilder: void <init>()>": 2,"<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>": 9,"<java.lang.String: java.lang.String replace(java.lang.CharSequence,java.lang.CharSequence)>": 6,"<java.lang.StringBuilder: java.lang.String toString()>": 2}
;stmts r0 := @this: org.apache.dubbo.remoting.telnet.support.command.HelpTelnetHandler;	r1 := @parameter0: java.lang.String;	$r2 = r0.<org.apache.dubbo.remoting.telnet.support.command.HelpTelnetHandler: org.apache.dubbo.common.extension.ExtensionLoader extensionLoader>;	$z0 = virtualinvoke $r2.<org.apache.dubbo.common.extension.ExtensionLoader: boolean hasExtension(java.lang.String)>(r1);	if $z0 != 0 goto $r3 = r0.<org.apache.dubbo.remoting.telnet.support.command.HelpTelnetHandler: org.apache.dubbo.common.extension.ExtensionLoader extensionLoader>;	$r3 = r0.<org.apache.dubbo.remoting.telnet.support.command.HelpTelnetHandler: org.apache.dubbo.common.extension.ExtensionLoader extensionLoader>;	$r4 = virtualinvoke $r3.<org.apache.dubbo.common.extension.ExtensionLoader: java.lang.Object getExtension(java.lang.String)>(r1);	r5 = (org.apache.dubbo.remoting.telnet.TelnetHandler) $r4;	$r6 = interfaceinvoke r5.<org.apache.dubbo.remoting.telnet.TelnetHandler: java.lang.Class getClass()>();	$r7 = virtualinvoke $r6.<java.lang.Class: java.lang.'annotation'.Annotation getAnnotation(java.lang.Class)>(class "Lorg/apache/dubbo/remoting/telnet/support/Help;");	r8 = (org.apache.dubbo.remoting.telnet.support.Help) $r7;	$r9 = new java.lang.StringBuilder;	specialinvoke $r9.<java.lang.StringBuilder: void <init>()>();	virtualinvoke $r9.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("Command:\r\n    ");	$r10 = new java.lang.StringBuilder;	specialinvoke $r10.<java.lang.StringBuilder: void <init>()>();	$r11 = virtualinvoke $r10.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(r1);	$r15 = virtualinvoke $r11.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(" ");	$r12 = interfaceinvoke r8.<org.apache.dubbo.remoting.telnet.support.Help: java.lang.String parameter()>();	$r13 = virtualinvoke $r12.<java.lang.String: java.lang.String replace(java.lang.CharSequence,java.lang.CharSequence)>("\r\n", " ");	$r14 = virtualinvoke $r13.<java.lang.String: java.lang.String replace(java.lang.CharSequence,java.lang.CharSequence)>("\n", " ");	$r16 = virtualinvoke $r15.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>($r14);	$r17 = virtualinvoke $r16.<java.lang.StringBuilder: java.lang.String toString()>();	virtualinvoke $r9.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>($r17);	virtualinvoke $r9.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("\r\nSummary:\r\n    ");	$r18 = interfaceinvoke r8.<org.apache.dubbo.remoting.telnet.support.Help: java.lang.String summary()>();	$r19 = virtualinvoke $r18.<java.lang.String: java.lang.String replace(java.lang.CharSequence,java.lang.CharSequence)>("\r\n", " ");	$r20 = virtualinvoke $r19.<java.lang.String: java.lang.String replace(java.lang.CharSequence,java.lang.CharSequence)>("\n", " ");	virtualinvoke $r9.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>($r20);	virtualinvoke $r9.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("\r\nDetail:\r\n    ");	$r21 = interfaceinvoke r8.<org.apache.dubbo.remoting.telnet.support.Help: java.lang.String detail()>();	$r22 = virtualinvoke $r21.<java.lang.String: java.lang.String replace(java.lang.CharSequence,java.lang.CharSequence)>("\r\n", "    \r\n");	$r23 = virtualinvoke $r22.<java.lang.String: java.lang.String replace(java.lang.CharSequence,java.lang.CharSequence)>("\n", "    \n");	virtualinvoke $r9.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>($r23);	$r24 = virtualinvoke $r9.<java.lang.StringBuilder: java.lang.String toString()>();	return $r24
;block_num 2