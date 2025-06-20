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

(declare-sort var2726 0)
(declare-sort var1735 0)
(declare-sort var2195 0)
(declare-sort var765 0)
(declare-sort var1147 0)
(declare-sort var2409 0)
(declare-sort var2570 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun var1147-init () var1147)
(declare-fun String-init () String)
(define-fun <init>/1968657023 () String "")
(define-fun append/672562846 ((s String) (tail String)) String (str.++ s tail))
(declare-fun append/-1031950772 (String var2409) String)
(declare-fun cast-from-var1735-to-var2409 (var1735) var2409)
(declare-fun getUrl/866469067 (var2570) var1735)
(declare-fun cast-from-var2726-to-var2570 (var2726) var2570)
(declare-fun getMessage/849299655 (var765) String)
(define-fun toString/-2075883882 ((s String)) String s)
(declare-fun <init>/552350055 (var1147 String var765) void)
(declare-const null-var2726 var2726)
(declare-const null-var1735 var1735)
(declare-const null-var2195 var2195)
(declare-const null-var765 var765)
(declare-const var2654 var2726) ; Statement: r0 := @this: org.apache.dubbo.registry.zookeeper.ZookeeperRegistry 
(assert (not (= var2654 null-var2726)))
(declare-const var3904 var1735) ; Statement: r1 := @parameter0: org.apache.dubbo.common.URL 
(assert (not (= var3904 null-var1735)))
(declare-const var2141 var2195) ; Statement: r6 := @parameter1: org.apache.dubbo.registry.NotifyListener 
(assert (not (= var2141 null-var2195)))
(assert true) ; Handling Exception: java.lang.Throwable 
(declare-const var3070 var765) ; Statement: $r31 := @caughtexception 
(assert (not (= var3070 null-var765)))
(define-const var3395 var1147 var1147-init) ; Statement: $r32 = new org.apache.dubbo.rpc.RpcException 
(define-const var1889 String String-init) ; Statement: $r33 = new java.lang.StringBuilder 
(assert true)
;(assert (<init>/1968657023 var1889)) ; Statement: specialinvoke $r33.<java.lang.StringBuilder: void <init>()>() 
(declare-const var1889!1 String)
(assert (= var1889!1 ""))
(assert true)
(define-const var549 String (append/672562846 var1889!1 "Failed to subscribe ")) ; Statement: $r34 = virtualinvoke $r33.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("Failed to subscribe ") 
(declare-const var1889!2 String)
(assert (= var1889!2 (str.++ var1889!1 "Failed to subscribe ")))
(assert true)
(define-const var1409 String (append/-1031950772 var549 (cast-from-var1735-to-var2409 var3904))) ; Statement: $r35 = virtualinvoke $r34.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.Object)>(r1) 
(declare-const var549!1 String)
(assert (str.prefixof var549 var549!1))
(assert true)
(define-const var561 String (append/672562846 var1409 " to zookeeper ")) ; Statement: $r37 = virtualinvoke $r35.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(" to zookeeper ") 
(declare-const var1409!1 String)
(assert (= var1409!1 (str.++ var1409 " to zookeeper ")))
(assert true)
(define-const var3827 var1735 (getUrl/866469067 (cast-from-var2726-to-var2570 var2654))) ; Statement: $r36 = virtualinvoke r0.<org.apache.dubbo.registry.zookeeper.ZookeeperRegistry: org.apache.dubbo.common.URL getUrl()>() 
(assert true)
(define-const var3936 String (append/-1031950772 var561 (cast-from-var1735-to-var2409 var3827))) ; Statement: $r38 = virtualinvoke $r37.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.Object)>($r36) 
(declare-const var561!1 String)
(assert (str.prefixof var561 var561!1))
(assert true)
(define-const var3906 String (append/672562846 var3936 ", cause: ")) ; Statement: $r40 = virtualinvoke $r38.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(", cause: ") 
(declare-const var3936!1 String)
(assert (= var3936!1 (str.++ var3936 ", cause: ")))
(assert true)
(define-const var1162 String (getMessage/849299655 var3070)) ; Statement: $r39 = virtualinvoke $r31.<java.lang.Throwable: java.lang.String getMessage()>() 
(assert true)
(define-const var1598 String (append/672562846 var3906 var1162)) ; Statement: $r41 = virtualinvoke $r40.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>($r39) 
(declare-const var3906!1 String)
(assert (= var3906!1 (str.++ var3906 var1162)))
(assert true)
(define-const var420 String (toString/-2075883882 var1598)) ; Statement: $r42 = virtualinvoke $r41.<java.lang.StringBuilder: java.lang.String toString()>() 
(assert true)
;(assert (<init>/552350055 var3395 var420 var3070)) ; Statement: specialinvoke $r32.<org.apache.dubbo.rpc.RpcException: void <init>(java.lang.String,java.lang.Throwable)>($r42, $r31) 

(declare-const var3395!1 var1147)
(declare-const var420!1 String)
(declare-const var3070!1 var765)
 ; Statement: throw $r32 
(check-sat)
; {var1147-init=([], org.apache.dubbo.rpc.RpcException), String-init=([], java.lang.StringBuilder), <init>/1968657023=([java.lang.StringBuilder], void), append/672562846=([java.lang.StringBuilder, java.lang.String], java.lang.StringBuilder), append/-1031950772=([java.lang.StringBuilder, java.lang.Object], java.lang.StringBuilder), cast-from-var1735-to-var2409=([org.apache.dubbo.common.URL], java.lang.Object), getUrl/866469067=([org.apache.dubbo.registry.support.AbstractRegistry], org.apache.dubbo.common.URL), cast-from-var2726-to-var2570=([org.apache.dubbo.registry.zookeeper.ZookeeperRegistry], org.apache.dubbo.registry.support.AbstractRegistry), getMessage/849299655=([java.lang.Throwable], java.lang.String), toString/-2075883882=([java.lang.StringBuilder], java.lang.String), <init>/552350055=([org.apache.dubbo.rpc.RpcException, java.lang.String, java.lang.Throwable], void)}
; {var2726=org.apache.dubbo.registry.zookeeper.ZookeeperRegistry, var2654=r0, var1735=org.apache.dubbo.common.URL, var3904=r1, var2195=org.apache.dubbo.registry.NotifyListener, var2141=r6, var765=java.lang.Throwable, var3070=$r31, var1147=org.apache.dubbo.rpc.RpcException, var3395=$r32, var1889=$r33, var549=$r34, var2409=java.lang.Object, var1409=$r35, var561=$r37, var2570=org.apache.dubbo.registry.support.AbstractRegistry, var3827=$r36, var3936=$r38, var3906=$r40, var1162=$r39, var1598=$r41, var420=$r42}
; {org.apache.dubbo.registry.zookeeper.ZookeeperRegistry=var2726, r0=var2654, org.apache.dubbo.common.URL=var1735, r1=var3904, org.apache.dubbo.registry.NotifyListener=var2195, r6=var2141, java.lang.Throwable=var765, $r31=var3070, org.apache.dubbo.rpc.RpcException=var1147, $r32=var3395, $r33=var1889, $r34=var549, java.lang.Object=var2409, $r35=var1409, $r37=var561, org.apache.dubbo.registry.support.AbstractRegistry=var2570, $r36=var3827, $r38=var3936, $r40=var3906, $r39=var1162, $r41=var1598, $r42=var420}
;seq <java.lang.StringBuilder: void <init>()>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.Object)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.Object)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.String toString()>
;cnt {"<java.lang.StringBuilder: void <init>()>": 1,"<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>": 4,"<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.Object)>": 2,"<java.lang.StringBuilder: java.lang.String toString()>": 1}
;stmts r0 := @this: org.apache.dubbo.registry.zookeeper.ZookeeperRegistry;	r1 := @parameter0: org.apache.dubbo.common.URL;	r6 := @parameter1: org.apache.dubbo.registry.NotifyListener;	$r31 := @caughtexception;	$r32 = new org.apache.dubbo.rpc.RpcException;	$r33 = new java.lang.StringBuilder;	specialinvoke $r33.<java.lang.StringBuilder: void <init>()>();	$r34 = virtualinvoke $r33.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("Failed to subscribe ");	$r35 = virtualinvoke $r34.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.Object)>(r1);	$r37 = virtualinvoke $r35.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(" to zookeeper ");	$r36 = virtualinvoke r0.<org.apache.dubbo.registry.zookeeper.ZookeeperRegistry: org.apache.dubbo.common.URL getUrl()>();	$r38 = virtualinvoke $r37.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.Object)>($r36);	$r40 = virtualinvoke $r38.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(", cause: ");	$r39 = virtualinvoke $r31.<java.lang.Throwable: java.lang.String getMessage()>();	$r41 = virtualinvoke $r40.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>($r39);	$r42 = virtualinvoke $r41.<java.lang.StringBuilder: java.lang.String toString()>();	specialinvoke $r32.<org.apache.dubbo.rpc.RpcException: void <init>(java.lang.String,java.lang.Throwable)>($r42, $r31);	throw $r32
;block_num 2