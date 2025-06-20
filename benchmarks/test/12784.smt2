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

(declare-sort var1854 0)
(declare-sort var2881 0)
(declare-sort var945 0)
(declare-sort var2861 0)
(declare-sort var1779 0)
(declare-sort var263 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun var2861_isBlank/-523695098 (String) Bool)
(define-fun cast-from-String-to-String ((arg String)) String arg)
(declare-fun var2881_writeAndFlush/-1998013070 (var2881 var1779) var263)
(declare-fun cast-from-String-to-var1779 (String) var1779)
(declare-const null-var1854 var1854)
(declare-const null-var2881 var2881)
(declare-const null-String String)
(declare-const var1628 var1854) ; Statement: r2 := @this: org.apache.dubbo.qos.server.handler.TelnetProcessHandler 
(assert (not (= var1628 null-var1854)))
(declare-const var3724 var2881) ; Statement: r4 := @parameter0: io.netty.channel.ChannelHandlerContext 
(assert (not (= var3724 null-var2881)))
(declare-const var3296 String) ; Statement: r0 := @parameter1: java.lang.String 
(assert (not (= var3296 null-String)))
(define-const var3639 Bool (var2861_isBlank/-523695098 (cast-from-String-to-String var3296))) ; Statement: $z0 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: boolean isBlank(java.lang.CharSequence)>(r0) 
 ; Statement: if $z0 == 0 goto r1 = staticinvoke <org.apache.dubbo.qos.command.decoder.TelnetCommandDecoder: org.apache.dubbo.qos.api.CommandContext decode(java.lang.String)>(r0) 
(assert (not (= (ite var3639 1 0) 0))) ; Negate: Cond: $z0 == 0  
;(assert (var2881_writeAndFlush/-1998013070 var3724 (cast-from-String-to-var1779 "dubbo>"))) ; Statement: interfaceinvoke r4.<io.netty.channel.ChannelHandlerContext: io.netty.channel.ChannelFuture writeAndFlush(java.lang.Object)>("dubbo>") 

(declare-const var3724!1 var2881)
(declare-const var327 String)
 ; Statement: goto [?= return] 
(assert true) ; Non Conditional
 ; Statement: return 
(check-sat)
; {var2861_isBlank/-523695098=([java.lang.CharSequence], boolean), cast-from-String-to-String=([java.lang.String], java.lang.CharSequence), var2881_writeAndFlush/-1998013070=([io.netty.channel.ChannelHandlerContext, java.lang.Object], io.netty.channel.ChannelFuture), cast-from-String-to-var1779=([java.lang.String], java.lang.Object)}
; {var1854=org.apache.dubbo.qos.server.handler.TelnetProcessHandler, var1628=r2, var2881=io.netty.channel.ChannelHandlerContext, var3724=r4, var3296=r0, var945=null_type, var2861=org.apache.dubbo.common.utils.StringUtils, var3639=$z0, var1779=java.lang.Object, var327="dubbo>", var263=io.netty.channel.ChannelFuture}
; {org.apache.dubbo.qos.server.handler.TelnetProcessHandler=var1854, r2=var1628, io.netty.channel.ChannelHandlerContext=var2881, r4=var3724, r0=var3296, null_type=var945, org.apache.dubbo.common.utils.StringUtils=var2861, $z0=var3639, java.lang.Object=var1779, "dubbo>"=var327, io.netty.channel.ChannelFuture=var263}
;seq <org.apache.dubbo.common.utils.StringUtils: boolean isBlank(java.lang.CharSequence)>
;cnt {"<org.apache.dubbo.common.utils.StringUtils: boolean isBlank(java.lang.CharSequence)>": 1}
;stmts r2 := @this: org.apache.dubbo.qos.server.handler.TelnetProcessHandler;	r4 := @parameter0: io.netty.channel.ChannelHandlerContext;	r0 := @parameter1: java.lang.String;	$z0 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: boolean isBlank(java.lang.CharSequence)>(r0);	if $z0 == 0 goto r1 = staticinvoke <org.apache.dubbo.qos.command.decoder.TelnetCommandDecoder: org.apache.dubbo.qos.api.CommandContext decode(java.lang.String)>(r0);	interfaceinvoke r4.<io.netty.channel.ChannelHandlerContext: io.netty.channel.ChannelFuture writeAndFlush(java.lang.Object)>("dubbo>");	goto [?= return];	return
;block_num 3