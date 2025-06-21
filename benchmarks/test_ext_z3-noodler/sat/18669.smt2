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

(declare-sort var268 0)
(declare-sort var2225 0)
(declare-sort var2222 0)
(declare-sort var3811 0)
(declare-sort var503 0)
(declare-sort var1131 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun getBytes/-163691139 (String var2222) (Array Int Int))
(declare-fun var503-init () var503)
(declare-fun getMessage/849299655 (var1131) String)
(declare-fun cast-from-var3811-to-var1131 (var3811) var1131)
(declare-fun <init>/-1447874194 (var503 String var1131) void)
(declare-const null-var268 var268)
(declare-const null-String String)
(declare-const var268-CHARSET var2222)
(declare-const null-var3811 var3811)
(declare-const var2758 var268) ; Statement: r3 := @this: org.apache.dubbo.remoting.zookeeper.curator5.Curator5ZookeeperClient 
(assert (not (= var2758 null-var268)))
(declare-const var843 String) ; Statement: r5 := @parameter0: java.lang.String 
(assert (not (= var843 null-String)))
(declare-const var1642 String) ; Statement: r0 := @parameter1: java.lang.String 
(assert (not (= var1642 null-String)))
(define-const var141 var2222 var268-CHARSET) ; Statement: $r1 = <org.apache.dubbo.remoting.zookeeper.curator5.Curator5ZookeeperClient: java.nio.charset.Charset CHARSET> 
(assert true)
(define-const var3436 (Array Int Int) (getBytes/-163691139 var1642 var141)) ; Statement: r2 = virtualinvoke r0.<java.lang.String: byte[] getBytes(java.nio.charset.Charset)>($r1) 
(assert true) ; Handling Exception: java.lang.Throwable 
(declare-const var1717 var3811) ; Statement: $r7 := @caughtexception 
(assert (not (= var1717 null-var3811)))
(define-const var1348 var503 var503-init) ; Statement: $r8 = new java.lang.IllegalStateException 
(assert true)
(define-const var1929 String (getMessage/849299655 (cast-from-var3811-to-var1131 var1717))) ; Statement: $r9 = virtualinvoke $r7.<java.lang.Exception: java.lang.String getMessage()>() 
(assert true)
;(assert (<init>/-1447874194 var1348 var1929 (cast-from-var3811-to-var1131 var1717))) ; Statement: specialinvoke $r8.<java.lang.IllegalStateException: void <init>(java.lang.String,java.lang.Throwable)>($r9, $r7) 

(declare-const var1348!1 var503)
(declare-const var1929!1 String)
(declare-const var1717!1 var3811)
 ; Statement: throw $r8 
(check-sat)
; {getBytes/-163691139=([java.lang.String, java.nio.charset.Charset], byte[]), var503-init=([], java.lang.IllegalStateException), getMessage/849299655=([java.lang.Throwable], java.lang.String), cast-from-var3811-to-var1131=([java.lang.Exception], java.lang.Throwable), <init>/-1447874194=([java.lang.IllegalStateException, java.lang.String, java.lang.Throwable], void)}
; {var268=org.apache.dubbo.remoting.zookeeper.curator5.Curator5ZookeeperClient, var2758=r3, var843=r5, var2225=null_type, var1642=r0, var2222=java.nio.charset.Charset, var141=$r1, var3436=r2, var3811=java.lang.Exception, var1717=$r7, var503=java.lang.IllegalStateException, var1348=$r8, var1131=java.lang.Throwable, var1929=$r9}
; {org.apache.dubbo.remoting.zookeeper.curator5.Curator5ZookeeperClient=var268, r3=var2758, r5=var843, null_type=var2225, r0=var1642, java.nio.charset.Charset=var2222, $r1=var141, r2=var3436, java.lang.Exception=var3811, $r7=var1717, java.lang.IllegalStateException=var503, $r8=var1348, java.lang.Throwable=var1131, $r9=var1929}
;seq <java.lang.String: byte[] getBytes(java.nio.charset.Charset)>
;cnt {"<java.lang.String: byte[] getBytes(java.nio.charset.Charset)>": 1}
;stmts r3 := @this: org.apache.dubbo.remoting.zookeeper.curator5.Curator5ZookeeperClient;	r5 := @parameter0: java.lang.String;	r0 := @parameter1: java.lang.String;	$r1 = <org.apache.dubbo.remoting.zookeeper.curator5.Curator5ZookeeperClient: java.nio.charset.Charset CHARSET>;	r2 = virtualinvoke r0.<java.lang.String: byte[] getBytes(java.nio.charset.Charset)>($r1);	$r7 := @caughtexception;	$r8 = new java.lang.IllegalStateException;	$r9 = virtualinvoke $r7.<java.lang.Exception: java.lang.String getMessage()>();	specialinvoke $r8.<java.lang.IllegalStateException: void <init>(java.lang.String,java.lang.Throwable)>($r9, $r7);	throw $r8
;block_num 2