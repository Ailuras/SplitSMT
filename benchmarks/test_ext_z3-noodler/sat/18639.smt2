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

(declare-sort var460 0)
(declare-sort var2424 0)
(declare-sort var1436 0)
(declare-sort var807 0)
(declare-sort var3786 0)
(declare-sort var2485 0)
(declare-sort var1836 0)
(declare-sort var1767 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun getBytes/-163691139 (String var1436) (Array Int Int))
(declare-fun client/1857390096 (var460) var807)
(declare-fun String-init () String)
(define-fun <init>/1968657023 () String "")
(define-fun append/672562846 ((s String) (tail String)) String (str.++ s tail))
(define-fun toString/-2075883882 ((s String)) String s)
(declare-fun var2485_warn/126438324 (var2485 String String String String var3786) void)
(declare-fun var1836-init () var1836)
(declare-fun cast-from-var3786-to-var1767 (var3786) var1767)
(declare-fun getMessage/879517157 (var1767) String)
(declare-fun <init>/-1447874194 (var1836 String var3786) void)
(declare-const null-var460 var460)
(declare-const null-String String)
(declare-const null-Bool Bool)
(declare-const var460-CHARSET var1436)
(declare-const null-var3786 var3786)
(declare-const var460-logger var2485)
(declare-const var2822 var460) ; Statement: r3 := @this: org.apache.dubbo.remoting.zookeeper.curator5.Curator5ZookeeperClient 
(assert (not (= var2822 null-var460)))
(declare-const var3935 String) ; Statement: r8 := @parameter0: java.lang.String 
(assert (not (= var3935 null-String)))
(declare-const var376 String) ; Statement: r0 := @parameter1: java.lang.String 
(assert (not (= var376 null-String)))
(declare-const var2365 Bool) ; Statement: z0 := @parameter2: boolean 
(assert (not (= var2365 null-Bool)))
(define-const var2531 var1436 var460-CHARSET) ; Statement: $r1 = <org.apache.dubbo.remoting.zookeeper.curator5.Curator5ZookeeperClient: java.nio.charset.Charset CHARSET> 
(assert true)
(define-const var339 (Array Int Int) (getBytes/-163691139 var376 var2531)) ; Statement: r2 = virtualinvoke r0.<java.lang.String: byte[] getBytes(java.nio.charset.Charset)>($r1) 
(assert true) ; Non Conditional
(define-const var2425 var807 (client/1857390096 var2822)) ; Statement: $r4 = r3.<org.apache.dubbo.remoting.zookeeper.curator5.Curator5ZookeeperClient: org.apache.curator.framework.CuratorFramework client> 
(assert true) ; Handling Exception: java.lang.Throwable 
(declare-const var3542 var3786) ; Statement: $r13 := @caughtexception 
(assert (not (= var3542 null-var3786)))
 ; Statement: if z0 == 0 goto $r15 = <org.apache.dubbo.remoting.zookeeper.curator5.Curator5ZookeeperClient: org.apache.dubbo.common.logger.ErrorTypeAwareLogger logger> 
(assert (= (ite var2365 1 0) 0)) ; Cond: z0 == 0 
(define-const var1616 var2485 var460-logger) ; Statement: $r15 = <org.apache.dubbo.remoting.zookeeper.curator5.Curator5ZookeeperClient: org.apache.dubbo.common.logger.ErrorTypeAwareLogger logger> 
(define-const var703 String String-init) ; Statement: $r29 = new java.lang.StringBuilder 
(assert true)
;(assert (<init>/1968657023 var703)) ; Statement: specialinvoke $r29.<java.lang.StringBuilder: void <init>()>() 
(declare-const var703!1 String)
(assert (= var703!1 ""))
(assert true)
(define-const var3459 String (append/672562846 var703!1 "ZNode ")) ; Statement: $r16 = virtualinvoke $r29.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("ZNode ") 
(declare-const var703!2 String)
(assert (= var703!2 (str.++ var703!1 "ZNode ")))
(assert true)
(define-const var1658 String (append/672562846 var3459 var3935)) ; Statement: $r17 = virtualinvoke $r16.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(r8) 
(declare-const var3459!1 String)
(assert (= var3459!1 (str.++ var3459 var3935)))
(assert true)
(define-const var2290 String (append/672562846 var1658 " already exists.")) ; Statement: $r18 = virtualinvoke $r17.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(" already exists.") 
(declare-const var1658!1 String)
(assert (= var1658!1 (str.++ var1658 " already exists.")))
(assert true)
(define-const var1820 String (toString/-2075883882 var2290)) ; Statement: $r19 = virtualinvoke $r18.<java.lang.StringBuilder: java.lang.String toString()>() 
;(assert (var2485_warn/126438324 var1616 "1-35" "" "" var1820 var3542)) ; Statement: interfaceinvoke $r15.<org.apache.dubbo.common.logger.ErrorTypeAwareLogger: void warn(java.lang.String,java.lang.String,java.lang.String,java.lang.String,java.lang.Throwable)>("1-35", "", "", $r19, $r13) 

(declare-const var1616!1 var2485)
(declare-const var1911 String)
(declare-const var1804 String)
(declare-const var1804!1 String)
(declare-const var1820!1 String)
(declare-const var3542!1 var3786)
(define-const var2500 var1836 var1836-init) ; Statement: $r30 = new java.lang.IllegalStateException 
(define-const var3907 var1767 (cast-from-var3786-to-var1767 var3542!1)) ; Statement: $r32 = (org.apache.zookeeper.KeeperException$NodeExistsException) $r13 
(assert true)
(define-const var3870 String (getMessage/879517157 var3907)) ; Statement: $r21 = virtualinvoke $r32.<org.apache.zookeeper.KeeperException$NodeExistsException: java.lang.String getMessage()>() 
(assert true)
;(assert (<init>/-1447874194 var2500 var3870 var3542!1)) ; Statement: specialinvoke $r30.<java.lang.IllegalStateException: void <init>(java.lang.String,java.lang.Throwable)>($r21, $r13) 

(declare-const var2500!1 var1836)
(declare-const var3870!1 String)
(declare-const var3542!2 var3786)
 ; Statement: throw $r30 
(check-sat)
; {getBytes/-163691139=([java.lang.String, java.nio.charset.Charset], byte[]), client/1857390096=([org.apache.dubbo.remoting.zookeeper.curator5.Curator5ZookeeperClient], org.apache.curator.framework.CuratorFramework), String-init=([], java.lang.StringBuilder), <init>/1968657023=([java.lang.StringBuilder], void), append/672562846=([java.lang.StringBuilder, java.lang.String], java.lang.StringBuilder), toString/-2075883882=([java.lang.StringBuilder], java.lang.String), var2485_warn/126438324=([org.apache.dubbo.common.logger.ErrorTypeAwareLogger, java.lang.String, java.lang.String, java.lang.String, java.lang.String, java.lang.Throwable], void), var1836-init=([], java.lang.IllegalStateException), cast-from-var3786-to-var1767=([java.lang.Throwable], org.apache.zookeeper.KeeperException$NodeExistsException), getMessage/879517157=([org.apache.zookeeper.KeeperException$NodeExistsException], java.lang.String), <init>/-1447874194=([java.lang.IllegalStateException, java.lang.String, java.lang.Throwable], void)}
; {var460=org.apache.dubbo.remoting.zookeeper.curator5.Curator5ZookeeperClient, var2822=r3, var3935=r8, var2424=null_type, var376=r0, var2365=z0, var1436=java.nio.charset.Charset, var2531=$r1, var339=r2, var807=org.apache.curator.framework.CuratorFramework, var2425=$r4, var3786=java.lang.Throwable, var3542=$r13, var2485=org.apache.dubbo.common.logger.ErrorTypeAwareLogger, var1616=$r15, var703=$r29, var3459=$r16, var1658=$r17, var2290=$r18, var1820=$r19, var1911="1-35", var1804="", var1836=java.lang.IllegalStateException, var2500=$r30, var1767=org.apache.zookeeper.KeeperException$NodeExistsException, var3907=$r32, var3870=$r21}
; {org.apache.dubbo.remoting.zookeeper.curator5.Curator5ZookeeperClient=var460, r3=var2822, r8=var3935, null_type=var2424, r0=var376, z0=var2365, java.nio.charset.Charset=var1436, $r1=var2531, r2=var339, org.apache.curator.framework.CuratorFramework=var807, $r4=var2425, java.lang.Throwable=var3786, $r13=var3542, org.apache.dubbo.common.logger.ErrorTypeAwareLogger=var2485, $r15=var1616, $r29=var703, $r16=var3459, $r17=var1658, $r18=var2290, $r19=var1820, "1-35"=var1911, ""=var1804, java.lang.IllegalStateException=var1836, $r30=var2500, org.apache.zookeeper.KeeperException$NodeExistsException=var1767, $r32=var3907, $r21=var3870}
;seq <java.lang.String: byte[] getBytes(java.nio.charset.Charset)>;	<java.lang.StringBuilder: void <init>()>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.String toString()>
;cnt {"<java.lang.String: byte[] getBytes(java.nio.charset.Charset)>": 1,"<java.lang.StringBuilder: void <init>()>": 1,"<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>": 3,"<java.lang.StringBuilder: java.lang.String toString()>": 1}
;stmts r3 := @this: org.apache.dubbo.remoting.zookeeper.curator5.Curator5ZookeeperClient;	r8 := @parameter0: java.lang.String;	r0 := @parameter1: java.lang.String;	z0 := @parameter2: boolean;	$r1 = <org.apache.dubbo.remoting.zookeeper.curator5.Curator5ZookeeperClient: java.nio.charset.Charset CHARSET>;	r2 = virtualinvoke r0.<java.lang.String: byte[] getBytes(java.nio.charset.Charset)>($r1);	$r4 = r3.<org.apache.dubbo.remoting.zookeeper.curator5.Curator5ZookeeperClient: org.apache.curator.framework.CuratorFramework client>;	$r13 := @caughtexception;	if z0 == 0 goto $r15 = <org.apache.dubbo.remoting.zookeeper.curator5.Curator5ZookeeperClient: org.apache.dubbo.common.logger.ErrorTypeAwareLogger logger>;	$r15 = <org.apache.dubbo.remoting.zookeeper.curator5.Curator5ZookeeperClient: org.apache.dubbo.common.logger.ErrorTypeAwareLogger logger>;	$r29 = new java.lang.StringBuilder;	specialinvoke $r29.<java.lang.StringBuilder: void <init>()>();	$r16 = virtualinvoke $r29.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("ZNode ");	$r17 = virtualinvoke $r16.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(r8);	$r18 = virtualinvoke $r17.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(" already exists.");	$r19 = virtualinvoke $r18.<java.lang.StringBuilder: java.lang.String toString()>();	interfaceinvoke $r15.<org.apache.dubbo.common.logger.ErrorTypeAwareLogger: void warn(java.lang.String,java.lang.String,java.lang.String,java.lang.String,java.lang.Throwable)>("1-35", "", "", $r19, $r13);	$r30 = new java.lang.IllegalStateException;	$r32 = (org.apache.zookeeper.KeeperException$NodeExistsException) $r13;	$r21 = virtualinvoke $r32.<org.apache.zookeeper.KeeperException$NodeExistsException: java.lang.String getMessage()>();	specialinvoke $r30.<java.lang.IllegalStateException: void <init>(java.lang.String,java.lang.Throwable)>($r21, $r13);	throw $r30
;block_num 4