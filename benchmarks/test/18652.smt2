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

(declare-sort var2983 0)
(declare-sort var372 0)
(declare-sort var3844 0)
(declare-sort var2664 0)
(declare-sort var67 0)
(declare-sort var2793 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun getBytes/-163691139 (String var3844) (Array Int Int))
(declare-fun var67-init () var67)
(declare-fun getMessage/849299655 (var2793) String)
(declare-fun cast-from-var2664-to-var2793 (var2664) var2793)
(declare-fun <init>/-1447874194 (var67 String var2793) void)
(declare-const null-var2983 var2983)
(declare-const null-String String)
(declare-const null-Int Int)
(declare-const var2983-CHARSET var3844)
(declare-const null-var2664 var2664)
(declare-const var156 var2983) ; Statement: r3 := @this: org.apache.dubbo.remoting.zookeeper.curator5.Curator5ZookeeperClient 
(assert (not (= var156 null-var2983)))
(declare-const var1020 String) ; Statement: r7 := @parameter0: java.lang.String 
(assert (not (= var1020 null-String)))
(declare-const var2989 String) ; Statement: r0 := @parameter1: java.lang.String 
(assert (not (= var2989 null-String)))
(declare-const var3996 Int) ; Statement: i0 := @parameter2: int 
(assert (not (= var3996 null-Int)))
(define-const var2726 var3844 var2983-CHARSET) ; Statement: $r1 = <org.apache.dubbo.remoting.zookeeper.curator5.Curator5ZookeeperClient: java.nio.charset.Charset CHARSET> 
(assert true)
(define-const var1447 (Array Int Int) (getBytes/-163691139 var2989 var2726)) ; Statement: r2 = virtualinvoke r0.<java.lang.String: byte[] getBytes(java.nio.charset.Charset)>($r1) 
(assert true) ; Handling Exception: java.lang.Throwable 
(declare-const var1245 var2664) ; Statement: $r9 := @caughtexception 
(assert (not (= var1245 null-var2664)))
(define-const var3658 var67 var67-init) ; Statement: $r10 = new java.lang.IllegalStateException 
(assert true)
(define-const var1774 String (getMessage/849299655 (cast-from-var2664-to-var2793 var1245))) ; Statement: $r11 = virtualinvoke $r9.<java.lang.Exception: java.lang.String getMessage()>() 
(assert true)
;(assert (<init>/-1447874194 var3658 var1774 (cast-from-var2664-to-var2793 var1245))) ; Statement: specialinvoke $r10.<java.lang.IllegalStateException: void <init>(java.lang.String,java.lang.Throwable)>($r11, $r9) 

(declare-const var3658!1 var67)
(declare-const var1774!1 String)
(declare-const var1245!1 var2664)
 ; Statement: throw $r10 
(check-sat)
; {getBytes/-163691139=([java.lang.String, java.nio.charset.Charset], byte[]), var67-init=([], java.lang.IllegalStateException), getMessage/849299655=([java.lang.Throwable], java.lang.String), cast-from-var2664-to-var2793=([java.lang.Exception], java.lang.Throwable), <init>/-1447874194=([java.lang.IllegalStateException, java.lang.String, java.lang.Throwable], void)}
; {var2983=org.apache.dubbo.remoting.zookeeper.curator5.Curator5ZookeeperClient, var156=r3, var1020=r7, var372=null_type, var2989=r0, var3996=i0, var3844=java.nio.charset.Charset, var2726=$r1, var1447=r2, var2664=java.lang.Exception, var1245=$r9, var67=java.lang.IllegalStateException, var3658=$r10, var2793=java.lang.Throwable, var1774=$r11}
; {org.apache.dubbo.remoting.zookeeper.curator5.Curator5ZookeeperClient=var2983, r3=var156, r7=var1020, null_type=var372, r0=var2989, i0=var3996, java.nio.charset.Charset=var3844, $r1=var2726, r2=var1447, java.lang.Exception=var2664, $r9=var1245, java.lang.IllegalStateException=var67, $r10=var3658, java.lang.Throwable=var2793, $r11=var1774}
;seq <java.lang.String: byte[] getBytes(java.nio.charset.Charset)>
;cnt {"<java.lang.String: byte[] getBytes(java.nio.charset.Charset)>": 1}
;stmts r3 := @this: org.apache.dubbo.remoting.zookeeper.curator5.Curator5ZookeeperClient;	r7 := @parameter0: java.lang.String;	r0 := @parameter1: java.lang.String;	i0 := @parameter2: int;	$r1 = <org.apache.dubbo.remoting.zookeeper.curator5.Curator5ZookeeperClient: java.nio.charset.Charset CHARSET>;	r2 = virtualinvoke r0.<java.lang.String: byte[] getBytes(java.nio.charset.Charset)>($r1);	$r9 := @caughtexception;	$r10 = new java.lang.IllegalStateException;	$r11 = virtualinvoke $r9.<java.lang.Exception: java.lang.String getMessage()>();	specialinvoke $r10.<java.lang.IllegalStateException: void <init>(java.lang.String,java.lang.Throwable)>($r11, $r9);	throw $r10
;block_num 2