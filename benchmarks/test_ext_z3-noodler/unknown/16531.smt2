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

(declare-sort var740 0)
(declare-sort var349 0)
(declare-sort var3349 0)
(declare-sort var1641 0)
(declare-sort var2519 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun String-init () String)
(define-fun <init>/1968657023 () String "")
(declare-fun getLocalAddress/2019899378 (var3349) var349)
(declare-fun cast-from-var740-to-var3349 (var740) var3349)
(declare-fun append/-1031950772 (String var1641) String)
(declare-fun cast-from-var349-to-var1641 (var349) var1641)
(define-fun append/672562846 ((s String) (tail String)) String (str.++ s tail))
(declare-fun getRemoteAddress/1597111645 (var2519) var349)
(declare-fun cast-from-var740-to-var2519 (var740) var2519)
(define-fun toString/-2075883882 ((s String)) String s)
(declare-const null-var740 var740)
(declare-const var2726 var740) ; Statement: r1 := @this: org.apache.dubbo.remoting.transport.AbstractChannel 
(assert (not (= var2726 null-var740)))
(define-const var2246 String String-init) ; Statement: $r0 = new java.lang.StringBuilder 
(assert true)
;(assert (<init>/1968657023 var2246)) ; Statement: specialinvoke $r0.<java.lang.StringBuilder: void <init>()>() 
(declare-const var2246!1 String)
(assert (= var2246!1 ""))
(assert true)
(define-const var80 var349 (getLocalAddress/2019899378 (cast-from-var740-to-var3349 var2726))) ; Statement: $r2 = virtualinvoke r1.<org.apache.dubbo.remoting.transport.AbstractChannel: java.net.InetSocketAddress getLocalAddress()>() 
(assert true)
(define-const var1976 String (append/-1031950772 var2246!1 (cast-from-var349-to-var1641 var80))) ; Statement: $r3 = virtualinvoke $r0.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.Object)>($r2) 
(declare-const var2246!2 String)
(assert (str.prefixof var2246!1 var2246!2))
(assert true)
(define-const var3866 String (append/672562846 var1976 " -> ")) ; Statement: $r5 = virtualinvoke $r3.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(" -> ") 
(declare-const var1976!1 String)
(assert (= var1976!1 (str.++ var1976 " -> ")))
(assert true)
(define-const var962 var349 (getRemoteAddress/1597111645 (cast-from-var740-to-var2519 var2726))) ; Statement: $r4 = virtualinvoke r1.<org.apache.dubbo.remoting.transport.AbstractChannel: java.net.InetSocketAddress getRemoteAddress()>() 
(assert true)
(define-const var1805 String (append/-1031950772 var3866 (cast-from-var349-to-var1641 var962))) ; Statement: $r6 = virtualinvoke $r5.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.Object)>($r4) 
(declare-const var3866!1 String)
(assert (str.prefixof var3866 var3866!1))
(assert true)
(define-const var1791 String (toString/-2075883882 var1805)) ; Statement: $r7 = virtualinvoke $r6.<java.lang.StringBuilder: java.lang.String toString()>() 
 ; Statement: return $r7 
(check-sat)
; {String-init=([], java.lang.StringBuilder), <init>/1968657023=([java.lang.StringBuilder], void), getLocalAddress/2019899378=([org.apache.dubbo.remoting.Endpoint], java.net.InetSocketAddress), cast-from-var740-to-var3349=([org.apache.dubbo.remoting.transport.AbstractChannel], org.apache.dubbo.remoting.Endpoint), append/-1031950772=([java.lang.StringBuilder, java.lang.Object], java.lang.StringBuilder), cast-from-var349-to-var1641=([java.net.InetSocketAddress], java.lang.Object), append/672562846=([java.lang.StringBuilder, java.lang.String], java.lang.StringBuilder), getRemoteAddress/1597111645=([org.apache.dubbo.remoting.Channel], java.net.InetSocketAddress), cast-from-var740-to-var2519=([org.apache.dubbo.remoting.transport.AbstractChannel], org.apache.dubbo.remoting.Channel), toString/-2075883882=([java.lang.StringBuilder], java.lang.String)}
; {var740=org.apache.dubbo.remoting.transport.AbstractChannel, var2726=r1, var2246=$r0, var349=java.net.InetSocketAddress, var3349=org.apache.dubbo.remoting.Endpoint, var80=$r2, var1641=java.lang.Object, var1976=$r3, var3866=$r5, var2519=org.apache.dubbo.remoting.Channel, var962=$r4, var1805=$r6, var1791=$r7}
; {org.apache.dubbo.remoting.transport.AbstractChannel=var740, r1=var2726, $r0=var2246, java.net.InetSocketAddress=var349, org.apache.dubbo.remoting.Endpoint=var3349, $r2=var80, java.lang.Object=var1641, $r3=var1976, $r5=var3866, org.apache.dubbo.remoting.Channel=var2519, $r4=var962, $r6=var1805, $r7=var1791}
;seq <java.lang.StringBuilder: void <init>()>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.Object)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.Object)>;	<java.lang.StringBuilder: java.lang.String toString()>
;cnt {"<java.lang.StringBuilder: void <init>()>": 1,"<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.Object)>": 2,"<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>": 1,"<java.lang.StringBuilder: java.lang.String toString()>": 1}
;stmts r1 := @this: org.apache.dubbo.remoting.transport.AbstractChannel;	$r0 = new java.lang.StringBuilder;	specialinvoke $r0.<java.lang.StringBuilder: void <init>()>();	$r2 = virtualinvoke r1.<org.apache.dubbo.remoting.transport.AbstractChannel: java.net.InetSocketAddress getLocalAddress()>();	$r3 = virtualinvoke $r0.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.Object)>($r2);	$r5 = virtualinvoke $r3.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(" -> ");	$r4 = virtualinvoke r1.<org.apache.dubbo.remoting.transport.AbstractChannel: java.net.InetSocketAddress getRemoteAddress()>();	$r6 = virtualinvoke $r5.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.Object)>($r4);	$r7 = virtualinvoke $r6.<java.lang.StringBuilder: java.lang.String toString()>();	return $r7
;block_num 1