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

(declare-sort var2693 0)
(declare-sort var3151 0)
(declare-sort var893 0)
(declare-sort var1827 0)
(declare-sort var2080 0)
(declare-sort var1819 0)
(declare-sort var575 0)
(declare-sort var505 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun userEventTriggered/47672626 (var1827 var3151 var893) void)
(declare-fun cast-from-var2693-to-var1827 (var2693) var1827)
(declare-fun cast-from-var893-to-var2080 (var893) var2080)
(declare-fun var3151_close/780824979 (var3151) var505)
(declare-fun String-init () String)
(define-fun <init>/1968657023 () String "")
(define-fun append/672562846 ((s String) (tail String)) String (str.++ s tail))
(declare-fun var2080_name/-1925011038 (var2080) String)
(declare-fun var2080_lastStreamId/827966416 (var2080) Int)
(define-fun append/-1001720160 ((s String) (tail Int)) String (str.++ s (str.from_int tail)))
(define-fun toString/-2075883882 ((s String)) String s)
(declare-fun var575_debug/470264832 (var575 String) void)
(declare-fun cast-from-var1819-to-var575 (var1819) var575)
(declare-const null-var2693 var2693)
(declare-const null-var3151 var3151)
(declare-const null-var893 var893)
(declare-const var2693-LOGGER var1819)
(declare-const var3000 var2693) ; Statement: r0 := @this: org.apache.dubbo.rpc.protocol.tri.transport.TripleHttp2ClientResponseHandler 
(assert (not (= var3000 null-var2693)))
(declare-const var729 var3151) ; Statement: r1 := @parameter0: io.netty.channel.ChannelHandlerContext 
(assert (not (= var729 null-var3151)))
(declare-const var3134 var893) ; Statement: r2 := @parameter1: java.lang.Object 
(assert (not (= var3134 null-var893)))
(assert true)
;(assert (userEventTriggered/47672626 (cast-from-var2693-to-var1827 var3000) var729 var3134)) ; Statement: specialinvoke r0.<io.netty.channel.SimpleChannelInboundHandler: void userEventTriggered(io.netty.channel.ChannelHandlerContext,java.lang.Object)>(r1, r2) 

(declare-const var3000!1 var2693)
(declare-const var729!1 var3151)
(declare-const var3134!1 var893)
(define-const var2538 Bool false) ; Statement: $z0 = r2 instanceof io.netty.handler.codec.http2.Http2GoAwayFrame 
 ; Statement: if $z0 == 0 goto $z1 = r2 instanceof io.netty.handler.codec.http2.Http2ResetFrame 
(assert (not (= (ite var2538 1 0) 0))) ; Negate: Cond: $z0 == 0  
(define-const var1597 var2080 (cast-from-var893-to-var2080 var3134!1)) ; Statement: r4 = (io.netty.handler.codec.http2.Http2GoAwayFrame) r2 
;(assert (var3151_close/780824979 var729!1)) ; Statement: interfaceinvoke r1.<io.netty.channel.ChannelHandlerContext: io.netty.channel.ChannelFuture close()>() 

(declare-const var729!2 var3151)
(define-const var802 var1819 var2693-LOGGER) ; Statement: $r6 = <org.apache.dubbo.rpc.protocol.tri.transport.TripleHttp2ClientResponseHandler: org.apache.dubbo.common.logger.ErrorTypeAwareLogger LOGGER> 
(define-const var3580 String String-init) ; Statement: $r5 = new java.lang.StringBuilder 
(assert true)
;(assert (<init>/1968657023 var3580)) ; Statement: specialinvoke $r5.<java.lang.StringBuilder: void <init>()>() 
(declare-const var3580!1 String)
(assert (= var3580!1 ""))
(assert true)
(define-const var3079 String (append/672562846 var3580!1 "Event triggered, event name is: ")) ; Statement: $r8 = virtualinvoke $r5.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("Event triggered, event name is: ") 
(declare-const var3580!2 String)
(assert (= var3580!2 (str.++ var3580!1 "Event triggered, event name is: ")))
(define-const var1608 String (var2080_name/-1925011038 var1597)) ; Statement: $r7 = interfaceinvoke r4.<io.netty.handler.codec.http2.Http2GoAwayFrame: java.lang.String name()>() 
(assert true)
(define-const var270 String (append/672562846 var3079 var1608)) ; Statement: $r9 = virtualinvoke $r8.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>($r7) 
(declare-const var3079!1 String)
(assert (= var3079!1 (str.++ var3079 var1608)))
(assert true)
(define-const var1813 String (append/672562846 var270 ", last stream id is: ")) ; Statement: $r10 = virtualinvoke $r9.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(", last stream id is: ") 
(declare-const var270!1 String)
(assert (= var270!1 (str.++ var270 ", last stream id is: ")))
(define-const var812 Int (var2080_lastStreamId/827966416 var1597)) ; Statement: $i0 = interfaceinvoke r4.<io.netty.handler.codec.http2.Http2GoAwayFrame: int lastStreamId()>() 
(assert true)
(define-const var354 String (append/-1001720160 var1813 var812)) ; Statement: $r11 = virtualinvoke $r10.<java.lang.StringBuilder: java.lang.StringBuilder append(int)>($i0) 
(declare-const var1813!1 String)
(assert (str.prefixof var1813 var1813!1))
(assert true)
(define-const var3167 String (toString/-2075883882 var354)) ; Statement: $r12 = virtualinvoke $r11.<java.lang.StringBuilder: java.lang.String toString()>() 
;(assert (var575_debug/470264832 (cast-from-var1819-to-var575 var802) var3167)) ; Statement: interfaceinvoke $r6.<org.apache.dubbo.common.logger.ErrorTypeAwareLogger: void debug(java.lang.String)>($r12) 

(declare-const var802!1 var1819)
(declare-const var3167!1 String)
 ; Statement: goto [?= return] 
(assert true) ; Non Conditional
 ; Statement: return 
(check-sat)
; {userEventTriggered/47672626=([io.netty.channel.SimpleChannelInboundHandler, io.netty.channel.ChannelHandlerContext, java.lang.Object], void), cast-from-var2693-to-var1827=([org.apache.dubbo.rpc.protocol.tri.transport.TripleHttp2ClientResponseHandler], io.netty.channel.SimpleChannelInboundHandler), cast-from-var893-to-var2080=([java.lang.Object], io.netty.handler.codec.http2.Http2GoAwayFrame), var3151_close/780824979=([io.netty.channel.ChannelHandlerContext], io.netty.channel.ChannelFuture), String-init=([], java.lang.StringBuilder), <init>/1968657023=([java.lang.StringBuilder], void), append/672562846=([java.lang.StringBuilder, java.lang.String], java.lang.StringBuilder), var2080_name/-1925011038=([io.netty.handler.codec.http2.Http2GoAwayFrame], java.lang.String), var2080_lastStreamId/827966416=([io.netty.handler.codec.http2.Http2GoAwayFrame], int), append/-1001720160=([java.lang.StringBuilder, int], java.lang.StringBuilder), toString/-2075883882=([java.lang.StringBuilder], java.lang.String), var575_debug/470264832=([org.apache.dubbo.common.logger.Logger, java.lang.String], void), cast-from-var1819-to-var575=([org.apache.dubbo.common.logger.ErrorTypeAwareLogger], org.apache.dubbo.common.logger.Logger)}
; {var2693=org.apache.dubbo.rpc.protocol.tri.transport.TripleHttp2ClientResponseHandler, var3000=r0, var3151=io.netty.channel.ChannelHandlerContext, var729=r1, var893=java.lang.Object, var3134=r2, var1827=io.netty.channel.SimpleChannelInboundHandler, var2538=$z0, var2080=io.netty.handler.codec.http2.Http2GoAwayFrame, var1597=r4, var1819=org.apache.dubbo.common.logger.ErrorTypeAwareLogger, var802=$r6, var3580=$r5, var3079=$r8, var1608=$r7, var270=$r9, var1813=$r10, var812=$i0, var354=$r11, var3167=$r12, var575=org.apache.dubbo.common.logger.Logger, var505=io.netty.channel.ChannelFuture}
; {org.apache.dubbo.rpc.protocol.tri.transport.TripleHttp2ClientResponseHandler=var2693, r0=var3000, io.netty.channel.ChannelHandlerContext=var3151, r1=var729, java.lang.Object=var893, r2=var3134, io.netty.channel.SimpleChannelInboundHandler=var1827, $z0=var2538, io.netty.handler.codec.http2.Http2GoAwayFrame=var2080, r4=var1597, org.apache.dubbo.common.logger.ErrorTypeAwareLogger=var1819, $r6=var802, $r5=var3580, $r8=var3079, $r7=var1608, $r9=var270, $r10=var1813, $i0=var812, $r11=var354, $r12=var3167, org.apache.dubbo.common.logger.Logger=var575, io.netty.channel.ChannelFuture=var505}
;seq <java.lang.StringBuilder: void <init>()>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(int)>;	<java.lang.StringBuilder: java.lang.String toString()>
;cnt {"<java.lang.StringBuilder: void <init>()>": 1,"<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>": 3,"<java.lang.StringBuilder: java.lang.StringBuilder append(int)>": 1,"<java.lang.StringBuilder: java.lang.String toString()>": 1}
;stmts r0 := @this: org.apache.dubbo.rpc.protocol.tri.transport.TripleHttp2ClientResponseHandler;	r1 := @parameter0: io.netty.channel.ChannelHandlerContext;	r2 := @parameter1: java.lang.Object;	specialinvoke r0.<io.netty.channel.SimpleChannelInboundHandler: void userEventTriggered(io.netty.channel.ChannelHandlerContext,java.lang.Object)>(r1, r2);	$z0 = r2 instanceof io.netty.handler.codec.http2.Http2GoAwayFrame;	if $z0 == 0 goto $z1 = r2 instanceof io.netty.handler.codec.http2.Http2ResetFrame;	r4 = (io.netty.handler.codec.http2.Http2GoAwayFrame) r2;	interfaceinvoke r1.<io.netty.channel.ChannelHandlerContext: io.netty.channel.ChannelFuture close()>();	$r6 = <org.apache.dubbo.rpc.protocol.tri.transport.TripleHttp2ClientResponseHandler: org.apache.dubbo.common.logger.ErrorTypeAwareLogger LOGGER>;	$r5 = new java.lang.StringBuilder;	specialinvoke $r5.<java.lang.StringBuilder: void <init>()>();	$r8 = virtualinvoke $r5.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("Event triggered, event name is: ");	$r7 = interfaceinvoke r4.<io.netty.handler.codec.http2.Http2GoAwayFrame: java.lang.String name()>();	$r9 = virtualinvoke $r8.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>($r7);	$r10 = virtualinvoke $r9.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(", last stream id is: ");	$i0 = interfaceinvoke r4.<io.netty.handler.codec.http2.Http2GoAwayFrame: int lastStreamId()>();	$r11 = virtualinvoke $r10.<java.lang.StringBuilder: java.lang.StringBuilder append(int)>($i0);	$r12 = virtualinvoke $r11.<java.lang.StringBuilder: java.lang.String toString()>();	interfaceinvoke $r6.<org.apache.dubbo.common.logger.ErrorTypeAwareLogger: void debug(java.lang.String)>($r12);	goto [?= return];	return
;block_num 3