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

(declare-sort var1881 0)
(declare-sort var3319 0)
(declare-sort var327 0)
(declare-sort var417 0)
(declare-sort var1641 0)
(declare-sort var2820 0)
(declare-sort var3788 0)
(declare-sort var1484 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun getInvoker/-2049196212 (var327) var417)
(declare-fun getProtocolServiceKey/-1744514792 (var327) String)
(declare-fun var2820_getMethodName/-516674313 (var3788) String)
(declare-fun cast-from-var327-to-var3788 (var327) var3788)
(declare-fun var1881_isCallBack/-1919732310 (var1641 String String Int) Int)
(declare-fun getArguments/91264090 (var327) (Array Int var1484))
(declare-fun getParameterTypes/1177367737 (var327) (Array Int ClassObject))
(define-fun cast-from-Int-to-Int ((arg Int)) Int arg)
(declare-const null-var1881 var1881)
(declare-const null-var3319 var3319)
(declare-const null-var327 var327)
(declare-const null-Int Int)
(declare-const null-var417 var417)
(declare-const null-var1641 var1641)
(declare-const var744 var1881) ; Statement: r8 := @this: org.apache.dubbo.rpc.protocol.dubbo.CallbackServiceCodec 
(assert (not (= var744 null-var1881)))
(declare-const var871 var3319) ; Statement: r9 := @parameter0: org.apache.dubbo.remoting.Channel 
(assert (not (= var871 null-var3319)))
(declare-const var2336 var327) ; Statement: r0 := @parameter1: org.apache.dubbo.rpc.RpcInvocation 
(assert (not (= var2336 null-var327)))
(declare-const var1847 Int) ; Statement: i0 := @parameter2: int 
(assert (not (= var1847 null-Int)))
(assert true)
(define-const var2062 var417 (getInvoker/-2049196212 var2336)) ; Statement: $r1 = virtualinvoke r0.<org.apache.dubbo.rpc.RpcInvocation: org.apache.dubbo.rpc.Invoker getInvoker()>() 
 ; Statement: if $r1 != null goto $r2 = virtualinvoke r0.<org.apache.dubbo.rpc.RpcInvocation: org.apache.dubbo.rpc.Invoker getInvoker()>() 
(assert (not (not (= var2062 null-var417)))) ; Negate: Cond: $r1 != null  
(define-const var2697 var1641 null-var1641) ; Statement: $r26 = null 
 ; Statement: goto [?= $r4 = virtualinvoke r0.<org.apache.dubbo.rpc.RpcInvocation: java.lang.String getProtocolServiceKey()>()] 
(assert true) ; Non Conditional
(assert true)
(define-const var2984 String (getProtocolServiceKey/-1744514792 var2336)) ; Statement: $r4 = virtualinvoke r0.<org.apache.dubbo.rpc.RpcInvocation: java.lang.String getProtocolServiceKey()>() 
(define-const var1178 String (var2820_getMethodName/-516674313 (cast-from-var327-to-var3788 var2336))) ; Statement: $r3 = staticinvoke <org.apache.dubbo.rpc.support.RpcUtils: java.lang.String getMethodName(org.apache.dubbo.rpc.Invocation)>(r0) 
(define-const var3013 Int (var1881_isCallBack/-1919732310 var2697 var2984 var1178 var1847)) ; Statement: $b1 = staticinvoke <org.apache.dubbo.rpc.protocol.dubbo.CallbackServiceCodec: byte isCallBack(org.apache.dubbo.common.URL,java.lang.String,java.lang.String,int)>($r26, $r4, $r3, i0) 
(assert true)
(define-const var235 (Array Int var1484) (getArguments/91264090 var2336)) ; Statement: $r24 = virtualinvoke r0.<org.apache.dubbo.rpc.RpcInvocation: java.lang.Object[] getArguments()>() 
(assert true)
(define-const var628 (Array Int ClassObject) (getParameterTypes/1177367737 var2336)) ; Statement: $r25 = virtualinvoke r0.<org.apache.dubbo.rpc.RpcInvocation: java.lang.Class[] getParameterTypes()>() 
(define-const var1531 Int (cast-from-Int-to-Int var3013)) ; Statement: $i2 = (int) $b1 
 ; Statement: lookupswitch($i2) {     case 1: goto $r27 = new java.lang.StringBuilder;     case 2: goto $r28 = new java.lang.StringBuilder;     default: goto $r23 = $r24[i0]; } 
(assert (and (not (= var1531 2)) (and (not (= var1531 1)) true))) ; Intersect: Negate: Cond: $i2 == 2   and Intersect: Negate: Cond: $i2 == 1   and Non Conditional  
(define-const var392 var1484 (select var235 var1847)) ; Statement: $r23 = $r24[i0] 
 ; Statement: return $r23 
(check-sat)
; {getInvoker/-2049196212=([org.apache.dubbo.rpc.RpcInvocation], org.apache.dubbo.rpc.Invoker), getProtocolServiceKey/-1744514792=([org.apache.dubbo.rpc.RpcInvocation], java.lang.String), var2820_getMethodName/-516674313=([org.apache.dubbo.rpc.Invocation], java.lang.String), cast-from-var327-to-var3788=([org.apache.dubbo.rpc.RpcInvocation], org.apache.dubbo.rpc.Invocation), var1881_isCallBack/-1919732310=([org.apache.dubbo.common.URL, java.lang.String, java.lang.String, int], byte), getArguments/91264090=([org.apache.dubbo.rpc.RpcInvocation], java.lang.Object[]), getParameterTypes/1177367737=([org.apache.dubbo.rpc.RpcInvocation], java.lang.Class[]), cast-from-Int-to-Int=([byte], int)}
; {var1881=org.apache.dubbo.rpc.protocol.dubbo.CallbackServiceCodec, var744=r8, var3319=org.apache.dubbo.remoting.Channel, var871=r9, var327=org.apache.dubbo.rpc.RpcInvocation, var2336=r0, var1847=i0, var417=org.apache.dubbo.rpc.Invoker, var2062=$r1, var1641=org.apache.dubbo.common.URL, var2697=$r26, var2984=$r4, var2820=org.apache.dubbo.rpc.support.RpcUtils, var3788=org.apache.dubbo.rpc.Invocation, var1178=$r3, var3013=$b1, var1484=java.lang.Object, var235=$r24, var628=$r25, var1531=$i2, var392=$r23}
; {org.apache.dubbo.rpc.protocol.dubbo.CallbackServiceCodec=var1881, r8=var744, org.apache.dubbo.remoting.Channel=var3319, r9=var871, org.apache.dubbo.rpc.RpcInvocation=var327, r0=var2336, i0=var1847, org.apache.dubbo.rpc.Invoker=var417, $r1=var2062, org.apache.dubbo.common.URL=var1641, $r26=var2697, $r4=var2984, org.apache.dubbo.rpc.support.RpcUtils=var2820, org.apache.dubbo.rpc.Invocation=var3788, $r3=var1178, $b1=var3013, java.lang.Object=var1484, $r24=var235, $r25=var628, $i2=var1531, $r23=var392}
;seq 
;cnt {}
;stmts r8 := @this: org.apache.dubbo.rpc.protocol.dubbo.CallbackServiceCodec;	r9 := @parameter0: org.apache.dubbo.remoting.Channel;	r0 := @parameter1: org.apache.dubbo.rpc.RpcInvocation;	i0 := @parameter2: int;	$r1 = virtualinvoke r0.<org.apache.dubbo.rpc.RpcInvocation: org.apache.dubbo.rpc.Invoker getInvoker()>();	if $r1 != null goto $r2 = virtualinvoke r0.<org.apache.dubbo.rpc.RpcInvocation: org.apache.dubbo.rpc.Invoker getInvoker()>();	$r26 = null;	goto [?= $r4 = virtualinvoke r0.<org.apache.dubbo.rpc.RpcInvocation: java.lang.String getProtocolServiceKey()>()];	$r4 = virtualinvoke r0.<org.apache.dubbo.rpc.RpcInvocation: java.lang.String getProtocolServiceKey()>();	$r3 = staticinvoke <org.apache.dubbo.rpc.support.RpcUtils: java.lang.String getMethodName(org.apache.dubbo.rpc.Invocation)>(r0);	$b1 = staticinvoke <org.apache.dubbo.rpc.protocol.dubbo.CallbackServiceCodec: byte isCallBack(org.apache.dubbo.common.URL,java.lang.String,java.lang.String,int)>($r26, $r4, $r3, i0);	$r24 = virtualinvoke r0.<org.apache.dubbo.rpc.RpcInvocation: java.lang.Object[] getArguments()>();	$r25 = virtualinvoke r0.<org.apache.dubbo.rpc.RpcInvocation: java.lang.Class[] getParameterTypes()>();	$i2 = (int) $b1;	lookupswitch($i2) {     case 1: goto $r27 = new java.lang.StringBuilder;     case 2: goto $r28 = new java.lang.StringBuilder;     default: goto $r23 = $r24[i0]; };	$r23 = $r24[i0];	return $r23
;block_num 4