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

(declare-sort var3306 0)
(declare-sort var1210 0)
(declare-sort var3387 0)
(declare-sort var2102 0)
(declare-sort var948 0)
(declare-sort var1425 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun var2102-init () var2102)
(declare-fun String-init () String)
(define-fun <init>/1968657023 () String "")
(define-fun append/672562846 ((s String) (tail String)) String (str.++ s tail))
(declare-fun append/-1031950772 (String var948) String)
(declare-fun cast-from-var1210-to-var948 (var1210) var948)
(declare-fun getUrl/866469067 (var1425) var1210)
(declare-fun cast-from-var3306-to-var1425 (var3306) var1425)
(declare-fun getMessage/849299655 (var3387) String)
(define-fun toString/-2075883882 ((s String)) String s)
(declare-fun <init>/552350055 (var2102 String var3387) void)
(declare-const null-var3306 var3306)
(declare-const null-var1210 var1210)
(declare-const null-var3387 var3387)
(declare-const var1662 var3306) ; Statement: r1 := @this: org.apache.dubbo.registry.zookeeper.ZookeeperRegistry 
(assert (not (= var1662 null-var3306)))
(declare-const var3945 var1210) ; Statement: r0 := @parameter0: org.apache.dubbo.common.URL 
(assert (not (= var3945 null-var1210)))
 ; Statement: if r0 != null goto specialinvoke r1.<org.apache.dubbo.registry.zookeeper.ZookeeperRegistry: void checkDestroyed()>() 
(assert (not (not (= var3945 null-var1210)))) ; Negate: Cond: r0 != null  
(declare-const var2786 var3387) ; Statement: $r9 := @caughtexception 
(assert (not (= var2786 null-var3387)))
(define-const var362 var2102 var2102-init) ; Statement: $r10 = new org.apache.dubbo.rpc.RpcException 
(define-const var1486 String String-init) ; Statement: $r11 = new java.lang.StringBuilder 
(assert true)
;(assert (<init>/1968657023 var1486)) ; Statement: specialinvoke $r11.<java.lang.StringBuilder: void <init>()>() 
(declare-const var1486!1 String)
(assert (= var1486!1 ""))
(assert true)
(define-const var2340 String (append/672562846 var1486!1 "Failed to lookup ")) ; Statement: $r12 = virtualinvoke $r11.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("Failed to lookup ") 
(declare-const var1486!2 String)
(assert (= var1486!2 (str.++ var1486!1 "Failed to lookup ")))
(assert true)
(define-const var3429 String (append/-1031950772 var2340 (cast-from-var1210-to-var948 var3945))) ; Statement: $r13 = virtualinvoke $r12.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.Object)>(r0) 
(declare-const var2340!1 String)
(assert (str.prefixof var2340 var2340!1))
(assert true)
(define-const var2788 String (append/672562846 var3429 " from zookeeper ")) ; Statement: $r15 = virtualinvoke $r13.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(" from zookeeper ") 
(declare-const var3429!1 String)
(assert (= var3429!1 (str.++ var3429 " from zookeeper ")))
(assert true)
(define-const var1804 var1210 (getUrl/866469067 (cast-from-var3306-to-var1425 var1662))) ; Statement: $r14 = virtualinvoke r1.<org.apache.dubbo.registry.zookeeper.ZookeeperRegistry: org.apache.dubbo.common.URL getUrl()>() 
(assert true)
(define-const var2390 String (append/-1031950772 var2788 (cast-from-var1210-to-var948 var1804))) ; Statement: $r16 = virtualinvoke $r15.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.Object)>($r14) 
(declare-const var2788!1 String)
(assert (str.prefixof var2788 var2788!1))
(assert true)
(define-const var2628 String (append/672562846 var2390 ", cause: ")) ; Statement: $r18 = virtualinvoke $r16.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(", cause: ") 
(declare-const var2390!1 String)
(assert (= var2390!1 (str.++ var2390 ", cause: ")))
(assert true)
(define-const var3310 String (getMessage/849299655 var2786)) ; Statement: $r17 = virtualinvoke $r9.<java.lang.Throwable: java.lang.String getMessage()>() 
(assert true)
(define-const var1324 String (append/672562846 var2628 var3310)) ; Statement: $r19 = virtualinvoke $r18.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>($r17) 
(declare-const var2628!1 String)
(assert (= var2628!1 (str.++ var2628 var3310)))
(assert true)
(define-const var3297 String (toString/-2075883882 var1324)) ; Statement: $r20 = virtualinvoke $r19.<java.lang.StringBuilder: java.lang.String toString()>() 
(assert true)
;(assert (<init>/552350055 var362 var3297 var2786)) ; Statement: specialinvoke $r10.<org.apache.dubbo.rpc.RpcException: void <init>(java.lang.String,java.lang.Throwable)>($r20, $r9) 

(declare-const var362!1 var2102)
(declare-const var3297!1 String)
(declare-const var2786!1 var3387)
 ; Statement: throw $r10 
(check-sat)
; {var2102-init=([], org.apache.dubbo.rpc.RpcException), String-init=([], java.lang.StringBuilder), <init>/1968657023=([java.lang.StringBuilder], void), append/672562846=([java.lang.StringBuilder, java.lang.String], java.lang.StringBuilder), append/-1031950772=([java.lang.StringBuilder, java.lang.Object], java.lang.StringBuilder), cast-from-var1210-to-var948=([org.apache.dubbo.common.URL], java.lang.Object), getUrl/866469067=([org.apache.dubbo.registry.support.AbstractRegistry], org.apache.dubbo.common.URL), cast-from-var3306-to-var1425=([org.apache.dubbo.registry.zookeeper.ZookeeperRegistry], org.apache.dubbo.registry.support.AbstractRegistry), getMessage/849299655=([java.lang.Throwable], java.lang.String), toString/-2075883882=([java.lang.StringBuilder], java.lang.String), <init>/552350055=([org.apache.dubbo.rpc.RpcException, java.lang.String, java.lang.Throwable], void)}
; {var3306=org.apache.dubbo.registry.zookeeper.ZookeeperRegistry, var1662=r1, var1210=org.apache.dubbo.common.URL, var3945=r0, var3387=java.lang.Throwable, var2786=$r9, var2102=org.apache.dubbo.rpc.RpcException, var362=$r10, var1486=$r11, var2340=$r12, var948=java.lang.Object, var3429=$r13, var2788=$r15, var1425=org.apache.dubbo.registry.support.AbstractRegistry, var1804=$r14, var2390=$r16, var2628=$r18, var3310=$r17, var1324=$r19, var3297=$r20}
; {org.apache.dubbo.registry.zookeeper.ZookeeperRegistry=var3306, r1=var1662, org.apache.dubbo.common.URL=var1210, r0=var3945, java.lang.Throwable=var3387, $r9=var2786, org.apache.dubbo.rpc.RpcException=var2102, $r10=var362, $r11=var1486, $r12=var2340, java.lang.Object=var948, $r13=var3429, $r15=var2788, org.apache.dubbo.registry.support.AbstractRegistry=var1425, $r14=var1804, $r16=var2390, $r18=var2628, $r17=var3310, $r19=var1324, $r20=var3297}
;seq <java.lang.StringBuilder: void <init>()>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.Object)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.Object)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.String toString()>
;cnt {"<java.lang.StringBuilder: void <init>()>": 1,"<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>": 4,"<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.Object)>": 2,"<java.lang.StringBuilder: java.lang.String toString()>": 1}
;stmts r1 := @this: org.apache.dubbo.registry.zookeeper.ZookeeperRegistry;	r0 := @parameter0: org.apache.dubbo.common.URL;	if r0 != null goto specialinvoke r1.<org.apache.dubbo.registry.zookeeper.ZookeeperRegistry: void checkDestroyed()>();	$r9 := @caughtexception;	$r10 = new org.apache.dubbo.rpc.RpcException;	$r11 = new java.lang.StringBuilder;	specialinvoke $r11.<java.lang.StringBuilder: void <init>()>();	$r12 = virtualinvoke $r11.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("Failed to lookup ");	$r13 = virtualinvoke $r12.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.Object)>(r0);	$r15 = virtualinvoke $r13.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(" from zookeeper ");	$r14 = virtualinvoke r1.<org.apache.dubbo.registry.zookeeper.ZookeeperRegistry: org.apache.dubbo.common.URL getUrl()>();	$r16 = virtualinvoke $r15.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.Object)>($r14);	$r18 = virtualinvoke $r16.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(", cause: ");	$r17 = virtualinvoke $r9.<java.lang.Throwable: java.lang.String getMessage()>();	$r19 = virtualinvoke $r18.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>($r17);	$r20 = virtualinvoke $r19.<java.lang.StringBuilder: java.lang.String toString()>();	specialinvoke $r10.<org.apache.dubbo.rpc.RpcException: void <init>(java.lang.String,java.lang.Throwable)>($r20, $r9);	throw $r10
;block_num 2