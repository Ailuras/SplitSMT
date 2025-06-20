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

(declare-sort var3809 0)
(declare-sort var1287 0)
(declare-sort var898 0)
(declare-sort var322 0)
(declare-sort var3428 0)
(declare-sort var3755 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun getBytes/-163691139 (String var898) (Array Int Int))
(declare-fun var3428-init () var3428)
(declare-fun getMessage/849299655 (var3755) String)
(declare-fun cast-from-var322-to-var3755 (var322) var3755)
(declare-fun <init>/-1447874194 (var3428 String var3755) void)
(declare-const null-var3809 var3809)
(declare-const null-String String)
(declare-const null-Bool Bool)
(declare-const var3809-CHARSET var898)
(declare-const null-var322 var322)
(declare-const var3409 var3809) ; Statement: r3 := @this: org.apache.dubbo.remoting.zookeeper.curator5.Curator5ZookeeperClient 
(assert (not (= var3409 null-var3809)))
(declare-const var3400 String) ; Statement: r8 := @parameter0: java.lang.String 
(assert (not (= var3400 null-String)))
(declare-const var865 String) ; Statement: r0 := @parameter1: java.lang.String 
(assert (not (= var865 null-String)))
(declare-const var3437 Bool) ; Statement: z0 := @parameter2: boolean 
(assert (not (= var3437 null-Bool)))
(define-const var3492 var898 var3809-CHARSET) ; Statement: $r1 = <org.apache.dubbo.remoting.zookeeper.curator5.Curator5ZookeeperClient: java.nio.charset.Charset CHARSET> 
(assert true)
(define-const var543 (Array Int Int) (getBytes/-163691139 var865 var3492)) ; Statement: r2 = virtualinvoke r0.<java.lang.String: byte[] getBytes(java.nio.charset.Charset)>($r1) 
(assert true) ; Handling Exception: java.lang.Throwable 
(declare-const var2140 var322) ; Statement: $r10 := @caughtexception 
(assert (not (= var2140 null-var322)))
(define-const var3118 var3428 var3428-init) ; Statement: $r31 = new java.lang.IllegalStateException 
(assert true)
(define-const var1501 String (getMessage/849299655 (cast-from-var322-to-var3755 var2140))) ; Statement: $r12 = virtualinvoke $r10.<java.lang.Exception: java.lang.String getMessage()>() 
(assert true)
;(assert (<init>/-1447874194 var3118 var1501 (cast-from-var322-to-var3755 var2140))) ; Statement: specialinvoke $r31.<java.lang.IllegalStateException: void <init>(java.lang.String,java.lang.Throwable)>($r12, $r10) 

(declare-const var3118!1 var3428)
(declare-const var1501!1 String)
(declare-const var2140!1 var322)
 ; Statement: throw $r31 
(check-sat)
; {getBytes/-163691139=([java.lang.String, java.nio.charset.Charset], byte[]), var3428-init=([], java.lang.IllegalStateException), getMessage/849299655=([java.lang.Throwable], java.lang.String), cast-from-var322-to-var3755=([java.lang.Exception], java.lang.Throwable), <init>/-1447874194=([java.lang.IllegalStateException, java.lang.String, java.lang.Throwable], void)}
; {var3809=org.apache.dubbo.remoting.zookeeper.curator5.Curator5ZookeeperClient, var3409=r3, var3400=r8, var1287=null_type, var865=r0, var3437=z0, var898=java.nio.charset.Charset, var3492=$r1, var543=r2, var322=java.lang.Exception, var2140=$r10, var3428=java.lang.IllegalStateException, var3118=$r31, var3755=java.lang.Throwable, var1501=$r12}
; {org.apache.dubbo.remoting.zookeeper.curator5.Curator5ZookeeperClient=var3809, r3=var3409, r8=var3400, null_type=var1287, r0=var865, z0=var3437, java.nio.charset.Charset=var898, $r1=var3492, r2=var543, java.lang.Exception=var322, $r10=var2140, java.lang.IllegalStateException=var3428, $r31=var3118, java.lang.Throwable=var3755, $r12=var1501}
;seq <java.lang.String: byte[] getBytes(java.nio.charset.Charset)>
;cnt {"<java.lang.String: byte[] getBytes(java.nio.charset.Charset)>": 1}
;stmts r3 := @this: org.apache.dubbo.remoting.zookeeper.curator5.Curator5ZookeeperClient;	r8 := @parameter0: java.lang.String;	r0 := @parameter1: java.lang.String;	z0 := @parameter2: boolean;	$r1 = <org.apache.dubbo.remoting.zookeeper.curator5.Curator5ZookeeperClient: java.nio.charset.Charset CHARSET>;	r2 = virtualinvoke r0.<java.lang.String: byte[] getBytes(java.nio.charset.Charset)>($r1);	$r10 := @caughtexception;	$r31 = new java.lang.IllegalStateException;	$r12 = virtualinvoke $r10.<java.lang.Exception: java.lang.String getMessage()>();	specialinvoke $r31.<java.lang.IllegalStateException: void <init>(java.lang.String,java.lang.Throwable)>($r12, $r10);	throw $r31
;block_num 2