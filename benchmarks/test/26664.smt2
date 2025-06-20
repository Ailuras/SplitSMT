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

(declare-sort var129 0)
(declare-sort var915 0)
(declare-sort var3186 0)
(declare-sort var2179 0)
(declare-sort var2596 0)
(declare-sort var1661 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun String-init () String)
(define-fun <init>/1968657023 () String "")
(define-fun append/672562846 ((s String) (tail String)) String (str.++ s tail))
(declare-fun var3186_errorCode/387601846 (var3186) Int)
(declare-fun append/-901862667 (String Int) String)
(define-fun toString/-2075883882 ((s String)) String s)
(declare-fun var2179_warn/1431914100 (var2179 String String String String) void)
(declare-fun transportListener/-1461522527 (var129) var2596)
(declare-fun var2596_cancelByRemote/58321284 (var2596 Int) void)
(declare-fun var915_close/780824979 (var915) var1661)
(declare-const null-var129 var129)
(declare-const null-var915 var915)
(declare-const null-var3186 var3186)
(declare-const var129-LOGGER var2179)
(declare-const var1011 var129) ; Statement: r6 := @this: org.apache.dubbo.rpc.protocol.tri.transport.TripleHttp2ClientResponseHandler 
(assert (not (= var1011 null-var129)))
(declare-const var2359 var915) ; Statement: r8 := @parameter0: io.netty.channel.ChannelHandlerContext 
(assert (not (= var2359 null-var915)))
(declare-const var3138 var3186) ; Statement: r2 := @parameter1: io.netty.handler.codec.http2.Http2ResetFrame 
(assert (not (= var3138 null-var3186)))
(define-const var3554 var2179 var129-LOGGER) ; Statement: $r1 = <org.apache.dubbo.rpc.protocol.tri.transport.TripleHttp2ClientResponseHandler: org.apache.dubbo.common.logger.ErrorTypeAwareLogger LOGGER> 
(define-const var3946 String String-init) ; Statement: $r0 = new java.lang.StringBuilder 
(assert true)
;(assert (<init>/1968657023 var3946)) ; Statement: specialinvoke $r0.<java.lang.StringBuilder: void <init>()>() 
(declare-const var3946!1 String)
(assert (= var3946!1 ""))
(assert true)
(define-const var3630 String (append/672562846 var3946!1 "Triple Client received remote reset errorCode=")) ; Statement: $r3 = virtualinvoke $r0.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("Triple Client received remote reset errorCode=") 
(declare-const var3946!2 String)
(assert (= var3946!2 (str.++ var3946!1 "Triple Client received remote reset errorCode=")))
(define-const var2007 Int (var3186_errorCode/387601846 var3138)) ; Statement: $l0 = interfaceinvoke r2.<io.netty.handler.codec.http2.Http2ResetFrame: long errorCode()>() 
(assert true)
(define-const var1515 String (append/-901862667 var3630 var2007)) ; Statement: $r4 = virtualinvoke $r3.<java.lang.StringBuilder: java.lang.StringBuilder append(long)>($l0) 
(declare-const var3630!1 String)
(assert (str.prefixof var3630 var3630!1))
(assert true)
(define-const var2516 String (toString/-2075883882 var1515)) ; Statement: $r5 = virtualinvoke $r4.<java.lang.StringBuilder: java.lang.String toString()>() 
;(assert (var2179_warn/1431914100 var3554 "4-10" "" "" var2516)) ; Statement: interfaceinvoke $r1.<org.apache.dubbo.common.logger.ErrorTypeAwareLogger: void warn(java.lang.String,java.lang.String,java.lang.String,java.lang.String)>("4-10", "", "", $r5) 

(declare-const var3554!1 var2179)
(declare-const var690 String)
(declare-const var2501 String)
(declare-const var2501!1 String)
(declare-const var2516!1 String)
(define-const var3420 var2596 (transportListener/-1461522527 var1011)) ; Statement: $r7 = r6.<org.apache.dubbo.rpc.protocol.tri.transport.TripleHttp2ClientResponseHandler: org.apache.dubbo.rpc.protocol.tri.transport.H2TransportListener transportListener> 
(define-const var2662 Int (var3186_errorCode/387601846 var3138)) ; Statement: $l1 = interfaceinvoke r2.<io.netty.handler.codec.http2.Http2ResetFrame: long errorCode()>() 
;(assert (var2596_cancelByRemote/58321284 var3420 var2662)) ; Statement: interfaceinvoke $r7.<org.apache.dubbo.rpc.protocol.tri.transport.H2TransportListener: void cancelByRemote(long)>($l1) 

(declare-const var3420!1 var2596)
(declare-const var2662!1 Int)
;(assert (var915_close/780824979 var2359)) ; Statement: interfaceinvoke r8.<io.netty.channel.ChannelHandlerContext: io.netty.channel.ChannelFuture close()>() 

(declare-const var2359!1 var915)
 ; Statement: return 
(check-sat)
; {String-init=([], java.lang.StringBuilder), <init>/1968657023=([java.lang.StringBuilder], void), append/672562846=([java.lang.StringBuilder, java.lang.String], java.lang.StringBuilder), var3186_errorCode/387601846=([io.netty.handler.codec.http2.Http2ResetFrame], long), append/-901862667=([java.lang.StringBuilder, long], java.lang.StringBuilder), toString/-2075883882=([java.lang.StringBuilder], java.lang.String), var2179_warn/1431914100=([org.apache.dubbo.common.logger.ErrorTypeAwareLogger, java.lang.String, java.lang.String, java.lang.String, java.lang.String], void), transportListener/-1461522527=([org.apache.dubbo.rpc.protocol.tri.transport.TripleHttp2ClientResponseHandler], org.apache.dubbo.rpc.protocol.tri.transport.H2TransportListener), var2596_cancelByRemote/58321284=([org.apache.dubbo.rpc.protocol.tri.transport.H2TransportListener, long], void), var915_close/780824979=([io.netty.channel.ChannelHandlerContext], io.netty.channel.ChannelFuture)}
; {var129=org.apache.dubbo.rpc.protocol.tri.transport.TripleHttp2ClientResponseHandler, var1011=r6, var915=io.netty.channel.ChannelHandlerContext, var2359=r8, var3186=io.netty.handler.codec.http2.Http2ResetFrame, var3138=r2, var2179=org.apache.dubbo.common.logger.ErrorTypeAwareLogger, var3554=$r1, var3946=$r0, var3630=$r3, var2007=$l0, var1515=$r4, var2516=$r5, var690="4-10", var2501="", var2596=org.apache.dubbo.rpc.protocol.tri.transport.H2TransportListener, var3420=$r7, var2662=$l1, var1661=io.netty.channel.ChannelFuture}
; {org.apache.dubbo.rpc.protocol.tri.transport.TripleHttp2ClientResponseHandler=var129, r6=var1011, io.netty.channel.ChannelHandlerContext=var915, r8=var2359, io.netty.handler.codec.http2.Http2ResetFrame=var3186, r2=var3138, org.apache.dubbo.common.logger.ErrorTypeAwareLogger=var2179, $r1=var3554, $r0=var3946, $r3=var3630, $l0=var2007, $r4=var1515, $r5=var2516, "4-10"=var690, ""=var2501, org.apache.dubbo.rpc.protocol.tri.transport.H2TransportListener=var2596, $r7=var3420, $l1=var2662, io.netty.channel.ChannelFuture=var1661}
;seq <java.lang.StringBuilder: void <init>()>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(long)>;	<java.lang.StringBuilder: java.lang.String toString()>
;cnt {"<java.lang.StringBuilder: void <init>()>": 1,"<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>": 1,"<java.lang.StringBuilder: java.lang.StringBuilder append(long)>": 1,"<java.lang.StringBuilder: java.lang.String toString()>": 1}
;stmts r6 := @this: org.apache.dubbo.rpc.protocol.tri.transport.TripleHttp2ClientResponseHandler;	r8 := @parameter0: io.netty.channel.ChannelHandlerContext;	r2 := @parameter1: io.netty.handler.codec.http2.Http2ResetFrame;	$r1 = <org.apache.dubbo.rpc.protocol.tri.transport.TripleHttp2ClientResponseHandler: org.apache.dubbo.common.logger.ErrorTypeAwareLogger LOGGER>;	$r0 = new java.lang.StringBuilder;	specialinvoke $r0.<java.lang.StringBuilder: void <init>()>();	$r3 = virtualinvoke $r0.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("Triple Client received remote reset errorCode=");	$l0 = interfaceinvoke r2.<io.netty.handler.codec.http2.Http2ResetFrame: long errorCode()>();	$r4 = virtualinvoke $r3.<java.lang.StringBuilder: java.lang.StringBuilder append(long)>($l0);	$r5 = virtualinvoke $r4.<java.lang.StringBuilder: java.lang.String toString()>();	interfaceinvoke $r1.<org.apache.dubbo.common.logger.ErrorTypeAwareLogger: void warn(java.lang.String,java.lang.String,java.lang.String,java.lang.String)>("4-10", "", "", $r5);	$r7 = r6.<org.apache.dubbo.rpc.protocol.tri.transport.TripleHttp2ClientResponseHandler: org.apache.dubbo.rpc.protocol.tri.transport.H2TransportListener transportListener>;	$l1 = interfaceinvoke r2.<io.netty.handler.codec.http2.Http2ResetFrame: long errorCode()>();	interfaceinvoke $r7.<org.apache.dubbo.rpc.protocol.tri.transport.H2TransportListener: void cancelByRemote(long)>($l1);	interfaceinvoke r8.<io.netty.channel.ChannelHandlerContext: io.netty.channel.ChannelFuture close()>();	return
;block_num 1