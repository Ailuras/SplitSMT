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

(declare-sort var2853 0)
(declare-sort var1708 0)
(declare-sort var3078 0)
(declare-sort var1639 0)
(declare-sort var174 0)
(declare-sort var838 0)
(declare-sort var2675 0)
(declare-sort var3979 0)
(declare-sort var1099 0)
(declare-sort var945 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun getInvoker/-2049196212 (var3078) var1639)
(declare-fun var838_getUrl/-275947851 (var838) var174)
(declare-fun cast-from-var1639-to-var838 (var1639) var838)
(declare-fun getProtocolServiceKey/-1744514792 (var3078) String)
(declare-fun var2675_getMethodName/-516674313 (var3979) String)
(declare-fun cast-from-var3078-to-var3979 (var3078) var3979)
(declare-fun var2853_isCallBack/-1919732310 (var174 String String Int) Int)
(declare-fun getArguments/91264090 (var3078) (Array Int var1099))
(declare-fun getParameterTypes/1177367737 (var3078) (Array Int ClassObject))
(define-fun cast-from-Int-to-Int ((arg Int)) Int arg)
(declare-fun String-init () String)
(define-fun <init>/1968657023 () String "")
(define-fun append/672562846 ((s String) (tail String)) String (str.++ s tail))
(define-fun append/-1001720160 ((s String) (tail Int)) String (str.++ s (str.from_int tail)))
(define-fun toString/-2075883882 ((s String)) String s)
(declare-fun var945_valueOf/1602327315 (Bool) var945)
(declare-fun exportOrUnexportCallbackService/-2059280590 (var2853 var1708 var3078 var174 ClassObject var1099 var945) String)
(declare-fun setAttachment/548019834 (var3078 String String) void)
(declare-const null-var2853 var2853)
(declare-const null-var1708 var1708)
(declare-const null-var3078 var3078)
(declare-const null-Int Int)
(declare-const null-var1639 var1639)
(declare-const var1021 var2853) ; Statement: r8 := @this: org.apache.dubbo.rpc.protocol.dubbo.CallbackServiceCodec 
(assert (not (= var1021 null-var2853)))
(declare-const var559 var1708) ; Statement: r9 := @parameter0: org.apache.dubbo.remoting.Channel 
(assert (not (= var559 null-var1708)))
(declare-const var3062 var3078) ; Statement: r0 := @parameter1: org.apache.dubbo.rpc.RpcInvocation 
(assert (not (= var3062 null-var3078)))
(declare-const var3961 Int) ; Statement: i0 := @parameter2: int 
(assert (not (= var3961 null-Int)))
(assert true)
(define-const var493 var1639 (getInvoker/-2049196212 var3062)) ; Statement: $r1 = virtualinvoke r0.<org.apache.dubbo.rpc.RpcInvocation: org.apache.dubbo.rpc.Invoker getInvoker()>() 
 ; Statement: if $r1 != null goto $r2 = virtualinvoke r0.<org.apache.dubbo.rpc.RpcInvocation: org.apache.dubbo.rpc.Invoker getInvoker()>() 
(assert (not (= var493 null-var1639))) ; Cond: $r1 != null 
(assert true)
(define-const var2567 var1639 (getInvoker/-2049196212 var3062)) ; Statement: $r2 = virtualinvoke r0.<org.apache.dubbo.rpc.RpcInvocation: org.apache.dubbo.rpc.Invoker getInvoker()>() 
(define-const var2416 var174 (var838_getUrl/-275947851 (cast-from-var1639-to-var838 var2567))) ; Statement: $r26 = interfaceinvoke $r2.<org.apache.dubbo.rpc.Invoker: org.apache.dubbo.common.URL getUrl()>() 
(assert true) ; Non Conditional
(assert true)
(define-const var3425 String (getProtocolServiceKey/-1744514792 var3062)) ; Statement: $r4 = virtualinvoke r0.<org.apache.dubbo.rpc.RpcInvocation: java.lang.String getProtocolServiceKey()>() 
(define-const var2500 String (var2675_getMethodName/-516674313 (cast-from-var3078-to-var3979 var3062))) ; Statement: $r3 = staticinvoke <org.apache.dubbo.rpc.support.RpcUtils: java.lang.String getMethodName(org.apache.dubbo.rpc.Invocation)>(r0) 
(define-const var2228 Int (var2853_isCallBack/-1919732310 var2416 var3425 var2500 var3961)) ; Statement: $b1 = staticinvoke <org.apache.dubbo.rpc.protocol.dubbo.CallbackServiceCodec: byte isCallBack(org.apache.dubbo.common.URL,java.lang.String,java.lang.String,int)>($r26, $r4, $r3, i0) 
(assert true)
(define-const var2535 (Array Int var1099) (getArguments/91264090 var3062)) ; Statement: $r24 = virtualinvoke r0.<org.apache.dubbo.rpc.RpcInvocation: java.lang.Object[] getArguments()>() 
(assert true)
(define-const var627 (Array Int ClassObject) (getParameterTypes/1177367737 var3062)) ; Statement: $r25 = virtualinvoke r0.<org.apache.dubbo.rpc.RpcInvocation: java.lang.Class[] getParameterTypes()>() 
(define-const var3220 Int (cast-from-Int-to-Int var2228)) ; Statement: $i2 = (int) $b1 
 ; Statement: lookupswitch($i2) {     case 1: goto $r27 = new java.lang.StringBuilder;     case 2: goto $r28 = new java.lang.StringBuilder;     default: goto $r23 = $r24[i0]; } 
(assert (and (= var3220 2) (and (not (= var3220 1)) true))) ; Intersect: Cond: $i2 == 2  and Intersect: Negate: Cond: $i2 == 1   and Non Conditional  
(define-const var2799 String String-init) ; Statement: $r28 = new java.lang.StringBuilder 
(assert true)
;(assert (<init>/1968657023 var2799)) ; Statement: specialinvoke $r28.<java.lang.StringBuilder: void <init>()>() 
(declare-const var2799!1 String)
(assert (= var2799!1 ""))
(assert true)
(define-const var11 String (append/672562846 var2799!1 "sys_callback_arg-")) ; Statement: $r6 = virtualinvoke $r28.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("sys_callback_arg-") 
(declare-const var2799!2 String)
(assert (= var2799!2 (str.++ var2799!1 "sys_callback_arg-")))
(assert true)
(define-const var3073 String (append/-1001720160 var11 var3961)) ; Statement: $r7 = virtualinvoke $r6.<java.lang.StringBuilder: java.lang.StringBuilder append(int)>(i0) 
(declare-const var11!1 String)
(assert (str.prefixof var11 var11!1))
(assert true)
(define-const var3833 String (toString/-2075883882 var3073)) ; Statement: $r14 = virtualinvoke $r7.<java.lang.StringBuilder: java.lang.String toString()>() 
(define-const var994 ClassObject (select var627 var3961)) ; Statement: $r10 = $r25[i0] 
(define-const var1894 var1099 (select var2535 var3961)) ; Statement: $r11 = $r24[i0] 
(define-const var205 var945 (var945_valueOf/1602327315 (ite (= 1 0) true false))) ; Statement: $r12 = staticinvoke <java.lang.Boolean: java.lang.Boolean valueOf(boolean)>(0) 
(assert true)
(define-const var104 String (exportOrUnexportCallbackService/-2059280590 var1021 var559 var3062 var2416 var994 var1894 var205)) ; Statement: $r13 = specialinvoke r8.<org.apache.dubbo.rpc.protocol.dubbo.CallbackServiceCodec: java.lang.String exportOrUnexportCallbackService(org.apache.dubbo.remoting.Channel,org.apache.dubbo.rpc.RpcInvocation,org.apache.dubbo.common.URL,java.lang.Class,java.lang.Object,java.lang.Boolean)>(r9, r0, $r26, $r10, $r11, $r12) 
(assert true)
;(assert (setAttachment/548019834 var3062 var3833 var104)) ; Statement: virtualinvoke r0.<org.apache.dubbo.rpc.RpcInvocation: void setAttachment(java.lang.String,java.lang.String)>($r14, $r13) 

(declare-const var3062!1 var3078)
(declare-const var3833!1 String)
(declare-const var104!1 String)
 ; Statement: return null 
(check-sat)
; {getInvoker/-2049196212=([org.apache.dubbo.rpc.RpcInvocation], org.apache.dubbo.rpc.Invoker), var838_getUrl/-275947851=([org.apache.dubbo.common.Node], org.apache.dubbo.common.URL), cast-from-var1639-to-var838=([org.apache.dubbo.rpc.Invoker], org.apache.dubbo.common.Node), getProtocolServiceKey/-1744514792=([org.apache.dubbo.rpc.RpcInvocation], java.lang.String), var2675_getMethodName/-516674313=([org.apache.dubbo.rpc.Invocation], java.lang.String), cast-from-var3078-to-var3979=([org.apache.dubbo.rpc.RpcInvocation], org.apache.dubbo.rpc.Invocation), var2853_isCallBack/-1919732310=([org.apache.dubbo.common.URL, java.lang.String, java.lang.String, int], byte), getArguments/91264090=([org.apache.dubbo.rpc.RpcInvocation], java.lang.Object[]), getParameterTypes/1177367737=([org.apache.dubbo.rpc.RpcInvocation], java.lang.Class[]), cast-from-Int-to-Int=([byte], int), String-init=([], java.lang.StringBuilder), <init>/1968657023=([java.lang.StringBuilder], void), append/672562846=([java.lang.StringBuilder, java.lang.String], java.lang.StringBuilder), append/-1001720160=([java.lang.StringBuilder, int], java.lang.StringBuilder), toString/-2075883882=([java.lang.StringBuilder], java.lang.String), var945_valueOf/1602327315=([boolean], java.lang.Boolean), exportOrUnexportCallbackService/-2059280590=([org.apache.dubbo.rpc.protocol.dubbo.CallbackServiceCodec, org.apache.dubbo.remoting.Channel, org.apache.dubbo.rpc.RpcInvocation, org.apache.dubbo.common.URL, java.lang.Class, java.lang.Object, java.lang.Boolean], java.lang.String), setAttachment/548019834=([org.apache.dubbo.rpc.RpcInvocation, java.lang.String, java.lang.String], void)}
; {var2853=org.apache.dubbo.rpc.protocol.dubbo.CallbackServiceCodec, var1021=r8, var1708=org.apache.dubbo.remoting.Channel, var559=r9, var3078=org.apache.dubbo.rpc.RpcInvocation, var3062=r0, var3961=i0, var1639=org.apache.dubbo.rpc.Invoker, var493=$r1, var2567=$r2, var174=org.apache.dubbo.common.URL, var838=org.apache.dubbo.common.Node, var2416=$r26, var3425=$r4, var2675=org.apache.dubbo.rpc.support.RpcUtils, var3979=org.apache.dubbo.rpc.Invocation, var2500=$r3, var2228=$b1, var1099=java.lang.Object, var2535=$r24, var627=$r25, var3220=$i2, var2799=$r28, var11=$r6, var3073=$r7, var3833=$r14, var994=$r10, var1894=$r11, var945=java.lang.Boolean, var205=$r12, var104=$r13}
; {org.apache.dubbo.rpc.protocol.dubbo.CallbackServiceCodec=var2853, r8=var1021, org.apache.dubbo.remoting.Channel=var1708, r9=var559, org.apache.dubbo.rpc.RpcInvocation=var3078, r0=var3062, i0=var3961, org.apache.dubbo.rpc.Invoker=var1639, $r1=var493, $r2=var2567, org.apache.dubbo.common.URL=var174, org.apache.dubbo.common.Node=var838, $r26=var2416, $r4=var3425, org.apache.dubbo.rpc.support.RpcUtils=var2675, org.apache.dubbo.rpc.Invocation=var3979, $r3=var2500, $b1=var2228, java.lang.Object=var1099, $r24=var2535, $r25=var627, $i2=var3220, $r28=var2799, $r6=var11, $r7=var3073, $r14=var3833, $r10=var994, $r11=var1894, java.lang.Boolean=var945, $r12=var205, $r13=var104}
;seq <java.lang.StringBuilder: void <init>()>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(int)>;	<java.lang.StringBuilder: java.lang.String toString()>
;cnt {"<java.lang.StringBuilder: void <init>()>": 1,"<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>": 1,"<java.lang.StringBuilder: java.lang.StringBuilder append(int)>": 1,"<java.lang.StringBuilder: java.lang.String toString()>": 1}
;stmts r8 := @this: org.apache.dubbo.rpc.protocol.dubbo.CallbackServiceCodec;	r9 := @parameter0: org.apache.dubbo.remoting.Channel;	r0 := @parameter1: org.apache.dubbo.rpc.RpcInvocation;	i0 := @parameter2: int;	$r1 = virtualinvoke r0.<org.apache.dubbo.rpc.RpcInvocation: org.apache.dubbo.rpc.Invoker getInvoker()>();	if $r1 != null goto $r2 = virtualinvoke r0.<org.apache.dubbo.rpc.RpcInvocation: org.apache.dubbo.rpc.Invoker getInvoker()>();	$r2 = virtualinvoke r0.<org.apache.dubbo.rpc.RpcInvocation: org.apache.dubbo.rpc.Invoker getInvoker()>();	$r26 = interfaceinvoke $r2.<org.apache.dubbo.rpc.Invoker: org.apache.dubbo.common.URL getUrl()>();	$r4 = virtualinvoke r0.<org.apache.dubbo.rpc.RpcInvocation: java.lang.String getProtocolServiceKey()>();	$r3 = staticinvoke <org.apache.dubbo.rpc.support.RpcUtils: java.lang.String getMethodName(org.apache.dubbo.rpc.Invocation)>(r0);	$b1 = staticinvoke <org.apache.dubbo.rpc.protocol.dubbo.CallbackServiceCodec: byte isCallBack(org.apache.dubbo.common.URL,java.lang.String,java.lang.String,int)>($r26, $r4, $r3, i0);	$r24 = virtualinvoke r0.<org.apache.dubbo.rpc.RpcInvocation: java.lang.Object[] getArguments()>();	$r25 = virtualinvoke r0.<org.apache.dubbo.rpc.RpcInvocation: java.lang.Class[] getParameterTypes()>();	$i2 = (int) $b1;	lookupswitch($i2) {     case 1: goto $r27 = new java.lang.StringBuilder;     case 2: goto $r28 = new java.lang.StringBuilder;     default: goto $r23 = $r24[i0]; };	$r28 = new java.lang.StringBuilder;	specialinvoke $r28.<java.lang.StringBuilder: void <init>()>();	$r6 = virtualinvoke $r28.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("sys_callback_arg-");	$r7 = virtualinvoke $r6.<java.lang.StringBuilder: java.lang.StringBuilder append(int)>(i0);	$r14 = virtualinvoke $r7.<java.lang.StringBuilder: java.lang.String toString()>();	$r10 = $r25[i0];	$r11 = $r24[i0];	$r12 = staticinvoke <java.lang.Boolean: java.lang.Boolean valueOf(boolean)>(0);	$r13 = specialinvoke r8.<org.apache.dubbo.rpc.protocol.dubbo.CallbackServiceCodec: java.lang.String exportOrUnexportCallbackService(org.apache.dubbo.remoting.Channel,org.apache.dubbo.rpc.RpcInvocation,org.apache.dubbo.common.URL,java.lang.Class,java.lang.Object,java.lang.Boolean)>(r9, r0, $r26, $r10, $r11, $r12);	virtualinvoke r0.<org.apache.dubbo.rpc.RpcInvocation: void setAttachment(java.lang.String,java.lang.String)>($r14, $r13);	return null
;block_num 4