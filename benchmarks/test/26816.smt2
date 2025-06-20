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

(declare-sort var1189 0)
(declare-sort var3694 0)
(declare-sort var3436 0)
(declare-sort var1394 0)
(declare-sort var3787 0)
(declare-sort var2288 0)
(declare-sort var1744 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun isQuiteException/-322664486 (var1189 var3436) Bool)
(declare-fun arr-var3787-init () (Array Int var3787))
(declare-fun var3694_channel/-1990826581 (var3694) var2288)
(declare-fun cast-from-var2288-to-var3787 (var2288) var3787)
(declare-fun String_format/1339386452 (String (Array Int var3787)) String)
(declare-fun var1394_warn/126438324 (var1394 String String String String var3436) void)
(declare-fun var3694_close/780824979 (var3694) var1744)
(declare-const null-var1189 var1189)
(declare-const null-var3694 var3694)
(declare-const null-var3436 var3436)
(declare-const var1189-logger var1394)
(declare-const null-__Array__Int__var3787__ (Array Int var3787))
(declare-const var3431 var1189) ; Statement: r0 := @this: org.apache.dubbo.rpc.protocol.tri.transport.TripleServerConnectionHandler 
(assert (not (= var3431 null-var1189)))
(declare-const var2626 var3694) ; Statement: r3 := @parameter0: io.netty.channel.ChannelHandlerContext 
(assert (not (= var2626 null-var3694)))
(declare-const var2035 var3436) ; Statement: r1 := @parameter1: java.lang.Throwable 
(assert (not (= var2035 null-var3436)))
(assert true)
(define-const var2484 Bool (isQuiteException/-322664486 var3431 var2035)) ; Statement: $z0 = specialinvoke r0.<org.apache.dubbo.rpc.protocol.tri.transport.TripleServerConnectionHandler: boolean isQuiteException(java.lang.Throwable)>(r1) 
 ; Statement: if $z0 == 0 goto $r4 = <org.apache.dubbo.rpc.protocol.tri.transport.TripleServerConnectionHandler: org.apache.dubbo.common.logger.ErrorTypeAwareLogger logger> 
(assert (= (ite var2484 1 0) 0)) ; Cond: $z0 == 0 
(define-const var587 var1394 var1189-logger) ; Statement: $r4 = <org.apache.dubbo.rpc.protocol.tri.transport.TripleServerConnectionHandler: org.apache.dubbo.common.logger.ErrorTypeAwareLogger logger> 
(define-const var3509 (Array Int var3787) arr-var3787-init) ; Statement: $r2 = newarray (java.lang.Object)[1] 
(define-const var174 var2288 (var3694_channel/-1990826581 var2626)) ; Statement: $r5 = interfaceinvoke r3.<io.netty.channel.ChannelHandlerContext: io.netty.channel.Channel channel()>() 
(declare-const var3509!1 (Array Int var3787))
(assert (not (= var3509!1 null-__Array__Int__var3787__)))
(assert (= (select var3509!1 0) (cast-from-var2288-to-var3787 var174))) ; Statement: $r2[0] = $r5 
(define-const var1642 String (String_format/1339386452 "Channel:%s Error" var3509!1)) ; Statement: $r6 = staticinvoke <java.lang.String: java.lang.String format(java.lang.String,java.lang.Object[])>("Channel:%s Error", $r2) 
;(assert (var1394_warn/126438324 var587 "4-14" "" "" var1642 var2035)) ; Statement: interfaceinvoke $r4.<org.apache.dubbo.common.logger.ErrorTypeAwareLogger: void warn(java.lang.String,java.lang.String,java.lang.String,java.lang.String,java.lang.Throwable)>("4-14", "", "", $r6, r1) 

(declare-const var587!1 var1394)
(declare-const var48 String)
(declare-const var2683 String)
(declare-const var2683!1 String)
(declare-const var1642!1 String)
(declare-const var2035!1 var3436)
(assert true) ; Non Conditional
;(assert (var3694_close/780824979 var2626)) ; Statement: interfaceinvoke r3.<io.netty.channel.ChannelHandlerContext: io.netty.channel.ChannelFuture close()>() 

(declare-const var2626!1 var3694)
 ; Statement: return 
(check-sat)
; {isQuiteException/-322664486=([org.apache.dubbo.rpc.protocol.tri.transport.TripleServerConnectionHandler, java.lang.Throwable], boolean), arr-var3787-init=([], java.lang.Object[]), var3694_channel/-1990826581=([io.netty.channel.ChannelHandlerContext], io.netty.channel.Channel), cast-from-var2288-to-var3787=([io.netty.channel.Channel], java.lang.Object), String_format/1339386452=([java.lang.String, java.lang.Object[]], java.lang.String), var1394_warn/126438324=([org.apache.dubbo.common.logger.ErrorTypeAwareLogger, java.lang.String, java.lang.String, java.lang.String, java.lang.String, java.lang.Throwable], void), var3694_close/780824979=([io.netty.channel.ChannelHandlerContext], io.netty.channel.ChannelFuture)}
; {var1189=org.apache.dubbo.rpc.protocol.tri.transport.TripleServerConnectionHandler, var3431=r0, var3694=io.netty.channel.ChannelHandlerContext, var2626=r3, var3436=java.lang.Throwable, var2035=r1, var2484=$z0, var1394=org.apache.dubbo.common.logger.ErrorTypeAwareLogger, var587=$r4, var3787=java.lang.Object, var3509=$r2, var2288=io.netty.channel.Channel, var174=$r5, var1642=$r6, var48="4-14", var2683="", var1744=io.netty.channel.ChannelFuture}
; {org.apache.dubbo.rpc.protocol.tri.transport.TripleServerConnectionHandler=var1189, r0=var3431, io.netty.channel.ChannelHandlerContext=var3694, r3=var2626, java.lang.Throwable=var3436, r1=var2035, $z0=var2484, org.apache.dubbo.common.logger.ErrorTypeAwareLogger=var1394, $r4=var587, java.lang.Object=var3787, $r2=var3509, io.netty.channel.Channel=var2288, $r5=var174, $r6=var1642, "4-14"=var48, ""=var2683, io.netty.channel.ChannelFuture=var1744}
;seq <java.lang.String: java.lang.String format(java.lang.String,java.lang.Object[])>
;cnt {"<java.lang.String: java.lang.String format(java.lang.String,java.lang.Object[])>": 1}
;stmts r0 := @this: org.apache.dubbo.rpc.protocol.tri.transport.TripleServerConnectionHandler;	r3 := @parameter0: io.netty.channel.ChannelHandlerContext;	r1 := @parameter1: java.lang.Throwable;	$z0 = specialinvoke r0.<org.apache.dubbo.rpc.protocol.tri.transport.TripleServerConnectionHandler: boolean isQuiteException(java.lang.Throwable)>(r1);	if $z0 == 0 goto $r4 = <org.apache.dubbo.rpc.protocol.tri.transport.TripleServerConnectionHandler: org.apache.dubbo.common.logger.ErrorTypeAwareLogger logger>;	$r4 = <org.apache.dubbo.rpc.protocol.tri.transport.TripleServerConnectionHandler: org.apache.dubbo.common.logger.ErrorTypeAwareLogger logger>;	$r2 = newarray (java.lang.Object)[1];	$r5 = interfaceinvoke r3.<io.netty.channel.ChannelHandlerContext: io.netty.channel.Channel channel()>();	$r2[0] = $r5;	$r6 = staticinvoke <java.lang.String: java.lang.String format(java.lang.String,java.lang.Object[])>("Channel:%s Error", $r2);	interfaceinvoke $r4.<org.apache.dubbo.common.logger.ErrorTypeAwareLogger: void warn(java.lang.String,java.lang.String,java.lang.String,java.lang.String,java.lang.Throwable)>("4-14", "", "", $r6, r1);	interfaceinvoke r3.<io.netty.channel.ChannelHandlerContext: io.netty.channel.ChannelFuture close()>();	return
;block_num 3