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

(declare-sort var3417 0)
(declare-sort var1430 0)
(declare-sort var571 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-const null-var3417 var3417)
(declare-const null-var1430 var1430)
(declare-const null-String String)
(declare-const var1061 var3417) ; Statement: r3 := @this: org.apache.dubbo.remoting.transport.netty4.NettyPortUnificationServerHandler$1 
(assert (not (= var1061 null-var3417)))
(declare-const var2854 var1430) ; Statement: r2 := @parameter0: io.netty.channel.ChannelHandlerContext 
(assert (not (= var2854 null-var1430)))
(declare-const var3829 String) ; Statement: r0 := @parameter1: java.lang.String 
(assert (not (= var3829 null-String)))
(define-const var3257 String "h2") ; Statement: $r1 = "h2" 
(assert true)
(define-const var1456 Bool (= var3257 var3829)) ; Statement: $z0 = virtualinvoke $r1.<java.lang.String: boolean equals(java.lang.Object)>(r0) 
 ; Statement: if $z0 != 0 goto $r8 = interfaceinvoke r2.<io.netty.channel.ChannelHandlerContext: io.netty.channel.Channel channel()>() 
(assert (not (not (= (ite var1456 1 0) 0)))) ; Negate: Cond: $z0 != 0  
 ; Statement: return 
(check-sat)
; {}
; {var3417=org.apache.dubbo.remoting.transport.netty4.NettyPortUnificationServerHandler$1, var1061=r3, var1430=io.netty.channel.ChannelHandlerContext, var2854=r2, var3829=r0, var571=null_type, var3257=$r1, var1456=$z0}
; {org.apache.dubbo.remoting.transport.netty4.NettyPortUnificationServerHandler$1=var3417, r3=var1061, io.netty.channel.ChannelHandlerContext=var1430, r2=var2854, r0=var3829, null_type=var571, $r1=var3257, $z0=var1456}
;seq <java.lang.String: boolean equals(java.lang.Object)>
;cnt {"<java.lang.String: boolean equals(java.lang.Object)>": 1}
;stmts r3 := @this: org.apache.dubbo.remoting.transport.netty4.NettyPortUnificationServerHandler$1;	r2 := @parameter0: io.netty.channel.ChannelHandlerContext;	r0 := @parameter1: java.lang.String;	$r1 = "h2";	$z0 = virtualinvoke $r1.<java.lang.String: boolean equals(java.lang.Object)>(r0);	if $z0 != 0 goto $r8 = interfaceinvoke r2.<io.netty.channel.ChannelHandlerContext: io.netty.channel.Channel channel()>();	return
;block_num 2