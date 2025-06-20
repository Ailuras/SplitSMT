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

(declare-sort var823 0)
(declare-sort var393 0)
(declare-sort var2760 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun String-init () String)
(define-fun <init>/1968657023 () String "")
(declare-fun getClass/1258963082 (var393) ClassObject)
(declare-fun cast-from-var823-to-var393 (var823) var393)
(declare-fun getName/-1958580599 (ClassObject) String)
(define-fun append/672562846 ((s String) (tail String)) String (str.++ s tail))
(declare-fun getLocalAddress/-1034328587 (var823) var2760)
(declare-fun append/-1031950772 (String var393) String)
(declare-fun cast-from-var2760-to-var393 (var2760) var393)
(declare-fun getRemoteAddress/-557105490 (var823) var2760)
(define-fun toString/-2075883882 ((s String)) String s)
(declare-const null-var823 var823)
(declare-const var7 var823) ; Statement: r1 := @this: org.apache.dubbo.remoting.transport.AbstractClient 
(assert (not (= var7 null-var823)))
(define-const var91 String String-init) ; Statement: $r0 = new java.lang.StringBuilder 
(assert true)
;(assert (<init>/1968657023 var91)) ; Statement: specialinvoke $r0.<java.lang.StringBuilder: void <init>()>() 
(declare-const var91!1 String)
(assert (= var91!1 ""))
(assert true)
(define-const var2260 ClassObject (getClass/1258963082 (cast-from-var823-to-var393 var7))) ; Statement: $r2 = virtualinvoke r1.<java.lang.Object: java.lang.Class getClass()>() 
(assert true)
(define-const var955 String (getName/-1958580599 var2260)) ; Statement: $r3 = virtualinvoke $r2.<java.lang.Class: java.lang.String getName()>() 
(assert true)
(define-const var3785 String (append/672562846 var91!1 var955)) ; Statement: $r4 = virtualinvoke $r0.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>($r3) 
(declare-const var91!2 String)
(assert (= var91!2 (str.++ var91!1 var955)))
(assert true)
(define-const var3347 String (append/672562846 var3785 " [")) ; Statement: $r6 = virtualinvoke $r4.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(" [") 
(declare-const var3785!1 String)
(assert (= var3785!1 (str.++ var3785 " [")))
(assert true)
(define-const var1276 var2760 (getLocalAddress/-1034328587 var7)) ; Statement: $r5 = virtualinvoke r1.<org.apache.dubbo.remoting.transport.AbstractClient: java.net.InetSocketAddress getLocalAddress()>() 
(assert true)
(define-const var2174 String (append/-1031950772 var3347 (cast-from-var2760-to-var393 var1276))) ; Statement: $r7 = virtualinvoke $r6.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.Object)>($r5) 
(declare-const var3347!1 String)
(assert (str.prefixof var3347 var3347!1))
(assert true)
(define-const var2505 String (append/672562846 var2174 " -> ")) ; Statement: $r9 = virtualinvoke $r7.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(" -> ") 
(declare-const var2174!1 String)
(assert (= var2174!1 (str.++ var2174 " -> ")))
(assert true)
(define-const var265 var2760 (getRemoteAddress/-557105490 var7)) ; Statement: $r8 = virtualinvoke r1.<org.apache.dubbo.remoting.transport.AbstractClient: java.net.InetSocketAddress getRemoteAddress()>() 
(assert true)
(define-const var1292 String (append/-1031950772 var2505 (cast-from-var2760-to-var393 var265))) ; Statement: $r10 = virtualinvoke $r9.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.Object)>($r8) 
(declare-const var2505!1 String)
(assert (str.prefixof var2505 var2505!1))
(assert true)
(define-const var228 String (append/672562846 var1292 "]")) ; Statement: $r11 = virtualinvoke $r10.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("]") 
(declare-const var1292!1 String)
(assert (= var1292!1 (str.++ var1292 "]")))
(assert true)
(define-const var1262 String (toString/-2075883882 var228)) ; Statement: $r12 = virtualinvoke $r11.<java.lang.StringBuilder: java.lang.String toString()>() 
 ; Statement: return $r12 
(check-sat)
; {String-init=([], java.lang.StringBuilder), <init>/1968657023=([java.lang.StringBuilder], void), getClass/1258963082=([java.lang.Object], java.lang.Class), cast-from-var823-to-var393=([org.apache.dubbo.remoting.transport.AbstractClient], java.lang.Object), getName/-1958580599=([java.lang.Class], java.lang.String), append/672562846=([java.lang.StringBuilder, java.lang.String], java.lang.StringBuilder), getLocalAddress/-1034328587=([org.apache.dubbo.remoting.transport.AbstractClient], java.net.InetSocketAddress), append/-1031950772=([java.lang.StringBuilder, java.lang.Object], java.lang.StringBuilder), cast-from-var2760-to-var393=([java.net.InetSocketAddress], java.lang.Object), getRemoteAddress/-557105490=([org.apache.dubbo.remoting.transport.AbstractClient], java.net.InetSocketAddress), toString/-2075883882=([java.lang.StringBuilder], java.lang.String)}
; {var823=org.apache.dubbo.remoting.transport.AbstractClient, var7=r1, var91=$r0, var393=java.lang.Object, var2260=$r2, var955=$r3, var3785=$r4, var3347=$r6, var2760=java.net.InetSocketAddress, var1276=$r5, var2174=$r7, var2505=$r9, var265=$r8, var1292=$r10, var228=$r11, var1262=$r12}
; {org.apache.dubbo.remoting.transport.AbstractClient=var823, r1=var7, $r0=var91, java.lang.Object=var393, $r2=var2260, $r3=var955, $r4=var3785, $r6=var3347, java.net.InetSocketAddress=var2760, $r5=var1276, $r7=var2174, $r9=var2505, $r8=var265, $r10=var1292, $r11=var228, $r12=var1262}
;seq <java.lang.StringBuilder: void <init>()>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.Object)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.Object)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.String toString()>
;cnt {"<java.lang.StringBuilder: void <init>()>": 1,"<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>": 4,"<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.Object)>": 2,"<java.lang.StringBuilder: java.lang.String toString()>": 1}
;stmts r1 := @this: org.apache.dubbo.remoting.transport.AbstractClient;	$r0 = new java.lang.StringBuilder;	specialinvoke $r0.<java.lang.StringBuilder: void <init>()>();	$r2 = virtualinvoke r1.<java.lang.Object: java.lang.Class getClass()>();	$r3 = virtualinvoke $r2.<java.lang.Class: java.lang.String getName()>();	$r4 = virtualinvoke $r0.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>($r3);	$r6 = virtualinvoke $r4.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(" [");	$r5 = virtualinvoke r1.<org.apache.dubbo.remoting.transport.AbstractClient: java.net.InetSocketAddress getLocalAddress()>();	$r7 = virtualinvoke $r6.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.Object)>($r5);	$r9 = virtualinvoke $r7.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(" -> ");	$r8 = virtualinvoke r1.<org.apache.dubbo.remoting.transport.AbstractClient: java.net.InetSocketAddress getRemoteAddress()>();	$r10 = virtualinvoke $r9.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.Object)>($r8);	$r11 = virtualinvoke $r10.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("]");	$r12 = virtualinvoke $r11.<java.lang.StringBuilder: java.lang.String toString()>();	return $r12
;block_num 1