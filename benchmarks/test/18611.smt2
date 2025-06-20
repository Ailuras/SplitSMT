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

(declare-sort var1189 0)
(declare-sort var1960 0)
(declare-sort var1473 0)
(declare-sort var3689 0)
(declare-sort var1744 0)
(declare-sort var1158 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun getBytes/-163691139 (String var1473) (Array Int Int))
(declare-fun var1744-init () var1744)
(declare-fun getMessage/849299655 (var1158) String)
(declare-fun cast-from-var3689-to-var1158 (var3689) var1158)
(declare-fun <init>/-1447874194 (var1744 String var1158) void)
(declare-const null-var1189 var1189)
(declare-const null-String String)
(declare-const null-Bool Bool)
(declare-const var1189-CHARSET var1473)
(declare-const null-var3689 var3689)
(declare-const var800 var1189) ; Statement: r3 := @this: org.apache.dubbo.remoting.zookeeper.curator5.Curator5ZookeeperClient 
(assert (not (= var800 null-var1189)))
(declare-const var1219 String) ; Statement: r5 := @parameter0: java.lang.String 
(assert (not (= var1219 null-String)))
(declare-const var3205 String) ; Statement: r0 := @parameter1: java.lang.String 
(assert (not (= var3205 null-String)))
(declare-const var1280 Bool) ; Statement: z0 := @parameter2: boolean 
(assert (not (= var1280 null-Bool)))
(define-const var3256 var1473 var1189-CHARSET) ; Statement: $r1 = <org.apache.dubbo.remoting.zookeeper.curator5.Curator5ZookeeperClient: java.nio.charset.Charset CHARSET> 
(assert true)
(define-const var3865 (Array Int Int) (getBytes/-163691139 var3205 var3256)) ; Statement: r2 = virtualinvoke r0.<java.lang.String: byte[] getBytes(java.nio.charset.Charset)>($r1) 
(assert true) ; Handling Exception: java.lang.Throwable 
(declare-const var419 var3689) ; Statement: $r7 := @caughtexception 
(assert (not (= var419 null-var3689)))
(define-const var2652 var1744 var1744-init) ; Statement: $r34 = new java.lang.IllegalStateException 
(assert true)
(define-const var2818 String (getMessage/849299655 (cast-from-var3689-to-var1158 var419))) ; Statement: $r9 = virtualinvoke $r7.<java.lang.Exception: java.lang.String getMessage()>() 
(assert true)
;(assert (<init>/-1447874194 var2652 var2818 (cast-from-var3689-to-var1158 var419))) ; Statement: specialinvoke $r34.<java.lang.IllegalStateException: void <init>(java.lang.String,java.lang.Throwable)>($r9, $r7) 

(declare-const var2652!1 var1744)
(declare-const var2818!1 String)
(declare-const var419!1 var3689)
 ; Statement: throw $r34 
(check-sat)
; {getBytes/-163691139=([java.lang.String, java.nio.charset.Charset], byte[]), var1744-init=([], java.lang.IllegalStateException), getMessage/849299655=([java.lang.Throwable], java.lang.String), cast-from-var3689-to-var1158=([java.lang.Exception], java.lang.Throwable), <init>/-1447874194=([java.lang.IllegalStateException, java.lang.String, java.lang.Throwable], void)}
; {var1189=org.apache.dubbo.remoting.zookeeper.curator5.Curator5ZookeeperClient, var800=r3, var1219=r5, var1960=null_type, var3205=r0, var1280=z0, var1473=java.nio.charset.Charset, var3256=$r1, var3865=r2, var3689=java.lang.Exception, var419=$r7, var1744=java.lang.IllegalStateException, var2652=$r34, var1158=java.lang.Throwable, var2818=$r9}
; {org.apache.dubbo.remoting.zookeeper.curator5.Curator5ZookeeperClient=var1189, r3=var800, r5=var1219, null_type=var1960, r0=var3205, z0=var1280, java.nio.charset.Charset=var1473, $r1=var3256, r2=var3865, java.lang.Exception=var3689, $r7=var419, java.lang.IllegalStateException=var1744, $r34=var2652, java.lang.Throwable=var1158, $r9=var2818}
;seq <java.lang.String: byte[] getBytes(java.nio.charset.Charset)>
;cnt {"<java.lang.String: byte[] getBytes(java.nio.charset.Charset)>": 1}
;stmts r3 := @this: org.apache.dubbo.remoting.zookeeper.curator5.Curator5ZookeeperClient;	r5 := @parameter0: java.lang.String;	r0 := @parameter1: java.lang.String;	z0 := @parameter2: boolean;	$r1 = <org.apache.dubbo.remoting.zookeeper.curator5.Curator5ZookeeperClient: java.nio.charset.Charset CHARSET>;	r2 = virtualinvoke r0.<java.lang.String: byte[] getBytes(java.nio.charset.Charset)>($r1);	$r7 := @caughtexception;	$r34 = new java.lang.IllegalStateException;	$r9 = virtualinvoke $r7.<java.lang.Exception: java.lang.String getMessage()>();	specialinvoke $r34.<java.lang.IllegalStateException: void <init>(java.lang.String,java.lang.Throwable)>($r9, $r7);	throw $r34
;block_num 2