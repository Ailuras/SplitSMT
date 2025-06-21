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

(declare-sort var2628 0)
(declare-sort var3307 0)
(declare-sort var3982 0)
(declare-sort var2045 0)
(declare-sort var286 0)
(declare-sort var1212 0)
(declare-sort var1637 0)
(declare-sort var1648 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun var286-init () var286)
(declare-fun var1637-init () var1637)
(declare-fun String-init () String)
(define-fun <init>/1968657023 () String "")
(define-fun append/672562846 ((s String) (tail String)) String (str.++ s tail))
(define-fun toString/-2075883882 ((s String)) String s)
(declare-fun <init>/-1447874194 (var1637 String var1648) void)
(declare-fun cast-from-var1212-to-var1648 (var1212) var1648)
(declare-const null-var2628 var2628)
(declare-const null-String String)
(declare-const null-var3982 var3982)
(declare-const null-var2045 var2045)
(declare-const null-var1212 var1212)
(declare-const var140 var2628) ; Statement: r1 := @this: org.apache.dubbo.remoting.zookeeper.curator5.Curator5ZookeeperClient 
(assert (not (= var140 null-var2628)))
(declare-const var1131 String) ; Statement: r2 := @parameter0: java.lang.String 
(assert (not (= var1131 null-String)))
(declare-const var3730 var3982) ; Statement: r7 := @parameter1: org.apache.dubbo.remoting.zookeeper.curator5.Curator5ZookeeperClient$NodeCacheListenerImpl 
(assert (not (= var3730 null-var3982)))
(declare-const var1923 var2045) ; Statement: r6 := @parameter2: java.util.concurrent.Executor 
(assert (not (= var1923 null-var2045)))
(define-const var3007 var286 var286-init) ; Statement: $r0 = new org.apache.curator.framework.recipes.cache.NodeCache 
(assert true) ; Handling Exception: java.lang.Throwable 
(declare-const var3778 var1212) ; Statement: $r10 := @caughtexception 
(assert (not (= var3778 null-var1212)))
(define-const var592 var1637 var1637-init) ; Statement: $r11 = new java.lang.IllegalStateException 
(define-const var2074 String String-init) ; Statement: $r12 = new java.lang.StringBuilder 
(assert true)
;(assert (<init>/1968657023 var2074)) ; Statement: specialinvoke $r12.<java.lang.StringBuilder: void <init>()>() 
(declare-const var2074!1 String)
(assert (= var2074!1 ""))
(assert true)
(define-const var3632 String (append/672562846 var2074!1 "Add nodeCache listener for path:")) ; Statement: $r13 = virtualinvoke $r12.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("Add nodeCache listener for path:") 
(declare-const var2074!2 String)
(assert (= var2074!2 (str.++ var2074!1 "Add nodeCache listener for path:")))
(assert true)
(define-const var810 String (append/672562846 var3632 var1131)) ; Statement: $r14 = virtualinvoke $r13.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(r2) 
(declare-const var3632!1 String)
(assert (= var3632!1 (str.++ var3632 var1131)))
(assert true)
(define-const var1664 String (toString/-2075883882 var810)) ; Statement: $r15 = virtualinvoke $r14.<java.lang.StringBuilder: java.lang.String toString()>() 
(assert true)
;(assert (<init>/-1447874194 var592 var1664 (cast-from-var1212-to-var1648 var3778))) ; Statement: specialinvoke $r11.<java.lang.IllegalStateException: void <init>(java.lang.String,java.lang.Throwable)>($r15, $r10) 

(declare-const var592!1 var1637)
(declare-const var1664!1 String)
(declare-const var3778!1 var1212)
 ; Statement: throw $r11 
(check-sat)
; {var286-init=([], org.apache.curator.framework.recipes.cache.NodeCache), var1637-init=([], java.lang.IllegalStateException), String-init=([], java.lang.StringBuilder), <init>/1968657023=([java.lang.StringBuilder], void), append/672562846=([java.lang.StringBuilder, java.lang.String], java.lang.StringBuilder), toString/-2075883882=([java.lang.StringBuilder], java.lang.String), <init>/-1447874194=([java.lang.IllegalStateException, java.lang.String, java.lang.Throwable], void), cast-from-var1212-to-var1648=([java.lang.Exception], java.lang.Throwable)}
; {var2628=org.apache.dubbo.remoting.zookeeper.curator5.Curator5ZookeeperClient, var140=r1, var1131=r2, var3307=null_type, var3982=org.apache.dubbo.remoting.zookeeper.curator5.Curator5ZookeeperClient$NodeCacheListenerImpl, var3730=r7, var2045=java.util.concurrent.Executor, var1923=r6, var286=org.apache.curator.framework.recipes.cache.NodeCache, var3007=$r0, var1212=java.lang.Exception, var3778=$r10, var1637=java.lang.IllegalStateException, var592=$r11, var2074=$r12, var3632=$r13, var810=$r14, var1664=$r15, var1648=java.lang.Throwable}
; {org.apache.dubbo.remoting.zookeeper.curator5.Curator5ZookeeperClient=var2628, r1=var140, r2=var1131, null_type=var3307, org.apache.dubbo.remoting.zookeeper.curator5.Curator5ZookeeperClient$NodeCacheListenerImpl=var3982, r7=var3730, java.util.concurrent.Executor=var2045, r6=var1923, org.apache.curator.framework.recipes.cache.NodeCache=var286, $r0=var3007, java.lang.Exception=var1212, $r10=var3778, java.lang.IllegalStateException=var1637, $r11=var592, $r12=var2074, $r13=var3632, $r14=var810, $r15=var1664, java.lang.Throwable=var1648}
;seq <java.lang.StringBuilder: void <init>()>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.String toString()>
;cnt {"<java.lang.StringBuilder: void <init>()>": 1,"<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>": 2,"<java.lang.StringBuilder: java.lang.String toString()>": 1}
;stmts r1 := @this: org.apache.dubbo.remoting.zookeeper.curator5.Curator5ZookeeperClient;	r2 := @parameter0: java.lang.String;	r7 := @parameter1: org.apache.dubbo.remoting.zookeeper.curator5.Curator5ZookeeperClient$NodeCacheListenerImpl;	r6 := @parameter2: java.util.concurrent.Executor;	$r0 = new org.apache.curator.framework.recipes.cache.NodeCache;	$r10 := @caughtexception;	$r11 = new java.lang.IllegalStateException;	$r12 = new java.lang.StringBuilder;	specialinvoke $r12.<java.lang.StringBuilder: void <init>()>();	$r13 = virtualinvoke $r12.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("Add nodeCache listener for path:");	$r14 = virtualinvoke $r13.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(r2);	$r15 = virtualinvoke $r14.<java.lang.StringBuilder: java.lang.String toString()>();	specialinvoke $r11.<java.lang.IllegalStateException: void <init>(java.lang.String,java.lang.Throwable)>($r15, $r10);	throw $r11
;block_num 2