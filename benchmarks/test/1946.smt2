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

(declare-sort var3971 0)
(declare-sort var1104 0)
(declare-sort var3018 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun String-init () String)
(define-fun <init>/1968657023 () String "")
(declare-fun getInterface/-134461520 (var3971) ClassObject)
(declare-fun append/-1031950772 (String var1104) String)
(declare-fun cast-from-ClassObject-to-var1104 (ClassObject) var1104)
(define-fun append/672562846 ((s String) (tail String)) String (str.++ s tail))
(declare-fun getUrl/776545256 (var3971) var3018)
(declare-fun toString/-2052709774 (var3018) String)
(define-fun toString/-2075883882 ((s String)) String s)
(declare-const null-var3971 var3971)
(declare-const var2070 var3971) ; Statement: r1 := @this: org.apache.dubbo.rpc.cluster.support.AbstractClusterInvoker 
(assert (not (= var2070 null-var3971)))
(define-const var2310 String String-init) ; Statement: $r0 = new java.lang.StringBuilder 
(assert true)
;(assert (<init>/1968657023 var2310)) ; Statement: specialinvoke $r0.<java.lang.StringBuilder: void <init>()>() 
(declare-const var2310!1 String)
(assert (= var2310!1 ""))
(assert true)
(define-const var1998 ClassObject (getInterface/-134461520 var2070)) ; Statement: $r2 = virtualinvoke r1.<org.apache.dubbo.rpc.cluster.support.AbstractClusterInvoker: java.lang.Class getInterface()>() 
(assert true)
(define-const var3375 String (append/-1031950772 var2310!1 (cast-from-ClassObject-to-var1104 var1998))) ; Statement: $r3 = virtualinvoke $r0.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.Object)>($r2) 
(declare-const var2310!2 String)
(assert (str.prefixof var2310!1 var2310!2))
(assert true)
(define-const var1076 String (append/672562846 var3375 " -> ")) ; Statement: $r6 = virtualinvoke $r3.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(" -> ") 
(declare-const var3375!1 String)
(assert (= var3375!1 (str.++ var3375 " -> ")))
(assert true)
(define-const var876 var3018 (getUrl/776545256 var2070)) ; Statement: $r4 = virtualinvoke r1.<org.apache.dubbo.rpc.cluster.support.AbstractClusterInvoker: org.apache.dubbo.common.URL getUrl()>() 
(assert true)
(define-const var810 String (toString/-2052709774 var876)) ; Statement: $r5 = virtualinvoke $r4.<org.apache.dubbo.common.URL: java.lang.String toString()>() 
(assert true)
(define-const var3703 String (append/672562846 var1076 var810)) ; Statement: $r7 = virtualinvoke $r6.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>($r5) 
(declare-const var1076!1 String)
(assert (= var1076!1 (str.++ var1076 var810)))
(assert true)
(define-const var2864 String (toString/-2075883882 var3703)) ; Statement: $r8 = virtualinvoke $r7.<java.lang.StringBuilder: java.lang.String toString()>() 
 ; Statement: return $r8 
(check-sat)
; {String-init=([], java.lang.StringBuilder), <init>/1968657023=([java.lang.StringBuilder], void), getInterface/-134461520=([org.apache.dubbo.rpc.cluster.support.AbstractClusterInvoker], java.lang.Class), append/-1031950772=([java.lang.StringBuilder, java.lang.Object], java.lang.StringBuilder), cast-from-ClassObject-to-var1104=([java.lang.Class], java.lang.Object), append/672562846=([java.lang.StringBuilder, java.lang.String], java.lang.StringBuilder), getUrl/776545256=([org.apache.dubbo.rpc.cluster.support.AbstractClusterInvoker], org.apache.dubbo.common.URL), toString/-2052709774=([org.apache.dubbo.common.URL], java.lang.String), toString/-2075883882=([java.lang.StringBuilder], java.lang.String)}
; {var3971=org.apache.dubbo.rpc.cluster.support.AbstractClusterInvoker, var2070=r1, var2310=$r0, var1998=$r2, var1104=java.lang.Object, var3375=$r3, var1076=$r6, var3018=org.apache.dubbo.common.URL, var876=$r4, var810=$r5, var3703=$r7, var2864=$r8}
; {org.apache.dubbo.rpc.cluster.support.AbstractClusterInvoker=var3971, r1=var2070, $r0=var2310, $r2=var1998, java.lang.Object=var1104, $r3=var3375, $r6=var1076, org.apache.dubbo.common.URL=var3018, $r4=var876, $r5=var810, $r7=var3703, $r8=var2864}
;seq <java.lang.StringBuilder: void <init>()>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.Object)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<org.apache.dubbo.common.URL: java.lang.String toString()>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.String toString()>
;cnt {"<java.lang.StringBuilder: void <init>()>": 1,"<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.Object)>": 1,"<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>": 2,"<java.lang.StringBuilder: java.lang.String toString()>": 1}
;stmts r1 := @this: org.apache.dubbo.rpc.cluster.support.AbstractClusterInvoker;	$r0 = new java.lang.StringBuilder;	specialinvoke $r0.<java.lang.StringBuilder: void <init>()>();	$r2 = virtualinvoke r1.<org.apache.dubbo.rpc.cluster.support.AbstractClusterInvoker: java.lang.Class getInterface()>();	$r3 = virtualinvoke $r0.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.Object)>($r2);	$r6 = virtualinvoke $r3.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(" -> ");	$r4 = virtualinvoke r1.<org.apache.dubbo.rpc.cluster.support.AbstractClusterInvoker: org.apache.dubbo.common.URL getUrl()>();	$r5 = virtualinvoke $r4.<org.apache.dubbo.common.URL: java.lang.String toString()>();	$r7 = virtualinvoke $r6.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>($r5);	$r8 = virtualinvoke $r7.<java.lang.StringBuilder: java.lang.String toString()>();	return $r8
;block_num 1