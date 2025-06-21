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

(declare-sort var3407 0)
(declare-sort var2885 0)
(declare-sort var914 0)
(declare-sort var1136 0)
(declare-sort var1747 0)
(declare-sort var2580 0)
(declare-sort var2565 0)
(declare-sort var3382 0)
(declare-sort var676 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun getInvoker/-2049196212 (var914) var1136)
(declare-fun getProtocolServiceKey/-1744514792 (var914) String)
(declare-fun var2580_getMethodName/-516674313 (var2565) String)
(declare-fun cast-from-var914-to-var2565 (var914) var2565)
(declare-fun var3407_isCallBack/-1919732310 (var1747 String String Int) Int)
(declare-fun getArguments/91264090 (var914) (Array Int var3382))
(declare-fun getParameterTypes/1177367737 (var914) (Array Int ClassObject))
(define-fun cast-from-Int-to-Int ((arg Int)) Int arg)
(declare-fun String-init () String)
(define-fun <init>/1968657023 () String "")
(define-fun append/672562846 ((s String) (tail String)) String (str.++ s tail))
(define-fun append/-1001720160 ((s String) (tail Int)) String (str.++ s (str.from_int tail)))
(define-fun toString/-2075883882 ((s String)) String s)
(declare-fun var676_valueOf/1602327315 (Bool) var676)
(declare-fun exportOrUnexportCallbackService/-2059280590 (var3407 var2885 var914 var1747 ClassObject var3382 var676) String)
(declare-fun setAttachment/548019834 (var914 String String) void)
(declare-const null-var3407 var3407)
(declare-const null-var2885 var2885)
(declare-const null-var914 var914)
(declare-const null-Int Int)
(declare-const null-var1136 var1136)
(declare-const null-var1747 var1747)
(declare-const var3647 var3407) ; Statement: r8 := @this: org.apache.dubbo.rpc.protocol.dubbo.CallbackServiceCodec 
(assert (not (= var3647 null-var3407)))
(declare-const var2771 var2885) ; Statement: r9 := @parameter0: org.apache.dubbo.remoting.Channel 
(assert (not (= var2771 null-var2885)))
(declare-const var2996 var914) ; Statement: r0 := @parameter1: org.apache.dubbo.rpc.RpcInvocation 
(assert (not (= var2996 null-var914)))
(declare-const var592 Int) ; Statement: i0 := @parameter2: int 
(assert (not (= var592 null-Int)))
(assert true)
(define-const var2468 var1136 (getInvoker/-2049196212 var2996)) ; Statement: $r1 = virtualinvoke r0.<org.apache.dubbo.rpc.RpcInvocation: org.apache.dubbo.rpc.Invoker getInvoker()>() 
 ; Statement: if $r1 != null goto $r2 = virtualinvoke r0.<org.apache.dubbo.rpc.RpcInvocation: org.apache.dubbo.rpc.Invoker getInvoker()>() 
(assert (not (not (= var2468 null-var1136)))) ; Negate: Cond: $r1 != null  
(define-const var2442 var1747 null-var1747) ; Statement: $r26 = null 
 ; Statement: goto [?= $r4 = virtualinvoke r0.<org.apache.dubbo.rpc.RpcInvocation: java.lang.String getProtocolServiceKey()>()] 
(assert true) ; Non Conditional
(assert true)
(define-const var2722 String (getProtocolServiceKey/-1744514792 var2996)) ; Statement: $r4 = virtualinvoke r0.<org.apache.dubbo.rpc.RpcInvocation: java.lang.String getProtocolServiceKey()>() 
(define-const var3166 String (var2580_getMethodName/-516674313 (cast-from-var914-to-var2565 var2996))) ; Statement: $r3 = staticinvoke <org.apache.dubbo.rpc.support.RpcUtils: java.lang.String getMethodName(org.apache.dubbo.rpc.Invocation)>(r0) 
(define-const var3322 Int (var3407_isCallBack/-1919732310 var2442 var2722 var3166 var592)) ; Statement: $b1 = staticinvoke <org.apache.dubbo.rpc.protocol.dubbo.CallbackServiceCodec: byte isCallBack(org.apache.dubbo.common.URL,java.lang.String,java.lang.String,int)>($r26, $r4, $r3, i0) 
(assert true)
(define-const var3092 (Array Int var3382) (getArguments/91264090 var2996)) ; Statement: $r24 = virtualinvoke r0.<org.apache.dubbo.rpc.RpcInvocation: java.lang.Object[] getArguments()>() 
(assert true)
(define-const var1437 (Array Int ClassObject) (getParameterTypes/1177367737 var2996)) ; Statement: $r25 = virtualinvoke r0.<org.apache.dubbo.rpc.RpcInvocation: java.lang.Class[] getParameterTypes()>() 
(define-const var3315 Int (cast-from-Int-to-Int var3322)) ; Statement: $i2 = (int) $b1 
 ; Statement: lookupswitch($i2) {     case 1: goto $r27 = new java.lang.StringBuilder;     case 2: goto $r28 = new java.lang.StringBuilder;     default: goto $r23 = $r24[i0]; } 
(assert (and (= var3315 2) (and (not (= var3315 1)) true))) ; Intersect: Cond: $i2 == 2  and Intersect: Negate: Cond: $i2 == 1   and Non Conditional  
(define-const var1176 String String-init) ; Statement: $r28 = new java.lang.StringBuilder 
(assert true)
;(assert (<init>/1968657023 var1176)) ; Statement: specialinvoke $r28.<java.lang.StringBuilder: void <init>()>() 
(declare-const var1176!1 String)
(assert (= var1176!1 ""))
(assert true)
(define-const var458 String (append/672562846 var1176!1 "sys_callback_arg-")) ; Statement: $r6 = virtualinvoke $r28.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("sys_callback_arg-") 
(declare-const var1176!2 String)
(assert (= var1176!2 (str.++ var1176!1 "sys_callback_arg-")))
(assert true)
(define-const var4 String (append/-1001720160 var458 var592)) ; Statement: $r7 = virtualinvoke $r6.<java.lang.StringBuilder: java.lang.StringBuilder append(int)>(i0) 
(declare-const var458!1 String)
(assert (str.prefixof var458 var458!1))
(assert true)
(define-const var2718 String (toString/-2075883882 var4)) ; Statement: $r14 = virtualinvoke $r7.<java.lang.StringBuilder: java.lang.String toString()>() 
(define-const var3309 ClassObject (select var1437 var592)) ; Statement: $r10 = $r25[i0] 
(define-const var887 var3382 (select var3092 var592)) ; Statement: $r11 = $r24[i0] 
(define-const var93 var676 (var676_valueOf/1602327315 (ite (= 1 0) true false))) ; Statement: $r12 = staticinvoke <java.lang.Boolean: java.lang.Boolean valueOf(boolean)>(0) 
(assert true)
(define-const var1649 String (exportOrUnexportCallbackService/-2059280590 var3647 var2771 var2996 var2442 var3309 var887 var93)) ; Statement: $r13 = specialinvoke r8.<org.apache.dubbo.rpc.protocol.dubbo.CallbackServiceCodec: java.lang.String exportOrUnexportCallbackService(org.apache.dubbo.remoting.Channel,org.apache.dubbo.rpc.RpcInvocation,org.apache.dubbo.common.URL,java.lang.Class,java.lang.Object,java.lang.Boolean)>(r9, r0, $r26, $r10, $r11, $r12) 
(assert true)
;(assert (setAttachment/548019834 var2996 var2718 var1649)) ; Statement: virtualinvoke r0.<org.apache.dubbo.rpc.RpcInvocation: void setAttachment(java.lang.String,java.lang.String)>($r14, $r13) 

(declare-const var2996!1 var914)
(declare-const var2718!1 String)
(declare-const var1649!1 String)
 ; Statement: return null 
(check-sat)
; {getInvoker/-2049196212=([org.apache.dubbo.rpc.RpcInvocation], org.apache.dubbo.rpc.Invoker), getProtocolServiceKey/-1744514792=([org.apache.dubbo.rpc.RpcInvocation], java.lang.String), var2580_getMethodName/-516674313=([org.apache.dubbo.rpc.Invocation], java.lang.String), cast-from-var914-to-var2565=([org.apache.dubbo.rpc.RpcInvocation], org.apache.dubbo.rpc.Invocation), var3407_isCallBack/-1919732310=([org.apache.dubbo.common.URL, java.lang.String, java.lang.String, int], byte), getArguments/91264090=([org.apache.dubbo.rpc.RpcInvocation], java.lang.Object[]), getParameterTypes/1177367737=([org.apache.dubbo.rpc.RpcInvocation], java.lang.Class[]), cast-from-Int-to-Int=([byte], int), String-init=([], java.lang.StringBuilder), <init>/1968657023=([java.lang.StringBuilder], void), append/672562846=([java.lang.StringBuilder, java.lang.String], java.lang.StringBuilder), append/-1001720160=([java.lang.StringBuilder, int], java.lang.StringBuilder), toString/-2075883882=([java.lang.StringBuilder], java.lang.String), var676_valueOf/1602327315=([boolean], java.lang.Boolean), exportOrUnexportCallbackService/-2059280590=([org.apache.dubbo.rpc.protocol.dubbo.CallbackServiceCodec, org.apache.dubbo.remoting.Channel, org.apache.dubbo.rpc.RpcInvocation, org.apache.dubbo.common.URL, java.lang.Class, java.lang.Object, java.lang.Boolean], java.lang.String), setAttachment/548019834=([org.apache.dubbo.rpc.RpcInvocation, java.lang.String, java.lang.String], void)}
; {var3407=org.apache.dubbo.rpc.protocol.dubbo.CallbackServiceCodec, var3647=r8, var2885=org.apache.dubbo.remoting.Channel, var2771=r9, var914=org.apache.dubbo.rpc.RpcInvocation, var2996=r0, var592=i0, var1136=org.apache.dubbo.rpc.Invoker, var2468=$r1, var1747=org.apache.dubbo.common.URL, var2442=$r26, var2722=$r4, var2580=org.apache.dubbo.rpc.support.RpcUtils, var2565=org.apache.dubbo.rpc.Invocation, var3166=$r3, var3322=$b1, var3382=java.lang.Object, var3092=$r24, var1437=$r25, var3315=$i2, var1176=$r28, var458=$r6, var4=$r7, var2718=$r14, var3309=$r10, var887=$r11, var676=java.lang.Boolean, var93=$r12, var1649=$r13}
; {org.apache.dubbo.rpc.protocol.dubbo.CallbackServiceCodec=var3407, r8=var3647, org.apache.dubbo.remoting.Channel=var2885, r9=var2771, org.apache.dubbo.rpc.RpcInvocation=var914, r0=var2996, i0=var592, org.apache.dubbo.rpc.Invoker=var1136, $r1=var2468, org.apache.dubbo.common.URL=var1747, $r26=var2442, $r4=var2722, org.apache.dubbo.rpc.support.RpcUtils=var2580, org.apache.dubbo.rpc.Invocation=var2565, $r3=var3166, $b1=var3322, java.lang.Object=var3382, $r24=var3092, $r25=var1437, $i2=var3315, $r28=var1176, $r6=var458, $r7=var4, $r14=var2718, $r10=var3309, $r11=var887, java.lang.Boolean=var676, $r12=var93, $r13=var1649}
;seq <java.lang.StringBuilder: void <init>()>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(int)>;	<java.lang.StringBuilder: java.lang.String toString()>
;cnt {"<java.lang.StringBuilder: void <init>()>": 1,"<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>": 1,"<java.lang.StringBuilder: java.lang.StringBuilder append(int)>": 1,"<java.lang.StringBuilder: java.lang.String toString()>": 1}
;stmts r8 := @this: org.apache.dubbo.rpc.protocol.dubbo.CallbackServiceCodec;	r9 := @parameter0: org.apache.dubbo.remoting.Channel;	r0 := @parameter1: org.apache.dubbo.rpc.RpcInvocation;	i0 := @parameter2: int;	$r1 = virtualinvoke r0.<org.apache.dubbo.rpc.RpcInvocation: org.apache.dubbo.rpc.Invoker getInvoker()>();	if $r1 != null goto $r2 = virtualinvoke r0.<org.apache.dubbo.rpc.RpcInvocation: org.apache.dubbo.rpc.Invoker getInvoker()>();	$r26 = null;	goto [?= $r4 = virtualinvoke r0.<org.apache.dubbo.rpc.RpcInvocation: java.lang.String getProtocolServiceKey()>()];	$r4 = virtualinvoke r0.<org.apache.dubbo.rpc.RpcInvocation: java.lang.String getProtocolServiceKey()>();	$r3 = staticinvoke <org.apache.dubbo.rpc.support.RpcUtils: java.lang.String getMethodName(org.apache.dubbo.rpc.Invocation)>(r0);	$b1 = staticinvoke <org.apache.dubbo.rpc.protocol.dubbo.CallbackServiceCodec: byte isCallBack(org.apache.dubbo.common.URL,java.lang.String,java.lang.String,int)>($r26, $r4, $r3, i0);	$r24 = virtualinvoke r0.<org.apache.dubbo.rpc.RpcInvocation: java.lang.Object[] getArguments()>();	$r25 = virtualinvoke r0.<org.apache.dubbo.rpc.RpcInvocation: java.lang.Class[] getParameterTypes()>();	$i2 = (int) $b1;	lookupswitch($i2) {     case 1: goto $r27 = new java.lang.StringBuilder;     case 2: goto $r28 = new java.lang.StringBuilder;     default: goto $r23 = $r24[i0]; };	$r28 = new java.lang.StringBuilder;	specialinvoke $r28.<java.lang.StringBuilder: void <init>()>();	$r6 = virtualinvoke $r28.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("sys_callback_arg-");	$r7 = virtualinvoke $r6.<java.lang.StringBuilder: java.lang.StringBuilder append(int)>(i0);	$r14 = virtualinvoke $r7.<java.lang.StringBuilder: java.lang.String toString()>();	$r10 = $r25[i0];	$r11 = $r24[i0];	$r12 = staticinvoke <java.lang.Boolean: java.lang.Boolean valueOf(boolean)>(0);	$r13 = specialinvoke r8.<org.apache.dubbo.rpc.protocol.dubbo.CallbackServiceCodec: java.lang.String exportOrUnexportCallbackService(org.apache.dubbo.remoting.Channel,org.apache.dubbo.rpc.RpcInvocation,org.apache.dubbo.common.URL,java.lang.Class,java.lang.Object,java.lang.Boolean)>(r9, r0, $r26, $r10, $r11, $r12);	virtualinvoke r0.<org.apache.dubbo.rpc.RpcInvocation: void setAttachment(java.lang.String,java.lang.String)>($r14, $r13);	return null
;block_num 4