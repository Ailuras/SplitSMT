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

(declare-sort var1421 0)
(declare-sort var921 0)
(declare-sort var3606 0)
(declare-sort var1329 0)
(declare-sort var1832 0)
(declare-sort var841 0)
(declare-sort var121 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun getBytes/-163691139 (String var3606) (Array Int Int))
(declare-fun client/1857390096 (var1421) var1329)
(declare-fun var841-init () var841)
(declare-fun getMessage/849299655 (var121) String)
(declare-fun cast-from-var1832-to-var121 (var1832) var121)
(declare-fun <init>/-1447874194 (var841 String var121) void)
(declare-const null-var1421 var1421)
(declare-const null-String String)
(declare-const null-Int Int)
(declare-const var1421-CHARSET var3606)
(declare-const null-var1832 var1832)
(declare-const var1196 var1421) ; Statement: r3 := @this: org.apache.dubbo.remoting.zookeeper.curator5.Curator5ZookeeperClient 
(assert (not (= var1196 null-var1421)))
(declare-const var3587 String) ; Statement: r7 := @parameter0: java.lang.String 
(assert (not (= var3587 null-String)))
(declare-const var2875 String) ; Statement: r0 := @parameter1: java.lang.String 
(assert (not (= var2875 null-String)))
(declare-const var3595 Int) ; Statement: i0 := @parameter2: int 
(assert (not (= var3595 null-Int)))
(define-const var1624 var3606 var1421-CHARSET) ; Statement: $r1 = <org.apache.dubbo.remoting.zookeeper.curator5.Curator5ZookeeperClient: java.nio.charset.Charset CHARSET> 
(assert true)
(define-const var1306 (Array Int Int) (getBytes/-163691139 var2875 var1624)) ; Statement: r2 = virtualinvoke r0.<java.lang.String: byte[] getBytes(java.nio.charset.Charset)>($r1) 
(assert true) ; Non Conditional
(define-const var3650 var1329 (client/1857390096 var1196)) ; Statement: $r4 = r3.<org.apache.dubbo.remoting.zookeeper.curator5.Curator5ZookeeperClient: org.apache.curator.framework.CuratorFramework client> 
(assert true) ; Handling Exception: java.lang.Throwable 
(declare-const var728 var1832) ; Statement: $r9 := @caughtexception 
(assert (not (= var728 null-var1832)))
(define-const var615 var841 var841-init) ; Statement: $r10 = new java.lang.IllegalStateException 
(assert true)
(define-const var1228 String (getMessage/849299655 (cast-from-var1832-to-var121 var728))) ; Statement: $r11 = virtualinvoke $r9.<java.lang.Exception: java.lang.String getMessage()>() 
(assert true)
;(assert (<init>/-1447874194 var615 var1228 (cast-from-var1832-to-var121 var728))) ; Statement: specialinvoke $r10.<java.lang.IllegalStateException: void <init>(java.lang.String,java.lang.Throwable)>($r11, $r9) 

(declare-const var615!1 var841)
(declare-const var1228!1 String)
(declare-const var728!1 var1832)
 ; Statement: throw $r10 
(check-sat)
; {getBytes/-163691139=([java.lang.String, java.nio.charset.Charset], byte[]), client/1857390096=([org.apache.dubbo.remoting.zookeeper.curator5.Curator5ZookeeperClient], org.apache.curator.framework.CuratorFramework), var841-init=([], java.lang.IllegalStateException), getMessage/849299655=([java.lang.Throwable], java.lang.String), cast-from-var1832-to-var121=([java.lang.Exception], java.lang.Throwable), <init>/-1447874194=([java.lang.IllegalStateException, java.lang.String, java.lang.Throwable], void)}
; {var1421=org.apache.dubbo.remoting.zookeeper.curator5.Curator5ZookeeperClient, var1196=r3, var3587=r7, var921=null_type, var2875=r0, var3595=i0, var3606=java.nio.charset.Charset, var1624=$r1, var1306=r2, var1329=org.apache.curator.framework.CuratorFramework, var3650=$r4, var1832=java.lang.Exception, var728=$r9, var841=java.lang.IllegalStateException, var615=$r10, var121=java.lang.Throwable, var1228=$r11}
; {org.apache.dubbo.remoting.zookeeper.curator5.Curator5ZookeeperClient=var1421, r3=var1196, r7=var3587, null_type=var921, r0=var2875, i0=var3595, java.nio.charset.Charset=var3606, $r1=var1624, r2=var1306, org.apache.curator.framework.CuratorFramework=var1329, $r4=var3650, java.lang.Exception=var1832, $r9=var728, java.lang.IllegalStateException=var841, $r10=var615, java.lang.Throwable=var121, $r11=var1228}
;seq <java.lang.String: byte[] getBytes(java.nio.charset.Charset)>
;cnt {"<java.lang.String: byte[] getBytes(java.nio.charset.Charset)>": 1}
;stmts r3 := @this: org.apache.dubbo.remoting.zookeeper.curator5.Curator5ZookeeperClient;	r7 := @parameter0: java.lang.String;	r0 := @parameter1: java.lang.String;	i0 := @parameter2: int;	$r1 = <org.apache.dubbo.remoting.zookeeper.curator5.Curator5ZookeeperClient: java.nio.charset.Charset CHARSET>;	r2 = virtualinvoke r0.<java.lang.String: byte[] getBytes(java.nio.charset.Charset)>($r1);	$r4 = r3.<org.apache.dubbo.remoting.zookeeper.curator5.Curator5ZookeeperClient: org.apache.curator.framework.CuratorFramework client>;	$r9 := @caughtexception;	$r10 = new java.lang.IllegalStateException;	$r11 = virtualinvoke $r9.<java.lang.Exception: java.lang.String getMessage()>();	specialinvoke $r10.<java.lang.IllegalStateException: void <init>(java.lang.String,java.lang.Throwable)>($r11, $r9);	throw $r10
;block_num 3