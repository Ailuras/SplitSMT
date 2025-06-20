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

(declare-sort var519 0)
(declare-sort var63 0)
(declare-sort var1035 0)
(declare-sort var1411 0)
(declare-sort var1155 0)
(declare-sort var1328 0)
(declare-sort var2174 0)
(declare-sort var3678 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun getBytes/-163691139 (String var1035) (Array Int Int))
(declare-fun client/1857390096 (var519) var1411)
(declare-fun String-init () String)
(define-fun <init>/1968657023 () String "")
(define-fun append/672562846 ((s String) (tail String)) String (str.++ s tail))
(define-fun toString/-2075883882 ((s String)) String s)
(declare-fun var1328_warn/126438324 (var1328 String String String String var1155) void)
(declare-fun var2174-init () var2174)
(declare-fun cast-from-var1155-to-var3678 (var1155) var3678)
(declare-fun getMessage/879517157 (var3678) String)
(declare-fun <init>/-1447874194 (var2174 String var1155) void)
(declare-const null-var519 var519)
(declare-const null-String String)
(declare-const null-Bool Bool)
(declare-const var519-CHARSET var1035)
(declare-const null-var1155 var1155)
(declare-const var519-logger var1328)
(declare-const var2284 var519) ; Statement: r3 := @this: org.apache.dubbo.remoting.zookeeper.curator5.Curator5ZookeeperClient 
(assert (not (= var2284 null-var519)))
(declare-const var3343 String) ; Statement: r5 := @parameter0: java.lang.String 
(assert (not (= var3343 null-String)))
(declare-const var2871 String) ; Statement: r0 := @parameter1: java.lang.String 
(assert (not (= var2871 null-String)))
(declare-const var3199 Bool) ; Statement: z0 := @parameter2: boolean 
(assert (not (= var3199 null-Bool)))
(define-const var2817 var1035 var519-CHARSET) ; Statement: $r1 = <org.apache.dubbo.remoting.zookeeper.curator5.Curator5ZookeeperClient: java.nio.charset.Charset CHARSET> 
(assert true)
(define-const var2130 (Array Int Int) (getBytes/-163691139 var2871 var2817)) ; Statement: r2 = virtualinvoke r0.<java.lang.String: byte[] getBytes(java.nio.charset.Charset)>($r1) 
(assert true) ; Non Conditional
(define-const var1855 var1411 (client/1857390096 var2284)) ; Statement: $r4 = r3.<org.apache.dubbo.remoting.zookeeper.curator5.Curator5ZookeeperClient: org.apache.curator.framework.CuratorFramework client> 
(assert true) ; Handling Exception: java.lang.Throwable 
(declare-const var1282 var1155) ; Statement: $r13 := @caughtexception 
(assert (not (= var1282 null-var1155)))
 ; Statement: if z0 == 0 goto $r15 = <org.apache.dubbo.remoting.zookeeper.curator5.Curator5ZookeeperClient: org.apache.dubbo.common.logger.ErrorTypeAwareLogger logger> 
(assert (= (ite var3199 1 0) 0)) ; Cond: z0 == 0 
(define-const var693 var1328 var519-logger) ; Statement: $r15 = <org.apache.dubbo.remoting.zookeeper.curator5.Curator5ZookeeperClient: org.apache.dubbo.common.logger.ErrorTypeAwareLogger logger> 
(define-const var3910 String String-init) ; Statement: $r32 = new java.lang.StringBuilder 
(assert true)
;(assert (<init>/1968657023 var3910)) ; Statement: specialinvoke $r32.<java.lang.StringBuilder: void <init>()>() 
(declare-const var3910!1 String)
(assert (= var3910!1 ""))
(assert true)
(define-const var2645 String (append/672562846 var3910!1 "ZNode ")) ; Statement: $r16 = virtualinvoke $r32.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("ZNode ") 
(declare-const var3910!2 String)
(assert (= var3910!2 (str.++ var3910!1 "ZNode ")))
(assert true)
(define-const var2669 String (append/672562846 var2645 var3343)) ; Statement: $r17 = virtualinvoke $r16.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(r5) 
(declare-const var2645!1 String)
(assert (= var2645!1 (str.++ var2645 var3343)))
(assert true)
(define-const var175 String (append/672562846 var2669 " already exists.")) ; Statement: $r18 = virtualinvoke $r17.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(" already exists.") 
(declare-const var2669!1 String)
(assert (= var2669!1 (str.++ var2669 " already exists.")))
(assert true)
(define-const var2724 String (toString/-2075883882 var175)) ; Statement: $r19 = virtualinvoke $r18.<java.lang.StringBuilder: java.lang.String toString()>() 
;(assert (var1328_warn/126438324 var693 "1-35" "" "" var2724 var1282)) ; Statement: interfaceinvoke $r15.<org.apache.dubbo.common.logger.ErrorTypeAwareLogger: void warn(java.lang.String,java.lang.String,java.lang.String,java.lang.String,java.lang.Throwable)>("1-35", "", "", $r19, $r13) 

(declare-const var693!1 var1328)
(declare-const var1554 String)
(declare-const var2224 String)
(declare-const var2224!1 String)
(declare-const var2724!1 String)
(declare-const var1282!1 var1155)
(define-const var720 var2174 var2174-init) ; Statement: $r33 = new java.lang.IllegalStateException 
(define-const var2247 var3678 (cast-from-var1155-to-var3678 var1282!1)) ; Statement: $r36 = (org.apache.zookeeper.KeeperException$NodeExistsException) $r13 
(assert true)
(define-const var1881 String (getMessage/879517157 var2247)) ; Statement: $r21 = virtualinvoke $r36.<org.apache.zookeeper.KeeperException$NodeExistsException: java.lang.String getMessage()>() 
(assert true)
;(assert (<init>/-1447874194 var720 var1881 var1282!1)) ; Statement: specialinvoke $r33.<java.lang.IllegalStateException: void <init>(java.lang.String,java.lang.Throwable)>($r21, $r13) 

(declare-const var720!1 var2174)
(declare-const var1881!1 String)
(declare-const var1282!2 var1155)
 ; Statement: throw $r33 
(check-sat)
; {getBytes/-163691139=([java.lang.String, java.nio.charset.Charset], byte[]), client/1857390096=([org.apache.dubbo.remoting.zookeeper.curator5.Curator5ZookeeperClient], org.apache.curator.framework.CuratorFramework), String-init=([], java.lang.StringBuilder), <init>/1968657023=([java.lang.StringBuilder], void), append/672562846=([java.lang.StringBuilder, java.lang.String], java.lang.StringBuilder), toString/-2075883882=([java.lang.StringBuilder], java.lang.String), var1328_warn/126438324=([org.apache.dubbo.common.logger.ErrorTypeAwareLogger, java.lang.String, java.lang.String, java.lang.String, java.lang.String, java.lang.Throwable], void), var2174-init=([], java.lang.IllegalStateException), cast-from-var1155-to-var3678=([java.lang.Throwable], org.apache.zookeeper.KeeperException$NodeExistsException), getMessage/879517157=([org.apache.zookeeper.KeeperException$NodeExistsException], java.lang.String), <init>/-1447874194=([java.lang.IllegalStateException, java.lang.String, java.lang.Throwable], void)}
; {var519=org.apache.dubbo.remoting.zookeeper.curator5.Curator5ZookeeperClient, var2284=r3, var3343=r5, var63=null_type, var2871=r0, var3199=z0, var1035=java.nio.charset.Charset, var2817=$r1, var2130=r2, var1411=org.apache.curator.framework.CuratorFramework, var1855=$r4, var1155=java.lang.Throwable, var1282=$r13, var1328=org.apache.dubbo.common.logger.ErrorTypeAwareLogger, var693=$r15, var3910=$r32, var2645=$r16, var2669=$r17, var175=$r18, var2724=$r19, var1554="1-35", var2224="", var2174=java.lang.IllegalStateException, var720=$r33, var3678=org.apache.zookeeper.KeeperException$NodeExistsException, var2247=$r36, var1881=$r21}
; {org.apache.dubbo.remoting.zookeeper.curator5.Curator5ZookeeperClient=var519, r3=var2284, r5=var3343, null_type=var63, r0=var2871, z0=var3199, java.nio.charset.Charset=var1035, $r1=var2817, r2=var2130, org.apache.curator.framework.CuratorFramework=var1411, $r4=var1855, java.lang.Throwable=var1155, $r13=var1282, org.apache.dubbo.common.logger.ErrorTypeAwareLogger=var1328, $r15=var693, $r32=var3910, $r16=var2645, $r17=var2669, $r18=var175, $r19=var2724, "1-35"=var1554, ""=var2224, java.lang.IllegalStateException=var2174, $r33=var720, org.apache.zookeeper.KeeperException$NodeExistsException=var3678, $r36=var2247, $r21=var1881}
;seq <java.lang.String: byte[] getBytes(java.nio.charset.Charset)>;	<java.lang.StringBuilder: void <init>()>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.String toString()>
;cnt {"<java.lang.String: byte[] getBytes(java.nio.charset.Charset)>": 1,"<java.lang.StringBuilder: void <init>()>": 1,"<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>": 3,"<java.lang.StringBuilder: java.lang.String toString()>": 1}
;stmts r3 := @this: org.apache.dubbo.remoting.zookeeper.curator5.Curator5ZookeeperClient;	r5 := @parameter0: java.lang.String;	r0 := @parameter1: java.lang.String;	z0 := @parameter2: boolean;	$r1 = <org.apache.dubbo.remoting.zookeeper.curator5.Curator5ZookeeperClient: java.nio.charset.Charset CHARSET>;	r2 = virtualinvoke r0.<java.lang.String: byte[] getBytes(java.nio.charset.Charset)>($r1);	$r4 = r3.<org.apache.dubbo.remoting.zookeeper.curator5.Curator5ZookeeperClient: org.apache.curator.framework.CuratorFramework client>;	$r13 := @caughtexception;	if z0 == 0 goto $r15 = <org.apache.dubbo.remoting.zookeeper.curator5.Curator5ZookeeperClient: org.apache.dubbo.common.logger.ErrorTypeAwareLogger logger>;	$r15 = <org.apache.dubbo.remoting.zookeeper.curator5.Curator5ZookeeperClient: org.apache.dubbo.common.logger.ErrorTypeAwareLogger logger>;	$r32 = new java.lang.StringBuilder;	specialinvoke $r32.<java.lang.StringBuilder: void <init>()>();	$r16 = virtualinvoke $r32.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("ZNode ");	$r17 = virtualinvoke $r16.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(r5);	$r18 = virtualinvoke $r17.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(" already exists.");	$r19 = virtualinvoke $r18.<java.lang.StringBuilder: java.lang.String toString()>();	interfaceinvoke $r15.<org.apache.dubbo.common.logger.ErrorTypeAwareLogger: void warn(java.lang.String,java.lang.String,java.lang.String,java.lang.String,java.lang.Throwable)>("1-35", "", "", $r19, $r13);	$r33 = new java.lang.IllegalStateException;	$r36 = (org.apache.zookeeper.KeeperException$NodeExistsException) $r13;	$r21 = virtualinvoke $r36.<org.apache.zookeeper.KeeperException$NodeExistsException: java.lang.String getMessage()>();	specialinvoke $r33.<java.lang.IllegalStateException: void <init>(java.lang.String,java.lang.Throwable)>($r21, $r13);	throw $r33
;block_num 4