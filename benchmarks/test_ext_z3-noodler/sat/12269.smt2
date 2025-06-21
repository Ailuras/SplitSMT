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

(declare-sort var870 0)
(declare-sort var2615 0)
(declare-sort var1374 0)
(declare-sort var958 0)
(declare-sort var3670 0)
(declare-sort var3416 0)
(declare-sort var3018 0)
(declare-sort var3441 0)
(declare-sort var790 0)
(declare-sort var2588 0)
(declare-sort var933 0)
(declare-sort var2768 0)
(declare-sort var3343 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun getRemote/226840252 (var2615) var1374)
(declare-fun var958_ofNullable/-1077078438 (var3670) var958)
(declare-fun cast-from-var1374-to-var3670 (var1374) var3670)
(declare-fun var3018_bootstrap$/-133126144 () var3416)
(declare-fun map/1305667865 (var958 var3416) var958)
(declare-fun var3441_bootstrap$/-1556620157 () var3416)
(declare-fun orElse/-757175127 (var958 var3670) var3670)
(declare-fun cast-from-String-to-var3670 (String) var3670)
(declare-fun cast-from-var3670-to-String (var3670) String)
(declare-fun String-init () String)
(define-fun <init>/1968657023 () String "")
(define-fun append/672562846 ((s String) (tail String)) String (str.++ s tail))
(declare-fun getCommandName/999015139 (var2615) String)
(declare-fun getArgs/983883266 (var2615) (Array Int String))
(declare-fun var2588_toString/-575966009 ((Array Int var3670)) String)
(declare-fun cast-from-__Array__Int__String__-to-__Array__Int__var3670__ ((Array Int String)) (Array Int var3670))
(define-fun toString/-2075883882 ((s String)) String s)
(declare-fun var790_info/484404803 (var790 String) void)
(declare-fun var3343-init () var3343)
(declare-fun <init>/135814875 (var3343 String) void)
(declare-const null-var870 var870)
(declare-const null-var2615 var2615)
(declare-const var870-logger var790)
(declare-const null-var933 var933)
(declare-const null-var2768 var2768)
(declare-const var2465 var870) ; Statement: r21 := @this: org.apache.dubbo.qos.command.DefaultCommandExecutor 
(assert (not (= var2465 null-var870)))
(declare-const var1275 var2615) ; Statement: r0 := @parameter0: org.apache.dubbo.qos.api.CommandContext 
(assert (not (= var1275 null-var2615)))
(assert true)
(define-const var3429 var1374 (getRemote/226840252 var1275)) ; Statement: $r1 = virtualinvoke r0.<org.apache.dubbo.qos.api.CommandContext: io.netty.channel.Channel getRemote()>() 
(define-const var1164 var958 (var958_ofNullable/-1077078438 (cast-from-var1374-to-var3670 var3429))) ; Statement: $r3 = staticinvoke <java.util.Optional: java.util.Optional ofNullable(java.lang.Object)>($r1) 
(define-const var3803 var3416 var3018_bootstrap$/-133126144) ; Statement: $r2 = staticinvoke <org.apache.dubbo.qos.command.DefaultCommandExecutor$remoteAddress__848: java.util.function.Function bootstrap$()>() 
(assert true)
(define-const var1515 var958 (map/1305667865 var1164 var3803)) ; Statement: $r5 = virtualinvoke $r3.<java.util.Optional: java.util.Optional map(java.util.function.Function)>($r2) 
(define-const var2326 var3416 var3441_bootstrap$/-1556620157) ; Statement: $r4 = staticinvoke <org.apache.dubbo.qos.command.DefaultCommandExecutor$toString__856: java.util.function.Function bootstrap$()>() 
(assert true)
(define-const var1350 var958 (map/1305667865 var1515 var2326)) ; Statement: $r6 = virtualinvoke $r5.<java.util.Optional: java.util.Optional map(java.util.function.Function)>($r4) 
(assert true)
(define-const var974 var3670 (orElse/-757175127 var1350 (cast-from-String-to-var3670 "unknown"))) ; Statement: $r7 = virtualinvoke $r6.<java.util.Optional: java.lang.Object orElse(java.lang.Object)>("unknown") 
(define-const var1126 String (cast-from-var3670-to-String var974)) ; Statement: r8 = (java.lang.String) $r7 
(define-const var2357 var790 var870-logger) ; Statement: $r10 = <org.apache.dubbo.qos.command.DefaultCommandExecutor: org.apache.dubbo.common.logger.Logger logger> 
(define-const var1373 String String-init) ; Statement: $r9 = new java.lang.StringBuilder 
(assert true)
;(assert (<init>/1968657023 var1373)) ; Statement: specialinvoke $r9.<java.lang.StringBuilder: void <init>()>() 
(declare-const var1373!1 String)
(assert (= var1373!1 ""))
(assert true)
(define-const var3499 String (append/672562846 var1373!1 "[Dubbo QoS] Command Process start. Command: ")) ; Statement: $r12 = virtualinvoke $r9.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("[Dubbo QoS] Command Process start. Command: ") 
(declare-const var1373!2 String)
(assert (= var1373!2 (str.++ var1373!1 "[Dubbo QoS] Command Process start. Command: ")))
(assert true)
(define-const var2504 String (getCommandName/999015139 var1275)) ; Statement: $r11 = virtualinvoke r0.<org.apache.dubbo.qos.api.CommandContext: java.lang.String getCommandName()>() 
(assert true)
(define-const var1307 String (append/672562846 var3499 var2504)) ; Statement: $r13 = virtualinvoke $r12.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>($r11) 
(declare-const var3499!1 String)
(assert (= var3499!1 (str.++ var3499 var2504)))
(assert true)
(define-const var2344 String (append/672562846 var1307 ", Args: ")) ; Statement: $r16 = virtualinvoke $r13.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(", Args: ") 
(declare-const var1307!1 String)
(assert (= var1307!1 (str.++ var1307 ", Args: ")))
(assert true)
(define-const var3422 (Array Int String) (getArgs/983883266 var1275)) ; Statement: $r14 = virtualinvoke r0.<org.apache.dubbo.qos.api.CommandContext: java.lang.String[] getArgs()>() 
(define-const var3358 String (var2588_toString/-575966009 (cast-from-__Array__Int__String__-to-__Array__Int__var3670__ var3422))) ; Statement: $r15 = staticinvoke <java.util.Arrays: java.lang.String toString(java.lang.Object[])>($r14) 
(assert true)
(define-const var3145 String (append/672562846 var2344 var3358)) ; Statement: $r17 = virtualinvoke $r16.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>($r15) 
(declare-const var2344!1 String)
(assert (= var2344!1 (str.++ var2344 var3358)))
(assert true)
(define-const var3095 String (append/672562846 var3145 ", Remote Address: ")) ; Statement: $r18 = virtualinvoke $r17.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(", Remote Address: ") 
(declare-const var3145!1 String)
(assert (= var3145!1 (str.++ var3145 ", Remote Address: ")))
(assert true)
(define-const var1140 String (append/672562846 var3095 var1126)) ; Statement: $r19 = virtualinvoke $r18.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(r8) 
(declare-const var3095!1 String)
(assert (= var3095!1 (str.++ var3095 var1126)))
(assert true)
(define-const var2308 String (toString/-2075883882 var1140)) ; Statement: $r20 = virtualinvoke $r19.<java.lang.StringBuilder: java.lang.String toString()>() 
;(assert (var790_info/484404803 var2357 var2308)) ; Statement: interfaceinvoke $r10.<org.apache.dubbo.common.logger.Logger: void info(java.lang.String)>($r20) 

(declare-const var2357!1 var790)
(declare-const var2308!1 String)
(define-const var1302 var933 null-var933) ; Statement: r90 = null 
(assert true) ; Handling Exception: java.lang.Throwable 
(declare-const var1599 var2768) ; Statement: $r89 := @caughtexception 
(assert (not (= var1599 null-var2768)))
(assert true) ; Non Conditional
 ; Statement: if r90 != null goto $z0 = virtualinvoke r0.<org.apache.dubbo.qos.api.CommandContext: boolean isAllowAnonymousAccess()>() 
(assert (not (not (= var1302 null-var933)))) ; Negate: Cond: r90 != null  
(define-const var2056 var790 var870-logger) ; Statement: $r64 = <org.apache.dubbo.qos.command.DefaultCommandExecutor: org.apache.dubbo.common.logger.Logger logger> 
(define-const var419 String String-init) ; Statement: $r63 = new java.lang.StringBuilder 
(assert true)
;(assert (<init>/1968657023 var419)) ; Statement: specialinvoke $r63.<java.lang.StringBuilder: void <init>()>() 
(declare-const var419!1 String)
(assert (= var419!1 ""))
(assert true)
(define-const var3662 String (append/672562846 var419!1 "[Dubbo QoS] Command Not found. Command: ")) ; Statement: $r66 = virtualinvoke $r63.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("[Dubbo QoS] Command Not found. Command: ") 
(declare-const var419!2 String)
(assert (= var419!2 (str.++ var419!1 "[Dubbo QoS] Command Not found. Command: ")))
(assert true)
(define-const var1602 String (getCommandName/999015139 var1275)) ; Statement: $r65 = virtualinvoke r0.<org.apache.dubbo.qos.api.CommandContext: java.lang.String getCommandName()>() 
(assert true)
(define-const var3502 String (append/672562846 var3662 var1602)) ; Statement: $r67 = virtualinvoke $r66.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>($r65) 
(declare-const var3662!1 String)
(assert (= var3662!1 (str.++ var3662 var1602)))
(assert true)
(define-const var2673 String (append/672562846 var3502 ", Remote Address: ")) ; Statement: $r68 = virtualinvoke $r67.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(", Remote Address: ") 
(declare-const var3502!1 String)
(assert (= var3502!1 (str.++ var3502 ", Remote Address: ")))
(assert true)
(define-const var799 String (append/672562846 var2673 var1126)) ; Statement: $r69 = virtualinvoke $r68.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(r8) 
(declare-const var2673!1 String)
(assert (= var2673!1 (str.++ var2673 var1126)))
(assert true)
(define-const var456 String (toString/-2075883882 var799)) ; Statement: $r70 = virtualinvoke $r69.<java.lang.StringBuilder: java.lang.String toString()>() 
;(assert (var790_info/484404803 var2056 var456)) ; Statement: interfaceinvoke $r64.<org.apache.dubbo.common.logger.Logger: void info(java.lang.String)>($r70) 

(declare-const var2056!1 var790)
(declare-const var456!1 String)
(define-const var724 var3343 var3343-init) ; Statement: $r71 = new org.apache.dubbo.qos.command.exception.NoSuchCommandException 
(assert true)
(define-const var1636 String (getCommandName/999015139 var1275)) ; Statement: $r72 = virtualinvoke r0.<org.apache.dubbo.qos.api.CommandContext: java.lang.String getCommandName()>() 
(assert true)
;(assert (<init>/135814875 var724 var1636)) ; Statement: specialinvoke $r71.<org.apache.dubbo.qos.command.exception.NoSuchCommandException: void <init>(java.lang.String)>($r72) 

(declare-const var724!1 var3343)
(declare-const var1636!1 String)
 ; Statement: throw $r71 
(check-sat)
; {getRemote/226840252=([org.apache.dubbo.qos.api.CommandContext], io.netty.channel.Channel), var958_ofNullable/-1077078438=([java.lang.Object], java.util.Optional), cast-from-var1374-to-var3670=([io.netty.channel.Channel], java.lang.Object), var3018_bootstrap$/-133126144=([], java.util.function.Function), map/1305667865=([java.util.Optional, java.util.function.Function], java.util.Optional), var3441_bootstrap$/-1556620157=([], java.util.function.Function), orElse/-757175127=([java.util.Optional, java.lang.Object], java.lang.Object), cast-from-String-to-var3670=([java.lang.String], java.lang.Object), cast-from-var3670-to-String=([java.lang.Object], java.lang.String), String-init=([], java.lang.StringBuilder), <init>/1968657023=([java.lang.StringBuilder], void), append/672562846=([java.lang.StringBuilder, java.lang.String], java.lang.StringBuilder), getCommandName/999015139=([org.apache.dubbo.qos.api.CommandContext], java.lang.String), getArgs/983883266=([org.apache.dubbo.qos.api.CommandContext], java.lang.String[]), var2588_toString/-575966009=([java.lang.Object[]], java.lang.String), cast-from-__Array__Int__String__-to-__Array__Int__var3670__=([java.lang.String[]], java.lang.Object[]), toString/-2075883882=([java.lang.StringBuilder], java.lang.String), var790_info/484404803=([org.apache.dubbo.common.logger.Logger, java.lang.String], void), var3343-init=([], org.apache.dubbo.qos.command.exception.NoSuchCommandException), <init>/135814875=([org.apache.dubbo.qos.command.exception.NoSuchCommandException, java.lang.String], void)}
; {var870=org.apache.dubbo.qos.command.DefaultCommandExecutor, var2465=r21, var2615=org.apache.dubbo.qos.api.CommandContext, var1275=r0, var1374=io.netty.channel.Channel, var3429=$r1, var958=java.util.Optional, var3670=java.lang.Object, var1164=$r3, var3416=java.util.function.Function, var3018=org.apache.dubbo.qos.command.DefaultCommandExecutor$remoteAddress__848, var3803=$r2, var1515=$r5, var3441=org.apache.dubbo.qos.command.DefaultCommandExecutor$toString__856, var2326=$r4, var1350=$r6, var974=$r7, var1126=r8, var790=org.apache.dubbo.common.logger.Logger, var2357=$r10, var1373=$r9, var3499=$r12, var2504=$r11, var1307=$r13, var2344=$r16, var3422=$r14, var2588=java.util.Arrays, var3358=$r15, var3145=$r17, var3095=$r18, var1140=$r19, var2308=$r20, var933=org.apache.dubbo.qos.api.BaseCommand, var1302=r90, var2768=java.lang.Throwable, var1599=$r89, var2056=$r64, var419=$r63, var3662=$r66, var1602=$r65, var3502=$r67, var2673=$r68, var799=$r69, var456=$r70, var3343=org.apache.dubbo.qos.command.exception.NoSuchCommandException, var724=$r71, var1636=$r72}
; {org.apache.dubbo.qos.command.DefaultCommandExecutor=var870, r21=var2465, org.apache.dubbo.qos.api.CommandContext=var2615, r0=var1275, io.netty.channel.Channel=var1374, $r1=var3429, java.util.Optional=var958, java.lang.Object=var3670, $r3=var1164, java.util.function.Function=var3416, org.apache.dubbo.qos.command.DefaultCommandExecutor$remoteAddress__848=var3018, $r2=var3803, $r5=var1515, org.apache.dubbo.qos.command.DefaultCommandExecutor$toString__856=var3441, $r4=var2326, $r6=var1350, $r7=var974, r8=var1126, org.apache.dubbo.common.logger.Logger=var790, $r10=var2357, $r9=var1373, $r12=var3499, $r11=var2504, $r13=var1307, $r16=var2344, $r14=var3422, java.util.Arrays=var2588, $r15=var3358, $r17=var3145, $r18=var3095, $r19=var1140, $r20=var2308, org.apache.dubbo.qos.api.BaseCommand=var933, r90=var1302, java.lang.Throwable=var2768, $r89=var1599, $r64=var2056, $r63=var419, $r66=var3662, $r65=var1602, $r67=var3502, $r68=var2673, $r69=var799, $r70=var456, org.apache.dubbo.qos.command.exception.NoSuchCommandException=var3343, $r71=var724, $r72=var1636}
;seq <java.lang.StringBuilder: void <init>()>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.util.Arrays: java.lang.String toString(java.lang.Object[])>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.String toString()>;	<java.lang.StringBuilder: void <init>()>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.String toString()>
;cnt {"<java.lang.StringBuilder: void <init>()>": 2,"<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>": 10,"<java.lang.StringBuilder: java.lang.String toString()>": 2}
;stmts r21 := @this: org.apache.dubbo.qos.command.DefaultCommandExecutor;	r0 := @parameter0: org.apache.dubbo.qos.api.CommandContext;	$r1 = virtualinvoke r0.<org.apache.dubbo.qos.api.CommandContext: io.netty.channel.Channel getRemote()>();	$r3 = staticinvoke <java.util.Optional: java.util.Optional ofNullable(java.lang.Object)>($r1);	$r2 = staticinvoke <org.apache.dubbo.qos.command.DefaultCommandExecutor$remoteAddress__848: java.util.function.Function bootstrap$()>();	$r5 = virtualinvoke $r3.<java.util.Optional: java.util.Optional map(java.util.function.Function)>($r2);	$r4 = staticinvoke <org.apache.dubbo.qos.command.DefaultCommandExecutor$toString__856: java.util.function.Function bootstrap$()>();	$r6 = virtualinvoke $r5.<java.util.Optional: java.util.Optional map(java.util.function.Function)>($r4);	$r7 = virtualinvoke $r6.<java.util.Optional: java.lang.Object orElse(java.lang.Object)>("unknown");	r8 = (java.lang.String) $r7;	$r10 = <org.apache.dubbo.qos.command.DefaultCommandExecutor: org.apache.dubbo.common.logger.Logger logger>;	$r9 = new java.lang.StringBuilder;	specialinvoke $r9.<java.lang.StringBuilder: void <init>()>();	$r12 = virtualinvoke $r9.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("[Dubbo QoS] Command Process start. Command: ");	$r11 = virtualinvoke r0.<org.apache.dubbo.qos.api.CommandContext: java.lang.String getCommandName()>();	$r13 = virtualinvoke $r12.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>($r11);	$r16 = virtualinvoke $r13.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(", Args: ");	$r14 = virtualinvoke r0.<org.apache.dubbo.qos.api.CommandContext: java.lang.String[] getArgs()>();	$r15 = staticinvoke <java.util.Arrays: java.lang.String toString(java.lang.Object[])>($r14);	$r17 = virtualinvoke $r16.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>($r15);	$r18 = virtualinvoke $r17.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(", Remote Address: ");	$r19 = virtualinvoke $r18.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(r8);	$r20 = virtualinvoke $r19.<java.lang.StringBuilder: java.lang.String toString()>();	interfaceinvoke $r10.<org.apache.dubbo.common.logger.Logger: void info(java.lang.String)>($r20);	r90 = null;	$r89 := @caughtexception;	if r90 != null goto $z0 = virtualinvoke r0.<org.apache.dubbo.qos.api.CommandContext: boolean isAllowAnonymousAccess()>();	$r64 = <org.apache.dubbo.qos.command.DefaultCommandExecutor: org.apache.dubbo.common.logger.Logger logger>;	$r63 = new java.lang.StringBuilder;	specialinvoke $r63.<java.lang.StringBuilder: void <init>()>();	$r66 = virtualinvoke $r63.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("[Dubbo QoS] Command Not found. Command: ");	$r65 = virtualinvoke r0.<org.apache.dubbo.qos.api.CommandContext: java.lang.String getCommandName()>();	$r67 = virtualinvoke $r66.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>($r65);	$r68 = virtualinvoke $r67.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(", Remote Address: ");	$r69 = virtualinvoke $r68.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(r8);	$r70 = virtualinvoke $r69.<java.lang.StringBuilder: java.lang.String toString()>();	interfaceinvoke $r64.<org.apache.dubbo.common.logger.Logger: void info(java.lang.String)>($r70);	$r71 = new org.apache.dubbo.qos.command.exception.NoSuchCommandException;	$r72 = virtualinvoke r0.<org.apache.dubbo.qos.api.CommandContext: java.lang.String getCommandName()>();	specialinvoke $r71.<org.apache.dubbo.qos.command.exception.NoSuchCommandException: void <init>(java.lang.String)>($r72);	throw $r71
;block_num 4