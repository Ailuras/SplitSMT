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

(declare-sort var485 0)
(declare-sort var286 0)
(declare-sort var1318 0)
(declare-sort var2089 0)
(declare-sort var2196 0)
(declare-sort var2234 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun String-init () String)
(define-fun <init>/1968657023 () String "")
(define-fun append/672562846 ((s String) (tail String)) String (str.++ s tail))
(declare-fun connectionClient/-1865024164 (var485) var2089)
(declare-fun getChannel/-423721195 (var2089) var2196)
(declare-fun append/-1031950772 (String var2234) String)
(declare-fun cast-from-var2196-to-var2234 (var2196) var2234)
(define-fun toString/-2075883882 ((s String)) String s)
(declare-fun var1318_error/377575788 (var1318 String String String String var286) void)
(declare-const null-var485 var485)
(declare-const null-var286 var286)
(declare-const var485-LOGGER var1318)
(declare-const var198 var485) ; Statement: r0 := @this: org.apache.dubbo.remoting.transport.netty4.NettyConnectionHandler 
(assert (not (= var198 null-var485)))
(assert true) ; Handling Exception: java.lang.Throwable 
(declare-const var3954 var286) ; Statement: $r2 := @caughtexception 
(assert (not (= var3954 null-var286)))
(define-const var189 var1318 var485-LOGGER) ; Statement: $r4 = <org.apache.dubbo.remoting.transport.netty4.NettyConnectionHandler: org.apache.dubbo.common.logger.ErrorTypeAwareLogger LOGGER> 
(define-const var195 String String-init) ; Statement: $r3 = new java.lang.StringBuilder 
(assert true)
;(assert (<init>/1968657023 var195)) ; Statement: specialinvoke $r3.<java.lang.StringBuilder: void <init>()>() 
(declare-const var195!1 String)
(assert (= var195!1 ""))
(assert true)
(define-const var1687 String (append/672562846 var195!1 "Fail to connect to ")) ; Statement: $r7 = virtualinvoke $r3.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("Fail to connect to ") 
(declare-const var195!2 String)
(assert (= var195!2 (str.++ var195!1 "Fail to connect to ")))
(define-const var3164 var2089 (connectionClient/-1865024164 var198)) ; Statement: $r5 = r0.<org.apache.dubbo.remoting.transport.netty4.NettyConnectionHandler: org.apache.dubbo.remoting.transport.netty4.AbstractNettyConnectionClient connectionClient> 
(assert true)
(define-const var3148 var2196 (getChannel/-423721195 var3164)) ; Statement: $r6 = virtualinvoke $r5.<org.apache.dubbo.remoting.transport.netty4.AbstractNettyConnectionClient: org.apache.dubbo.remoting.Channel getChannel()>() 
(assert true)
(define-const var3133 String (append/-1031950772 var1687 (cast-from-var2196-to-var2234 var3148))) ; Statement: $r8 = virtualinvoke $r7.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.Object)>($r6) 
(declare-const var1687!1 String)
(assert (str.prefixof var1687 var1687!1))
(assert true)
(define-const var2072 String (toString/-2075883882 var3133)) ; Statement: $r9 = virtualinvoke $r8.<java.lang.StringBuilder: java.lang.String toString()>() 
;(assert (var1318_error/377575788 var189 "6-16" "" "" var2072 var3954)) ; Statement: interfaceinvoke $r4.<org.apache.dubbo.common.logger.ErrorTypeAwareLogger: void error(java.lang.String,java.lang.String,java.lang.String,java.lang.String,java.lang.Throwable)>("6-16", "", "", $r9, $r2) 

(declare-const var189!1 var1318)
(declare-const var3479 String)
(declare-const var3533 String)
(declare-const var3533!1 String)
(declare-const var2072!1 String)
(declare-const var3954!1 var286)
(assert true) ; Non Conditional
 ; Statement: return 
(check-sat)
; {String-init=([], java.lang.StringBuilder), <init>/1968657023=([java.lang.StringBuilder], void), append/672562846=([java.lang.StringBuilder, java.lang.String], java.lang.StringBuilder), connectionClient/-1865024164=([org.apache.dubbo.remoting.transport.netty4.NettyConnectionHandler], org.apache.dubbo.remoting.transport.netty4.AbstractNettyConnectionClient), getChannel/-423721195=([org.apache.dubbo.remoting.transport.netty4.AbstractNettyConnectionClient], org.apache.dubbo.remoting.Channel), append/-1031950772=([java.lang.StringBuilder, java.lang.Object], java.lang.StringBuilder), cast-from-var2196-to-var2234=([org.apache.dubbo.remoting.Channel], java.lang.Object), toString/-2075883882=([java.lang.StringBuilder], java.lang.String), var1318_error/377575788=([org.apache.dubbo.common.logger.ErrorTypeAwareLogger, java.lang.String, java.lang.String, java.lang.String, java.lang.String, java.lang.Throwable], void)}
; {var485=org.apache.dubbo.remoting.transport.netty4.NettyConnectionHandler, var198=r0, var286=java.lang.Throwable, var3954=$r2, var1318=org.apache.dubbo.common.logger.ErrorTypeAwareLogger, var189=$r4, var195=$r3, var1687=$r7, var2089=org.apache.dubbo.remoting.transport.netty4.AbstractNettyConnectionClient, var3164=$r5, var2196=org.apache.dubbo.remoting.Channel, var3148=$r6, var2234=java.lang.Object, var3133=$r8, var2072=$r9, var3479="6-16", var3533=""}
; {org.apache.dubbo.remoting.transport.netty4.NettyConnectionHandler=var485, r0=var198, java.lang.Throwable=var286, $r2=var3954, org.apache.dubbo.common.logger.ErrorTypeAwareLogger=var1318, $r4=var189, $r3=var195, $r7=var1687, org.apache.dubbo.remoting.transport.netty4.AbstractNettyConnectionClient=var2089, $r5=var3164, org.apache.dubbo.remoting.Channel=var2196, $r6=var3148, java.lang.Object=var2234, $r8=var3133, $r9=var2072, "6-16"=var3479, ""=var3533}
;seq <java.lang.StringBuilder: void <init>()>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.Object)>;	<java.lang.StringBuilder: java.lang.String toString()>
;cnt {"<java.lang.StringBuilder: void <init>()>": 1,"<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>": 1,"<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.Object)>": 1,"<java.lang.StringBuilder: java.lang.String toString()>": 1}
;stmts r0 := @this: org.apache.dubbo.remoting.transport.netty4.NettyConnectionHandler;	$r2 := @caughtexception;	$r4 = <org.apache.dubbo.remoting.transport.netty4.NettyConnectionHandler: org.apache.dubbo.common.logger.ErrorTypeAwareLogger LOGGER>;	$r3 = new java.lang.StringBuilder;	specialinvoke $r3.<java.lang.StringBuilder: void <init>()>();	$r7 = virtualinvoke $r3.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("Fail to connect to ");	$r5 = r0.<org.apache.dubbo.remoting.transport.netty4.NettyConnectionHandler: org.apache.dubbo.remoting.transport.netty4.AbstractNettyConnectionClient connectionClient>;	$r6 = virtualinvoke $r5.<org.apache.dubbo.remoting.transport.netty4.AbstractNettyConnectionClient: org.apache.dubbo.remoting.Channel getChannel()>();	$r8 = virtualinvoke $r7.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.Object)>($r6);	$r9 = virtualinvoke $r8.<java.lang.StringBuilder: java.lang.String toString()>();	interfaceinvoke $r4.<org.apache.dubbo.common.logger.ErrorTypeAwareLogger: void error(java.lang.String,java.lang.String,java.lang.String,java.lang.String,java.lang.Throwable)>("6-16", "", "", $r9, $r2);	return
;block_num 3