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

(declare-sort var749 0)
(declare-sort var633 0)
(declare-sort var1005 0)
(declare-sort var1979 0)
(declare-sort var1907 0)
(declare-sort var1836 0)
(declare-sort var2829 0)
(declare-sort var767 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun var1979_newInstance/-1183533700 (String) var1005)
(declare-fun setHttp/-297667212 (var1005 Bool) void)
(declare-fun String-init () String)
(define-fun <init>/1968657023 () String "")
(define-fun append/672562846 ((s String) (tail String)) String (str.++ s tail))
(declare-fun getCommandName/999015139 (var1005) String)
(declare-fun getArgs/983883266 (var1005) (Array Int String))
(declare-fun var1836_toString/-575966009 ((Array Int var2829)) String)
(declare-fun cast-from-__Array__Int__String__-to-__Array__Int__var2829__ ((Array Int String)) (Array Int var2829))
(define-fun toString/-2075883882 ((s String)) String s)
(declare-fun var1907_info/484404803 (var1907 String) void)
(declare-fun var1907_info/1294235139 (var1907 String var767) void)
(declare-const null-var749 var749)
(declare-const null-String String)
(declare-const null-__Array__Int__String__ (Array Int String))
(declare-const var749-logger var1907)
(declare-const null-var767 var767)
(declare-const var2801 var749) ; Statement: r12 := @this: org.apache.dubbo.qos.command.ActuatorCommandExecutor 
(assert (not (= var2801 null-var749)))
(declare-const var2940 String) ; Statement: r1 := @parameter0: java.lang.String 
(assert (not (= var2940 null-String)))
(declare-const var411 (Array Int String)) ; Statement: r0 := @parameter1: java.lang.String[] 
(assert (not (= var411 null-__Array__Int__String__)))
 ; Statement: if r0 == null goto $r20 = staticinvoke <org.apache.dubbo.qos.command.CommandContextFactory: org.apache.dubbo.qos.api.CommandContext newInstance(java.lang.String)>(r1) 
(assert (= var411 null-__Array__Int__String__)) ; Cond: r0 == null 
(define-const var762 var1005 (var1979_newInstance/-1183533700 var2940)) ; Statement: $r20 = staticinvoke <org.apache.dubbo.qos.command.CommandContextFactory: org.apache.dubbo.qos.api.CommandContext newInstance(java.lang.String)>(r1) 
(define-const var919 var1005 var762) ; Statement: r32 = $r20 
(assert true)
;(assert (setHttp/-297667212 var762 (ite (= 1 1) true false))) ; Statement: virtualinvoke $r20.<org.apache.dubbo.qos.api.CommandContext: void setHttp(boolean)>(1) 

(declare-const var762!1 var1005)
(declare-const var880 Int)
 ; Statement: goto [?= $r3 = <org.apache.dubbo.qos.command.ActuatorCommandExecutor: org.apache.dubbo.common.logger.Logger logger>] 
(assert true) ; Non Conditional
(define-const var82 var1907 var749-logger) ; Statement: $r3 = <org.apache.dubbo.qos.command.ActuatorCommandExecutor: org.apache.dubbo.common.logger.Logger logger> 
(define-const var1995 String String-init) ; Statement: $r2 = new java.lang.StringBuilder 
(assert true)
;(assert (<init>/1968657023 var1995)) ; Statement: specialinvoke $r2.<java.lang.StringBuilder: void <init>()>() 
(declare-const var1995!1 String)
(assert (= var1995!1 ""))
(assert true)
(define-const var3570 String (append/672562846 var1995!1 "[Dubbo Actuator QoS] Command Process start. Command: ")) ; Statement: $r5 = virtualinvoke $r2.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("[Dubbo Actuator QoS] Command Process start. Command: ") 
(declare-const var1995!2 String)
(assert (= var1995!2 (str.++ var1995!1 "[Dubbo Actuator QoS] Command Process start. Command: ")))
(assert true)
(define-const var2692 String (getCommandName/999015139 var919)) ; Statement: $r4 = virtualinvoke r32.<org.apache.dubbo.qos.api.CommandContext: java.lang.String getCommandName()>() 
(assert true)
(define-const var1370 String (append/672562846 var3570 var2692)) ; Statement: $r6 = virtualinvoke $r5.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>($r4) 
(declare-const var3570!1 String)
(assert (= var3570!1 (str.++ var3570 var2692)))
(assert true)
(define-const var1687 String (append/672562846 var1370 ", Args: ")) ; Statement: $r9 = virtualinvoke $r6.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(", Args: ") 
(declare-const var1370!1 String)
(assert (= var1370!1 (str.++ var1370 ", Args: ")))
(assert true)
(define-const var1459 (Array Int String) (getArgs/983883266 var919)) ; Statement: $r7 = virtualinvoke r32.<org.apache.dubbo.qos.api.CommandContext: java.lang.String[] getArgs()>() 
(define-const var1058 String (var1836_toString/-575966009 (cast-from-__Array__Int__String__-to-__Array__Int__var2829__ var1459))) ; Statement: $r8 = staticinvoke <java.util.Arrays: java.lang.String toString(java.lang.Object[])>($r7) 
(assert true)
(define-const var430 String (append/672562846 var1687 var1058)) ; Statement: $r10 = virtualinvoke $r9.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>($r8) 
(declare-const var1687!1 String)
(assert (= var1687!1 (str.++ var1687 var1058)))
(assert true)
(define-const var2961 String (toString/-2075883882 var430)) ; Statement: $r11 = virtualinvoke $r10.<java.lang.StringBuilder: java.lang.String toString()>() 
;(assert (var1907_info/484404803 var82 var2961)) ; Statement: interfaceinvoke $r3.<org.apache.dubbo.common.logger.Logger: void info(java.lang.String)>($r11) 

(declare-const var82!1 var1907)
(declare-const var2961!1 String)
(assert true) ; Handling Exception: java.lang.Throwable 
(declare-const var3030 var767) ; Statement: $r21 := @caughtexception 
(assert (not (= var3030 null-var767)))
(define-const var417 var1907 var749-logger) ; Statement: $r23 = <org.apache.dubbo.qos.command.ActuatorCommandExecutor: org.apache.dubbo.common.logger.Logger logger> 
(define-const var2534 String String-init) ; Statement: $r22 = new java.lang.StringBuilder 
(assert true)
;(assert (<init>/1968657023 var2534)) ; Statement: specialinvoke $r22.<java.lang.StringBuilder: void <init>()>() 
(declare-const var2534!1 String)
(assert (= var2534!1 ""))
(assert true)
(define-const var2406 String (append/672562846 var2534!1 "[Dubbo Actuator QoS] Command Process Failed. Command: ")) ; Statement: $r25 = virtualinvoke $r22.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("[Dubbo Actuator QoS] Command Process Failed. Command: ") 
(declare-const var2534!2 String)
(assert (= var2534!2 (str.++ var2534!1 "[Dubbo Actuator QoS] Command Process Failed. Command: ")))
(assert true)
(define-const var2326 String (getCommandName/999015139 var919)) ; Statement: $r24 = virtualinvoke r32.<org.apache.dubbo.qos.api.CommandContext: java.lang.String getCommandName()>() 
(assert true)
(define-const var2948 String (append/672562846 var2406 var2326)) ; Statement: $r26 = virtualinvoke $r25.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>($r24) 
(declare-const var2406!1 String)
(assert (= var2406!1 (str.++ var2406 var2326)))
(assert true)
(define-const var3391 String (append/672562846 var2948 ", Args: ")) ; Statement: $r29 = virtualinvoke $r26.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(", Args: ") 
(declare-const var2948!1 String)
(assert (= var2948!1 (str.++ var2948 ", Args: ")))
(assert true)
(define-const var368 (Array Int String) (getArgs/983883266 var919)) ; Statement: $r27 = virtualinvoke r32.<org.apache.dubbo.qos.api.CommandContext: java.lang.String[] getArgs()>() 
(define-const var683 String (var1836_toString/-575966009 (cast-from-__Array__Int__String__-to-__Array__Int__var2829__ var368))) ; Statement: $r28 = staticinvoke <java.util.Arrays: java.lang.String toString(java.lang.Object[])>($r27) 
(assert true)
(define-const var439 String (append/672562846 var3391 var683)) ; Statement: $r30 = virtualinvoke $r29.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>($r28) 
(declare-const var3391!1 String)
(assert (= var3391!1 (str.++ var3391 var683)))
(assert true)
(define-const var2591 String (toString/-2075883882 var439)) ; Statement: $r31 = virtualinvoke $r30.<java.lang.StringBuilder: java.lang.String toString()>() 
;(assert (var1907_info/1294235139 var417 var2591 var3030)) ; Statement: interfaceinvoke $r23.<org.apache.dubbo.common.logger.Logger: void info(java.lang.String,java.lang.Throwable)>($r31, $r21) 

(declare-const var417!1 var1907)
(declare-const var2591!1 String)
(declare-const var3030!1 var767)
 ; Statement: throw $r21 
(check-sat)
; {var1979_newInstance/-1183533700=([java.lang.String], org.apache.dubbo.qos.api.CommandContext), setHttp/-297667212=([org.apache.dubbo.qos.api.CommandContext, boolean], void), String-init=([], java.lang.StringBuilder), <init>/1968657023=([java.lang.StringBuilder], void), append/672562846=([java.lang.StringBuilder, java.lang.String], java.lang.StringBuilder), getCommandName/999015139=([org.apache.dubbo.qos.api.CommandContext], java.lang.String), getArgs/983883266=([org.apache.dubbo.qos.api.CommandContext], java.lang.String[]), var1836_toString/-575966009=([java.lang.Object[]], java.lang.String), cast-from-__Array__Int__String__-to-__Array__Int__var2829__=([java.lang.String[]], java.lang.Object[]), toString/-2075883882=([java.lang.StringBuilder], java.lang.String), var1907_info/484404803=([org.apache.dubbo.common.logger.Logger, java.lang.String], void), var1907_info/1294235139=([org.apache.dubbo.common.logger.Logger, java.lang.String, java.lang.Throwable], void)}
; {var749=org.apache.dubbo.qos.command.ActuatorCommandExecutor, var2801=r12, var2940=r1, var633=null_type, var411=r0, var1005=org.apache.dubbo.qos.api.CommandContext, var1979=org.apache.dubbo.qos.command.CommandContextFactory, var762=$r20, var919=r32, var880=1, var1907=org.apache.dubbo.common.logger.Logger, var82=$r3, var1995=$r2, var3570=$r5, var2692=$r4, var1370=$r6, var1687=$r9, var1459=$r7, var1836=java.util.Arrays, var2829=java.lang.Object, var1058=$r8, var430=$r10, var2961=$r11, var767=java.lang.Throwable, var3030=$r21, var417=$r23, var2534=$r22, var2406=$r25, var2326=$r24, var2948=$r26, var3391=$r29, var368=$r27, var683=$r28, var439=$r30, var2591=$r31}
; {org.apache.dubbo.qos.command.ActuatorCommandExecutor=var749, r12=var2801, r1=var2940, null_type=var633, r0=var411, org.apache.dubbo.qos.api.CommandContext=var1005, org.apache.dubbo.qos.command.CommandContextFactory=var1979, $r20=var762, r32=var919, 1=var880, org.apache.dubbo.common.logger.Logger=var1907, $r3=var82, $r2=var1995, $r5=var3570, $r4=var2692, $r6=var1370, $r9=var1687, $r7=var1459, java.util.Arrays=var1836, java.lang.Object=var2829, $r8=var1058, $r10=var430, $r11=var2961, java.lang.Throwable=var767, $r21=var3030, $r23=var417, $r22=var2534, $r25=var2406, $r24=var2326, $r26=var2948, $r29=var3391, $r27=var368, $r28=var683, $r30=var439, $r31=var2591}
;seq <java.lang.StringBuilder: void <init>()>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.util.Arrays: java.lang.String toString(java.lang.Object[])>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.String toString()>;	<java.lang.StringBuilder: void <init>()>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.util.Arrays: java.lang.String toString(java.lang.Object[])>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.String toString()>
;cnt {"<java.lang.StringBuilder: void <init>()>": 2,"<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>": 8,"<java.lang.StringBuilder: java.lang.String toString()>": 2}
;stmts r12 := @this: org.apache.dubbo.qos.command.ActuatorCommandExecutor;	r1 := @parameter0: java.lang.String;	r0 := @parameter1: java.lang.String[];	if r0 == null goto $r20 = staticinvoke <org.apache.dubbo.qos.command.CommandContextFactory: org.apache.dubbo.qos.api.CommandContext newInstance(java.lang.String)>(r1);	$r20 = staticinvoke <org.apache.dubbo.qos.command.CommandContextFactory: org.apache.dubbo.qos.api.CommandContext newInstance(java.lang.String)>(r1);	r32 = $r20;	virtualinvoke $r20.<org.apache.dubbo.qos.api.CommandContext: void setHttp(boolean)>(1);	goto [?= $r3 = <org.apache.dubbo.qos.command.ActuatorCommandExecutor: org.apache.dubbo.common.logger.Logger logger>];	$r3 = <org.apache.dubbo.qos.command.ActuatorCommandExecutor: org.apache.dubbo.common.logger.Logger logger>;	$r2 = new java.lang.StringBuilder;	specialinvoke $r2.<java.lang.StringBuilder: void <init>()>();	$r5 = virtualinvoke $r2.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("[Dubbo Actuator QoS] Command Process start. Command: ");	$r4 = virtualinvoke r32.<org.apache.dubbo.qos.api.CommandContext: java.lang.String getCommandName()>();	$r6 = virtualinvoke $r5.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>($r4);	$r9 = virtualinvoke $r6.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(", Args: ");	$r7 = virtualinvoke r32.<org.apache.dubbo.qos.api.CommandContext: java.lang.String[] getArgs()>();	$r8 = staticinvoke <java.util.Arrays: java.lang.String toString(java.lang.Object[])>($r7);	$r10 = virtualinvoke $r9.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>($r8);	$r11 = virtualinvoke $r10.<java.lang.StringBuilder: java.lang.String toString()>();	interfaceinvoke $r3.<org.apache.dubbo.common.logger.Logger: void info(java.lang.String)>($r11);	$r21 := @caughtexception;	$r23 = <org.apache.dubbo.qos.command.ActuatorCommandExecutor: org.apache.dubbo.common.logger.Logger logger>;	$r22 = new java.lang.StringBuilder;	specialinvoke $r22.<java.lang.StringBuilder: void <init>()>();	$r25 = virtualinvoke $r22.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("[Dubbo Actuator QoS] Command Process Failed. Command: ");	$r24 = virtualinvoke r32.<org.apache.dubbo.qos.api.CommandContext: java.lang.String getCommandName()>();	$r26 = virtualinvoke $r25.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>($r24);	$r29 = virtualinvoke $r26.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(", Args: ");	$r27 = virtualinvoke r32.<org.apache.dubbo.qos.api.CommandContext: java.lang.String[] getArgs()>();	$r28 = staticinvoke <java.util.Arrays: java.lang.String toString(java.lang.Object[])>($r27);	$r30 = virtualinvoke $r29.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>($r28);	$r31 = virtualinvoke $r30.<java.lang.StringBuilder: java.lang.String toString()>();	interfaceinvoke $r23.<org.apache.dubbo.common.logger.Logger: void info(java.lang.String,java.lang.Throwable)>($r31, $r21);	throw $r21
;block_num 4