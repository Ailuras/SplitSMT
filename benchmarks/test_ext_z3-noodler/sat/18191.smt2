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

(declare-sort var2277 0)
(declare-sort var415 0)
(declare-sort var2469 0)
(declare-sort var3215 0)
(declare-sort var2558 0)
(declare-sort var423 0)
(declare-sort var3098 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun var415_access$100/-2082680640 () var3215)
(declare-fun String-init () String)
(define-fun <init>/1968657023 () String "")
(define-fun append/672562846 ((s String) (tail String)) String (str.++ s tail))
(declare-fun this$0/-1599017697 (var2277) var415)
(declare-fun getConnectAddress/-1402199948 (var423) var2558)
(declare-fun cast-from-var415-to-var423 (var415) var423)
(declare-fun append/-1031950772 (String var3098) String)
(declare-fun cast-from-var2558-to-var3098 (var2558) var3098)
(define-fun toString/-2075883882 ((s String)) String s)
(declare-fun var3215_error/-110665684 (var3215 String String String String) void)
(declare-const null-var2277 var2277)
(declare-const null-var415 var415)
(declare-const null-var2469 var2469)
(declare-const var3874 var2277) ; Statement: r3 := @this: org.apache.dubbo.remoting.transport.netty4.AbstractNettyConnectionClient$ConnectionListener 
(assert (not (= var3874 null-var2277)))
(declare-const var744 var415) ; Statement: r0 := @parameter0: org.apache.dubbo.remoting.transport.netty4.AbstractNettyConnectionClient 
(assert (not (= var744 null-var415)))
(assert true) ; Handling Exception: java.lang.Throwable 
(declare-const var1171 var2469) ; Statement: $r1 := @caughtexception 
(assert (not (= var1171 null-var2469)))
(define-const var7 var3215 var415_access$100/-2082680640) ; Statement: $r9 = staticinvoke <org.apache.dubbo.remoting.transport.netty4.AbstractNettyConnectionClient: org.apache.dubbo.common.logger.ErrorTypeAwareLogger access$100()>() 
(define-const var136 String String-init) ; Statement: $r2 = new java.lang.StringBuilder 
(assert true)
;(assert (<init>/1968657023 var136)) ; Statement: specialinvoke $r2.<java.lang.StringBuilder: void <init>()>() 
(declare-const var136!1 String)
(assert (= var136!1 ""))
(assert true)
(define-const var1685 String (append/672562846 var136!1 "Failed to connect to server: ")) ; Statement: $r6 = virtualinvoke $r2.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("Failed to connect to server: ") 
(declare-const var136!2 String)
(assert (= var136!2 (str.++ var136!1 "Failed to connect to server: ")))
(define-const var2781 var415 (this$0/-1599017697 var3874)) ; Statement: $r4 = r3.<org.apache.dubbo.remoting.transport.netty4.AbstractNettyConnectionClient$ConnectionListener: org.apache.dubbo.remoting.transport.netty4.AbstractNettyConnectionClient this$0> 
(assert true)
(define-const var2097 var2558 (getConnectAddress/-1402199948 (cast-from-var415-to-var423 var2781))) ; Statement: $r5 = virtualinvoke $r4.<org.apache.dubbo.remoting.transport.netty4.AbstractNettyConnectionClient: java.net.InetSocketAddress getConnectAddress()>() 
(assert true)
(define-const var2841 String (append/-1031950772 var1685 (cast-from-var2558-to-var3098 var2097))) ; Statement: $r7 = virtualinvoke $r6.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.Object)>($r5) 
(declare-const var1685!1 String)
(assert (str.prefixof var1685 var1685!1))
(assert true)
(define-const var1848 String (toString/-2075883882 var2841)) ; Statement: $r8 = virtualinvoke $r7.<java.lang.StringBuilder: java.lang.String toString()>() 
;(assert (var3215_error/-110665684 var7 "6-16" "" "" var1848)) ; Statement: interfaceinvoke $r9.<org.apache.dubbo.common.logger.ErrorTypeAwareLogger: void error(java.lang.String,java.lang.String,java.lang.String,java.lang.String)>("6-16", "", "", $r8) 

(declare-const var7!1 var3215)
(declare-const var1681 String)
(declare-const var594 String)
(declare-const var594!1 String)
(declare-const var1848!1 String)
(assert true) ; Non Conditional
 ; Statement: return 
(check-sat)
; {var415_access$100/-2082680640=([], org.apache.dubbo.common.logger.ErrorTypeAwareLogger), String-init=([], java.lang.StringBuilder), <init>/1968657023=([java.lang.StringBuilder], void), append/672562846=([java.lang.StringBuilder, java.lang.String], java.lang.StringBuilder), this$0/-1599017697=([org.apache.dubbo.remoting.transport.netty4.AbstractNettyConnectionClient$ConnectionListener], org.apache.dubbo.remoting.transport.netty4.AbstractNettyConnectionClient), getConnectAddress/-1402199948=([org.apache.dubbo.remoting.transport.AbstractClient], java.net.InetSocketAddress), cast-from-var415-to-var423=([org.apache.dubbo.remoting.transport.netty4.AbstractNettyConnectionClient], org.apache.dubbo.remoting.transport.AbstractClient), append/-1031950772=([java.lang.StringBuilder, java.lang.Object], java.lang.StringBuilder), cast-from-var2558-to-var3098=([java.net.InetSocketAddress], java.lang.Object), toString/-2075883882=([java.lang.StringBuilder], java.lang.String), var3215_error/-110665684=([org.apache.dubbo.common.logger.ErrorTypeAwareLogger, java.lang.String, java.lang.String, java.lang.String, java.lang.String], void)}
; {var2277=org.apache.dubbo.remoting.transport.netty4.AbstractNettyConnectionClient$ConnectionListener, var3874=r3, var415=org.apache.dubbo.remoting.transport.netty4.AbstractNettyConnectionClient, var744=r0, var2469=org.apache.dubbo.remoting.RemotingException, var1171=$r1, var3215=org.apache.dubbo.common.logger.ErrorTypeAwareLogger, var7=$r9, var136=$r2, var1685=$r6, var2781=$r4, var2558=java.net.InetSocketAddress, var423=org.apache.dubbo.remoting.transport.AbstractClient, var2097=$r5, var3098=java.lang.Object, var2841=$r7, var1848=$r8, var1681="6-16", var594=""}
; {org.apache.dubbo.remoting.transport.netty4.AbstractNettyConnectionClient$ConnectionListener=var2277, r3=var3874, org.apache.dubbo.remoting.transport.netty4.AbstractNettyConnectionClient=var415, r0=var744, org.apache.dubbo.remoting.RemotingException=var2469, $r1=var1171, org.apache.dubbo.common.logger.ErrorTypeAwareLogger=var3215, $r9=var7, $r2=var136, $r6=var1685, $r4=var2781, java.net.InetSocketAddress=var2558, org.apache.dubbo.remoting.transport.AbstractClient=var423, $r5=var2097, java.lang.Object=var3098, $r7=var2841, $r8=var1848, "6-16"=var1681, ""=var594}
;seq <java.lang.StringBuilder: void <init>()>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.Object)>;	<java.lang.StringBuilder: java.lang.String toString()>
;cnt {"<java.lang.StringBuilder: void <init>()>": 1,"<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>": 1,"<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.Object)>": 1,"<java.lang.StringBuilder: java.lang.String toString()>": 1}
;stmts r3 := @this: org.apache.dubbo.remoting.transport.netty4.AbstractNettyConnectionClient$ConnectionListener;	r0 := @parameter0: org.apache.dubbo.remoting.transport.netty4.AbstractNettyConnectionClient;	$r1 := @caughtexception;	$r9 = staticinvoke <org.apache.dubbo.remoting.transport.netty4.AbstractNettyConnectionClient: org.apache.dubbo.common.logger.ErrorTypeAwareLogger access$100()>();	$r2 = new java.lang.StringBuilder;	specialinvoke $r2.<java.lang.StringBuilder: void <init>()>();	$r6 = virtualinvoke $r2.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("Failed to connect to server: ");	$r4 = r3.<org.apache.dubbo.remoting.transport.netty4.AbstractNettyConnectionClient$ConnectionListener: org.apache.dubbo.remoting.transport.netty4.AbstractNettyConnectionClient this$0>;	$r5 = virtualinvoke $r4.<org.apache.dubbo.remoting.transport.netty4.AbstractNettyConnectionClient: java.net.InetSocketAddress getConnectAddress()>();	$r7 = virtualinvoke $r6.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.Object)>($r5);	$r8 = virtualinvoke $r7.<java.lang.StringBuilder: java.lang.String toString()>();	interfaceinvoke $r9.<org.apache.dubbo.common.logger.ErrorTypeAwareLogger: void error(java.lang.String,java.lang.String,java.lang.String,java.lang.String)>("6-16", "", "", $r8);	return
;block_num 3