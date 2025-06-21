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

(declare-sort var2295 0)
(declare-sort var3896 0)
(declare-sort var681 0)
(declare-sort var3168 0)
(declare-sort var571 0)
(declare-sort var2349 0)
(declare-sort var1398 0)
(declare-sort var1582 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun getBytes/-163691139 (String var681) (Array Int Int))
(declare-fun client/1857390096 (var2295) var3168)
(declare-fun var3168_create/-683419810 (var3168) var571)
(declare-fun var1398-init () var1398)
(declare-fun getMessage/849299655 (var1582) String)
(declare-fun cast-from-var2349-to-var1582 (var2349) var1582)
(declare-fun <init>/-1447874194 (var1398 String var1582) void)
(declare-const null-var2295 var2295)
(declare-const null-String String)
(declare-const null-Bool Bool)
(declare-const var2295-CHARSET var681)
(declare-const null-var2349 var2349)
(declare-const var1228 var2295) ; Statement: r3 := @this: org.apache.dubbo.remoting.zookeeper.curator5.Curator5ZookeeperClient 
(assert (not (= var1228 null-var2295)))
(declare-const var1995 String) ; Statement: r5 := @parameter0: java.lang.String 
(assert (not (= var1995 null-String)))
(declare-const var818 String) ; Statement: r0 := @parameter1: java.lang.String 
(assert (not (= var818 null-String)))
(declare-const var3544 Bool) ; Statement: z0 := @parameter2: boolean 
(assert (not (= var3544 null-Bool)))
(define-const var121 var681 var2295-CHARSET) ; Statement: $r1 = <org.apache.dubbo.remoting.zookeeper.curator5.Curator5ZookeeperClient: java.nio.charset.Charset CHARSET> 
(assert true)
(define-const var3479 (Array Int Int) (getBytes/-163691139 var818 var121)) ; Statement: r2 = virtualinvoke r0.<java.lang.String: byte[] getBytes(java.nio.charset.Charset)>($r1) 
(assert true) ; Non Conditional
(define-const var2523 var3168 (client/1857390096 var1228)) ; Statement: $r4 = r3.<org.apache.dubbo.remoting.zookeeper.curator5.Curator5ZookeeperClient: org.apache.curator.framework.CuratorFramework client> 
(assert true) ; Non Conditional
(define-const var3392 var571 (var3168_create/-683419810 var2523)) ; Statement: $r6 = interfaceinvoke $r4.<org.apache.curator.framework.CuratorFramework: org.apache.curator.framework.api.CreateBuilder create()>() 
(assert true) ; Handling Exception: java.lang.Throwable 
(declare-const var2378 var2349) ; Statement: $r7 := @caughtexception 
(assert (not (= var2378 null-var2349)))
(define-const var15 var1398 var1398-init) ; Statement: $r34 = new java.lang.IllegalStateException 
(assert true)
(define-const var2125 String (getMessage/849299655 (cast-from-var2349-to-var1582 var2378))) ; Statement: $r9 = virtualinvoke $r7.<java.lang.Exception: java.lang.String getMessage()>() 
(assert true)
;(assert (<init>/-1447874194 var15 var2125 (cast-from-var2349-to-var1582 var2378))) ; Statement: specialinvoke $r34.<java.lang.IllegalStateException: void <init>(java.lang.String,java.lang.Throwable)>($r9, $r7) 

(declare-const var15!1 var1398)
(declare-const var2125!1 String)
(declare-const var2378!1 var2349)
 ; Statement: throw $r34 
(check-sat)
; {getBytes/-163691139=([java.lang.String, java.nio.charset.Charset], byte[]), client/1857390096=([org.apache.dubbo.remoting.zookeeper.curator5.Curator5ZookeeperClient], org.apache.curator.framework.CuratorFramework), var3168_create/-683419810=([org.apache.curator.framework.CuratorFramework], org.apache.curator.framework.api.CreateBuilder), var1398-init=([], java.lang.IllegalStateException), getMessage/849299655=([java.lang.Throwable], java.lang.String), cast-from-var2349-to-var1582=([java.lang.Exception], java.lang.Throwable), <init>/-1447874194=([java.lang.IllegalStateException, java.lang.String, java.lang.Throwable], void)}
; {var2295=org.apache.dubbo.remoting.zookeeper.curator5.Curator5ZookeeperClient, var1228=r3, var1995=r5, var3896=null_type, var818=r0, var3544=z0, var681=java.nio.charset.Charset, var121=$r1, var3479=r2, var3168=org.apache.curator.framework.CuratorFramework, var2523=$r4, var571=org.apache.curator.framework.api.CreateBuilder, var3392=$r6, var2349=java.lang.Exception, var2378=$r7, var1398=java.lang.IllegalStateException, var15=$r34, var1582=java.lang.Throwable, var2125=$r9}
; {org.apache.dubbo.remoting.zookeeper.curator5.Curator5ZookeeperClient=var2295, r3=var1228, r5=var1995, null_type=var3896, r0=var818, z0=var3544, java.nio.charset.Charset=var681, $r1=var121, r2=var3479, org.apache.curator.framework.CuratorFramework=var3168, $r4=var2523, org.apache.curator.framework.api.CreateBuilder=var571, $r6=var3392, java.lang.Exception=var2349, $r7=var2378, java.lang.IllegalStateException=var1398, $r34=var15, java.lang.Throwable=var1582, $r9=var2125}
;seq <java.lang.String: byte[] getBytes(java.nio.charset.Charset)>
;cnt {"<java.lang.String: byte[] getBytes(java.nio.charset.Charset)>": 1}
;stmts r3 := @this: org.apache.dubbo.remoting.zookeeper.curator5.Curator5ZookeeperClient;	r5 := @parameter0: java.lang.String;	r0 := @parameter1: java.lang.String;	z0 := @parameter2: boolean;	$r1 = <org.apache.dubbo.remoting.zookeeper.curator5.Curator5ZookeeperClient: java.nio.charset.Charset CHARSET>;	r2 = virtualinvoke r0.<java.lang.String: byte[] getBytes(java.nio.charset.Charset)>($r1);	$r4 = r3.<org.apache.dubbo.remoting.zookeeper.curator5.Curator5ZookeeperClient: org.apache.curator.framework.CuratorFramework client>;	$r6 = interfaceinvoke $r4.<org.apache.curator.framework.CuratorFramework: org.apache.curator.framework.api.CreateBuilder create()>();	$r7 := @caughtexception;	$r34 = new java.lang.IllegalStateException;	$r9 = virtualinvoke $r7.<java.lang.Exception: java.lang.String getMessage()>();	specialinvoke $r34.<java.lang.IllegalStateException: void <init>(java.lang.String,java.lang.Throwable)>($r9, $r7);	throw $r34
;block_num 4