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

(declare-sort var3166 0)
(declare-sort var1468 0)
(declare-sort var1302 0)
(declare-sort var35 0)
(declare-sort var2144 0)
(declare-sort var3773 0)
(declare-sort var283 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun var35_getAvailableAdapter/933843496 () var1302)
(declare-fun arr-String-init () (Array Int String))
(declare-fun var1302_toArray/-775711681 (var1302 (Array Int var2144)) (Array Int var2144))
(declare-fun cast-from-__Array__Int__String__-to-__Array__Int__var2144__ ((Array Int String)) (Array Int var2144))
(declare-fun cast-from-__Array__Int__var2144__-to-__Array__Int__String__ ((Array Int var2144)) (Array Int String))
(declare-fun String_join/-1520935655 (String (Array Int String)) String)
(define-fun cast-from-String-to-String ((arg String)) String arg)
(declare-fun var35_getCurrentAdapter/107571761 () String)
(declare-fun var35_getLevel/-706352403 () var3773)
(declare-fun String-init () String)
(define-fun <init>/1968657023 () String "")
(define-fun append/672562846 ((s String) (tail String)) String (str.++ s tail))
(declare-fun name/1633728430 (var283) String)
(declare-fun cast-from-var3773-to-var283 (var3773) var283)
(define-fun toString/-2075883882 ((s String)) String s)
(declare-const null-var3166 var3166)
(declare-const null-var1468 var1468)
(declare-const null-__Array__Int__String__ (Array Int String))
(declare-const var1593 var3166) ; Statement: r16 := @this: org.apache.dubbo.qos.command.impl.LoggerInfo 
(assert (not (= var1593 null-var3166)))
(declare-const var583 var1468) ; Statement: r17 := @parameter0: org.apache.dubbo.qos.api.CommandContext 
(assert (not (= var583 null-var1468)))
(declare-const var1679 (Array Int String)) ; Statement: r18 := @parameter1: java.lang.String[] 
(assert (not (= var1679 null-__Array__Int__String__)))
(define-const var830 var1302 var35_getAvailableAdapter/933843496) ; Statement: $r1 = staticinvoke <org.apache.dubbo.common.logger.LoggerFactory: java.util.List getAvailableAdapter()>() 
(define-const var3355 (Array Int String) arr-String-init) ; Statement: $r0 = newarray (java.lang.String)[0] 
(define-const var94 (Array Int var2144) (var1302_toArray/-775711681 var830 (cast-from-__Array__Int__String__-to-__Array__Int__var2144__ var3355))) ; Statement: $r2 = interfaceinvoke $r1.<java.util.List: java.lang.Object[] toArray(java.lang.Object[])>($r0) 
(define-const var452 (Array Int String) (cast-from-__Array__Int__var2144__-to-__Array__Int__String__ var94)) ; Statement: $r3 = (java.lang.CharSequence[]) $r2 
(define-const var1358 String (String_join/-1520935655 (cast-from-String-to-String ", ") var452)) ; Statement: r4 = staticinvoke <java.lang.String: java.lang.String join(java.lang.CharSequence,java.lang.CharSequence[])>(", ", $r3) 
(define-const var664 String var35_getCurrentAdapter/107571761) ; Statement: r5 = staticinvoke <org.apache.dubbo.common.logger.LoggerFactory: java.lang.String getCurrentAdapter()>() 
(define-const var730 var3773 var35_getLevel/-706352403) ; Statement: r6 = staticinvoke <org.apache.dubbo.common.logger.LoggerFactory: org.apache.dubbo.common.logger.Level getLevel()>() 
(define-const var2126 String String-init) ; Statement: $r7 = new java.lang.StringBuilder 
(assert true)
;(assert (<init>/1968657023 var2126)) ; Statement: specialinvoke $r7.<java.lang.StringBuilder: void <init>()>() 
(declare-const var2126!1 String)
(assert (= var2126!1 ""))
(assert true)
(define-const var758 String (append/672562846 var2126!1 "Available logger adapters: [")) ; Statement: $r8 = virtualinvoke $r7.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("Available logger adapters: [") 
(declare-const var2126!2 String)
(assert (= var2126!2 (str.++ var2126!1 "Available logger adapters: [")))
(assert true)
(define-const var2101 String (append/672562846 var758 var1358)) ; Statement: $r9 = virtualinvoke $r8.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(r4) 
(declare-const var758!1 String)
(assert (= var758!1 (str.++ var758 var1358)))
(assert true)
(define-const var1741 String (append/672562846 var2101 "]. Current Adapter: [")) ; Statement: $r10 = virtualinvoke $r9.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("]. Current Adapter: [") 
(declare-const var2101!1 String)
(assert (= var2101!1 (str.++ var2101 "]. Current Adapter: [")))
(assert true)
(define-const var3555 String (append/672562846 var1741 var664)) ; Statement: $r11 = virtualinvoke $r10.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(r5) 
(declare-const var1741!1 String)
(assert (= var1741!1 (str.++ var1741 var664)))
(assert true)
(define-const var3751 String (append/672562846 var3555 "]. Log level: ")) ; Statement: $r13 = virtualinvoke $r11.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("]. Log level: ") 
(declare-const var3555!1 String)
(assert (= var3555!1 (str.++ var3555 "]. Log level: ")))
(assert true)
(define-const var1442 String (name/1633728430 (cast-from-var3773-to-var283 var730))) ; Statement: $r12 = virtualinvoke r6.<org.apache.dubbo.common.logger.Level: java.lang.String name()>() 
(assert true)
(define-const var1459 String (append/672562846 var3751 var1442)) ; Statement: $r14 = virtualinvoke $r13.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>($r12) 
(declare-const var3751!1 String)
(assert (= var3751!1 (str.++ var3751 var1442)))
(assert true)
(define-const var2235 String (toString/-2075883882 var1459)) ; Statement: $r15 = virtualinvoke $r14.<java.lang.StringBuilder: java.lang.String toString()>() 
 ; Statement: return $r15 
(check-sat)
; {var35_getAvailableAdapter/933843496=([], java.util.List), arr-String-init=([], java.lang.String[]), var1302_toArray/-775711681=([java.util.List, java.lang.Object[]], java.lang.Object[]), cast-from-__Array__Int__String__-to-__Array__Int__var2144__=([java.lang.String[]], java.lang.Object[]), cast-from-__Array__Int__var2144__-to-__Array__Int__String__=([java.lang.Object[]], java.lang.CharSequence[]), String_join/-1520935655=([java.lang.CharSequence, java.lang.CharSequence[]], java.lang.String), cast-from-String-to-String=([java.lang.String], java.lang.CharSequence), var35_getCurrentAdapter/107571761=([], java.lang.String), var35_getLevel/-706352403=([], org.apache.dubbo.common.logger.Level), String-init=([], java.lang.StringBuilder), <init>/1968657023=([java.lang.StringBuilder], void), append/672562846=([java.lang.StringBuilder, java.lang.String], java.lang.StringBuilder), name/1633728430=([java.lang.Enum], java.lang.String), cast-from-var3773-to-var283=([org.apache.dubbo.common.logger.Level], java.lang.Enum), toString/-2075883882=([java.lang.StringBuilder], java.lang.String)}
; {var3166=org.apache.dubbo.qos.command.impl.LoggerInfo, var1593=r16, var1468=org.apache.dubbo.qos.api.CommandContext, var583=r17, var1679=r18, var1302=java.util.List, var35=org.apache.dubbo.common.logger.LoggerFactory, var830=$r1, var3355=$r0, var2144=java.lang.Object, var94=$r2, var452=$r3, var1358=r4, var664=r5, var3773=org.apache.dubbo.common.logger.Level, var730=r6, var2126=$r7, var758=$r8, var2101=$r9, var1741=$r10, var3555=$r11, var3751=$r13, var283=java.lang.Enum, var1442=$r12, var1459=$r14, var2235=$r15}
; {org.apache.dubbo.qos.command.impl.LoggerInfo=var3166, r16=var1593, org.apache.dubbo.qos.api.CommandContext=var1468, r17=var583, r18=var1679, java.util.List=var1302, org.apache.dubbo.common.logger.LoggerFactory=var35, $r1=var830, $r0=var3355, java.lang.Object=var2144, $r2=var94, $r3=var452, r4=var1358, r5=var664, org.apache.dubbo.common.logger.Level=var3773, r6=var730, $r7=var2126, $r8=var758, $r9=var2101, $r10=var1741, $r11=var3555, $r13=var3751, java.lang.Enum=var283, $r12=var1442, $r14=var1459, $r15=var2235}
;seq <java.lang.String: java.lang.String join(java.lang.CharSequence,java.lang.CharSequence[])>;	<java.lang.StringBuilder: void <init>()>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.String toString()>
;cnt {"<java.lang.String: java.lang.String join(java.lang.CharSequence,java.lang.CharSequence[])>": 1,"<java.lang.StringBuilder: void <init>()>": 1,"<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>": 6,"<java.lang.StringBuilder: java.lang.String toString()>": 1}
;stmts r16 := @this: org.apache.dubbo.qos.command.impl.LoggerInfo;	r17 := @parameter0: org.apache.dubbo.qos.api.CommandContext;	r18 := @parameter1: java.lang.String[];	$r1 = staticinvoke <org.apache.dubbo.common.logger.LoggerFactory: java.util.List getAvailableAdapter()>();	$r0 = newarray (java.lang.String)[0];	$r2 = interfaceinvoke $r1.<java.util.List: java.lang.Object[] toArray(java.lang.Object[])>($r0);	$r3 = (java.lang.CharSequence[]) $r2;	r4 = staticinvoke <java.lang.String: java.lang.String join(java.lang.CharSequence,java.lang.CharSequence[])>(", ", $r3);	r5 = staticinvoke <org.apache.dubbo.common.logger.LoggerFactory: java.lang.String getCurrentAdapter()>();	r6 = staticinvoke <org.apache.dubbo.common.logger.LoggerFactory: org.apache.dubbo.common.logger.Level getLevel()>();	$r7 = new java.lang.StringBuilder;	specialinvoke $r7.<java.lang.StringBuilder: void <init>()>();	$r8 = virtualinvoke $r7.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("Available logger adapters: [");	$r9 = virtualinvoke $r8.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(r4);	$r10 = virtualinvoke $r9.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("]. Current Adapter: [");	$r11 = virtualinvoke $r10.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(r5);	$r13 = virtualinvoke $r11.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("]. Log level: ");	$r12 = virtualinvoke r6.<org.apache.dubbo.common.logger.Level: java.lang.String name()>();	$r14 = virtualinvoke $r13.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>($r12);	$r15 = virtualinvoke $r14.<java.lang.StringBuilder: java.lang.String toString()>();	return $r15
;block_num 1