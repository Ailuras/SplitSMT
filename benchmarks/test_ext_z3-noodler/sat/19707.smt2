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

(declare-sort var3239 0)
(declare-sort var582 0)
(declare-sort var2880 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun String-init () String)
(define-fun <init>/1968657023 () String "")
(declare-fun getInterface/-1176091465 (var3239) ClassObject)
(declare-fun append/-1031950772 (String var582) String)
(declare-fun cast-from-ClassObject-to-var582 (ClassObject) var582)
(define-fun append/672562846 ((s String) (tail String)) String (str.++ s tail))
(declare-fun getUrl/407699375 (var3239) var2880)
(define-fun toString/-2075883882 ((s String)) String s)
(declare-const null-var3239 var3239)
(declare-const null-var2880 var2880)
(declare-const var623 var3239) ; Statement: r1 := @this: org.apache.dubbo.rpc.proxy.AbstractProxyInvoker 
(assert (not (= var623 null-var3239)))
(define-const var2165 String String-init) ; Statement: $r0 = new java.lang.StringBuilder 
(assert true)
;(assert (<init>/1968657023 var2165)) ; Statement: specialinvoke $r0.<java.lang.StringBuilder: void <init>()>() 
(declare-const var2165!1 String)
(assert (= var2165!1 ""))
(assert true)
(define-const var491 ClassObject (getInterface/-1176091465 var623)) ; Statement: $r2 = virtualinvoke r1.<org.apache.dubbo.rpc.proxy.AbstractProxyInvoker: java.lang.Class getInterface()>() 
(assert true)
(define-const var3109 String (append/-1031950772 var2165!1 (cast-from-ClassObject-to-var582 var491))) ; Statement: $r3 = virtualinvoke $r0.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.Object)>($r2) 
(declare-const var2165!2 String)
(assert (str.prefixof var2165!1 var2165!2))
(assert true)
(define-const var430 String (append/672562846 var3109 " -> ")) ; Statement: $r6 = virtualinvoke $r3.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(" -> ") 
(declare-const var3109!1 String)
(assert (= var3109!1 (str.++ var3109 " -> ")))
(assert true)
(define-const var3162 var2880 (getUrl/407699375 var623)) ; Statement: $r4 = virtualinvoke r1.<org.apache.dubbo.rpc.proxy.AbstractProxyInvoker: org.apache.dubbo.common.URL getUrl()>() 
 ; Statement: if $r4 != null goto $r5 = virtualinvoke r1.<org.apache.dubbo.rpc.proxy.AbstractProxyInvoker: org.apache.dubbo.common.URL getUrl()>() 
(assert (not (not (= var3162 null-var2880)))) ; Negate: Cond: $r4 != null  
(define-const var3212 String " ") ; Statement: $r9 = " " 
 ; Statement: goto [?= $r7 = virtualinvoke $r6.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>($r9)] 
(assert true) ; Non Conditional
(assert true)
(define-const var2917 String (append/672562846 var430 var3212)) ; Statement: $r7 = virtualinvoke $r6.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>($r9) 
(declare-const var430!1 String)
(assert (= var430!1 (str.++ var430 var3212)))
(assert true)
(define-const var3699 String (toString/-2075883882 var2917)) ; Statement: $r8 = virtualinvoke $r7.<java.lang.StringBuilder: java.lang.String toString()>() 
 ; Statement: return $r8 
(check-sat)
; {String-init=([], java.lang.StringBuilder), <init>/1968657023=([java.lang.StringBuilder], void), getInterface/-1176091465=([org.apache.dubbo.rpc.proxy.AbstractProxyInvoker], java.lang.Class), append/-1031950772=([java.lang.StringBuilder, java.lang.Object], java.lang.StringBuilder), cast-from-ClassObject-to-var582=([java.lang.Class], java.lang.Object), append/672562846=([java.lang.StringBuilder, java.lang.String], java.lang.StringBuilder), getUrl/407699375=([org.apache.dubbo.rpc.proxy.AbstractProxyInvoker], org.apache.dubbo.common.URL), toString/-2075883882=([java.lang.StringBuilder], java.lang.String)}
; {var3239=org.apache.dubbo.rpc.proxy.AbstractProxyInvoker, var623=r1, var2165=$r0, var491=$r2, var582=java.lang.Object, var3109=$r3, var430=$r6, var2880=org.apache.dubbo.common.URL, var3162=$r4, var3212=$r9, var2917=$r7, var3699=$r8}
; {org.apache.dubbo.rpc.proxy.AbstractProxyInvoker=var3239, r1=var623, $r0=var2165, $r2=var491, java.lang.Object=var582, $r3=var3109, $r6=var430, org.apache.dubbo.common.URL=var2880, $r4=var3162, $r9=var3212, $r7=var2917, $r8=var3699}
;seq <java.lang.StringBuilder: void <init>()>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.Object)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.String toString()>
;cnt {"<java.lang.StringBuilder: void <init>()>": 1,"<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.Object)>": 1,"<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>": 2,"<java.lang.StringBuilder: java.lang.String toString()>": 1}
;stmts r1 := @this: org.apache.dubbo.rpc.proxy.AbstractProxyInvoker;	$r0 = new java.lang.StringBuilder;	specialinvoke $r0.<java.lang.StringBuilder: void <init>()>();	$r2 = virtualinvoke r1.<org.apache.dubbo.rpc.proxy.AbstractProxyInvoker: java.lang.Class getInterface()>();	$r3 = virtualinvoke $r0.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.Object)>($r2);	$r6 = virtualinvoke $r3.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(" -> ");	$r4 = virtualinvoke r1.<org.apache.dubbo.rpc.proxy.AbstractProxyInvoker: org.apache.dubbo.common.URL getUrl()>();	if $r4 != null goto $r5 = virtualinvoke r1.<org.apache.dubbo.rpc.proxy.AbstractProxyInvoker: org.apache.dubbo.common.URL getUrl()>();	$r9 = " ";	goto [?= $r7 = virtualinvoke $r6.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>($r9)];	$r7 = virtualinvoke $r6.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>($r9);	$r8 = virtualinvoke $r7.<java.lang.StringBuilder: java.lang.String toString()>();	return $r8
;block_num 3