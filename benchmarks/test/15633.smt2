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

(declare-sort var1215 0)
(declare-sort var778 0)
(declare-sort var34 0)
(declare-sort var290 0)
(declare-sort var1204 0)
(declare-sort var1956 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun var290-init () var290)
(declare-fun String-init () String)
(define-fun <init>/1968657023 () String "")
(define-fun append/672562846 ((s String) (tail String)) String (str.++ s tail))
(declare-fun append/-1031950772 (String var1204) String)
(declare-fun cast-from-var778-to-var1204 (var778) var1204)
(declare-fun getUrl/866469067 (var1956) var778)
(declare-fun cast-from-var1215-to-var1956 (var1215) var1956)
(declare-fun getMessage/849299655 (var34) String)
(define-fun toString/-2075883882 ((s String)) String s)
(declare-fun <init>/552350055 (var290 String var34) void)
(declare-const null-var1215 var1215)
(declare-const null-var778 var778)
(declare-const null-var34 var34)
(declare-const var1468 var1215) ; Statement: r0 := @this: org.apache.dubbo.registry.zookeeper.ZookeeperRegistry 
(assert (not (= var1468 null-var1215)))
(declare-const var3604 var778) ; Statement: r1 := @parameter0: org.apache.dubbo.common.URL 
(assert (not (= var3604 null-var778)))
(assert true) ; Handling Exception: java.lang.Throwable 
(declare-const var1467 var34) ; Statement: $r4 := @caughtexception 
(assert (not (= var1467 null-var34)))
(define-const var3352 var290 var290-init) ; Statement: $r5 = new org.apache.dubbo.rpc.RpcException 
(define-const var650 String String-init) ; Statement: $r6 = new java.lang.StringBuilder 
(assert true)
;(assert (<init>/1968657023 var650)) ; Statement: specialinvoke $r6.<java.lang.StringBuilder: void <init>()>() 
(declare-const var650!1 String)
(assert (= var650!1 ""))
(assert true)
(define-const var3488 String (append/672562846 var650!1 "Failed to unregister ")) ; Statement: $r7 = virtualinvoke $r6.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("Failed to unregister ") 
(declare-const var650!2 String)
(assert (= var650!2 (str.++ var650!1 "Failed to unregister ")))
(assert true)
(define-const var3015 String (append/-1031950772 var3488 (cast-from-var778-to-var1204 var3604))) ; Statement: $r8 = virtualinvoke $r7.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.Object)>(r1) 
(declare-const var3488!1 String)
(assert (str.prefixof var3488 var3488!1))
(assert true)
(define-const var310 String (append/672562846 var3015 " to zookeeper ")) ; Statement: $r10 = virtualinvoke $r8.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(" to zookeeper ") 
(declare-const var3015!1 String)
(assert (= var3015!1 (str.++ var3015 " to zookeeper ")))
(assert true)
(define-const var3226 var778 (getUrl/866469067 (cast-from-var1215-to-var1956 var1468))) ; Statement: $r9 = virtualinvoke r0.<org.apache.dubbo.registry.zookeeper.ZookeeperRegistry: org.apache.dubbo.common.URL getUrl()>() 
(assert true)
(define-const var1018 String (append/-1031950772 var310 (cast-from-var778-to-var1204 var3226))) ; Statement: $r11 = virtualinvoke $r10.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.Object)>($r9) 
(declare-const var310!1 String)
(assert (str.prefixof var310 var310!1))
(assert true)
(define-const var1925 String (append/672562846 var1018 ", cause: ")) ; Statement: $r13 = virtualinvoke $r11.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(", cause: ") 
(declare-const var1018!1 String)
(assert (= var1018!1 (str.++ var1018 ", cause: ")))
(assert true)
(define-const var1200 String (getMessage/849299655 var1467)) ; Statement: $r12 = virtualinvoke $r4.<java.lang.Throwable: java.lang.String getMessage()>() 
(assert true)
(define-const var649 String (append/672562846 var1925 var1200)) ; Statement: $r14 = virtualinvoke $r13.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>($r12) 
(declare-const var1925!1 String)
(assert (= var1925!1 (str.++ var1925 var1200)))
(assert true)
(define-const var1523 String (toString/-2075883882 var649)) ; Statement: $r15 = virtualinvoke $r14.<java.lang.StringBuilder: java.lang.String toString()>() 
(assert true)
;(assert (<init>/552350055 var3352 var1523 var1467)) ; Statement: specialinvoke $r5.<org.apache.dubbo.rpc.RpcException: void <init>(java.lang.String,java.lang.Throwable)>($r15, $r4) 

(declare-const var3352!1 var290)
(declare-const var1523!1 String)
(declare-const var1467!1 var34)
 ; Statement: throw $r5 
(check-sat)
; {var290-init=([], org.apache.dubbo.rpc.RpcException), String-init=([], java.lang.StringBuilder), <init>/1968657023=([java.lang.StringBuilder], void), append/672562846=([java.lang.StringBuilder, java.lang.String], java.lang.StringBuilder), append/-1031950772=([java.lang.StringBuilder, java.lang.Object], java.lang.StringBuilder), cast-from-var778-to-var1204=([org.apache.dubbo.common.URL], java.lang.Object), getUrl/866469067=([org.apache.dubbo.registry.support.AbstractRegistry], org.apache.dubbo.common.URL), cast-from-var1215-to-var1956=([org.apache.dubbo.registry.zookeeper.ZookeeperRegistry], org.apache.dubbo.registry.support.AbstractRegistry), getMessage/849299655=([java.lang.Throwable], java.lang.String), toString/-2075883882=([java.lang.StringBuilder], java.lang.String), <init>/552350055=([org.apache.dubbo.rpc.RpcException, java.lang.String, java.lang.Throwable], void)}
; {var1215=org.apache.dubbo.registry.zookeeper.ZookeeperRegistry, var1468=r0, var778=org.apache.dubbo.common.URL, var3604=r1, var34=java.lang.Throwable, var1467=$r4, var290=org.apache.dubbo.rpc.RpcException, var3352=$r5, var650=$r6, var3488=$r7, var1204=java.lang.Object, var3015=$r8, var310=$r10, var1956=org.apache.dubbo.registry.support.AbstractRegistry, var3226=$r9, var1018=$r11, var1925=$r13, var1200=$r12, var649=$r14, var1523=$r15}
; {org.apache.dubbo.registry.zookeeper.ZookeeperRegistry=var1215, r0=var1468, org.apache.dubbo.common.URL=var778, r1=var3604, java.lang.Throwable=var34, $r4=var1467, org.apache.dubbo.rpc.RpcException=var290, $r5=var3352, $r6=var650, $r7=var3488, java.lang.Object=var1204, $r8=var3015, $r10=var310, org.apache.dubbo.registry.support.AbstractRegistry=var1956, $r9=var3226, $r11=var1018, $r13=var1925, $r12=var1200, $r14=var649, $r15=var1523}
;seq <java.lang.StringBuilder: void <init>()>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.Object)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.Object)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.String toString()>
;cnt {"<java.lang.StringBuilder: void <init>()>": 1,"<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>": 4,"<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.Object)>": 2,"<java.lang.StringBuilder: java.lang.String toString()>": 1}
;stmts r0 := @this: org.apache.dubbo.registry.zookeeper.ZookeeperRegistry;	r1 := @parameter0: org.apache.dubbo.common.URL;	$r4 := @caughtexception;	$r5 = new org.apache.dubbo.rpc.RpcException;	$r6 = new java.lang.StringBuilder;	specialinvoke $r6.<java.lang.StringBuilder: void <init>()>();	$r7 = virtualinvoke $r6.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("Failed to unregister ");	$r8 = virtualinvoke $r7.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.Object)>(r1);	$r10 = virtualinvoke $r8.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(" to zookeeper ");	$r9 = virtualinvoke r0.<org.apache.dubbo.registry.zookeeper.ZookeeperRegistry: org.apache.dubbo.common.URL getUrl()>();	$r11 = virtualinvoke $r10.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.Object)>($r9);	$r13 = virtualinvoke $r11.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(", cause: ");	$r12 = virtualinvoke $r4.<java.lang.Throwable: java.lang.String getMessage()>();	$r14 = virtualinvoke $r13.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>($r12);	$r15 = virtualinvoke $r14.<java.lang.StringBuilder: java.lang.String toString()>();	specialinvoke $r5.<org.apache.dubbo.rpc.RpcException: void <init>(java.lang.String,java.lang.Throwable)>($r15, $r4);	throw $r5
;block_num 2