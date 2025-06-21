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

(declare-sort var1577 0)
(declare-sort var829 0)
(declare-sort var3651 0)
(declare-sort var1045 0)
(declare-sort var2602 0)
(declare-sort var448 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun var1045-init () var1045)
(declare-fun String-init () String)
(define-fun <init>/1968657023 () String "")
(define-fun append/672562846 ((s String) (tail String)) String (str.++ s tail))
(declare-fun append/-1031950772 (String var2602) String)
(declare-fun cast-from-var829-to-var2602 (var829) var2602)
(declare-fun getUrl/866469067 (var448) var829)
(declare-fun cast-from-var1577-to-var448 (var1577) var448)
(declare-fun getMessage/849299655 (var3651) String)
(define-fun toString/-2075883882 ((s String)) String s)
(declare-fun <init>/552350055 (var1045 String var3651) void)
(declare-const null-var1577 var1577)
(declare-const null-var829 var829)
(declare-const null-var3651 var3651)
(declare-const var1878 var1577) ; Statement: r0 := @this: org.apache.dubbo.registry.zookeeper.ZookeeperRegistry 
(assert (not (= var1878 null-var1577)))
(declare-const var1947 var829) ; Statement: r1 := @parameter0: org.apache.dubbo.common.URL 
(assert (not (= var1947 null-var829)))
(assert true) ; Handling Exception: java.lang.Throwable 
(declare-const var2152 var3651) ; Statement: $r4 := @caughtexception 
(assert (not (= var2152 null-var3651)))
(define-const var2517 var1045 var1045-init) ; Statement: $r5 = new org.apache.dubbo.rpc.RpcException 
(define-const var3741 String String-init) ; Statement: $r6 = new java.lang.StringBuilder 
(assert true)
;(assert (<init>/1968657023 var3741)) ; Statement: specialinvoke $r6.<java.lang.StringBuilder: void <init>()>() 
(declare-const var3741!1 String)
(assert (= var3741!1 ""))
(assert true)
(define-const var3687 String (append/672562846 var3741!1 "Failed to register ")) ; Statement: $r7 = virtualinvoke $r6.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("Failed to register ") 
(declare-const var3741!2 String)
(assert (= var3741!2 (str.++ var3741!1 "Failed to register ")))
(assert true)
(define-const var3762 String (append/-1031950772 var3687 (cast-from-var829-to-var2602 var1947))) ; Statement: $r8 = virtualinvoke $r7.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.Object)>(r1) 
(declare-const var3687!1 String)
(assert (str.prefixof var3687 var3687!1))
(assert true)
(define-const var600 String (append/672562846 var3762 " to zookeeper ")) ; Statement: $r10 = virtualinvoke $r8.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(" to zookeeper ") 
(declare-const var3762!1 String)
(assert (= var3762!1 (str.++ var3762 " to zookeeper ")))
(assert true)
(define-const var2873 var829 (getUrl/866469067 (cast-from-var1577-to-var448 var1878))) ; Statement: $r9 = virtualinvoke r0.<org.apache.dubbo.registry.zookeeper.ZookeeperRegistry: org.apache.dubbo.common.URL getUrl()>() 
(assert true)
(define-const var223 String (append/-1031950772 var600 (cast-from-var829-to-var2602 var2873))) ; Statement: $r11 = virtualinvoke $r10.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.Object)>($r9) 
(declare-const var600!1 String)
(assert (str.prefixof var600 var600!1))
(assert true)
(define-const var2562 String (append/672562846 var223 ", cause: ")) ; Statement: $r13 = virtualinvoke $r11.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(", cause: ") 
(declare-const var223!1 String)
(assert (= var223!1 (str.++ var223 ", cause: ")))
(assert true)
(define-const var3711 String (getMessage/849299655 var2152)) ; Statement: $r12 = virtualinvoke $r4.<java.lang.Throwable: java.lang.String getMessage()>() 
(assert true)
(define-const var729 String (append/672562846 var2562 var3711)) ; Statement: $r14 = virtualinvoke $r13.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>($r12) 
(declare-const var2562!1 String)
(assert (= var2562!1 (str.++ var2562 var3711)))
(assert true)
(define-const var3660 String (toString/-2075883882 var729)) ; Statement: $r15 = virtualinvoke $r14.<java.lang.StringBuilder: java.lang.String toString()>() 
(assert true)
;(assert (<init>/552350055 var2517 var3660 var2152)) ; Statement: specialinvoke $r5.<org.apache.dubbo.rpc.RpcException: void <init>(java.lang.String,java.lang.Throwable)>($r15, $r4) 

(declare-const var2517!1 var1045)
(declare-const var3660!1 String)
(declare-const var2152!1 var3651)
 ; Statement: throw $r5 
(check-sat)
; {var1045-init=([], org.apache.dubbo.rpc.RpcException), String-init=([], java.lang.StringBuilder), <init>/1968657023=([java.lang.StringBuilder], void), append/672562846=([java.lang.StringBuilder, java.lang.String], java.lang.StringBuilder), append/-1031950772=([java.lang.StringBuilder, java.lang.Object], java.lang.StringBuilder), cast-from-var829-to-var2602=([org.apache.dubbo.common.URL], java.lang.Object), getUrl/866469067=([org.apache.dubbo.registry.support.AbstractRegistry], org.apache.dubbo.common.URL), cast-from-var1577-to-var448=([org.apache.dubbo.registry.zookeeper.ZookeeperRegistry], org.apache.dubbo.registry.support.AbstractRegistry), getMessage/849299655=([java.lang.Throwable], java.lang.String), toString/-2075883882=([java.lang.StringBuilder], java.lang.String), <init>/552350055=([org.apache.dubbo.rpc.RpcException, java.lang.String, java.lang.Throwable], void)}
; {var1577=org.apache.dubbo.registry.zookeeper.ZookeeperRegistry, var1878=r0, var829=org.apache.dubbo.common.URL, var1947=r1, var3651=java.lang.Throwable, var2152=$r4, var1045=org.apache.dubbo.rpc.RpcException, var2517=$r5, var3741=$r6, var3687=$r7, var2602=java.lang.Object, var3762=$r8, var600=$r10, var448=org.apache.dubbo.registry.support.AbstractRegistry, var2873=$r9, var223=$r11, var2562=$r13, var3711=$r12, var729=$r14, var3660=$r15}
; {org.apache.dubbo.registry.zookeeper.ZookeeperRegistry=var1577, r0=var1878, org.apache.dubbo.common.URL=var829, r1=var1947, java.lang.Throwable=var3651, $r4=var2152, org.apache.dubbo.rpc.RpcException=var1045, $r5=var2517, $r6=var3741, $r7=var3687, java.lang.Object=var2602, $r8=var3762, $r10=var600, org.apache.dubbo.registry.support.AbstractRegistry=var448, $r9=var2873, $r11=var223, $r13=var2562, $r12=var3711, $r14=var729, $r15=var3660}
;seq <java.lang.StringBuilder: void <init>()>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.Object)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.Object)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.String toString()>
;cnt {"<java.lang.StringBuilder: void <init>()>": 1,"<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>": 4,"<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.Object)>": 2,"<java.lang.StringBuilder: java.lang.String toString()>": 1}
;stmts r0 := @this: org.apache.dubbo.registry.zookeeper.ZookeeperRegistry;	r1 := @parameter0: org.apache.dubbo.common.URL;	$r4 := @caughtexception;	$r5 = new org.apache.dubbo.rpc.RpcException;	$r6 = new java.lang.StringBuilder;	specialinvoke $r6.<java.lang.StringBuilder: void <init>()>();	$r7 = virtualinvoke $r6.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("Failed to register ");	$r8 = virtualinvoke $r7.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.Object)>(r1);	$r10 = virtualinvoke $r8.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(" to zookeeper ");	$r9 = virtualinvoke r0.<org.apache.dubbo.registry.zookeeper.ZookeeperRegistry: org.apache.dubbo.common.URL getUrl()>();	$r11 = virtualinvoke $r10.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.Object)>($r9);	$r13 = virtualinvoke $r11.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(", cause: ");	$r12 = virtualinvoke $r4.<java.lang.Throwable: java.lang.String getMessage()>();	$r14 = virtualinvoke $r13.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>($r12);	$r15 = virtualinvoke $r14.<java.lang.StringBuilder: java.lang.String toString()>();	specialinvoke $r5.<org.apache.dubbo.rpc.RpcException: void <init>(java.lang.String,java.lang.Throwable)>($r15, $r4);	throw $r5
;block_num 2