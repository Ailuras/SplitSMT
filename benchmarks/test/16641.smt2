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

(declare-sort var3762 0)
(declare-sort var490 0)
(declare-sort var2196 0)
(declare-sort var787 0)
(declare-sort var3094 0)
(declare-sort var3956 0)
(declare-sort var781 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun isClosed/1772375327 (var2196) Bool)
(declare-fun cast-from-var3762-to-var2196 (var3762) var2196)
(declare-fun var787-init () var787)
(declare-fun String-init () String)
(define-fun <init>/1968657023 () String "")
(define-fun append/672562846 ((s String) (tail String)) String (str.++ s tail))
(declare-fun append/-1031950772 (String var3094) String)
(declare-fun cast-from-var490-to-var3094 (var490) var3094)
(declare-fun getLocalAddress/2019899378 (var781) var3956)
(declare-fun cast-from-var3762-to-var781 (var3762) var781)
(declare-fun cast-from-var3956-to-var3094 (var3956) var3094)
(define-fun toString/-2075883882 ((s String)) String s)
(declare-fun <init>/-1092629202 (var787 String) void)
(declare-const null-var3762 var3762)
(declare-const null-var490 var490)
(declare-const var3333 var3762) ; Statement: r0 := @this: org.apache.dubbo.remoting.transport.AbstractEndpoint 
(assert (not (= var3333 null-var3762)))
(declare-const var1505 var490) ; Statement: r1 := @parameter0: org.apache.dubbo.common.URL 
(assert (not (= var1505 null-var490)))
(assert true)
(define-const var1135 Bool (isClosed/1772375327 (cast-from-var3762-to-var2196 var3333))) ; Statement: $z0 = virtualinvoke r0.<org.apache.dubbo.remoting.transport.AbstractEndpoint: boolean isClosed()>() 
 ; Statement: if $z0 == 0 goto $z1 = virtualinvoke r1.<org.apache.dubbo.common.URL: boolean hasParameter(java.lang.String)>("connect.timeout") 
(assert (not (= (ite var1135 1 0) 0))) ; Negate: Cond: $z0 == 0  
(define-const var910 var787 var787-init) ; Statement: $r3 = new java.lang.IllegalStateException 
(define-const var472 String String-init) ; Statement: $r4 = new java.lang.StringBuilder 
(assert true)
;(assert (<init>/1968657023 var472)) ; Statement: specialinvoke $r4.<java.lang.StringBuilder: void <init>()>() 
(declare-const var472!1 String)
(assert (= var472!1 ""))
(assert true)
(define-const var2068 String (append/672562846 var472!1 "Failed to reset parameters ")) ; Statement: $r5 = virtualinvoke $r4.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("Failed to reset parameters ") 
(declare-const var472!2 String)
(assert (= var472!2 (str.++ var472!1 "Failed to reset parameters ")))
(assert true)
(define-const var2394 String (append/-1031950772 var2068 (cast-from-var490-to-var3094 var1505))) ; Statement: $r6 = virtualinvoke $r5.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.Object)>(r1) 
(declare-const var2068!1 String)
(assert (str.prefixof var2068 var2068!1))
(assert true)
(define-const var1800 String (append/672562846 var2394 ", cause: Channel closed. channel: ")) ; Statement: $r8 = virtualinvoke $r6.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(", cause: Channel closed. channel: ") 
(declare-const var2394!1 String)
(assert (= var2394!1 (str.++ var2394 ", cause: Channel closed. channel: ")))
(assert true)
(define-const var3572 var3956 (getLocalAddress/2019899378 (cast-from-var3762-to-var781 var3333))) ; Statement: $r7 = virtualinvoke r0.<org.apache.dubbo.remoting.transport.AbstractEndpoint: java.net.InetSocketAddress getLocalAddress()>() 
(assert true)
(define-const var1137 String (append/-1031950772 var1800 (cast-from-var3956-to-var3094 var3572))) ; Statement: $r9 = virtualinvoke $r8.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.Object)>($r7) 
(declare-const var1800!1 String)
(assert (str.prefixof var1800 var1800!1))
(assert true)
(define-const var1223 String (toString/-2075883882 var1137)) ; Statement: $r10 = virtualinvoke $r9.<java.lang.StringBuilder: java.lang.String toString()>() 
(assert true)
;(assert (<init>/-1092629202 var910 var1223)) ; Statement: specialinvoke $r3.<java.lang.IllegalStateException: void <init>(java.lang.String)>($r10) 

(declare-const var910!1 var787)
(declare-const var1223!1 String)
 ; Statement: throw $r3 
(check-sat)
; {isClosed/1772375327=([org.apache.dubbo.remoting.transport.AbstractPeer], boolean), cast-from-var3762-to-var2196=([org.apache.dubbo.remoting.transport.AbstractEndpoint], org.apache.dubbo.remoting.transport.AbstractPeer), var787-init=([], java.lang.IllegalStateException), String-init=([], java.lang.StringBuilder), <init>/1968657023=([java.lang.StringBuilder], void), append/672562846=([java.lang.StringBuilder, java.lang.String], java.lang.StringBuilder), append/-1031950772=([java.lang.StringBuilder, java.lang.Object], java.lang.StringBuilder), cast-from-var490-to-var3094=([org.apache.dubbo.common.URL], java.lang.Object), getLocalAddress/2019899378=([org.apache.dubbo.remoting.Endpoint], java.net.InetSocketAddress), cast-from-var3762-to-var781=([org.apache.dubbo.remoting.transport.AbstractEndpoint], org.apache.dubbo.remoting.Endpoint), cast-from-var3956-to-var3094=([java.net.InetSocketAddress], java.lang.Object), toString/-2075883882=([java.lang.StringBuilder], java.lang.String), <init>/-1092629202=([java.lang.IllegalStateException, java.lang.String], void)}
; {var3762=org.apache.dubbo.remoting.transport.AbstractEndpoint, var3333=r0, var490=org.apache.dubbo.common.URL, var1505=r1, var2196=org.apache.dubbo.remoting.transport.AbstractPeer, var1135=$z0, var787=java.lang.IllegalStateException, var910=$r3, var472=$r4, var2068=$r5, var3094=java.lang.Object, var2394=$r6, var1800=$r8, var3956=java.net.InetSocketAddress, var781=org.apache.dubbo.remoting.Endpoint, var3572=$r7, var1137=$r9, var1223=$r10}
; {org.apache.dubbo.remoting.transport.AbstractEndpoint=var3762, r0=var3333, org.apache.dubbo.common.URL=var490, r1=var1505, org.apache.dubbo.remoting.transport.AbstractPeer=var2196, $z0=var1135, java.lang.IllegalStateException=var787, $r3=var910, $r4=var472, $r5=var2068, java.lang.Object=var3094, $r6=var2394, $r8=var1800, java.net.InetSocketAddress=var3956, org.apache.dubbo.remoting.Endpoint=var781, $r7=var3572, $r9=var1137, $r10=var1223}
;seq <java.lang.StringBuilder: void <init>()>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.Object)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.Object)>;	<java.lang.StringBuilder: java.lang.String toString()>
;cnt {"<java.lang.StringBuilder: void <init>()>": 1,"<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>": 2,"<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.Object)>": 2,"<java.lang.StringBuilder: java.lang.String toString()>": 1}
;stmts r0 := @this: org.apache.dubbo.remoting.transport.AbstractEndpoint;	r1 := @parameter0: org.apache.dubbo.common.URL;	$z0 = virtualinvoke r0.<org.apache.dubbo.remoting.transport.AbstractEndpoint: boolean isClosed()>();	if $z0 == 0 goto $z1 = virtualinvoke r1.<org.apache.dubbo.common.URL: boolean hasParameter(java.lang.String)>("connect.timeout");	$r3 = new java.lang.IllegalStateException;	$r4 = new java.lang.StringBuilder;	specialinvoke $r4.<java.lang.StringBuilder: void <init>()>();	$r5 = virtualinvoke $r4.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("Failed to reset parameters ");	$r6 = virtualinvoke $r5.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.Object)>(r1);	$r8 = virtualinvoke $r6.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(", cause: Channel closed. channel: ");	$r7 = virtualinvoke r0.<org.apache.dubbo.remoting.transport.AbstractEndpoint: java.net.InetSocketAddress getLocalAddress()>();	$r9 = virtualinvoke $r8.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.Object)>($r7);	$r10 = virtualinvoke $r9.<java.lang.StringBuilder: java.lang.String toString()>();	specialinvoke $r3.<java.lang.IllegalStateException: void <init>(java.lang.String)>($r10);	throw $r3
;block_num 2