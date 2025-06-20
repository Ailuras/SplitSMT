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

(declare-sort var75 0)
(declare-sort var2290 0)
(declare-sort var3862 0)
(declare-sort var2211 0)
(declare-sort var1591 0)
(declare-sort var1254 0)
(declare-sort var394 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun getBytes/-163691139 (String var3862) (Array Int Int))
(declare-fun client/1857390096 (var75) var2211)
(declare-fun var1254-init () var1254)
(declare-fun getMessage/849299655 (var394) String)
(declare-fun cast-from-var1591-to-var394 (var1591) var394)
(declare-fun <init>/-1447874194 (var1254 String var394) void)
(declare-const null-var75 var75)
(declare-const null-String String)
(declare-const null-Bool Bool)
(declare-const var75-CHARSET var3862)
(declare-const null-var1591 var1591)
(declare-const var2085 var75) ; Statement: r3 := @this: org.apache.dubbo.remoting.zookeeper.curator5.Curator5ZookeeperClient 
(assert (not (= var2085 null-var75)))
(declare-const var392 String) ; Statement: r5 := @parameter0: java.lang.String 
(assert (not (= var392 null-String)))
(declare-const var2272 String) ; Statement: r0 := @parameter1: java.lang.String 
(assert (not (= var2272 null-String)))
(declare-const var2351 Bool) ; Statement: z0 := @parameter2: boolean 
(assert (not (= var2351 null-Bool)))
(define-const var1510 var3862 var75-CHARSET) ; Statement: $r1 = <org.apache.dubbo.remoting.zookeeper.curator5.Curator5ZookeeperClient: java.nio.charset.Charset CHARSET> 
(assert true)
(define-const var2457 (Array Int Int) (getBytes/-163691139 var2272 var1510)) ; Statement: r2 = virtualinvoke r0.<java.lang.String: byte[] getBytes(java.nio.charset.Charset)>($r1) 
(assert true) ; Non Conditional
(define-const var690 var2211 (client/1857390096 var2085)) ; Statement: $r4 = r3.<org.apache.dubbo.remoting.zookeeper.curator5.Curator5ZookeeperClient: org.apache.curator.framework.CuratorFramework client> 
(assert true) ; Handling Exception: java.lang.Throwable 
(declare-const var1263 var1591) ; Statement: $r7 := @caughtexception 
(assert (not (= var1263 null-var1591)))
(define-const var532 var1254 var1254-init) ; Statement: $r34 = new java.lang.IllegalStateException 
(assert true)
(define-const var1658 String (getMessage/849299655 (cast-from-var1591-to-var394 var1263))) ; Statement: $r9 = virtualinvoke $r7.<java.lang.Exception: java.lang.String getMessage()>() 
(assert true)
;(assert (<init>/-1447874194 var532 var1658 (cast-from-var1591-to-var394 var1263))) ; Statement: specialinvoke $r34.<java.lang.IllegalStateException: void <init>(java.lang.String,java.lang.Throwable)>($r9, $r7) 

(declare-const var532!1 var1254)
(declare-const var1658!1 String)
(declare-const var1263!1 var1591)
 ; Statement: throw $r34 
(check-sat)
; {getBytes/-163691139=([java.lang.String, java.nio.charset.Charset], byte[]), client/1857390096=([org.apache.dubbo.remoting.zookeeper.curator5.Curator5ZookeeperClient], org.apache.curator.framework.CuratorFramework), var1254-init=([], java.lang.IllegalStateException), getMessage/849299655=([java.lang.Throwable], java.lang.String), cast-from-var1591-to-var394=([java.lang.Exception], java.lang.Throwable), <init>/-1447874194=([java.lang.IllegalStateException, java.lang.String, java.lang.Throwable], void)}
; {var75=org.apache.dubbo.remoting.zookeeper.curator5.Curator5ZookeeperClient, var2085=r3, var392=r5, var2290=null_type, var2272=r0, var2351=z0, var3862=java.nio.charset.Charset, var1510=$r1, var2457=r2, var2211=org.apache.curator.framework.CuratorFramework, var690=$r4, var1591=java.lang.Exception, var1263=$r7, var1254=java.lang.IllegalStateException, var532=$r34, var394=java.lang.Throwable, var1658=$r9}
; {org.apache.dubbo.remoting.zookeeper.curator5.Curator5ZookeeperClient=var75, r3=var2085, r5=var392, null_type=var2290, r0=var2272, z0=var2351, java.nio.charset.Charset=var3862, $r1=var1510, r2=var2457, org.apache.curator.framework.CuratorFramework=var2211, $r4=var690, java.lang.Exception=var1591, $r7=var1263, java.lang.IllegalStateException=var1254, $r34=var532, java.lang.Throwable=var394, $r9=var1658}
;seq <java.lang.String: byte[] getBytes(java.nio.charset.Charset)>
;cnt {"<java.lang.String: byte[] getBytes(java.nio.charset.Charset)>": 1}
;stmts r3 := @this: org.apache.dubbo.remoting.zookeeper.curator5.Curator5ZookeeperClient;	r5 := @parameter0: java.lang.String;	r0 := @parameter1: java.lang.String;	z0 := @parameter2: boolean;	$r1 = <org.apache.dubbo.remoting.zookeeper.curator5.Curator5ZookeeperClient: java.nio.charset.Charset CHARSET>;	r2 = virtualinvoke r0.<java.lang.String: byte[] getBytes(java.nio.charset.Charset)>($r1);	$r4 = r3.<org.apache.dubbo.remoting.zookeeper.curator5.Curator5ZookeeperClient: org.apache.curator.framework.CuratorFramework client>;	$r7 := @caughtexception;	$r34 = new java.lang.IllegalStateException;	$r9 = virtualinvoke $r7.<java.lang.Exception: java.lang.String getMessage()>();	specialinvoke $r34.<java.lang.IllegalStateException: void <init>(java.lang.String,java.lang.Throwable)>($r9, $r7);	throw $r34
;block_num 3