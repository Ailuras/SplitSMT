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

(declare-sort var3158 0)
(declare-sort var204 0)
(declare-sort var3639 0)
(declare-sort var265 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun userEventTriggered/47672626 (var265 var204 var3639) void)
(declare-fun cast-from-var3158-to-var265 (var3158) var265)
(declare-const null-var3158 var3158)
(declare-const null-var204 var204)
(declare-const null-var3639 var3639)
(declare-const var2328 var3158) ; Statement: r0 := @this: org.apache.dubbo.rpc.protocol.tri.transport.TripleHttp2ClientResponseHandler 
(assert (not (= var2328 null-var3158)))
(declare-const var1184 var204) ; Statement: r1 := @parameter0: io.netty.channel.ChannelHandlerContext 
(assert (not (= var1184 null-var204)))
(declare-const var1150 var3639) ; Statement: r2 := @parameter1: java.lang.Object 
(assert (not (= var1150 null-var3639)))
(assert true)
;(assert (userEventTriggered/47672626 (cast-from-var3158-to-var265 var2328) var1184 var1150)) ; Statement: specialinvoke r0.<io.netty.channel.SimpleChannelInboundHandler: void userEventTriggered(io.netty.channel.ChannelHandlerContext,java.lang.Object)>(r1, r2) 

(declare-const var2328!1 var3158)
(declare-const var1184!1 var204)
(declare-const var1150!1 var3639)
(define-const var410 Bool false) ; Statement: $z0 = r2 instanceof io.netty.handler.codec.http2.Http2GoAwayFrame 
 ; Statement: if $z0 == 0 goto $z1 = r2 instanceof io.netty.handler.codec.http2.Http2ResetFrame 
(assert (= (ite var410 1 0) 0)) ; Cond: $z0 == 0 
(define-const var312 Bool false) ; Statement: $z1 = r2 instanceof io.netty.handler.codec.http2.Http2ResetFrame 
 ; Statement: if $z1 == 0 goto return 
(assert (= (ite var312 1 0) 0)) ; Cond: $z1 == 0 
 ; Statement: return 
(check-sat)
; {userEventTriggered/47672626=([io.netty.channel.SimpleChannelInboundHandler, io.netty.channel.ChannelHandlerContext, java.lang.Object], void), cast-from-var3158-to-var265=([org.apache.dubbo.rpc.protocol.tri.transport.TripleHttp2ClientResponseHandler], io.netty.channel.SimpleChannelInboundHandler)}
; {var3158=org.apache.dubbo.rpc.protocol.tri.transport.TripleHttp2ClientResponseHandler, var2328=r0, var204=io.netty.channel.ChannelHandlerContext, var1184=r1, var3639=java.lang.Object, var1150=r2, var265=io.netty.channel.SimpleChannelInboundHandler, var410=$z0, var312=$z1}
; {org.apache.dubbo.rpc.protocol.tri.transport.TripleHttp2ClientResponseHandler=var3158, r0=var2328, io.netty.channel.ChannelHandlerContext=var204, r1=var1184, java.lang.Object=var3639, r2=var1150, io.netty.channel.SimpleChannelInboundHandler=var265, $z0=var410, $z1=var312}
;seq 
;cnt {}
;stmts r0 := @this: org.apache.dubbo.rpc.protocol.tri.transport.TripleHttp2ClientResponseHandler;	r1 := @parameter0: io.netty.channel.ChannelHandlerContext;	r2 := @parameter1: java.lang.Object;	specialinvoke r0.<io.netty.channel.SimpleChannelInboundHandler: void userEventTriggered(io.netty.channel.ChannelHandlerContext,java.lang.Object)>(r1, r2);	$z0 = r2 instanceof io.netty.handler.codec.http2.Http2GoAwayFrame;	if $z0 == 0 goto $z1 = r2 instanceof io.netty.handler.codec.http2.Http2ResetFrame;	$z1 = r2 instanceof io.netty.handler.codec.http2.Http2ResetFrame;	if $z1 == 0 goto return;	return
;block_num 3