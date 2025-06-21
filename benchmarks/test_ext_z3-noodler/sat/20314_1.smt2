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

(declare-sort var3002 0)
(declare-sort var521 0)
(declare-sort var2570 0)
(declare-sort var1686 0)
(declare-sort var3629 0)
(declare-sort var960 0)
(declare-sort var123 0)
(declare-sort var3937 0)
(declare-sort var2541 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun getInvoker/-2049196212 (var2570) var1686)
(declare-fun getProtocolServiceKey/-1744514792 (var2570) String)
(declare-fun var960_getMethodName/-516674313 (var123) String)
(declare-fun cast-from-var2570-to-var123 (var2570) var123)
(declare-fun var3002_isCallBack/-1919732310 (var3629 String String Int) Int)
(declare-fun getArguments/91264090 (var2570) (Array Int var3937))
(declare-fun getParameterTypes/1177367737 (var2570) (Array Int ClassObject))
(define-fun cast-from-Int-to-Int ((arg Int)) Int arg)
(declare-fun String-init () String)
(define-fun <init>/1968657023 () String "")
(define-fun append/672562846 ((s String) (tail String)) String (str.++ s tail))
(define-fun append/-1001720160 ((s String) (tail Int)) String (str.++ s (str.from_int tail)))
(define-fun toString/-2075883882 ((s String)) String s)
(declare-fun var2541_valueOf/1602327315 (Bool) var2541)
(declare-fun exportOrUnexportCallbackService/-2059280590 (var3002 var521 var2570 var3629 ClassObject var3937 var2541) String)
(declare-fun setAttachment/548019834 (var2570 String String) void)
(declare-const null-var3002 var3002)
(declare-const null-var521 var521)
(declare-const null-var2570 var2570)
(declare-const null-Int Int)
(declare-const null-var1686 var1686)
(declare-const null-var3629 var3629)
(declare-const var3974 var3002) ; Statement: r8 := @this: org.apache.dubbo.rpc.protocol.dubbo.CallbackServiceCodec 
(assert (not (= var3974 null-var3002)))
(declare-const var2625 var521) ; Statement: r9 := @parameter0: org.apache.dubbo.remoting.Channel 
(assert (not (= var2625 null-var521)))
(declare-const var3325 var2570) ; Statement: r0 := @parameter1: org.apache.dubbo.rpc.RpcInvocation 
(assert (not (= var3325 null-var2570)))
(declare-const var807 Int) ; Statement: i0 := @parameter2: int 
(assert (not (= var807 null-Int)))
(assert true)
(define-const var2615 var1686 (getInvoker/-2049196212 var3325)) ; Statement: $r1 = virtualinvoke r0.<org.apache.dubbo.rpc.RpcInvocation: org.apache.dubbo.rpc.Invoker getInvoker()>() 
 ; Statement: if $r1 != null goto $r2 = virtualinvoke r0.<org.apache.dubbo.rpc.RpcInvocation: org.apache.dubbo.rpc.Invoker getInvoker()>() 
(assert (not (not (= var2615 null-var1686)))) ; Negate: Cond: $r1 != null  
(define-const var2571 var3629 null-var3629) ; Statement: $r26 = null 
 ; Statement: goto [?= $r4 = virtualinvoke r0.<org.apache.dubbo.rpc.RpcInvocation: java.lang.String getProtocolServiceKey()>()] 
(assert true) ; Non Conditional
(assert true)
(define-const var507 String (getProtocolServiceKey/-1744514792 var3325)) ; Statement: $r4 = virtualinvoke r0.<org.apache.dubbo.rpc.RpcInvocation: java.lang.String getProtocolServiceKey()>() 
(define-const var1087 String (var960_getMethodName/-516674313 (cast-from-var2570-to-var123 var3325))) ; Statement: $r3 = staticinvoke <org.apache.dubbo.rpc.support.RpcUtils: java.lang.String getMethodName(org.apache.dubbo.rpc.Invocation)>(r0) 
(define-const var675 Int (var3002_isCallBack/-1919732310 var2571 var507 var1087 var807)) ; Statement: $b1 = staticinvoke <org.apache.dubbo.rpc.protocol.dubbo.CallbackServiceCodec: byte isCallBack(org.apache.dubbo.common.URL,java.lang.String,java.lang.String,int)>($r26, $r4, $r3, i0) 
(assert true)
(define-const var2999 (Array Int var3937) (getArguments/91264090 var3325)) ; Statement: $r24 = virtualinvoke r0.<org.apache.dubbo.rpc.RpcInvocation: java.lang.Object[] getArguments()>() 
(assert true)
(define-const var2925 (Array Int ClassObject) (getParameterTypes/1177367737 var3325)) ; Statement: $r25 = virtualinvoke r0.<org.apache.dubbo.rpc.RpcInvocation: java.lang.Class[] getParameterTypes()>() 
(define-const var1114 Int (cast-from-Int-to-Int var675)) ; Statement: $i2 = (int) $b1 
 ; Statement: lookupswitch($i2) {     case 1: goto $r27 = new java.lang.StringBuilder;     case 2: goto $r28 = new java.lang.StringBuilder;     default: goto $r23 = $r24[i0]; } 
(assert (and (= var1114 1) true)) ; Intersect: Cond: $i2 == 1  and Non Conditional 
(define-const var3504 String String-init) ; Statement: $r27 = new java.lang.StringBuilder 
(assert true)
;(assert (<init>/1968657023 var3504)) ; Statement: specialinvoke $r27.<java.lang.StringBuilder: void <init>()>() 
(declare-const var3504!1 String)
(assert (= var3504!1 ""))
(assert true)
(define-const var372 String (append/672562846 var3504!1 "sys_callback_arg-")) ; Statement: $r16 = virtualinvoke $r27.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("sys_callback_arg-") 
(declare-const var3504!2 String)
(assert (= var3504!2 (str.++ var3504!1 "sys_callback_arg-")))
(assert true)
(define-const var2814 String (append/-1001720160 var372 var807)) ; Statement: $r17 = virtualinvoke $r16.<java.lang.StringBuilder: java.lang.StringBuilder append(int)>(i0) 
(declare-const var372!1 String)
(assert (str.prefixof var372 var372!1))
(assert true)
(define-const var3404 String (toString/-2075883882 var2814)) ; Statement: $r22 = virtualinvoke $r17.<java.lang.StringBuilder: java.lang.String toString()>() 
(define-const var858 ClassObject (select var2925 var807)) ; Statement: $r18 = $r25[i0] 
(define-const var2919 var3937 (select var2999 var807)) ; Statement: $r19 = $r24[i0] 
(define-const var414 var2541 (var2541_valueOf/1602327315 (ite (= 1 1) true false))) ; Statement: $r20 = staticinvoke <java.lang.Boolean: java.lang.Boolean valueOf(boolean)>(1) 
(assert true)
(define-const var30 String (exportOrUnexportCallbackService/-2059280590 var3974 var2625 var3325 var2571 var858 var2919 var414)) ; Statement: $r21 = specialinvoke r8.<org.apache.dubbo.rpc.protocol.dubbo.CallbackServiceCodec: java.lang.String exportOrUnexportCallbackService(org.apache.dubbo.remoting.Channel,org.apache.dubbo.rpc.RpcInvocation,org.apache.dubbo.common.URL,java.lang.Class,java.lang.Object,java.lang.Boolean)>(r9, r0, $r26, $r18, $r19, $r20) 
(assert true)
;(assert (setAttachment/548019834 var3325 var3404 var30)) ; Statement: virtualinvoke r0.<org.apache.dubbo.rpc.RpcInvocation: void setAttachment(java.lang.String,java.lang.String)>($r22, $r21) 

(declare-const var3325!1 var2570)
(declare-const var3404!1 String)
(declare-const var30!1 String)
 ; Statement: return null 
(check-sat)
; {getInvoker/-2049196212=([org.apache.dubbo.rpc.RpcInvocation], org.apache.dubbo.rpc.Invoker), getProtocolServiceKey/-1744514792=([org.apache.dubbo.rpc.RpcInvocation], java.lang.String), var960_getMethodName/-516674313=([org.apache.dubbo.rpc.Invocation], java.lang.String), cast-from-var2570-to-var123=([org.apache.dubbo.rpc.RpcInvocation], org.apache.dubbo.rpc.Invocation), var3002_isCallBack/-1919732310=([org.apache.dubbo.common.URL, java.lang.String, java.lang.String, int], byte), getArguments/91264090=([org.apache.dubbo.rpc.RpcInvocation], java.lang.Object[]), getParameterTypes/1177367737=([org.apache.dubbo.rpc.RpcInvocation], java.lang.Class[]), cast-from-Int-to-Int=([byte], int), String-init=([], java.lang.StringBuilder), <init>/1968657023=([java.lang.StringBuilder], void), append/672562846=([java.lang.StringBuilder, java.lang.String], java.lang.StringBuilder), append/-1001720160=([java.lang.StringBuilder, int], java.lang.StringBuilder), toString/-2075883882=([java.lang.StringBuilder], java.lang.String), var2541_valueOf/1602327315=([boolean], java.lang.Boolean), exportOrUnexportCallbackService/-2059280590=([org.apache.dubbo.rpc.protocol.dubbo.CallbackServiceCodec, org.apache.dubbo.remoting.Channel, org.apache.dubbo.rpc.RpcInvocation, org.apache.dubbo.common.URL, java.lang.Class, java.lang.Object, java.lang.Boolean], java.lang.String), setAttachment/548019834=([org.apache.dubbo.rpc.RpcInvocation, java.lang.String, java.lang.String], void)}
; {var3002=org.apache.dubbo.rpc.protocol.dubbo.CallbackServiceCodec, var3974=r8, var521=org.apache.dubbo.remoting.Channel, var2625=r9, var2570=org.apache.dubbo.rpc.RpcInvocation, var3325=r0, var807=i0, var1686=org.apache.dubbo.rpc.Invoker, var2615=$r1, var3629=org.apache.dubbo.common.URL, var2571=$r26, var507=$r4, var960=org.apache.dubbo.rpc.support.RpcUtils, var123=org.apache.dubbo.rpc.Invocation, var1087=$r3, var675=$b1, var3937=java.lang.Object, var2999=$r24, var2925=$r25, var1114=$i2, var3504=$r27, var372=$r16, var2814=$r17, var3404=$r22, var858=$r18, var2919=$r19, var2541=java.lang.Boolean, var414=$r20, var30=$r21}
; {org.apache.dubbo.rpc.protocol.dubbo.CallbackServiceCodec=var3002, r8=var3974, org.apache.dubbo.remoting.Channel=var521, r9=var2625, org.apache.dubbo.rpc.RpcInvocation=var2570, r0=var3325, i0=var807, org.apache.dubbo.rpc.Invoker=var1686, $r1=var2615, org.apache.dubbo.common.URL=var3629, $r26=var2571, $r4=var507, org.apache.dubbo.rpc.support.RpcUtils=var960, org.apache.dubbo.rpc.Invocation=var123, $r3=var1087, $b1=var675, java.lang.Object=var3937, $r24=var2999, $r25=var2925, $i2=var1114, $r27=var3504, $r16=var372, $r17=var2814, $r22=var3404, $r18=var858, $r19=var2919, java.lang.Boolean=var2541, $r20=var414, $r21=var30}
;seq <java.lang.StringBuilder: void <init>()>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(int)>;	<java.lang.StringBuilder: java.lang.String toString()>
;cnt {"<java.lang.StringBuilder: void <init>()>": 1,"<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>": 1,"<java.lang.StringBuilder: java.lang.StringBuilder append(int)>": 1,"<java.lang.StringBuilder: java.lang.String toString()>": 1}
;stmts r8 := @this: org.apache.dubbo.rpc.protocol.dubbo.CallbackServiceCodec;	r9 := @parameter0: org.apache.dubbo.remoting.Channel;	r0 := @parameter1: org.apache.dubbo.rpc.RpcInvocation;	i0 := @parameter2: int;	$r1 = virtualinvoke r0.<org.apache.dubbo.rpc.RpcInvocation: org.apache.dubbo.rpc.Invoker getInvoker()>();	if $r1 != null goto $r2 = virtualinvoke r0.<org.apache.dubbo.rpc.RpcInvocation: org.apache.dubbo.rpc.Invoker getInvoker()>();	$r26 = null;	goto [?= $r4 = virtualinvoke r0.<org.apache.dubbo.rpc.RpcInvocation: java.lang.String getProtocolServiceKey()>()];	$r4 = virtualinvoke r0.<org.apache.dubbo.rpc.RpcInvocation: java.lang.String getProtocolServiceKey()>();	$r3 = staticinvoke <org.apache.dubbo.rpc.support.RpcUtils: java.lang.String getMethodName(org.apache.dubbo.rpc.Invocation)>(r0);	$b1 = staticinvoke <org.apache.dubbo.rpc.protocol.dubbo.CallbackServiceCodec: byte isCallBack(org.apache.dubbo.common.URL,java.lang.String,java.lang.String,int)>($r26, $r4, $r3, i0);	$r24 = virtualinvoke r0.<org.apache.dubbo.rpc.RpcInvocation: java.lang.Object[] getArguments()>();	$r25 = virtualinvoke r0.<org.apache.dubbo.rpc.RpcInvocation: java.lang.Class[] getParameterTypes()>();	$i2 = (int) $b1;	lookupswitch($i2) {     case 1: goto $r27 = new java.lang.StringBuilder;     case 2: goto $r28 = new java.lang.StringBuilder;     default: goto $r23 = $r24[i0]; };	$r27 = new java.lang.StringBuilder;	specialinvoke $r27.<java.lang.StringBuilder: void <init>()>();	$r16 = virtualinvoke $r27.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("sys_callback_arg-");	$r17 = virtualinvoke $r16.<java.lang.StringBuilder: java.lang.StringBuilder append(int)>(i0);	$r22 = virtualinvoke $r17.<java.lang.StringBuilder: java.lang.String toString()>();	$r18 = $r25[i0];	$r19 = $r24[i0];	$r20 = staticinvoke <java.lang.Boolean: java.lang.Boolean valueOf(boolean)>(1);	$r21 = specialinvoke r8.<org.apache.dubbo.rpc.protocol.dubbo.CallbackServiceCodec: java.lang.String exportOrUnexportCallbackService(org.apache.dubbo.remoting.Channel,org.apache.dubbo.rpc.RpcInvocation,org.apache.dubbo.common.URL,java.lang.Class,java.lang.Object,java.lang.Boolean)>(r9, r0, $r26, $r18, $r19, $r20);	virtualinvoke r0.<org.apache.dubbo.rpc.RpcInvocation: void setAttachment(java.lang.String,java.lang.String)>($r22, $r21);	return null
;block_num 4