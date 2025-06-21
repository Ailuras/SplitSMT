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

(declare-sort var2410 0)
(declare-sort var1847 0)
(declare-sort var3306 0)
(declare-sort var1169 0)
(declare-sort var3233 0)
(declare-sort var2622 0)
(declare-sort var2692 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun getBytes/-163691139 (String var3306) (Array Int Int))
(declare-fun client/1857390096 (var2410) var1169)
(declare-fun var2622-init () var2622)
(declare-fun getMessage/849299655 (var2692) String)
(declare-fun cast-from-var3233-to-var2692 (var3233) var2692)
(declare-fun <init>/-1447874194 (var2622 String var2692) void)
(declare-const null-var2410 var2410)
(declare-const null-String String)
(declare-const null-Bool Bool)
(declare-const var2410-CHARSET var3306)
(declare-const null-var3233 var3233)
(declare-const var2069 var2410) ; Statement: r3 := @this: org.apache.dubbo.remoting.zookeeper.curator5.Curator5ZookeeperClient 
(assert (not (= var2069 null-var2410)))
(declare-const var1817 String) ; Statement: r8 := @parameter0: java.lang.String 
(assert (not (= var1817 null-String)))
(declare-const var1475 String) ; Statement: r0 := @parameter1: java.lang.String 
(assert (not (= var1475 null-String)))
(declare-const var318 Bool) ; Statement: z0 := @parameter2: boolean 
(assert (not (= var318 null-Bool)))
(define-const var1268 var3306 var2410-CHARSET) ; Statement: $r1 = <org.apache.dubbo.remoting.zookeeper.curator5.Curator5ZookeeperClient: java.nio.charset.Charset CHARSET> 
(assert true)
(define-const var2134 (Array Int Int) (getBytes/-163691139 var1475 var1268)) ; Statement: r2 = virtualinvoke r0.<java.lang.String: byte[] getBytes(java.nio.charset.Charset)>($r1) 
(assert true) ; Non Conditional
(define-const var1753 var1169 (client/1857390096 var2069)) ; Statement: $r4 = r3.<org.apache.dubbo.remoting.zookeeper.curator5.Curator5ZookeeperClient: org.apache.curator.framework.CuratorFramework client> 
(assert true) ; Handling Exception: java.lang.Throwable 
(declare-const var3975 var3233) ; Statement: $r10 := @caughtexception 
(assert (not (= var3975 null-var3233)))
(define-const var849 var2622 var2622-init) ; Statement: $r31 = new java.lang.IllegalStateException 
(assert true)
(define-const var3614 String (getMessage/849299655 (cast-from-var3233-to-var2692 var3975))) ; Statement: $r12 = virtualinvoke $r10.<java.lang.Exception: java.lang.String getMessage()>() 
(assert true)
;(assert (<init>/-1447874194 var849 var3614 (cast-from-var3233-to-var2692 var3975))) ; Statement: specialinvoke $r31.<java.lang.IllegalStateException: void <init>(java.lang.String,java.lang.Throwable)>($r12, $r10) 

(declare-const var849!1 var2622)
(declare-const var3614!1 String)
(declare-const var3975!1 var3233)
 ; Statement: throw $r31 
(check-sat)
; {getBytes/-163691139=([java.lang.String, java.nio.charset.Charset], byte[]), client/1857390096=([org.apache.dubbo.remoting.zookeeper.curator5.Curator5ZookeeperClient], org.apache.curator.framework.CuratorFramework), var2622-init=([], java.lang.IllegalStateException), getMessage/849299655=([java.lang.Throwable], java.lang.String), cast-from-var3233-to-var2692=([java.lang.Exception], java.lang.Throwable), <init>/-1447874194=([java.lang.IllegalStateException, java.lang.String, java.lang.Throwable], void)}
; {var2410=org.apache.dubbo.remoting.zookeeper.curator5.Curator5ZookeeperClient, var2069=r3, var1817=r8, var1847=null_type, var1475=r0, var318=z0, var3306=java.nio.charset.Charset, var1268=$r1, var2134=r2, var1169=org.apache.curator.framework.CuratorFramework, var1753=$r4, var3233=java.lang.Exception, var3975=$r10, var2622=java.lang.IllegalStateException, var849=$r31, var2692=java.lang.Throwable, var3614=$r12}
; {org.apache.dubbo.remoting.zookeeper.curator5.Curator5ZookeeperClient=var2410, r3=var2069, r8=var1817, null_type=var1847, r0=var1475, z0=var318, java.nio.charset.Charset=var3306, $r1=var1268, r2=var2134, org.apache.curator.framework.CuratorFramework=var1169, $r4=var1753, java.lang.Exception=var3233, $r10=var3975, java.lang.IllegalStateException=var2622, $r31=var849, java.lang.Throwable=var2692, $r12=var3614}
;seq <java.lang.String: byte[] getBytes(java.nio.charset.Charset)>
;cnt {"<java.lang.String: byte[] getBytes(java.nio.charset.Charset)>": 1}
;stmts r3 := @this: org.apache.dubbo.remoting.zookeeper.curator5.Curator5ZookeeperClient;	r8 := @parameter0: java.lang.String;	r0 := @parameter1: java.lang.String;	z0 := @parameter2: boolean;	$r1 = <org.apache.dubbo.remoting.zookeeper.curator5.Curator5ZookeeperClient: java.nio.charset.Charset CHARSET>;	r2 = virtualinvoke r0.<java.lang.String: byte[] getBytes(java.nio.charset.Charset)>($r1);	$r4 = r3.<org.apache.dubbo.remoting.zookeeper.curator5.Curator5ZookeeperClient: org.apache.curator.framework.CuratorFramework client>;	$r10 := @caughtexception;	$r31 = new java.lang.IllegalStateException;	$r12 = virtualinvoke $r10.<java.lang.Exception: java.lang.String getMessage()>();	specialinvoke $r31.<java.lang.IllegalStateException: void <init>(java.lang.String,java.lang.Throwable)>($r12, $r10);	throw $r31
;block_num 3