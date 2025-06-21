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

(declare-sort var1441 0)
(declare-sort var983 0)
(declare-sort var3009 0)
(declare-sort var142 0)
(declare-sort var1888 0)
(declare-sort var3485 0)
(declare-sort var287 0)
(declare-sort var3025 0)
(declare-sort var1108 0)
(declare-sort var1024 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun getInvoker/-2049196212 (var3009) var142)
(declare-fun var3485_getUrl/-275947851 (var3485) var1888)
(declare-fun cast-from-var142-to-var3485 (var142) var3485)
(declare-fun getProtocolServiceKey/-1744514792 (var3009) String)
(declare-fun var287_getMethodName/-516674313 (var3025) String)
(declare-fun cast-from-var3009-to-var3025 (var3009) var3025)
(declare-fun var1441_isCallBack/-1919732310 (var1888 String String Int) Int)
(declare-fun getArguments/91264090 (var3009) (Array Int var1108))
(declare-fun getParameterTypes/1177367737 (var3009) (Array Int ClassObject))
(define-fun cast-from-Int-to-Int ((arg Int)) Int arg)
(declare-fun String-init () String)
(define-fun <init>/1968657023 () String "")
(define-fun append/672562846 ((s String) (tail String)) String (str.++ s tail))
(define-fun append/-1001720160 ((s String) (tail Int)) String (str.++ s (str.from_int tail)))
(define-fun toString/-2075883882 ((s String)) String s)
(declare-fun var1024_valueOf/1602327315 (Bool) var1024)
(declare-fun exportOrUnexportCallbackService/-2059280590 (var1441 var983 var3009 var1888 ClassObject var1108 var1024) String)
(declare-fun setAttachment/548019834 (var3009 String String) void)
(declare-const null-var1441 var1441)
(declare-const null-var983 var983)
(declare-const null-var3009 var3009)
(declare-const null-Int Int)
(declare-const null-var142 var142)
(declare-const var1097 var1441) ; Statement: r8 := @this: org.apache.dubbo.rpc.protocol.dubbo.CallbackServiceCodec 
(assert (not (= var1097 null-var1441)))
(declare-const var2011 var983) ; Statement: r9 := @parameter0: org.apache.dubbo.remoting.Channel 
(assert (not (= var2011 null-var983)))
(declare-const var2538 var3009) ; Statement: r0 := @parameter1: org.apache.dubbo.rpc.RpcInvocation 
(assert (not (= var2538 null-var3009)))
(declare-const var1344 Int) ; Statement: i0 := @parameter2: int 
(assert (not (= var1344 null-Int)))
(assert true)
(define-const var1521 var142 (getInvoker/-2049196212 var2538)) ; Statement: $r1 = virtualinvoke r0.<org.apache.dubbo.rpc.RpcInvocation: org.apache.dubbo.rpc.Invoker getInvoker()>() 
 ; Statement: if $r1 != null goto $r2 = virtualinvoke r0.<org.apache.dubbo.rpc.RpcInvocation: org.apache.dubbo.rpc.Invoker getInvoker()>() 
(assert (not (= var1521 null-var142))) ; Cond: $r1 != null 
(assert true)
(define-const var2097 var142 (getInvoker/-2049196212 var2538)) ; Statement: $r2 = virtualinvoke r0.<org.apache.dubbo.rpc.RpcInvocation: org.apache.dubbo.rpc.Invoker getInvoker()>() 
(define-const var381 var1888 (var3485_getUrl/-275947851 (cast-from-var142-to-var3485 var2097))) ; Statement: $r26 = interfaceinvoke $r2.<org.apache.dubbo.rpc.Invoker: org.apache.dubbo.common.URL getUrl()>() 
(assert true) ; Non Conditional
(assert true)
(define-const var121 String (getProtocolServiceKey/-1744514792 var2538)) ; Statement: $r4 = virtualinvoke r0.<org.apache.dubbo.rpc.RpcInvocation: java.lang.String getProtocolServiceKey()>() 
(define-const var2336 String (var287_getMethodName/-516674313 (cast-from-var3009-to-var3025 var2538))) ; Statement: $r3 = staticinvoke <org.apache.dubbo.rpc.support.RpcUtils: java.lang.String getMethodName(org.apache.dubbo.rpc.Invocation)>(r0) 
(define-const var437 Int (var1441_isCallBack/-1919732310 var381 var121 var2336 var1344)) ; Statement: $b1 = staticinvoke <org.apache.dubbo.rpc.protocol.dubbo.CallbackServiceCodec: byte isCallBack(org.apache.dubbo.common.URL,java.lang.String,java.lang.String,int)>($r26, $r4, $r3, i0) 
(assert true)
(define-const var2434 (Array Int var1108) (getArguments/91264090 var2538)) ; Statement: $r24 = virtualinvoke r0.<org.apache.dubbo.rpc.RpcInvocation: java.lang.Object[] getArguments()>() 
(assert true)
(define-const var2246 (Array Int ClassObject) (getParameterTypes/1177367737 var2538)) ; Statement: $r25 = virtualinvoke r0.<org.apache.dubbo.rpc.RpcInvocation: java.lang.Class[] getParameterTypes()>() 
(define-const var2666 Int (cast-from-Int-to-Int var437)) ; Statement: $i2 = (int) $b1 
 ; Statement: lookupswitch($i2) {     case 1: goto $r27 = new java.lang.StringBuilder;     case 2: goto $r28 = new java.lang.StringBuilder;     default: goto $r23 = $r24[i0]; } 
(assert (and (= var2666 1) true)) ; Intersect: Cond: $i2 == 1  and Non Conditional 
(define-const var1043 String String-init) ; Statement: $r27 = new java.lang.StringBuilder 
(assert true)
;(assert (<init>/1968657023 var1043)) ; Statement: specialinvoke $r27.<java.lang.StringBuilder: void <init>()>() 
(declare-const var1043!1 String)
(assert (= var1043!1 ""))
(assert true)
(define-const var2694 String (append/672562846 var1043!1 "sys_callback_arg-")) ; Statement: $r16 = virtualinvoke $r27.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("sys_callback_arg-") 
(declare-const var1043!2 String)
(assert (= var1043!2 (str.++ var1043!1 "sys_callback_arg-")))
(assert true)
(define-const var2049 String (append/-1001720160 var2694 var1344)) ; Statement: $r17 = virtualinvoke $r16.<java.lang.StringBuilder: java.lang.StringBuilder append(int)>(i0) 
(declare-const var2694!1 String)
(assert (str.prefixof var2694 var2694!1))
(assert true)
(define-const var2637 String (toString/-2075883882 var2049)) ; Statement: $r22 = virtualinvoke $r17.<java.lang.StringBuilder: java.lang.String toString()>() 
(define-const var3296 ClassObject (select var2246 var1344)) ; Statement: $r18 = $r25[i0] 
(define-const var1752 var1108 (select var2434 var1344)) ; Statement: $r19 = $r24[i0] 
(define-const var857 var1024 (var1024_valueOf/1602327315 (ite (= 1 1) true false))) ; Statement: $r20 = staticinvoke <java.lang.Boolean: java.lang.Boolean valueOf(boolean)>(1) 
(assert true)
(define-const var1481 String (exportOrUnexportCallbackService/-2059280590 var1097 var2011 var2538 var381 var3296 var1752 var857)) ; Statement: $r21 = specialinvoke r8.<org.apache.dubbo.rpc.protocol.dubbo.CallbackServiceCodec: java.lang.String exportOrUnexportCallbackService(org.apache.dubbo.remoting.Channel,org.apache.dubbo.rpc.RpcInvocation,org.apache.dubbo.common.URL,java.lang.Class,java.lang.Object,java.lang.Boolean)>(r9, r0, $r26, $r18, $r19, $r20) 
(assert true)
;(assert (setAttachment/548019834 var2538 var2637 var1481)) ; Statement: virtualinvoke r0.<org.apache.dubbo.rpc.RpcInvocation: void setAttachment(java.lang.String,java.lang.String)>($r22, $r21) 

(declare-const var2538!1 var3009)
(declare-const var2637!1 String)
(declare-const var1481!1 String)
 ; Statement: return null 
(check-sat)
; {getInvoker/-2049196212=([org.apache.dubbo.rpc.RpcInvocation], org.apache.dubbo.rpc.Invoker), var3485_getUrl/-275947851=([org.apache.dubbo.common.Node], org.apache.dubbo.common.URL), cast-from-var142-to-var3485=([org.apache.dubbo.rpc.Invoker], org.apache.dubbo.common.Node), getProtocolServiceKey/-1744514792=([org.apache.dubbo.rpc.RpcInvocation], java.lang.String), var287_getMethodName/-516674313=([org.apache.dubbo.rpc.Invocation], java.lang.String), cast-from-var3009-to-var3025=([org.apache.dubbo.rpc.RpcInvocation], org.apache.dubbo.rpc.Invocation), var1441_isCallBack/-1919732310=([org.apache.dubbo.common.URL, java.lang.String, java.lang.String, int], byte), getArguments/91264090=([org.apache.dubbo.rpc.RpcInvocation], java.lang.Object[]), getParameterTypes/1177367737=([org.apache.dubbo.rpc.RpcInvocation], java.lang.Class[]), cast-from-Int-to-Int=([byte], int), String-init=([], java.lang.StringBuilder), <init>/1968657023=([java.lang.StringBuilder], void), append/672562846=([java.lang.StringBuilder, java.lang.String], java.lang.StringBuilder), append/-1001720160=([java.lang.StringBuilder, int], java.lang.StringBuilder), toString/-2075883882=([java.lang.StringBuilder], java.lang.String), var1024_valueOf/1602327315=([boolean], java.lang.Boolean), exportOrUnexportCallbackService/-2059280590=([org.apache.dubbo.rpc.protocol.dubbo.CallbackServiceCodec, org.apache.dubbo.remoting.Channel, org.apache.dubbo.rpc.RpcInvocation, org.apache.dubbo.common.URL, java.lang.Class, java.lang.Object, java.lang.Boolean], java.lang.String), setAttachment/548019834=([org.apache.dubbo.rpc.RpcInvocation, java.lang.String, java.lang.String], void)}
; {var1441=org.apache.dubbo.rpc.protocol.dubbo.CallbackServiceCodec, var1097=r8, var983=org.apache.dubbo.remoting.Channel, var2011=r9, var3009=org.apache.dubbo.rpc.RpcInvocation, var2538=r0, var1344=i0, var142=org.apache.dubbo.rpc.Invoker, var1521=$r1, var2097=$r2, var1888=org.apache.dubbo.common.URL, var3485=org.apache.dubbo.common.Node, var381=$r26, var121=$r4, var287=org.apache.dubbo.rpc.support.RpcUtils, var3025=org.apache.dubbo.rpc.Invocation, var2336=$r3, var437=$b1, var1108=java.lang.Object, var2434=$r24, var2246=$r25, var2666=$i2, var1043=$r27, var2694=$r16, var2049=$r17, var2637=$r22, var3296=$r18, var1752=$r19, var1024=java.lang.Boolean, var857=$r20, var1481=$r21}
; {org.apache.dubbo.rpc.protocol.dubbo.CallbackServiceCodec=var1441, r8=var1097, org.apache.dubbo.remoting.Channel=var983, r9=var2011, org.apache.dubbo.rpc.RpcInvocation=var3009, r0=var2538, i0=var1344, org.apache.dubbo.rpc.Invoker=var142, $r1=var1521, $r2=var2097, org.apache.dubbo.common.URL=var1888, org.apache.dubbo.common.Node=var3485, $r26=var381, $r4=var121, org.apache.dubbo.rpc.support.RpcUtils=var287, org.apache.dubbo.rpc.Invocation=var3025, $r3=var2336, $b1=var437, java.lang.Object=var1108, $r24=var2434, $r25=var2246, $i2=var2666, $r27=var1043, $r16=var2694, $r17=var2049, $r22=var2637, $r18=var3296, $r19=var1752, java.lang.Boolean=var1024, $r20=var857, $r21=var1481}
;seq <java.lang.StringBuilder: void <init>()>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(int)>;	<java.lang.StringBuilder: java.lang.String toString()>
;cnt {"<java.lang.StringBuilder: void <init>()>": 1,"<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>": 1,"<java.lang.StringBuilder: java.lang.StringBuilder append(int)>": 1,"<java.lang.StringBuilder: java.lang.String toString()>": 1}
;stmts r8 := @this: org.apache.dubbo.rpc.protocol.dubbo.CallbackServiceCodec;	r9 := @parameter0: org.apache.dubbo.remoting.Channel;	r0 := @parameter1: org.apache.dubbo.rpc.RpcInvocation;	i0 := @parameter2: int;	$r1 = virtualinvoke r0.<org.apache.dubbo.rpc.RpcInvocation: org.apache.dubbo.rpc.Invoker getInvoker()>();	if $r1 != null goto $r2 = virtualinvoke r0.<org.apache.dubbo.rpc.RpcInvocation: org.apache.dubbo.rpc.Invoker getInvoker()>();	$r2 = virtualinvoke r0.<org.apache.dubbo.rpc.RpcInvocation: org.apache.dubbo.rpc.Invoker getInvoker()>();	$r26 = interfaceinvoke $r2.<org.apache.dubbo.rpc.Invoker: org.apache.dubbo.common.URL getUrl()>();	$r4 = virtualinvoke r0.<org.apache.dubbo.rpc.RpcInvocation: java.lang.String getProtocolServiceKey()>();	$r3 = staticinvoke <org.apache.dubbo.rpc.support.RpcUtils: java.lang.String getMethodName(org.apache.dubbo.rpc.Invocation)>(r0);	$b1 = staticinvoke <org.apache.dubbo.rpc.protocol.dubbo.CallbackServiceCodec: byte isCallBack(org.apache.dubbo.common.URL,java.lang.String,java.lang.String,int)>($r26, $r4, $r3, i0);	$r24 = virtualinvoke r0.<org.apache.dubbo.rpc.RpcInvocation: java.lang.Object[] getArguments()>();	$r25 = virtualinvoke r0.<org.apache.dubbo.rpc.RpcInvocation: java.lang.Class[] getParameterTypes()>();	$i2 = (int) $b1;	lookupswitch($i2) {     case 1: goto $r27 = new java.lang.StringBuilder;     case 2: goto $r28 = new java.lang.StringBuilder;     default: goto $r23 = $r24[i0]; };	$r27 = new java.lang.StringBuilder;	specialinvoke $r27.<java.lang.StringBuilder: void <init>()>();	$r16 = virtualinvoke $r27.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("sys_callback_arg-");	$r17 = virtualinvoke $r16.<java.lang.StringBuilder: java.lang.StringBuilder append(int)>(i0);	$r22 = virtualinvoke $r17.<java.lang.StringBuilder: java.lang.String toString()>();	$r18 = $r25[i0];	$r19 = $r24[i0];	$r20 = staticinvoke <java.lang.Boolean: java.lang.Boolean valueOf(boolean)>(1);	$r21 = specialinvoke r8.<org.apache.dubbo.rpc.protocol.dubbo.CallbackServiceCodec: java.lang.String exportOrUnexportCallbackService(org.apache.dubbo.remoting.Channel,org.apache.dubbo.rpc.RpcInvocation,org.apache.dubbo.common.URL,java.lang.Class,java.lang.Object,java.lang.Boolean)>(r9, r0, $r26, $r18, $r19, $r20);	virtualinvoke r0.<org.apache.dubbo.rpc.RpcInvocation: void setAttachment(java.lang.String,java.lang.String)>($r22, $r21);	return null
;block_num 4