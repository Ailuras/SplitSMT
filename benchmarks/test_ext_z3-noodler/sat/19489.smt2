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

(declare-sort var3012 0)
(declare-sort var2829 0)
(declare-sort var879 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun String-init () String)
(define-fun <init>/1968657023 () String "")
(declare-fun getInterface/-178385660 (var3012) ClassObject)
(declare-fun append/-1031950772 (String var2829) String)
(declare-fun cast-from-ClassObject-to-var2829 (ClassObject) var2829)
(define-fun append/672562846 ((s String) (tail String)) String (str.++ s tail))
(declare-fun getUrl/1712233020 (var3012) var879)
(declare-fun toString/-2052709774 (var879) String)
(define-fun toString/-2075883882 ((s String)) String s)
(declare-const null-var3012 var3012)
(declare-const null-var879 var879)
(declare-const var134 var3012) ; Statement: r1 := @this: org.apache.dubbo.rpc.listener.ListenerInvokerWrapper 
(assert (not (= var134 null-var3012)))
(define-const var3043 String String-init) ; Statement: $r0 = new java.lang.StringBuilder 
(assert true)
;(assert (<init>/1968657023 var3043)) ; Statement: specialinvoke $r0.<java.lang.StringBuilder: void <init>()>() 
(declare-const var3043!1 String)
(assert (= var3043!1 ""))
(assert true)
(define-const var1549 ClassObject (getInterface/-178385660 var134)) ; Statement: $r2 = virtualinvoke r1.<org.apache.dubbo.rpc.listener.ListenerInvokerWrapper: java.lang.Class getInterface()>() 
(assert true)
(define-const var939 String (append/-1031950772 var3043!1 (cast-from-ClassObject-to-var2829 var1549))) ; Statement: $r3 = virtualinvoke $r0.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.Object)>($r2) 
(declare-const var3043!2 String)
(assert (str.prefixof var3043!1 var3043!2))
(assert true)
(define-const var2025 String (append/672562846 var939 " -> ")) ; Statement: $r6 = virtualinvoke $r3.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(" -> ") 
(declare-const var939!1 String)
(assert (= var939!1 (str.++ var939 " -> ")))
(assert true)
(define-const var2331 var879 (getUrl/1712233020 var134)) ; Statement: $r4 = virtualinvoke r1.<org.apache.dubbo.rpc.listener.ListenerInvokerWrapper: org.apache.dubbo.common.URL getUrl()>() 
 ; Statement: if $r4 != null goto $r5 = virtualinvoke r1.<org.apache.dubbo.rpc.listener.ListenerInvokerWrapper: org.apache.dubbo.common.URL getUrl()>() 
(assert (not (= var2331 null-var879))) ; Cond: $r4 != null 
(assert true)
(define-const var1931 var879 (getUrl/1712233020 var134)) ; Statement: $r5 = virtualinvoke r1.<org.apache.dubbo.rpc.listener.ListenerInvokerWrapper: org.apache.dubbo.common.URL getUrl()>() 
(assert true)
(define-const var3421 String (toString/-2052709774 var1931)) ; Statement: $r9 = virtualinvoke $r5.<org.apache.dubbo.common.URL: java.lang.String toString()>() 
(assert true) ; Non Conditional
(assert true)
(define-const var1935 String (append/672562846 var2025 var3421)) ; Statement: $r7 = virtualinvoke $r6.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>($r9) 
(declare-const var2025!1 String)
(assert (= var2025!1 (str.++ var2025 var3421)))
(assert true)
(define-const var1605 String (toString/-2075883882 var1935)) ; Statement: $r8 = virtualinvoke $r7.<java.lang.StringBuilder: java.lang.String toString()>() 
 ; Statement: return $r8 
(check-sat)
; {String-init=([], java.lang.StringBuilder), <init>/1968657023=([java.lang.StringBuilder], void), getInterface/-178385660=([org.apache.dubbo.rpc.listener.ListenerInvokerWrapper], java.lang.Class), append/-1031950772=([java.lang.StringBuilder, java.lang.Object], java.lang.StringBuilder), cast-from-ClassObject-to-var2829=([java.lang.Class], java.lang.Object), append/672562846=([java.lang.StringBuilder, java.lang.String], java.lang.StringBuilder), getUrl/1712233020=([org.apache.dubbo.rpc.listener.ListenerInvokerWrapper], org.apache.dubbo.common.URL), toString/-2052709774=([org.apache.dubbo.common.URL], java.lang.String), toString/-2075883882=([java.lang.StringBuilder], java.lang.String)}
; {var3012=org.apache.dubbo.rpc.listener.ListenerInvokerWrapper, var134=r1, var3043=$r0, var1549=$r2, var2829=java.lang.Object, var939=$r3, var2025=$r6, var879=org.apache.dubbo.common.URL, var2331=$r4, var1931=$r5, var3421=$r9, var1935=$r7, var1605=$r8}
; {org.apache.dubbo.rpc.listener.ListenerInvokerWrapper=var3012, r1=var134, $r0=var3043, $r2=var1549, java.lang.Object=var2829, $r3=var939, $r6=var2025, org.apache.dubbo.common.URL=var879, $r4=var2331, $r5=var1931, $r9=var3421, $r7=var1935, $r8=var1605}
;seq <java.lang.StringBuilder: void <init>()>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.Object)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<org.apache.dubbo.common.URL: java.lang.String toString()>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.String toString()>
;cnt {"<java.lang.StringBuilder: void <init>()>": 1,"<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.Object)>": 1,"<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>": 2,"<java.lang.StringBuilder: java.lang.String toString()>": 1}
;stmts r1 := @this: org.apache.dubbo.rpc.listener.ListenerInvokerWrapper;	$r0 = new java.lang.StringBuilder;	specialinvoke $r0.<java.lang.StringBuilder: void <init>()>();	$r2 = virtualinvoke r1.<org.apache.dubbo.rpc.listener.ListenerInvokerWrapper: java.lang.Class getInterface()>();	$r3 = virtualinvoke $r0.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.Object)>($r2);	$r6 = virtualinvoke $r3.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(" -> ");	$r4 = virtualinvoke r1.<org.apache.dubbo.rpc.listener.ListenerInvokerWrapper: org.apache.dubbo.common.URL getUrl()>();	if $r4 != null goto $r5 = virtualinvoke r1.<org.apache.dubbo.rpc.listener.ListenerInvokerWrapper: org.apache.dubbo.common.URL getUrl()>();	$r5 = virtualinvoke r1.<org.apache.dubbo.rpc.listener.ListenerInvokerWrapper: org.apache.dubbo.common.URL getUrl()>();	$r9 = virtualinvoke $r5.<org.apache.dubbo.common.URL: java.lang.String toString()>();	$r7 = virtualinvoke $r6.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>($r9);	$r8 = virtualinvoke $r7.<java.lang.StringBuilder: java.lang.String toString()>();	return $r8
;block_num 3