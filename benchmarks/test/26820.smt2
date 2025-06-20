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

(declare-sort var3542 0)
(declare-sort var1234 0)
(declare-sort var1672 0)
(declare-sort var999 0)
(declare-sort var3147 0)
(declare-sort var2547 0)
(declare-sort var1109 0)
(declare-sort var2578 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun isQuiteException/-322664486 (var3542 var1672) Bool)
(declare-fun var3147_isDebugEnabled/-823448366 (var3147) Bool)
(declare-fun cast-from-var999-to-var3147 (var999) var3147)
(declare-fun arr-var2547-init () (Array Int var2547))
(declare-fun var1234_channel/-1990826581 (var1234) var1109)
(declare-fun cast-from-var1109-to-var2547 (var1109) var2547)
(declare-fun String_format/1339386452 (String (Array Int var2547)) String)
(declare-fun var3147_debug/-407276736 (var3147 String var1672) void)
(declare-fun var1234_close/780824979 (var1234) var2578)
(declare-const null-var3542 var3542)
(declare-const null-var1234 var1234)
(declare-const null-var1672 var1672)
(declare-const var3542-logger var999)
(declare-const null-__Array__Int__var2547__ (Array Int var2547))
(declare-const var3887 var3542) ; Statement: r0 := @this: org.apache.dubbo.rpc.protocol.tri.transport.TripleServerConnectionHandler 
(assert (not (= var3887 null-var3542)))
(declare-const var1474 var1234) ; Statement: r3 := @parameter0: io.netty.channel.ChannelHandlerContext 
(assert (not (= var1474 null-var1234)))
(declare-const var3363 var1672) ; Statement: r1 := @parameter1: java.lang.Throwable 
(assert (not (= var3363 null-var1672)))
(assert true)
(define-const var356 Bool (isQuiteException/-322664486 var3887 var3363)) ; Statement: $z0 = specialinvoke r0.<org.apache.dubbo.rpc.protocol.tri.transport.TripleServerConnectionHandler: boolean isQuiteException(java.lang.Throwable)>(r1) 
 ; Statement: if $z0 == 0 goto $r4 = <org.apache.dubbo.rpc.protocol.tri.transport.TripleServerConnectionHandler: org.apache.dubbo.common.logger.ErrorTypeAwareLogger logger> 
(assert (not (= (ite var356 1 0) 0))) ; Negate: Cond: $z0 == 0  
(define-const var2832 var999 var3542-logger) ; Statement: $r7 = <org.apache.dubbo.rpc.protocol.tri.transport.TripleServerConnectionHandler: org.apache.dubbo.common.logger.ErrorTypeAwareLogger logger> 
(define-const var1403 Bool (var3147_isDebugEnabled/-823448366 (cast-from-var999-to-var3147 var2832))) ; Statement: $z1 = interfaceinvoke $r7.<org.apache.dubbo.common.logger.ErrorTypeAwareLogger: boolean isDebugEnabled()>() 
 ; Statement: if $z1 == 0 goto interfaceinvoke r3.<io.netty.channel.ChannelHandlerContext: io.netty.channel.ChannelFuture close()>() 
(assert (not (= (ite var1403 1 0) 0))) ; Negate: Cond: $z1 == 0  
(define-const var2273 var999 var3542-logger) ; Statement: $r9 = <org.apache.dubbo.rpc.protocol.tri.transport.TripleServerConnectionHandler: org.apache.dubbo.common.logger.ErrorTypeAwareLogger logger> 
(define-const var3536 (Array Int var2547) arr-var2547-init) ; Statement: $r8 = newarray (java.lang.Object)[1] 
(define-const var1250 var1109 (var1234_channel/-1990826581 var1474)) ; Statement: $r10 = interfaceinvoke r3.<io.netty.channel.ChannelHandlerContext: io.netty.channel.Channel channel()>() 
(declare-const var3536!1 (Array Int var2547))
(assert (not (= var3536!1 null-__Array__Int__var2547__)))
(assert (= (select var3536!1 0) (cast-from-var1109-to-var2547 var1250))) ; Statement: $r8[0] = $r10 
(define-const var3695 String (String_format/1339386452 "Channel:%s Error" var3536!1)) ; Statement: $r11 = staticinvoke <java.lang.String: java.lang.String format(java.lang.String,java.lang.Object[])>("Channel:%s Error", $r8) 
;(assert (var3147_debug/-407276736 (cast-from-var999-to-var3147 var2273) var3695 var3363)) ; Statement: interfaceinvoke $r9.<org.apache.dubbo.common.logger.ErrorTypeAwareLogger: void debug(java.lang.String,java.lang.Throwable)>($r11, r1) 

(declare-const var2273!1 var999)
(declare-const var3695!1 String)
(declare-const var3363!1 var1672)
 ; Statement: goto [?= interfaceinvoke r3.<io.netty.channel.ChannelHandlerContext: io.netty.channel.ChannelFuture close()>()] 
(assert true) ; Non Conditional
;(assert (var1234_close/780824979 var1474)) ; Statement: interfaceinvoke r3.<io.netty.channel.ChannelHandlerContext: io.netty.channel.ChannelFuture close()>() 

(declare-const var1474!1 var1234)
 ; Statement: return 
(check-sat)
; {isQuiteException/-322664486=([org.apache.dubbo.rpc.protocol.tri.transport.TripleServerConnectionHandler, java.lang.Throwable], boolean), var3147_isDebugEnabled/-823448366=([org.apache.dubbo.common.logger.Logger], boolean), cast-from-var999-to-var3147=([org.apache.dubbo.common.logger.ErrorTypeAwareLogger], org.apache.dubbo.common.logger.Logger), arr-var2547-init=([], java.lang.Object[]), var1234_channel/-1990826581=([io.netty.channel.ChannelHandlerContext], io.netty.channel.Channel), cast-from-var1109-to-var2547=([io.netty.channel.Channel], java.lang.Object), String_format/1339386452=([java.lang.String, java.lang.Object[]], java.lang.String), var3147_debug/-407276736=([org.apache.dubbo.common.logger.Logger, java.lang.String, java.lang.Throwable], void), var1234_close/780824979=([io.netty.channel.ChannelHandlerContext], io.netty.channel.ChannelFuture)}
; {var3542=org.apache.dubbo.rpc.protocol.tri.transport.TripleServerConnectionHandler, var3887=r0, var1234=io.netty.channel.ChannelHandlerContext, var1474=r3, var1672=java.lang.Throwable, var3363=r1, var356=$z0, var999=org.apache.dubbo.common.logger.ErrorTypeAwareLogger, var2832=$r7, var3147=org.apache.dubbo.common.logger.Logger, var1403=$z1, var2273=$r9, var2547=java.lang.Object, var3536=$r8, var1109=io.netty.channel.Channel, var1250=$r10, var3695=$r11, var2578=io.netty.channel.ChannelFuture}
; {org.apache.dubbo.rpc.protocol.tri.transport.TripleServerConnectionHandler=var3542, r0=var3887, io.netty.channel.ChannelHandlerContext=var1234, r3=var1474, java.lang.Throwable=var1672, r1=var3363, $z0=var356, org.apache.dubbo.common.logger.ErrorTypeAwareLogger=var999, $r7=var2832, org.apache.dubbo.common.logger.Logger=var3147, $z1=var1403, $r9=var2273, java.lang.Object=var2547, $r8=var3536, io.netty.channel.Channel=var1109, $r10=var1250, $r11=var3695, io.netty.channel.ChannelFuture=var2578}
;seq <java.lang.String: java.lang.String format(java.lang.String,java.lang.Object[])>
;cnt {"<java.lang.String: java.lang.String format(java.lang.String,java.lang.Object[])>": 1}
;stmts r0 := @this: org.apache.dubbo.rpc.protocol.tri.transport.TripleServerConnectionHandler;	r3 := @parameter0: io.netty.channel.ChannelHandlerContext;	r1 := @parameter1: java.lang.Throwable;	$z0 = specialinvoke r0.<org.apache.dubbo.rpc.protocol.tri.transport.TripleServerConnectionHandler: boolean isQuiteException(java.lang.Throwable)>(r1);	if $z0 == 0 goto $r4 = <org.apache.dubbo.rpc.protocol.tri.transport.TripleServerConnectionHandler: org.apache.dubbo.common.logger.ErrorTypeAwareLogger logger>;	$r7 = <org.apache.dubbo.rpc.protocol.tri.transport.TripleServerConnectionHandler: org.apache.dubbo.common.logger.ErrorTypeAwareLogger logger>;	$z1 = interfaceinvoke $r7.<org.apache.dubbo.common.logger.ErrorTypeAwareLogger: boolean isDebugEnabled()>();	if $z1 == 0 goto interfaceinvoke r3.<io.netty.channel.ChannelHandlerContext: io.netty.channel.ChannelFuture close()>();	$r9 = <org.apache.dubbo.rpc.protocol.tri.transport.TripleServerConnectionHandler: org.apache.dubbo.common.logger.ErrorTypeAwareLogger logger>;	$r8 = newarray (java.lang.Object)[1];	$r10 = interfaceinvoke r3.<io.netty.channel.ChannelHandlerContext: io.netty.channel.Channel channel()>();	$r8[0] = $r10;	$r11 = staticinvoke <java.lang.String: java.lang.String format(java.lang.String,java.lang.Object[])>("Channel:%s Error", $r8);	interfaceinvoke $r9.<org.apache.dubbo.common.logger.ErrorTypeAwareLogger: void debug(java.lang.String,java.lang.Throwable)>($r11, r1);	goto [?= interfaceinvoke r3.<io.netty.channel.ChannelHandlerContext: io.netty.channel.ChannelFuture close()>()];	interfaceinvoke r3.<io.netty.channel.ChannelHandlerContext: io.netty.channel.ChannelFuture close()>();	return
;block_num 4