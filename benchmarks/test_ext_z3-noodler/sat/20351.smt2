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

(declare-sort var2304 0)
(declare-sort var1602 0)
(declare-sort var653 0)
(declare-sort var3810 0)
(declare-sort var565 0)
(declare-sort var1768 0)
(declare-sort var3872 0)
(declare-sort var1041 0)
(declare-sort var570 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun getInvoker/-2049196212 (var653) var3810)
(declare-fun var1768_getUrl/-275947851 (var1768) var565)
(declare-fun cast-from-var3810-to-var1768 (var3810) var1768)
(declare-fun getProtocolServiceKey/-1744514792 (var653) String)
(declare-fun var3872_getMethodName/-516674313 (var1041) String)
(declare-fun cast-from-var653-to-var1041 (var653) var1041)
(declare-fun var2304_isCallBack/-1919732310 (var565 String String Int) Int)
(declare-fun getArguments/91264090 (var653) (Array Int var570))
(declare-fun getParameterTypes/1177367737 (var653) (Array Int ClassObject))
(define-fun cast-from-Int-to-Int ((arg Int)) Int arg)
(declare-const null-var2304 var2304)
(declare-const null-var1602 var1602)
(declare-const null-var653 var653)
(declare-const null-Int Int)
(declare-const null-var3810 var3810)
(declare-const var2615 var2304) ; Statement: r8 := @this: org.apache.dubbo.rpc.protocol.dubbo.CallbackServiceCodec 
(assert (not (= var2615 null-var2304)))
(declare-const var3506 var1602) ; Statement: r9 := @parameter0: org.apache.dubbo.remoting.Channel 
(assert (not (= var3506 null-var1602)))
(declare-const var2647 var653) ; Statement: r0 := @parameter1: org.apache.dubbo.rpc.RpcInvocation 
(assert (not (= var2647 null-var653)))
(declare-const var460 Int) ; Statement: i0 := @parameter2: int 
(assert (not (= var460 null-Int)))
(assert true)
(define-const var1912 var3810 (getInvoker/-2049196212 var2647)) ; Statement: $r1 = virtualinvoke r0.<org.apache.dubbo.rpc.RpcInvocation: org.apache.dubbo.rpc.Invoker getInvoker()>() 
 ; Statement: if $r1 != null goto $r2 = virtualinvoke r0.<org.apache.dubbo.rpc.RpcInvocation: org.apache.dubbo.rpc.Invoker getInvoker()>() 
(assert (not (= var1912 null-var3810))) ; Cond: $r1 != null 
(assert true)
(define-const var1717 var3810 (getInvoker/-2049196212 var2647)) ; Statement: $r2 = virtualinvoke r0.<org.apache.dubbo.rpc.RpcInvocation: org.apache.dubbo.rpc.Invoker getInvoker()>() 
(define-const var2482 var565 (var1768_getUrl/-275947851 (cast-from-var3810-to-var1768 var1717))) ; Statement: $r26 = interfaceinvoke $r2.<org.apache.dubbo.rpc.Invoker: org.apache.dubbo.common.URL getUrl()>() 
(assert true) ; Non Conditional
(assert true)
(define-const var1015 String (getProtocolServiceKey/-1744514792 var2647)) ; Statement: $r4 = virtualinvoke r0.<org.apache.dubbo.rpc.RpcInvocation: java.lang.String getProtocolServiceKey()>() 
(define-const var208 String (var3872_getMethodName/-516674313 (cast-from-var653-to-var1041 var2647))) ; Statement: $r3 = staticinvoke <org.apache.dubbo.rpc.support.RpcUtils: java.lang.String getMethodName(org.apache.dubbo.rpc.Invocation)>(r0) 
(define-const var890 Int (var2304_isCallBack/-1919732310 var2482 var1015 var208 var460)) ; Statement: $b1 = staticinvoke <org.apache.dubbo.rpc.protocol.dubbo.CallbackServiceCodec: byte isCallBack(org.apache.dubbo.common.URL,java.lang.String,java.lang.String,int)>($r26, $r4, $r3, i0) 
(assert true)
(define-const var2320 (Array Int var570) (getArguments/91264090 var2647)) ; Statement: $r24 = virtualinvoke r0.<org.apache.dubbo.rpc.RpcInvocation: java.lang.Object[] getArguments()>() 
(assert true)
(define-const var3729 (Array Int ClassObject) (getParameterTypes/1177367737 var2647)) ; Statement: $r25 = virtualinvoke r0.<org.apache.dubbo.rpc.RpcInvocation: java.lang.Class[] getParameterTypes()>() 
(define-const var744 Int (cast-from-Int-to-Int var890)) ; Statement: $i2 = (int) $b1 
 ; Statement: lookupswitch($i2) {     case 1: goto $r27 = new java.lang.StringBuilder;     case 2: goto $r28 = new java.lang.StringBuilder;     default: goto $r23 = $r24[i0]; } 
(assert (and (not (= var744 2)) (and (not (= var744 1)) true))) ; Intersect: Negate: Cond: $i2 == 2   and Intersect: Negate: Cond: $i2 == 1   and Non Conditional  
(define-const var1219 var570 (select var2320 var460)) ; Statement: $r23 = $r24[i0] 
 ; Statement: return $r23 
(check-sat)
; {getInvoker/-2049196212=([org.apache.dubbo.rpc.RpcInvocation], org.apache.dubbo.rpc.Invoker), var1768_getUrl/-275947851=([org.apache.dubbo.common.Node], org.apache.dubbo.common.URL), cast-from-var3810-to-var1768=([org.apache.dubbo.rpc.Invoker], org.apache.dubbo.common.Node), getProtocolServiceKey/-1744514792=([org.apache.dubbo.rpc.RpcInvocation], java.lang.String), var3872_getMethodName/-516674313=([org.apache.dubbo.rpc.Invocation], java.lang.String), cast-from-var653-to-var1041=([org.apache.dubbo.rpc.RpcInvocation], org.apache.dubbo.rpc.Invocation), var2304_isCallBack/-1919732310=([org.apache.dubbo.common.URL, java.lang.String, java.lang.String, int], byte), getArguments/91264090=([org.apache.dubbo.rpc.RpcInvocation], java.lang.Object[]), getParameterTypes/1177367737=([org.apache.dubbo.rpc.RpcInvocation], java.lang.Class[]), cast-from-Int-to-Int=([byte], int)}
; {var2304=org.apache.dubbo.rpc.protocol.dubbo.CallbackServiceCodec, var2615=r8, var1602=org.apache.dubbo.remoting.Channel, var3506=r9, var653=org.apache.dubbo.rpc.RpcInvocation, var2647=r0, var460=i0, var3810=org.apache.dubbo.rpc.Invoker, var1912=$r1, var1717=$r2, var565=org.apache.dubbo.common.URL, var1768=org.apache.dubbo.common.Node, var2482=$r26, var1015=$r4, var3872=org.apache.dubbo.rpc.support.RpcUtils, var1041=org.apache.dubbo.rpc.Invocation, var208=$r3, var890=$b1, var570=java.lang.Object, var2320=$r24, var3729=$r25, var744=$i2, var1219=$r23}
; {org.apache.dubbo.rpc.protocol.dubbo.CallbackServiceCodec=var2304, r8=var2615, org.apache.dubbo.remoting.Channel=var1602, r9=var3506, org.apache.dubbo.rpc.RpcInvocation=var653, r0=var2647, i0=var460, org.apache.dubbo.rpc.Invoker=var3810, $r1=var1912, $r2=var1717, org.apache.dubbo.common.URL=var565, org.apache.dubbo.common.Node=var1768, $r26=var2482, $r4=var1015, org.apache.dubbo.rpc.support.RpcUtils=var3872, org.apache.dubbo.rpc.Invocation=var1041, $r3=var208, $b1=var890, java.lang.Object=var570, $r24=var2320, $r25=var3729, $i2=var744, $r23=var1219}
;seq 
;cnt {}
;stmts r8 := @this: org.apache.dubbo.rpc.protocol.dubbo.CallbackServiceCodec;	r9 := @parameter0: org.apache.dubbo.remoting.Channel;	r0 := @parameter1: org.apache.dubbo.rpc.RpcInvocation;	i0 := @parameter2: int;	$r1 = virtualinvoke r0.<org.apache.dubbo.rpc.RpcInvocation: org.apache.dubbo.rpc.Invoker getInvoker()>();	if $r1 != null goto $r2 = virtualinvoke r0.<org.apache.dubbo.rpc.RpcInvocation: org.apache.dubbo.rpc.Invoker getInvoker()>();	$r2 = virtualinvoke r0.<org.apache.dubbo.rpc.RpcInvocation: org.apache.dubbo.rpc.Invoker getInvoker()>();	$r26 = interfaceinvoke $r2.<org.apache.dubbo.rpc.Invoker: org.apache.dubbo.common.URL getUrl()>();	$r4 = virtualinvoke r0.<org.apache.dubbo.rpc.RpcInvocation: java.lang.String getProtocolServiceKey()>();	$r3 = staticinvoke <org.apache.dubbo.rpc.support.RpcUtils: java.lang.String getMethodName(org.apache.dubbo.rpc.Invocation)>(r0);	$b1 = staticinvoke <org.apache.dubbo.rpc.protocol.dubbo.CallbackServiceCodec: byte isCallBack(org.apache.dubbo.common.URL,java.lang.String,java.lang.String,int)>($r26, $r4, $r3, i0);	$r24 = virtualinvoke r0.<org.apache.dubbo.rpc.RpcInvocation: java.lang.Object[] getArguments()>();	$r25 = virtualinvoke r0.<org.apache.dubbo.rpc.RpcInvocation: java.lang.Class[] getParameterTypes()>();	$i2 = (int) $b1;	lookupswitch($i2) {     case 1: goto $r27 = new java.lang.StringBuilder;     case 2: goto $r28 = new java.lang.StringBuilder;     default: goto $r23 = $r24[i0]; };	$r23 = $r24[i0];	return $r23
;block_num 4