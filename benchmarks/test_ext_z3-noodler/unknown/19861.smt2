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

(declare-sort var2480 0)
(declare-sort var3206 0)
(declare-sort var710 0)
(declare-sort var572 0)
(declare-sort var3011 0)
(declare-sort var1308 0)
(declare-sort var134 0)
(declare-sort var2044 0)
(declare-sort var2431 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun this$0/1565923212 (var2480) var710)
(declare-fun var710_access$100/160992089 (var710) var572)
(declare-fun var3011_isDebugEnabled/-823448366 (var3011) Bool)
(declare-fun cast-from-var572-to-var3011 (var572) var3011)
(declare-fun var710_access$200/854384794 (var710) var572)
(declare-fun String-init () String)
(define-fun <init>/1968657023 () String "")
(define-fun append/672562846 ((s String) (tail String)) String (str.++ s tail))
(declare-fun var3206_getRemoteAddress/1597111645 (var3206) var1308)
(declare-fun append/-1031950772 (String var134) String)
(declare-fun cast-from-var1308-to-var134 (var1308) var134)
(declare-fun var2431_getUrl/938756954 (var2431) var2044)
(declare-fun cast-from-var3206-to-var2431 (var3206) var2431)
(declare-fun cast-from-var2044-to-var134 (var2044) var134)
(define-fun toString/-2075883882 ((s String)) String s)
(declare-fun var3011_debug/470264832 (var3011 String) void)
(declare-fun invoke/733682530 (var2480 var3206 String) void)
(declare-const null-var2480 var2480)
(declare-const null-var3206 var3206)
(declare-const var850 var2480) ; Statement: r0 := @this: org.apache.dubbo.rpc.protocol.dubbo.DubboProtocol$1 
(assert (not (= var850 null-var2480)))
(declare-const var1997 var3206) ; Statement: r3 := @parameter0: org.apache.dubbo.remoting.Channel 
(assert (not (= var1997 null-var3206)))
(define-const var1043 var710 (this$0/1565923212 var850)) ; Statement: $r1 = r0.<org.apache.dubbo.rpc.protocol.dubbo.DubboProtocol$1: org.apache.dubbo.rpc.protocol.dubbo.DubboProtocol this$0> 
(define-const var2522 var572 (var710_access$100/160992089 var1043)) ; Statement: $r2 = staticinvoke <org.apache.dubbo.rpc.protocol.dubbo.DubboProtocol: org.apache.dubbo.common.logger.ErrorTypeAwareLogger access$100(org.apache.dubbo.rpc.protocol.dubbo.DubboProtocol)>($r1) 
(define-const var2302 Bool (var3011_isDebugEnabled/-823448366 (cast-from-var572-to-var3011 var2522))) ; Statement: $z0 = interfaceinvoke $r2.<org.apache.dubbo.common.logger.ErrorTypeAwareLogger: boolean isDebugEnabled()>() 
 ; Statement: if $z0 == 0 goto specialinvoke r0.<org.apache.dubbo.rpc.protocol.dubbo.DubboProtocol$1: void invoke(org.apache.dubbo.remoting.Channel,java.lang.String)>(r3, "ondisconnect") 
(assert (not (= (ite var2302 1 0) 0))) ; Negate: Cond: $z0 == 0  
(define-const var2131 var710 (this$0/1565923212 var850)) ; Statement: $r4 = r0.<org.apache.dubbo.rpc.protocol.dubbo.DubboProtocol$1: org.apache.dubbo.rpc.protocol.dubbo.DubboProtocol this$0> 
(define-const var540 var572 (var710_access$200/854384794 var2131)) ; Statement: $r13 = staticinvoke <org.apache.dubbo.rpc.protocol.dubbo.DubboProtocol: org.apache.dubbo.common.logger.ErrorTypeAwareLogger access$200(org.apache.dubbo.rpc.protocol.dubbo.DubboProtocol)>($r4) 
(define-const var2693 String String-init) ; Statement: $r5 = new java.lang.StringBuilder 
(assert true)
;(assert (<init>/1968657023 var2693)) ; Statement: specialinvoke $r5.<java.lang.StringBuilder: void <init>()>() 
(declare-const var2693!1 String)
(assert (= var2693!1 ""))
(assert true)
(define-const var1139 String (append/672562846 var2693!1 "disconnected from ")) ; Statement: $r7 = virtualinvoke $r5.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("disconnected from ") 
(declare-const var2693!2 String)
(assert (= var2693!2 (str.++ var2693!1 "disconnected from ")))
(define-const var1149 var1308 (var3206_getRemoteAddress/1597111645 var1997)) ; Statement: $r6 = interfaceinvoke r3.<org.apache.dubbo.remoting.Channel: java.net.InetSocketAddress getRemoteAddress()>() 
(assert true)
(define-const var3145 String (append/-1031950772 var1139 (cast-from-var1308-to-var134 var1149))) ; Statement: $r8 = virtualinvoke $r7.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.Object)>($r6) 
(declare-const var1139!1 String)
(assert (str.prefixof var1139 var1139!1))
(assert true)
(define-const var847 String (append/672562846 var3145 ",url:")) ; Statement: $r10 = virtualinvoke $r8.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(",url:") 
(declare-const var3145!1 String)
(assert (= var3145!1 (str.++ var3145 ",url:")))
(define-const var1012 var2044 (var2431_getUrl/938756954 (cast-from-var3206-to-var2431 var1997))) ; Statement: $r9 = interfaceinvoke r3.<org.apache.dubbo.remoting.Channel: org.apache.dubbo.common.URL getUrl()>() 
(assert true)
(define-const var2659 String (append/-1031950772 var847 (cast-from-var2044-to-var134 var1012))) ; Statement: $r11 = virtualinvoke $r10.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.Object)>($r9) 
(declare-const var847!1 String)
(assert (str.prefixof var847 var847!1))
(assert true)
(define-const var761 String (toString/-2075883882 var2659)) ; Statement: $r12 = virtualinvoke $r11.<java.lang.StringBuilder: java.lang.String toString()>() 
;(assert (var3011_debug/470264832 (cast-from-var572-to-var3011 var540) var761)) ; Statement: interfaceinvoke $r13.<org.apache.dubbo.common.logger.ErrorTypeAwareLogger: void debug(java.lang.String)>($r12) 

(declare-const var540!1 var572)
(declare-const var761!1 String)
(assert true) ; Non Conditional
(assert true)
;(assert (invoke/733682530 var850 var1997 "ondisconnect")) ; Statement: specialinvoke r0.<org.apache.dubbo.rpc.protocol.dubbo.DubboProtocol$1: void invoke(org.apache.dubbo.remoting.Channel,java.lang.String)>(r3, "ondisconnect") 

(declare-const var850!1 var2480)
(declare-const var1997!1 var3206)
(declare-const var415 String)
 ; Statement: return 
(check-sat)
; {this$0/1565923212=([org.apache.dubbo.rpc.protocol.dubbo.DubboProtocol$1], org.apache.dubbo.rpc.protocol.dubbo.DubboProtocol), var710_access$100/160992089=([org.apache.dubbo.rpc.protocol.dubbo.DubboProtocol], org.apache.dubbo.common.logger.ErrorTypeAwareLogger), var3011_isDebugEnabled/-823448366=([org.apache.dubbo.common.logger.Logger], boolean), cast-from-var572-to-var3011=([org.apache.dubbo.common.logger.ErrorTypeAwareLogger], org.apache.dubbo.common.logger.Logger), var710_access$200/854384794=([org.apache.dubbo.rpc.protocol.dubbo.DubboProtocol], org.apache.dubbo.common.logger.ErrorTypeAwareLogger), String-init=([], java.lang.StringBuilder), <init>/1968657023=([java.lang.StringBuilder], void), append/672562846=([java.lang.StringBuilder, java.lang.String], java.lang.StringBuilder), var3206_getRemoteAddress/1597111645=([org.apache.dubbo.remoting.Channel], java.net.InetSocketAddress), append/-1031950772=([java.lang.StringBuilder, java.lang.Object], java.lang.StringBuilder), cast-from-var1308-to-var134=([java.net.InetSocketAddress], java.lang.Object), var2431_getUrl/938756954=([org.apache.dubbo.remoting.Endpoint], org.apache.dubbo.common.URL), cast-from-var3206-to-var2431=([org.apache.dubbo.remoting.Channel], org.apache.dubbo.remoting.Endpoint), cast-from-var2044-to-var134=([org.apache.dubbo.common.URL], java.lang.Object), toString/-2075883882=([java.lang.StringBuilder], java.lang.String), var3011_debug/470264832=([org.apache.dubbo.common.logger.Logger, java.lang.String], void), invoke/733682530=([org.apache.dubbo.rpc.protocol.dubbo.DubboProtocol$1, org.apache.dubbo.remoting.Channel, java.lang.String], void)}
; {var2480=org.apache.dubbo.rpc.protocol.dubbo.DubboProtocol$1, var850=r0, var3206=org.apache.dubbo.remoting.Channel, var1997=r3, var710=org.apache.dubbo.rpc.protocol.dubbo.DubboProtocol, var1043=$r1, var572=org.apache.dubbo.common.logger.ErrorTypeAwareLogger, var2522=$r2, var3011=org.apache.dubbo.common.logger.Logger, var2302=$z0, var2131=$r4, var540=$r13, var2693=$r5, var1139=$r7, var1308=java.net.InetSocketAddress, var1149=$r6, var134=java.lang.Object, var3145=$r8, var847=$r10, var2044=org.apache.dubbo.common.URL, var2431=org.apache.dubbo.remoting.Endpoint, var1012=$r9, var2659=$r11, var761=$r12, var415="ondisconnect"}
; {org.apache.dubbo.rpc.protocol.dubbo.DubboProtocol$1=var2480, r0=var850, org.apache.dubbo.remoting.Channel=var3206, r3=var1997, org.apache.dubbo.rpc.protocol.dubbo.DubboProtocol=var710, $r1=var1043, org.apache.dubbo.common.logger.ErrorTypeAwareLogger=var572, $r2=var2522, org.apache.dubbo.common.logger.Logger=var3011, $z0=var2302, $r4=var2131, $r13=var540, $r5=var2693, $r7=var1139, java.net.InetSocketAddress=var1308, $r6=var1149, java.lang.Object=var134, $r8=var3145, $r10=var847, org.apache.dubbo.common.URL=var2044, org.apache.dubbo.remoting.Endpoint=var2431, $r9=var1012, $r11=var2659, $r12=var761, "ondisconnect"=var415}
;seq <java.lang.StringBuilder: void <init>()>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.Object)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.Object)>;	<java.lang.StringBuilder: java.lang.String toString()>
;cnt {"<java.lang.StringBuilder: void <init>()>": 1,"<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>": 2,"<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.Object)>": 2,"<java.lang.StringBuilder: java.lang.String toString()>": 1}
;stmts r0 := @this: org.apache.dubbo.rpc.protocol.dubbo.DubboProtocol$1;	r3 := @parameter0: org.apache.dubbo.remoting.Channel;	$r1 = r0.<org.apache.dubbo.rpc.protocol.dubbo.DubboProtocol$1: org.apache.dubbo.rpc.protocol.dubbo.DubboProtocol this$0>;	$r2 = staticinvoke <org.apache.dubbo.rpc.protocol.dubbo.DubboProtocol: org.apache.dubbo.common.logger.ErrorTypeAwareLogger access$100(org.apache.dubbo.rpc.protocol.dubbo.DubboProtocol)>($r1);	$z0 = interfaceinvoke $r2.<org.apache.dubbo.common.logger.ErrorTypeAwareLogger: boolean isDebugEnabled()>();	if $z0 == 0 goto specialinvoke r0.<org.apache.dubbo.rpc.protocol.dubbo.DubboProtocol$1: void invoke(org.apache.dubbo.remoting.Channel,java.lang.String)>(r3, "ondisconnect");	$r4 = r0.<org.apache.dubbo.rpc.protocol.dubbo.DubboProtocol$1: org.apache.dubbo.rpc.protocol.dubbo.DubboProtocol this$0>;	$r13 = staticinvoke <org.apache.dubbo.rpc.protocol.dubbo.DubboProtocol: org.apache.dubbo.common.logger.ErrorTypeAwareLogger access$200(org.apache.dubbo.rpc.protocol.dubbo.DubboProtocol)>($r4);	$r5 = new java.lang.StringBuilder;	specialinvoke $r5.<java.lang.StringBuilder: void <init>()>();	$r7 = virtualinvoke $r5.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("disconnected from ");	$r6 = interfaceinvoke r3.<org.apache.dubbo.remoting.Channel: java.net.InetSocketAddress getRemoteAddress()>();	$r8 = virtualinvoke $r7.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.Object)>($r6);	$r10 = virtualinvoke $r8.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(",url:");	$r9 = interfaceinvoke r3.<org.apache.dubbo.remoting.Channel: org.apache.dubbo.common.URL getUrl()>();	$r11 = virtualinvoke $r10.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.Object)>($r9);	$r12 = virtualinvoke $r11.<java.lang.StringBuilder: java.lang.String toString()>();	interfaceinvoke $r13.<org.apache.dubbo.common.logger.ErrorTypeAwareLogger: void debug(java.lang.String)>($r12);	specialinvoke r0.<org.apache.dubbo.rpc.protocol.dubbo.DubboProtocol$1: void invoke(org.apache.dubbo.remoting.Channel,java.lang.String)>(r3, "ondisconnect");	return
;block_num 3