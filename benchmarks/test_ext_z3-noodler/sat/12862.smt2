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

(declare-sort var1585 0)
(declare-sort var1527 0)
(declare-sort var1369 0)
(declare-sort var1444 0)
(declare-sort var3471 0)
(declare-sort var1079 0)
(declare-sort var1363 0)
(declare-sort var1545 0)
(declare-sort var2067 0)
(declare-sort var3099 0)
(declare-sort var398 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun var3471_decode/535291244 (var1369) var1444)
(declare-fun String-init () String)
(define-fun <init>/1968657023 () String "")
(define-fun append/672562846 ((s String) (tail String)) String (str.++ s tail))
(declare-fun var1369_uri/805623633 (var1369) String)
(define-fun toString/-2075883882 ((s String)) String s)
(declare-fun var1079_warn/1431914100 (var1079 String String String String) void)
(declare-fun var1585_http/-771896863 (Int) var1363)
(declare-fun var1527_writeAndFlush/-1998013070 (var1527 var2067) var1545)
(declare-fun cast-from-var1363-to-var2067 (var1363) var2067)
(declare-fun cast-from-var3099-to-var398 (var3099) var398)
(declare-fun var1545_addListener/17757127 (var1545 var398) var1545)
(declare-const null-var1585 var1585)
(declare-const null-var1527 var1527)
(declare-const null-var1369 var1369)
(declare-const null-var1444 var1444)
(declare-const var1585-log var1079)
(declare-const var3099-CLOSE var3099)
(declare-const var3066 var1585) ; Statement: r4 := @this: org.apache.dubbo.qos.server.handler.HttpProcessHandler 
(assert (not (= var3066 null-var1585)))
(declare-const var3793 var1527) ; Statement: r2 := @parameter0: io.netty.channel.ChannelHandlerContext 
(assert (not (= var3793 null-var1527)))
(declare-const var408 var1369) ; Statement: r0 := @parameter1: io.netty.handler.codec.http.HttpRequest 
(assert (not (= var408 null-var1369)))
(define-const var2696 var1444 (var3471_decode/535291244 var408)) ; Statement: r1 = staticinvoke <org.apache.dubbo.qos.command.decoder.HttpCommandDecoder: org.apache.dubbo.qos.api.CommandContext decode(io.netty.handler.codec.http.HttpRequest)>(r0) 
 ; Statement: if r1 != null goto $r3 = interfaceinvoke r2.<io.netty.channel.ChannelHandlerContext: io.netty.channel.Channel channel()>() 
(assert (not (not (= var2696 null-var1444)))) ; Negate: Cond: r1 != null  
(define-const var779 var1079 var1585-log) ; Statement: $r11 = <org.apache.dubbo.qos.server.handler.HttpProcessHandler: org.apache.dubbo.common.logger.ErrorTypeAwareLogger log> 
(define-const var2374 String String-init) ; Statement: $r49 = new java.lang.StringBuilder 
(assert true)
;(assert (<init>/1968657023 var2374)) ; Statement: specialinvoke $r49.<java.lang.StringBuilder: void <init>()>() 
(declare-const var2374!1 String)
(assert (= var2374!1 ""))
(assert true)
(define-const var3554 String (append/672562846 var2374!1 "can not found commandContext, url: ")) ; Statement: $r13 = virtualinvoke $r49.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("can not found commandContext, url: ") 
(declare-const var2374!2 String)
(assert (= var2374!2 (str.++ var2374!1 "can not found commandContext, url: ")))
(define-const var3334 String (var1369_uri/805623633 var408)) ; Statement: $r12 = interfaceinvoke r0.<io.netty.handler.codec.http.HttpRequest: java.lang.String uri()>() 
(assert true)
(define-const var2583 String (append/672562846 var3554 var3334)) ; Statement: $r14 = virtualinvoke $r13.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>($r12) 
(declare-const var3554!1 String)
(assert (= var3554!1 (str.++ var3554 var3334)))
(assert true)
(define-const var1005 String (toString/-2075883882 var2583)) ; Statement: $r15 = virtualinvoke $r14.<java.lang.StringBuilder: java.lang.String toString()>() 
;(assert (var1079_warn/1431914100 var779 "7-6" "" "" var1005)) ; Statement: interfaceinvoke $r11.<org.apache.dubbo.common.logger.ErrorTypeAwareLogger: void warn(java.lang.String,java.lang.String,java.lang.String,java.lang.String)>("7-6", "", "", $r15) 

(declare-const var779!1 var1079)
(declare-const var526 String)
(declare-const var602 String)
(declare-const var602!1 String)
(declare-const var1005!1 String)
(define-const var2665 var1363 (var1585_http/-771896863 404)) ; Statement: r44 = staticinvoke <org.apache.dubbo.qos.server.handler.HttpProcessHandler: io.netty.handler.codec.http.FullHttpResponse http(int)>(404) 
(define-const var2769 var1545 (var1527_writeAndFlush/-1998013070 var3793 (cast-from-var1363-to-var2067 var2665))) ; Statement: $r17 = interfaceinvoke r2.<io.netty.channel.ChannelHandlerContext: io.netty.channel.ChannelFuture writeAndFlush(java.lang.Object)>(r44) 
(define-const var2504 var3099 var3099-CLOSE) ; Statement: $r16 = <io.netty.channel.ChannelFutureListener: io.netty.channel.ChannelFutureListener CLOSE> 
(define-const var3084 var398 (cast-from-var3099-to-var398 var2504)) ; Statement: $r53 = (io.netty.util.concurrent.GenericFutureListener) $r16 
;(assert (var1545_addListener/17757127 var2769 var3084)) ; Statement: interfaceinvoke $r17.<io.netty.channel.ChannelFuture: io.netty.channel.ChannelFuture addListener(io.netty.util.concurrent.GenericFutureListener)>($r53) 

(declare-const var2769!1 var1545)
(declare-const var3084!1 var398)
 ; Statement: goto [?= return] 
(assert true) ; Non Conditional
 ; Statement: return 
(check-sat)
; {var3471_decode/535291244=([io.netty.handler.codec.http.HttpRequest], org.apache.dubbo.qos.api.CommandContext), String-init=([], java.lang.StringBuilder), <init>/1968657023=([java.lang.StringBuilder], void), append/672562846=([java.lang.StringBuilder, java.lang.String], java.lang.StringBuilder), var1369_uri/805623633=([io.netty.handler.codec.http.HttpRequest], java.lang.String), toString/-2075883882=([java.lang.StringBuilder], java.lang.String), var1079_warn/1431914100=([org.apache.dubbo.common.logger.ErrorTypeAwareLogger, java.lang.String, java.lang.String, java.lang.String, java.lang.String], void), var1585_http/-771896863=([int], io.netty.handler.codec.http.FullHttpResponse), var1527_writeAndFlush/-1998013070=([io.netty.channel.ChannelHandlerContext, java.lang.Object], io.netty.channel.ChannelFuture), cast-from-var1363-to-var2067=([io.netty.handler.codec.http.FullHttpResponse], java.lang.Object), cast-from-var3099-to-var398=([io.netty.channel.ChannelFutureListener], io.netty.util.concurrent.GenericFutureListener), var1545_addListener/17757127=([io.netty.channel.ChannelFuture, io.netty.util.concurrent.GenericFutureListener], io.netty.channel.ChannelFuture)}
; {var1585=org.apache.dubbo.qos.server.handler.HttpProcessHandler, var3066=r4, var1527=io.netty.channel.ChannelHandlerContext, var3793=r2, var1369=io.netty.handler.codec.http.HttpRequest, var408=r0, var1444=org.apache.dubbo.qos.api.CommandContext, var3471=org.apache.dubbo.qos.command.decoder.HttpCommandDecoder, var2696=r1, var1079=org.apache.dubbo.common.logger.ErrorTypeAwareLogger, var779=$r11, var2374=$r49, var3554=$r13, var3334=$r12, var2583=$r14, var1005=$r15, var526="7-6", var602="", var1363=io.netty.handler.codec.http.FullHttpResponse, var2665=r44, var1545=io.netty.channel.ChannelFuture, var2067=java.lang.Object, var2769=$r17, var3099=io.netty.channel.ChannelFutureListener, var2504=$r16, var398=io.netty.util.concurrent.GenericFutureListener, var3084=$r53}
; {org.apache.dubbo.qos.server.handler.HttpProcessHandler=var1585, r4=var3066, io.netty.channel.ChannelHandlerContext=var1527, r2=var3793, io.netty.handler.codec.http.HttpRequest=var1369, r0=var408, org.apache.dubbo.qos.api.CommandContext=var1444, org.apache.dubbo.qos.command.decoder.HttpCommandDecoder=var3471, r1=var2696, org.apache.dubbo.common.logger.ErrorTypeAwareLogger=var1079, $r11=var779, $r49=var2374, $r13=var3554, $r12=var3334, $r14=var2583, $r15=var1005, "7-6"=var526, ""=var602, io.netty.handler.codec.http.FullHttpResponse=var1363, r44=var2665, io.netty.channel.ChannelFuture=var1545, java.lang.Object=var2067, $r17=var2769, io.netty.channel.ChannelFutureListener=var3099, $r16=var2504, io.netty.util.concurrent.GenericFutureListener=var398, $r53=var3084}
;seq <java.lang.StringBuilder: void <init>()>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.String toString()>
;cnt {"<java.lang.StringBuilder: void <init>()>": 1,"<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>": 2,"<java.lang.StringBuilder: java.lang.String toString()>": 1}
;stmts r4 := @this: org.apache.dubbo.qos.server.handler.HttpProcessHandler;	r2 := @parameter0: io.netty.channel.ChannelHandlerContext;	r0 := @parameter1: io.netty.handler.codec.http.HttpRequest;	r1 = staticinvoke <org.apache.dubbo.qos.command.decoder.HttpCommandDecoder: org.apache.dubbo.qos.api.CommandContext decode(io.netty.handler.codec.http.HttpRequest)>(r0);	if r1 != null goto $r3 = interfaceinvoke r2.<io.netty.channel.ChannelHandlerContext: io.netty.channel.Channel channel()>();	$r11 = <org.apache.dubbo.qos.server.handler.HttpProcessHandler: org.apache.dubbo.common.logger.ErrorTypeAwareLogger log>;	$r49 = new java.lang.StringBuilder;	specialinvoke $r49.<java.lang.StringBuilder: void <init>()>();	$r13 = virtualinvoke $r49.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("can not found commandContext, url: ");	$r12 = interfaceinvoke r0.<io.netty.handler.codec.http.HttpRequest: java.lang.String uri()>();	$r14 = virtualinvoke $r13.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>($r12);	$r15 = virtualinvoke $r14.<java.lang.StringBuilder: java.lang.String toString()>();	interfaceinvoke $r11.<org.apache.dubbo.common.logger.ErrorTypeAwareLogger: void warn(java.lang.String,java.lang.String,java.lang.String,java.lang.String)>("7-6", "", "", $r15);	r44 = staticinvoke <org.apache.dubbo.qos.server.handler.HttpProcessHandler: io.netty.handler.codec.http.FullHttpResponse http(int)>(404);	$r17 = interfaceinvoke r2.<io.netty.channel.ChannelHandlerContext: io.netty.channel.ChannelFuture writeAndFlush(java.lang.Object)>(r44);	$r16 = <io.netty.channel.ChannelFutureListener: io.netty.channel.ChannelFutureListener CLOSE>;	$r53 = (io.netty.util.concurrent.GenericFutureListener) $r16;	interfaceinvoke $r17.<io.netty.channel.ChannelFuture: io.netty.channel.ChannelFuture addListener(io.netty.util.concurrent.GenericFutureListener)>($r53);	goto [?= return];	return
;block_num 3