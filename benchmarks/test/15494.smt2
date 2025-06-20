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

(declare-sort var1075 0)
(declare-sort var2171 0)
(declare-sort var3118 0)
(declare-sort var1057 0)
(declare-sort var3043 0)
(declare-sort var1189 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun var1057-init () var1057)
(declare-fun String-init () String)
(define-fun <init>/1968657023 () String "")
(define-fun append/672562846 ((s String) (tail String)) String (str.++ s tail))
(declare-fun var3043_toString/-522406933 (var3043) String)
(declare-fun cast-from-var2171-to-var3043 (var2171) var3043)
(define-fun toString/-2075883882 ((s String)) String s)
(declare-fun <init>/456387396 (var1057 Int String var1189) void)
(declare-fun cast-from-var3118-to-var1189 (var3118) var1189)
(declare-const null-var1075 var1075)
(declare-const null-var2171 var2171)
(declare-const null-var3118 var3118)
(declare-const var1986 var1075) ; Statement: r0 := @this: org.apache.dubbo.registry.zookeeper.ZookeeperServiceDiscovery 
(assert (not (= var1986 null-var1075)))
(declare-const var2087 var2171) ; Statement: r1 := @parameter0: org.apache.dubbo.registry.client.ServiceInstance 
(assert (not (= var2087 null-var2171)))
(assert true) ; Handling Exception: java.lang.Throwable 
(declare-const var3559 var3118) ; Statement: $r4 := @caughtexception 
(assert (not (= var3559 null-var3118)))
(define-const var1664 var1057 var1057-init) ; Statement: $r5 = new org.apache.dubbo.rpc.RpcException 
(define-const var3718 String String-init) ; Statement: $r6 = new java.lang.StringBuilder 
(assert true)
;(assert (<init>/1968657023 var3718)) ; Statement: specialinvoke $r6.<java.lang.StringBuilder: void <init>()>() 
(declare-const var3718!1 String)
(assert (= var3718!1 ""))
(assert true)
(define-const var1557 String (append/672562846 var3718!1 "Failed register instance ")) ; Statement: $r8 = virtualinvoke $r6.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("Failed register instance ") 
(declare-const var3718!2 String)
(assert (= var3718!2 (str.++ var3718!1 "Failed register instance ")))
(define-const var2008 String (var3043_toString/-522406933 (cast-from-var2171-to-var3043 var2087))) ; Statement: $r7 = interfaceinvoke r1.<org.apache.dubbo.registry.client.ServiceInstance: java.lang.String toString()>() 
(assert true)
(define-const var1825 String (append/672562846 var1557 var2008)) ; Statement: $r9 = virtualinvoke $r8.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>($r7) 
(declare-const var1557!1 String)
(assert (= var1557!1 (str.++ var1557 var2008)))
(assert true)
(define-const var1953 String (toString/-2075883882 var1825)) ; Statement: $r10 = virtualinvoke $r9.<java.lang.StringBuilder: java.lang.String toString()>() 
(assert true)
;(assert (<init>/456387396 var1664 9 var1953 (cast-from-var3118-to-var1189 var3559))) ; Statement: specialinvoke $r5.<org.apache.dubbo.rpc.RpcException: void <init>(int,java.lang.String,java.lang.Throwable)>(9, $r10, $r4) 

(declare-const var1664!1 var1057)
(declare-const var3293 Int)
(declare-const var1953!1 String)
(declare-const var3559!1 var3118)
 ; Statement: throw $r5 
(check-sat)
; {var1057-init=([], org.apache.dubbo.rpc.RpcException), String-init=([], java.lang.StringBuilder), <init>/1968657023=([java.lang.StringBuilder], void), append/672562846=([java.lang.StringBuilder, java.lang.String], java.lang.StringBuilder), var3043_toString/-522406933=([java.lang.Object], java.lang.String), cast-from-var2171-to-var3043=([org.apache.dubbo.registry.client.ServiceInstance], java.lang.Object), toString/-2075883882=([java.lang.StringBuilder], java.lang.String), <init>/456387396=([org.apache.dubbo.rpc.RpcException, int, java.lang.String, java.lang.Throwable], void), cast-from-var3118-to-var1189=([java.lang.Exception], java.lang.Throwable)}
; {var1075=org.apache.dubbo.registry.zookeeper.ZookeeperServiceDiscovery, var1986=r0, var2171=org.apache.dubbo.registry.client.ServiceInstance, var2087=r1, var3118=java.lang.Exception, var3559=$r4, var1057=org.apache.dubbo.rpc.RpcException, var1664=$r5, var3718=$r6, var1557=$r8, var3043=java.lang.Object, var2008=$r7, var1825=$r9, var1953=$r10, var1189=java.lang.Throwable, var3293=9}
; {org.apache.dubbo.registry.zookeeper.ZookeeperServiceDiscovery=var1075, r0=var1986, org.apache.dubbo.registry.client.ServiceInstance=var2171, r1=var2087, java.lang.Exception=var3118, $r4=var3559, org.apache.dubbo.rpc.RpcException=var1057, $r5=var1664, $r6=var3718, $r8=var1557, java.lang.Object=var3043, $r7=var2008, $r9=var1825, $r10=var1953, java.lang.Throwable=var1189, 9=var3293}
;seq <java.lang.StringBuilder: void <init>()>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.Object: java.lang.String toString()>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.String toString()>
;cnt {"<java.lang.StringBuilder: void <init>()>": 1,"<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>": 2,"<java.lang.StringBuilder: java.lang.String toString()>": 1}
;stmts r0 := @this: org.apache.dubbo.registry.zookeeper.ZookeeperServiceDiscovery;	r1 := @parameter0: org.apache.dubbo.registry.client.ServiceInstance;	$r4 := @caughtexception;	$r5 = new org.apache.dubbo.rpc.RpcException;	$r6 = new java.lang.StringBuilder;	specialinvoke $r6.<java.lang.StringBuilder: void <init>()>();	$r8 = virtualinvoke $r6.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("Failed register instance ");	$r7 = interfaceinvoke r1.<org.apache.dubbo.registry.client.ServiceInstance: java.lang.String toString()>();	$r9 = virtualinvoke $r8.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>($r7);	$r10 = virtualinvoke $r9.<java.lang.StringBuilder: java.lang.String toString()>();	specialinvoke $r5.<org.apache.dubbo.rpc.RpcException: void <init>(int,java.lang.String,java.lang.Throwable)>(9, $r10, $r4);	throw $r5
;block_num 2