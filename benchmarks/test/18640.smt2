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

(declare-sort var1370 0)
(declare-sort var1425 0)
(declare-sort var3514 0)
(declare-sort var1480 0)
(declare-sort var2981 0)
(declare-sort var1822 0)
(declare-sort var444 0)
(declare-sort var3927 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun getBytes/-163691139 (String var3514) (Array Int Int))
(declare-fun client/1857390096 (var1370) var1480)
(declare-fun var1480_create/-683419810 (var1480) var2981)
(declare-fun var444-init () var444)
(declare-fun getMessage/849299655 (var3927) String)
(declare-fun cast-from-var1822-to-var3927 (var1822) var3927)
(declare-fun <init>/-1447874194 (var444 String var3927) void)
(declare-const null-var1370 var1370)
(declare-const null-String String)
(declare-const null-Bool Bool)
(declare-const var1370-CHARSET var3514)
(declare-const null-var1822 var1822)
(declare-const var2978 var1370) ; Statement: r3 := @this: org.apache.dubbo.remoting.zookeeper.curator5.Curator5ZookeeperClient 
(assert (not (= var2978 null-var1370)))
(declare-const var3495 String) ; Statement: r8 := @parameter0: java.lang.String 
(assert (not (= var3495 null-String)))
(declare-const var2991 String) ; Statement: r0 := @parameter1: java.lang.String 
(assert (not (= var2991 null-String)))
(declare-const var2853 Bool) ; Statement: z0 := @parameter2: boolean 
(assert (not (= var2853 null-Bool)))
(define-const var2764 var3514 var1370-CHARSET) ; Statement: $r1 = <org.apache.dubbo.remoting.zookeeper.curator5.Curator5ZookeeperClient: java.nio.charset.Charset CHARSET> 
(assert true)
(define-const var475 (Array Int Int) (getBytes/-163691139 var2991 var2764)) ; Statement: r2 = virtualinvoke r0.<java.lang.String: byte[] getBytes(java.nio.charset.Charset)>($r1) 
(assert true) ; Non Conditional
(define-const var1889 var1480 (client/1857390096 var2978)) ; Statement: $r4 = r3.<org.apache.dubbo.remoting.zookeeper.curator5.Curator5ZookeeperClient: org.apache.curator.framework.CuratorFramework client> 
(assert true) ; Non Conditional
(define-const var1957 var2981 (var1480_create/-683419810 var1889)) ; Statement: $r6 = interfaceinvoke $r4.<org.apache.curator.framework.CuratorFramework: org.apache.curator.framework.api.CreateBuilder create()>() 
(assert true) ; Handling Exception: java.lang.Throwable 
(declare-const var706 var1822) ; Statement: $r10 := @caughtexception 
(assert (not (= var706 null-var1822)))
(define-const var612 var444 var444-init) ; Statement: $r31 = new java.lang.IllegalStateException 
(assert true)
(define-const var1601 String (getMessage/849299655 (cast-from-var1822-to-var3927 var706))) ; Statement: $r12 = virtualinvoke $r10.<java.lang.Exception: java.lang.String getMessage()>() 
(assert true)
;(assert (<init>/-1447874194 var612 var1601 (cast-from-var1822-to-var3927 var706))) ; Statement: specialinvoke $r31.<java.lang.IllegalStateException: void <init>(java.lang.String,java.lang.Throwable)>($r12, $r10) 

(declare-const var612!1 var444)
(declare-const var1601!1 String)
(declare-const var706!1 var1822)
 ; Statement: throw $r31 
(check-sat)
; {getBytes/-163691139=([java.lang.String, java.nio.charset.Charset], byte[]), client/1857390096=([org.apache.dubbo.remoting.zookeeper.curator5.Curator5ZookeeperClient], org.apache.curator.framework.CuratorFramework), var1480_create/-683419810=([org.apache.curator.framework.CuratorFramework], org.apache.curator.framework.api.CreateBuilder), var444-init=([], java.lang.IllegalStateException), getMessage/849299655=([java.lang.Throwable], java.lang.String), cast-from-var1822-to-var3927=([java.lang.Exception], java.lang.Throwable), <init>/-1447874194=([java.lang.IllegalStateException, java.lang.String, java.lang.Throwable], void)}
; {var1370=org.apache.dubbo.remoting.zookeeper.curator5.Curator5ZookeeperClient, var2978=r3, var3495=r8, var1425=null_type, var2991=r0, var2853=z0, var3514=java.nio.charset.Charset, var2764=$r1, var475=r2, var1480=org.apache.curator.framework.CuratorFramework, var1889=$r4, var2981=org.apache.curator.framework.api.CreateBuilder, var1957=$r6, var1822=java.lang.Exception, var706=$r10, var444=java.lang.IllegalStateException, var612=$r31, var3927=java.lang.Throwable, var1601=$r12}
; {org.apache.dubbo.remoting.zookeeper.curator5.Curator5ZookeeperClient=var1370, r3=var2978, r8=var3495, null_type=var1425, r0=var2991, z0=var2853, java.nio.charset.Charset=var3514, $r1=var2764, r2=var475, org.apache.curator.framework.CuratorFramework=var1480, $r4=var1889, org.apache.curator.framework.api.CreateBuilder=var2981, $r6=var1957, java.lang.Exception=var1822, $r10=var706, java.lang.IllegalStateException=var444, $r31=var612, java.lang.Throwable=var3927, $r12=var1601}
;seq <java.lang.String: byte[] getBytes(java.nio.charset.Charset)>
;cnt {"<java.lang.String: byte[] getBytes(java.nio.charset.Charset)>": 1}
;stmts r3 := @this: org.apache.dubbo.remoting.zookeeper.curator5.Curator5ZookeeperClient;	r8 := @parameter0: java.lang.String;	r0 := @parameter1: java.lang.String;	z0 := @parameter2: boolean;	$r1 = <org.apache.dubbo.remoting.zookeeper.curator5.Curator5ZookeeperClient: java.nio.charset.Charset CHARSET>;	r2 = virtualinvoke r0.<java.lang.String: byte[] getBytes(java.nio.charset.Charset)>($r1);	$r4 = r3.<org.apache.dubbo.remoting.zookeeper.curator5.Curator5ZookeeperClient: org.apache.curator.framework.CuratorFramework client>;	$r6 = interfaceinvoke $r4.<org.apache.curator.framework.CuratorFramework: org.apache.curator.framework.api.CreateBuilder create()>();	$r10 := @caughtexception;	$r31 = new java.lang.IllegalStateException;	$r12 = virtualinvoke $r10.<java.lang.Exception: java.lang.String getMessage()>();	specialinvoke $r31.<java.lang.IllegalStateException: void <init>(java.lang.String,java.lang.Throwable)>($r12, $r10);	throw $r31
;block_num 4