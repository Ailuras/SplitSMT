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

(declare-sort var579 0)
(declare-sort var2810 0)
(declare-sort var1825 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun String-init () String)
(define-fun <init>/1968657023 () String "")
(declare-fun getInterface/-1176091465 (var579) ClassObject)
(declare-fun append/-1031950772 (String var2810) String)
(declare-fun cast-from-ClassObject-to-var2810 (ClassObject) var2810)
(define-fun append/672562846 ((s String) (tail String)) String (str.++ s tail))
(declare-fun getUrl/407699375 (var579) var1825)
(declare-fun toString/-2052709774 (var1825) String)
(define-fun toString/-2075883882 ((s String)) String s)
(declare-const null-var579 var579)
(declare-const null-var1825 var1825)
(declare-const var3442 var579) ; Statement: r1 := @this: org.apache.dubbo.rpc.proxy.AbstractProxyInvoker 
(assert (not (= var3442 null-var579)))
(define-const var437 String String-init) ; Statement: $r0 = new java.lang.StringBuilder 
(assert true)
;(assert (<init>/1968657023 var437)) ; Statement: specialinvoke $r0.<java.lang.StringBuilder: void <init>()>() 
(declare-const var437!1 String)
(assert (= var437!1 ""))
(assert true)
(define-const var1466 ClassObject (getInterface/-1176091465 var3442)) ; Statement: $r2 = virtualinvoke r1.<org.apache.dubbo.rpc.proxy.AbstractProxyInvoker: java.lang.Class getInterface()>() 
(assert true)
(define-const var2637 String (append/-1031950772 var437!1 (cast-from-ClassObject-to-var2810 var1466))) ; Statement: $r3 = virtualinvoke $r0.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.Object)>($r2) 
(declare-const var437!2 String)
(assert (str.prefixof var437!1 var437!2))
(assert true)
(define-const var438 String (append/672562846 var2637 " -> ")) ; Statement: $r6 = virtualinvoke $r3.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(" -> ") 
(declare-const var2637!1 String)
(assert (= var2637!1 (str.++ var2637 " -> ")))
(assert true)
(define-const var144 var1825 (getUrl/407699375 var3442)) ; Statement: $r4 = virtualinvoke r1.<org.apache.dubbo.rpc.proxy.AbstractProxyInvoker: org.apache.dubbo.common.URL getUrl()>() 
 ; Statement: if $r4 != null goto $r5 = virtualinvoke r1.<org.apache.dubbo.rpc.proxy.AbstractProxyInvoker: org.apache.dubbo.common.URL getUrl()>() 
(assert (not (= var144 null-var1825))) ; Cond: $r4 != null 
(assert true)
(define-const var1910 var1825 (getUrl/407699375 var3442)) ; Statement: $r5 = virtualinvoke r1.<org.apache.dubbo.rpc.proxy.AbstractProxyInvoker: org.apache.dubbo.common.URL getUrl()>() 
(assert true)
(define-const var1600 String (toString/-2052709774 var1910)) ; Statement: $r9 = virtualinvoke $r5.<org.apache.dubbo.common.URL: java.lang.String toString()>() 
(assert true) ; Non Conditional
(assert true)
(define-const var153 String (append/672562846 var438 var1600)) ; Statement: $r7 = virtualinvoke $r6.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>($r9) 
(declare-const var438!1 String)
(assert (= var438!1 (str.++ var438 var1600)))
(assert true)
(define-const var3547 String (toString/-2075883882 var153)) ; Statement: $r8 = virtualinvoke $r7.<java.lang.StringBuilder: java.lang.String toString()>() 
 ; Statement: return $r8 
(check-sat)
; {String-init=([], java.lang.StringBuilder), <init>/1968657023=([java.lang.StringBuilder], void), getInterface/-1176091465=([org.apache.dubbo.rpc.proxy.AbstractProxyInvoker], java.lang.Class), append/-1031950772=([java.lang.StringBuilder, java.lang.Object], java.lang.StringBuilder), cast-from-ClassObject-to-var2810=([java.lang.Class], java.lang.Object), append/672562846=([java.lang.StringBuilder, java.lang.String], java.lang.StringBuilder), getUrl/407699375=([org.apache.dubbo.rpc.proxy.AbstractProxyInvoker], org.apache.dubbo.common.URL), toString/-2052709774=([org.apache.dubbo.common.URL], java.lang.String), toString/-2075883882=([java.lang.StringBuilder], java.lang.String)}
; {var579=org.apache.dubbo.rpc.proxy.AbstractProxyInvoker, var3442=r1, var437=$r0, var1466=$r2, var2810=java.lang.Object, var2637=$r3, var438=$r6, var1825=org.apache.dubbo.common.URL, var144=$r4, var1910=$r5, var1600=$r9, var153=$r7, var3547=$r8}
; {org.apache.dubbo.rpc.proxy.AbstractProxyInvoker=var579, r1=var3442, $r0=var437, $r2=var1466, java.lang.Object=var2810, $r3=var2637, $r6=var438, org.apache.dubbo.common.URL=var1825, $r4=var144, $r5=var1910, $r9=var1600, $r7=var153, $r8=var3547}
;seq <java.lang.StringBuilder: void <init>()>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.Object)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<org.apache.dubbo.common.URL: java.lang.String toString()>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.String toString()>
;cnt {"<java.lang.StringBuilder: void <init>()>": 1,"<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.Object)>": 1,"<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>": 2,"<java.lang.StringBuilder: java.lang.String toString()>": 1}
;stmts r1 := @this: org.apache.dubbo.rpc.proxy.AbstractProxyInvoker;	$r0 = new java.lang.StringBuilder;	specialinvoke $r0.<java.lang.StringBuilder: void <init>()>();	$r2 = virtualinvoke r1.<org.apache.dubbo.rpc.proxy.AbstractProxyInvoker: java.lang.Class getInterface()>();	$r3 = virtualinvoke $r0.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.Object)>($r2);	$r6 = virtualinvoke $r3.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(" -> ");	$r4 = virtualinvoke r1.<org.apache.dubbo.rpc.proxy.AbstractProxyInvoker: org.apache.dubbo.common.URL getUrl()>();	if $r4 != null goto $r5 = virtualinvoke r1.<org.apache.dubbo.rpc.proxy.AbstractProxyInvoker: org.apache.dubbo.common.URL getUrl()>();	$r5 = virtualinvoke r1.<org.apache.dubbo.rpc.proxy.AbstractProxyInvoker: org.apache.dubbo.common.URL getUrl()>();	$r9 = virtualinvoke $r5.<org.apache.dubbo.common.URL: java.lang.String toString()>();	$r7 = virtualinvoke $r6.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>($r9);	$r8 = virtualinvoke $r7.<java.lang.StringBuilder: java.lang.String toString()>();	return $r8
;block_num 3