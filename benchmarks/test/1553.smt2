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

(declare-sort var797 0)
(declare-sort var1606 0)
(declare-sort var3482 0)
(declare-sort var1572 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun String-init () String)
(define-fun <init>/1968657023 () String "")
(define-fun append/672562846 ((s String) (tail String)) String (str.++ s tail))
(declare-fun invoker/449019207 (var797) var1606)
(declare-fun append/-1031950772 (String var3482) String)
(declare-fun cast-from-var1606-to-var3482 (var1606) var3482)
(declare-fun directory/449019207 (var797) var1572)
(declare-fun cast-from-var1572-to-var3482 (var1572) var3482)
(define-fun toString/-2075883882 ((s String)) String s)
(declare-const null-var797 var797)
(declare-const var1532 var797) ; Statement: r1 := @this: org.apache.dubbo.rpc.cluster.support.wrapper.MockClusterInvoker 
(assert (not (= var1532 null-var797)))
(define-const var2165 String String-init) ; Statement: $r0 = new java.lang.StringBuilder 
(assert true)
;(assert (<init>/1968657023 var2165)) ; Statement: specialinvoke $r0.<java.lang.StringBuilder: void <init>()>() 
(declare-const var2165!1 String)
(assert (= var2165!1 ""))
(assert true)
(define-const var428 String (append/672562846 var2165!1 "invoker :")) ; Statement: $r3 = virtualinvoke $r0.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("invoker :") 
(declare-const var2165!2 String)
(assert (= var2165!2 (str.++ var2165!1 "invoker :")))
(define-const var617 var1606 (invoker/449019207 var1532)) ; Statement: $r2 = r1.<org.apache.dubbo.rpc.cluster.support.wrapper.MockClusterInvoker: org.apache.dubbo.rpc.Invoker invoker> 
(assert true)
(define-const var2372 String (append/-1031950772 var428 (cast-from-var1606-to-var3482 var617))) ; Statement: $r4 = virtualinvoke $r3.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.Object)>($r2) 
(declare-const var428!1 String)
(assert (str.prefixof var428 var428!1))
(assert true)
(define-const var2511 String (append/672562846 var2372 ",directory: ")) ; Statement: $r6 = virtualinvoke $r4.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(",directory: ") 
(declare-const var2372!1 String)
(assert (= var2372!1 (str.++ var2372 ",directory: ")))
(define-const var367 var1572 (directory/449019207 var1532)) ; Statement: $r5 = r1.<org.apache.dubbo.rpc.cluster.support.wrapper.MockClusterInvoker: org.apache.dubbo.rpc.cluster.Directory directory> 
(assert true)
(define-const var421 String (append/-1031950772 var2511 (cast-from-var1572-to-var3482 var367))) ; Statement: $r7 = virtualinvoke $r6.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.Object)>($r5) 
(declare-const var2511!1 String)
(assert (str.prefixof var2511 var2511!1))
(assert true)
(define-const var399 String (toString/-2075883882 var421)) ; Statement: $r8 = virtualinvoke $r7.<java.lang.StringBuilder: java.lang.String toString()>() 
 ; Statement: return $r8 
(check-sat)
; {String-init=([], java.lang.StringBuilder), <init>/1968657023=([java.lang.StringBuilder], void), append/672562846=([java.lang.StringBuilder, java.lang.String], java.lang.StringBuilder), invoker/449019207=([org.apache.dubbo.rpc.cluster.support.wrapper.MockClusterInvoker], org.apache.dubbo.rpc.Invoker), append/-1031950772=([java.lang.StringBuilder, java.lang.Object], java.lang.StringBuilder), cast-from-var1606-to-var3482=([org.apache.dubbo.rpc.Invoker], java.lang.Object), directory/449019207=([org.apache.dubbo.rpc.cluster.support.wrapper.MockClusterInvoker], org.apache.dubbo.rpc.cluster.Directory), cast-from-var1572-to-var3482=([org.apache.dubbo.rpc.cluster.Directory], java.lang.Object), toString/-2075883882=([java.lang.StringBuilder], java.lang.String)}
; {var797=org.apache.dubbo.rpc.cluster.support.wrapper.MockClusterInvoker, var1532=r1, var2165=$r0, var428=$r3, var1606=org.apache.dubbo.rpc.Invoker, var617=$r2, var3482=java.lang.Object, var2372=$r4, var2511=$r6, var1572=org.apache.dubbo.rpc.cluster.Directory, var367=$r5, var421=$r7, var399=$r8}
; {org.apache.dubbo.rpc.cluster.support.wrapper.MockClusterInvoker=var797, r1=var1532, $r0=var2165, $r3=var428, org.apache.dubbo.rpc.Invoker=var1606, $r2=var617, java.lang.Object=var3482, $r4=var2372, $r6=var2511, org.apache.dubbo.rpc.cluster.Directory=var1572, $r5=var367, $r7=var421, $r8=var399}
;seq <java.lang.StringBuilder: void <init>()>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.Object)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.Object)>;	<java.lang.StringBuilder: java.lang.String toString()>
;cnt {"<java.lang.StringBuilder: void <init>()>": 1,"<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>": 2,"<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.Object)>": 2,"<java.lang.StringBuilder: java.lang.String toString()>": 1}
;stmts r1 := @this: org.apache.dubbo.rpc.cluster.support.wrapper.MockClusterInvoker;	$r0 = new java.lang.StringBuilder;	specialinvoke $r0.<java.lang.StringBuilder: void <init>()>();	$r3 = virtualinvoke $r0.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("invoker :");	$r2 = r1.<org.apache.dubbo.rpc.cluster.support.wrapper.MockClusterInvoker: org.apache.dubbo.rpc.Invoker invoker>;	$r4 = virtualinvoke $r3.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.Object)>($r2);	$r6 = virtualinvoke $r4.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(",directory: ");	$r5 = r1.<org.apache.dubbo.rpc.cluster.support.wrapper.MockClusterInvoker: org.apache.dubbo.rpc.cluster.Directory directory>;	$r7 = virtualinvoke $r6.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.Object)>($r5);	$r8 = virtualinvoke $r7.<java.lang.StringBuilder: java.lang.String toString()>();	return $r8
;block_num 1