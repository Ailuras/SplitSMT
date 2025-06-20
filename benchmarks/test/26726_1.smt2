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

(declare-sort var1816 0)
(declare-sort var2420 0)
(declare-sort var2449 0)
(declare-sort var620 0)
(declare-sort var3769 0)
(declare-sort var3142 0)
(declare-sort var350 0)
(declare-sort var699 0)
(declare-sort var1868 0)
(declare-sort var1628 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun withCause/-2092378542 (var620 var2449) var620)
(declare-fun String-init () String)
(define-fun <init>/1968657023 () String "")
(define-fun append/672562846 ((s String) (tail String)) String (str.++ s tail))
(declare-fun code/195094363 (var620) var3142)
(declare-fun append/-1031950772 (String var350) String)
(declare-fun cast-from-var3142-to-var350 (var3142) var350)
(define-fun toString/-2075883882 ((s String)) String s)
(declare-fun var3769_warn/126438324 (var3769 String String String String var2449) void)
(declare-fun transportListener/-1461522527 (var1816) var699)
(declare-fun code/12534856 (var1868) Int)
(declare-fun var699_cancelByRemote/58321284 (var699 Int) void)
(declare-fun var2420_close/780824979 (var2420) var1628)
(declare-const null-var1816 var1816)
(declare-const null-var2420 var2420)
(declare-const null-var2449 var2449)
(declare-const var620-INTERNAL var620)
(declare-const var1816-LOGGER var3769)
(declare-const var1868-INTERNAL_ERROR var1868)
(declare-const var1163 var1816) ; Statement: r9 := @this: org.apache.dubbo.rpc.protocol.tri.transport.TripleHttp2ClientResponseHandler 
(assert (not (= var1163 null-var1816)))
(declare-const var740 var2420) ; Statement: r12 := @parameter0: io.netty.channel.ChannelHandlerContext 
(assert (not (= var740 null-var2420)))
(declare-const var2262 var2449) ; Statement: r0 := @parameter1: java.lang.Throwable 
(assert (not (= var2262 null-var2449)))
(define-const var2898 var620 var620-INTERNAL) ; Statement: $r1 = <org.apache.dubbo.rpc.TriRpcStatus: org.apache.dubbo.rpc.TriRpcStatus INTERNAL> 
(assert true)
(define-const var1617 var620 (withCause/-2092378542 var2898 var2262)) ; Statement: r2 = virtualinvoke $r1.<org.apache.dubbo.rpc.TriRpcStatus: org.apache.dubbo.rpc.TriRpcStatus withCause(java.lang.Throwable)>(r0) 
(define-const var3890 var3769 var1816-LOGGER) ; Statement: $r4 = <org.apache.dubbo.rpc.protocol.tri.transport.TripleHttp2ClientResponseHandler: org.apache.dubbo.common.logger.ErrorTypeAwareLogger LOGGER> 
(define-const var2832 String String-init) ; Statement: $r3 = new java.lang.StringBuilder 
(assert true)
;(assert (<init>/1968657023 var2832)) ; Statement: specialinvoke $r3.<java.lang.StringBuilder: void <init>()>() 
(declare-const var2832!1 String)
(assert (= var2832!1 ""))
(assert true)
(define-const var2254 String (append/672562846 var2832!1 "Meet Exception on ClientResponseHandler, status code is: ")) ; Statement: $r6 = virtualinvoke $r3.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("Meet Exception on ClientResponseHandler, status code is: ") 
(declare-const var2832!2 String)
(assert (= var2832!2 (str.++ var2832!1 "Meet Exception on ClientResponseHandler, status code is: ")))
(define-const var2878 var3142 (code/195094363 var1617)) ; Statement: $r5 = r2.<org.apache.dubbo.rpc.TriRpcStatus: org.apache.dubbo.rpc.TriRpcStatus$Code code> 
(assert true)
(define-const var1511 String (append/-1031950772 var2254 (cast-from-var3142-to-var350 var2878))) ; Statement: $r7 = virtualinvoke $r6.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.Object)>($r5) 
(declare-const var2254!1 String)
(assert (str.prefixof var2254 var2254!1))
(assert true)
(define-const var422 String (toString/-2075883882 var1511)) ; Statement: $r8 = virtualinvoke $r7.<java.lang.StringBuilder: java.lang.String toString()>() 
;(assert (var3769_warn/126438324 var3890 "4-10" "" "" var422 var2262)) ; Statement: interfaceinvoke $r4.<org.apache.dubbo.common.logger.ErrorTypeAwareLogger: void warn(java.lang.String,java.lang.String,java.lang.String,java.lang.String,java.lang.Throwable)>("4-10", "", "", $r8, r0) 

(declare-const var3890!1 var3769)
(declare-const var1702 String)
(declare-const var2609 String)
(declare-const var2609!1 String)
(declare-const var422!1 String)
(declare-const var2262!1 var2449)
(define-const var277 var699 (transportListener/-1461522527 var1163)) ; Statement: $r11 = r9.<org.apache.dubbo.rpc.protocol.tri.transport.TripleHttp2ClientResponseHandler: org.apache.dubbo.rpc.protocol.tri.transport.H2TransportListener transportListener> 
(define-const var1547 var1868 var1868-INTERNAL_ERROR) ; Statement: $r10 = <io.netty.handler.codec.http2.Http2Error: io.netty.handler.codec.http2.Http2Error INTERNAL_ERROR> 
(assert true)
(define-const var3321 Int (code/12534856 var1547)) ; Statement: $l0 = virtualinvoke $r10.<io.netty.handler.codec.http2.Http2Error: long code()>() 
;(assert (var699_cancelByRemote/58321284 var277 var3321)) ; Statement: interfaceinvoke $r11.<org.apache.dubbo.rpc.protocol.tri.transport.H2TransportListener: void cancelByRemote(long)>($l0) 

(declare-const var277!1 var699)
(declare-const var3321!1 Int)
;(assert (var2420_close/780824979 var740)) ; Statement: interfaceinvoke r12.<io.netty.channel.ChannelHandlerContext: io.netty.channel.ChannelFuture close()>() 

(declare-const var740!1 var2420)
 ; Statement: return 
(check-sat)
; {withCause/-2092378542=([org.apache.dubbo.rpc.TriRpcStatus, java.lang.Throwable], org.apache.dubbo.rpc.TriRpcStatus), String-init=([], java.lang.StringBuilder), <init>/1968657023=([java.lang.StringBuilder], void), append/672562846=([java.lang.StringBuilder, java.lang.String], java.lang.StringBuilder), code/195094363=([org.apache.dubbo.rpc.TriRpcStatus], org.apache.dubbo.rpc.TriRpcStatus$Code), append/-1031950772=([java.lang.StringBuilder, java.lang.Object], java.lang.StringBuilder), cast-from-var3142-to-var350=([org.apache.dubbo.rpc.TriRpcStatus$Code], java.lang.Object), toString/-2075883882=([java.lang.StringBuilder], java.lang.String), var3769_warn/126438324=([org.apache.dubbo.common.logger.ErrorTypeAwareLogger, java.lang.String, java.lang.String, java.lang.String, java.lang.String, java.lang.Throwable], void), transportListener/-1461522527=([org.apache.dubbo.rpc.protocol.tri.transport.TripleHttp2ClientResponseHandler], org.apache.dubbo.rpc.protocol.tri.transport.H2TransportListener), code/12534856=([io.netty.handler.codec.http2.Http2Error], long), var699_cancelByRemote/58321284=([org.apache.dubbo.rpc.protocol.tri.transport.H2TransportListener, long], void), var2420_close/780824979=([io.netty.channel.ChannelHandlerContext], io.netty.channel.ChannelFuture)}
; {var1816=org.apache.dubbo.rpc.protocol.tri.transport.TripleHttp2ClientResponseHandler, var1163=r9, var2420=io.netty.channel.ChannelHandlerContext, var740=r12, var2449=java.lang.Throwable, var2262=r0, var620=org.apache.dubbo.rpc.TriRpcStatus, var2898=$r1, var1617=r2, var3769=org.apache.dubbo.common.logger.ErrorTypeAwareLogger, var3890=$r4, var2832=$r3, var2254=$r6, var3142=org.apache.dubbo.rpc.TriRpcStatus$Code, var2878=$r5, var350=java.lang.Object, var1511=$r7, var422=$r8, var1702="4-10", var2609="", var699=org.apache.dubbo.rpc.protocol.tri.transport.H2TransportListener, var277=$r11, var1868=io.netty.handler.codec.http2.Http2Error, var1547=$r10, var3321=$l0, var1628=io.netty.channel.ChannelFuture}
; {org.apache.dubbo.rpc.protocol.tri.transport.TripleHttp2ClientResponseHandler=var1816, r9=var1163, io.netty.channel.ChannelHandlerContext=var2420, r12=var740, java.lang.Throwable=var2449, r0=var2262, org.apache.dubbo.rpc.TriRpcStatus=var620, $r1=var2898, r2=var1617, org.apache.dubbo.common.logger.ErrorTypeAwareLogger=var3769, $r4=var3890, $r3=var2832, $r6=var2254, org.apache.dubbo.rpc.TriRpcStatus$Code=var3142, $r5=var2878, java.lang.Object=var350, $r7=var1511, $r8=var422, "4-10"=var1702, ""=var2609, org.apache.dubbo.rpc.protocol.tri.transport.H2TransportListener=var699, $r11=var277, io.netty.handler.codec.http2.Http2Error=var1868, $r10=var1547, $l0=var3321, io.netty.channel.ChannelFuture=var1628}
;seq <java.lang.StringBuilder: void <init>()>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.Object)>;	<java.lang.StringBuilder: java.lang.String toString()>
;cnt {"<java.lang.StringBuilder: void <init>()>": 1,"<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>": 1,"<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.Object)>": 1,"<java.lang.StringBuilder: java.lang.String toString()>": 1}
;stmts r9 := @this: org.apache.dubbo.rpc.protocol.tri.transport.TripleHttp2ClientResponseHandler;	r12 := @parameter0: io.netty.channel.ChannelHandlerContext;	r0 := @parameter1: java.lang.Throwable;	$r1 = <org.apache.dubbo.rpc.TriRpcStatus: org.apache.dubbo.rpc.TriRpcStatus INTERNAL>;	r2 = virtualinvoke $r1.<org.apache.dubbo.rpc.TriRpcStatus: org.apache.dubbo.rpc.TriRpcStatus withCause(java.lang.Throwable)>(r0);	$r4 = <org.apache.dubbo.rpc.protocol.tri.transport.TripleHttp2ClientResponseHandler: org.apache.dubbo.common.logger.ErrorTypeAwareLogger LOGGER>;	$r3 = new java.lang.StringBuilder;	specialinvoke $r3.<java.lang.StringBuilder: void <init>()>();	$r6 = virtualinvoke $r3.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("Meet Exception on ClientResponseHandler, status code is: ");	$r5 = r2.<org.apache.dubbo.rpc.TriRpcStatus: org.apache.dubbo.rpc.TriRpcStatus$Code code>;	$r7 = virtualinvoke $r6.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.Object)>($r5);	$r8 = virtualinvoke $r7.<java.lang.StringBuilder: java.lang.String toString()>();	interfaceinvoke $r4.<org.apache.dubbo.common.logger.ErrorTypeAwareLogger: void warn(java.lang.String,java.lang.String,java.lang.String,java.lang.String,java.lang.Throwable)>("4-10", "", "", $r8, r0);	$r11 = r9.<org.apache.dubbo.rpc.protocol.tri.transport.TripleHttp2ClientResponseHandler: org.apache.dubbo.rpc.protocol.tri.transport.H2TransportListener transportListener>;	$r10 = <io.netty.handler.codec.http2.Http2Error: io.netty.handler.codec.http2.Http2Error INTERNAL_ERROR>;	$l0 = virtualinvoke $r10.<io.netty.handler.codec.http2.Http2Error: long code()>();	interfaceinvoke $r11.<org.apache.dubbo.rpc.protocol.tri.transport.H2TransportListener: void cancelByRemote(long)>($l0);	interfaceinvoke r12.<io.netty.channel.ChannelHandlerContext: io.netty.channel.ChannelFuture close()>();	return
;block_num 1