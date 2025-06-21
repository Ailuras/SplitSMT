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

(declare-sort var43 0)
(declare-sort var479 0)
(declare-sort var2893 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun String-init () String)
(define-fun <init>/1968657023 () String "")
(define-fun append/672562846 ((s String) (tail String)) String (str.++ s tail))
(declare-fun http3Connected/1236144978 (var43) Bool)
(declare-fun append/-388390247 (String Bool) String)
(declare-fun http3ConnectionClient/1236144978 (var43) var479)
(declare-fun append/-1031950772 (String var2893) String)
(declare-fun cast-from-var479-to-var2893 (var479) var2893)
(declare-fun connectionClient/1236144978 (var43) var479)
(declare-fun append/-1166366385 (String Int) String)
(define-fun toString/-2075883882 ((s String)) String s)
(declare-const null-var43 var43)
(declare-const var662 var43) ; Statement: r1 := @this: org.apache.dubbo.rpc.protocol.tri.h3.negotiation.AutoSwitchConnectionClient 
(assert (not (= var662 null-var43)))
(define-const var1392 String String-init) ; Statement: $r0 = new java.lang.StringBuilder 
(assert true)
;(assert (<init>/1968657023 var1392)) ; Statement: specialinvoke $r0.<java.lang.StringBuilder: void <init>()>() 
(declare-const var1392!1 String)
(assert (= var1392!1 ""))
(assert true)
(define-const var3095 String (append/672562846 var1392!1 "AutoSwitchConnectionClient{http3Enabled=")) ; Statement: $r2 = virtualinvoke $r0.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("AutoSwitchConnectionClient{http3Enabled=") 
(declare-const var1392!2 String)
(assert (= var1392!2 (str.++ var1392!1 "AutoSwitchConnectionClient{http3Enabled=")))
(define-const var3514 Bool (http3Connected/1236144978 var662)) ; Statement: $z0 = r1.<org.apache.dubbo.rpc.protocol.tri.h3.negotiation.AutoSwitchConnectionClient: boolean http3Connected> 
(assert true)
(define-const var3870 String (append/-388390247 var3095 var3514)) ; Statement: $r3 = virtualinvoke $r2.<java.lang.StringBuilder: java.lang.StringBuilder append(boolean)>($z0) 
(declare-const var3095!1 String)
(assert (str.prefixof var3095 var3095!1))
(assert true)
(define-const var1548 String (append/672562846 var3870 ", http3=")) ; Statement: $r5 = virtualinvoke $r3.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(", http3=") 
(declare-const var3870!1 String)
(assert (= var3870!1 (str.++ var3870 ", http3=")))
(define-const var1175 var479 (http3ConnectionClient/1236144978 var662)) ; Statement: $r4 = r1.<org.apache.dubbo.rpc.protocol.tri.h3.negotiation.AutoSwitchConnectionClient: org.apache.dubbo.remoting.api.connection.AbstractConnectionClient http3ConnectionClient> 
(assert true)
(define-const var136 String (append/-1031950772 var1548 (cast-from-var479-to-var2893 var1175))) ; Statement: $r6 = virtualinvoke $r5.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.Object)>($r4) 
(declare-const var1548!1 String)
(assert (str.prefixof var1548 var1548!1))
(assert true)
(define-const var1999 String (append/672562846 var136 ", http2=")) ; Statement: $r8 = virtualinvoke $r6.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(", http2=") 
(declare-const var136!1 String)
(assert (= var136!1 (str.++ var136 ", http2=")))
(define-const var478 var479 (connectionClient/1236144978 var662)) ; Statement: $r7 = r1.<org.apache.dubbo.rpc.protocol.tri.h3.negotiation.AutoSwitchConnectionClient: org.apache.dubbo.remoting.api.connection.AbstractConnectionClient connectionClient> 
(assert true)
(define-const var827 String (append/-1031950772 var1999 (cast-from-var479-to-var2893 var478))) ; Statement: $r9 = virtualinvoke $r8.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.Object)>($r7) 
(declare-const var1999!1 String)
(assert (str.prefixof var1999 var1999!1))
(assert true)
(define-const var2920 String (append/-1166366385 var827 125)) ; Statement: $r10 = virtualinvoke $r9.<java.lang.StringBuilder: java.lang.StringBuilder append(char)>(125) 
(declare-const var827!1 String)
(assert (str.prefixof var827 var827!1))
(assert true)
(define-const var3986 String (toString/-2075883882 var2920)) ; Statement: $r11 = virtualinvoke $r10.<java.lang.StringBuilder: java.lang.String toString()>() 
 ; Statement: return $r11 
(check-sat)
; {String-init=([], java.lang.StringBuilder), <init>/1968657023=([java.lang.StringBuilder], void), append/672562846=([java.lang.StringBuilder, java.lang.String], java.lang.StringBuilder), http3Connected/1236144978=([org.apache.dubbo.rpc.protocol.tri.h3.negotiation.AutoSwitchConnectionClient], boolean), append/-388390247=([java.lang.StringBuilder, boolean], java.lang.StringBuilder), http3ConnectionClient/1236144978=([org.apache.dubbo.rpc.protocol.tri.h3.negotiation.AutoSwitchConnectionClient], org.apache.dubbo.remoting.api.connection.AbstractConnectionClient), append/-1031950772=([java.lang.StringBuilder, java.lang.Object], java.lang.StringBuilder), cast-from-var479-to-var2893=([org.apache.dubbo.remoting.api.connection.AbstractConnectionClient], java.lang.Object), connectionClient/1236144978=([org.apache.dubbo.rpc.protocol.tri.h3.negotiation.AutoSwitchConnectionClient], org.apache.dubbo.remoting.api.connection.AbstractConnectionClient), append/-1166366385=([java.lang.StringBuilder, char], java.lang.StringBuilder), toString/-2075883882=([java.lang.StringBuilder], java.lang.String)}
; {var43=org.apache.dubbo.rpc.protocol.tri.h3.negotiation.AutoSwitchConnectionClient, var662=r1, var1392=$r0, var3095=$r2, var3514=$z0, var3870=$r3, var1548=$r5, var479=org.apache.dubbo.remoting.api.connection.AbstractConnectionClient, var1175=$r4, var2893=java.lang.Object, var136=$r6, var1999=$r8, var478=$r7, var827=$r9, var2920=$r10, var3986=$r11}
; {org.apache.dubbo.rpc.protocol.tri.h3.negotiation.AutoSwitchConnectionClient=var43, r1=var662, $r0=var1392, $r2=var3095, $z0=var3514, $r3=var3870, $r5=var1548, org.apache.dubbo.remoting.api.connection.AbstractConnectionClient=var479, $r4=var1175, java.lang.Object=var2893, $r6=var136, $r8=var1999, $r7=var478, $r9=var827, $r10=var2920, $r11=var3986}
;seq <java.lang.StringBuilder: void <init>()>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(boolean)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.Object)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.Object)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(char)>;	<java.lang.StringBuilder: java.lang.String toString()>
;cnt {"<java.lang.StringBuilder: void <init>()>": 1,"<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>": 3,"<java.lang.StringBuilder: java.lang.StringBuilder append(boolean)>": 1,"<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.Object)>": 2,"<java.lang.StringBuilder: java.lang.StringBuilder append(char)>": 1,"<java.lang.StringBuilder: java.lang.String toString()>": 1}
;stmts r1 := @this: org.apache.dubbo.rpc.protocol.tri.h3.negotiation.AutoSwitchConnectionClient;	$r0 = new java.lang.StringBuilder;	specialinvoke $r0.<java.lang.StringBuilder: void <init>()>();	$r2 = virtualinvoke $r0.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("AutoSwitchConnectionClient{http3Enabled=");	$z0 = r1.<org.apache.dubbo.rpc.protocol.tri.h3.negotiation.AutoSwitchConnectionClient: boolean http3Connected>;	$r3 = virtualinvoke $r2.<java.lang.StringBuilder: java.lang.StringBuilder append(boolean)>($z0);	$r5 = virtualinvoke $r3.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(", http3=");	$r4 = r1.<org.apache.dubbo.rpc.protocol.tri.h3.negotiation.AutoSwitchConnectionClient: org.apache.dubbo.remoting.api.connection.AbstractConnectionClient http3ConnectionClient>;	$r6 = virtualinvoke $r5.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.Object)>($r4);	$r8 = virtualinvoke $r6.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(", http2=");	$r7 = r1.<org.apache.dubbo.rpc.protocol.tri.h3.negotiation.AutoSwitchConnectionClient: org.apache.dubbo.remoting.api.connection.AbstractConnectionClient connectionClient>;	$r9 = virtualinvoke $r8.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.Object)>($r7);	$r10 = virtualinvoke $r9.<java.lang.StringBuilder: java.lang.StringBuilder append(char)>(125);	$r11 = virtualinvoke $r10.<java.lang.StringBuilder: java.lang.String toString()>();	return $r11
;block_num 1