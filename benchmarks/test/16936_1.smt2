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

(declare-sort var214 0)
(declare-sort var2998 0)
(declare-sort var1367 0)
(declare-sort var617 0)
(declare-sort var3766 0)
(declare-sort var2214 0)
(declare-sort var30 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun getPreferredExecutorService/166314845 (var3766 var1367) var617)
(declare-fun cast-from-var214-to-var3766 (var214) var3766)
(declare-fun var30-init () var30)
(declare-fun String-init () String)
(define-fun <init>/1968657023 () String "")
(declare-fun getClass/1258963082 (var1367) ClassObject)
(declare-fun cast-from-var214-to-var1367 (var214) var1367)
(declare-fun append/-1031950772 (String var1367) String)
(declare-fun cast-from-ClassObject-to-var1367 (ClassObject) var1367)
(define-fun append/672562846 ((s String) (tail String)) String (str.++ s tail))
(define-fun toString/-2075883882 ((s String)) String s)
(declare-fun <init>/-1164709639 (var30 var1367 var2998 String var2214) void)
(declare-const null-var214 var214)
(declare-const null-var2998 var2998)
(declare-const null-var1367 var1367)
(declare-const null-var2214 var2214)
(declare-const var3180 var214) ; Statement: r0 := @this: org.apache.dubbo.remoting.transport.dispatcher.message.MessageOnlyChannelHandler 
(assert (not (= var3180 null-var214)))
(declare-const var628 var2998) ; Statement: r4 := @parameter0: org.apache.dubbo.remoting.Channel 
(assert (not (= var628 null-var2998)))
(declare-const var1026 var1367) ; Statement: r1 := @parameter1: java.lang.Object 
(assert (not (= var1026 null-var1367)))
(assert true)
(define-const var864 var617 (getPreferredExecutorService/166314845 (cast-from-var214-to-var3766 var3180) var1026)) ; Statement: r2 = virtualinvoke r0.<org.apache.dubbo.remoting.transport.dispatcher.message.MessageOnlyChannelHandler: java.util.concurrent.ExecutorService getPreferredExecutorService(java.lang.Object)>(r1) 
(assert true) ; Handling Exception: java.lang.Throwable 
(declare-const var3098 var2214) ; Statement: $r7 := @caughtexception 
(assert (not (= var3098 null-var2214)))
(define-const var1961 Bool false) ; Statement: $z0 = r1 instanceof org.apache.dubbo.remoting.exchange.Request 
 ; Statement: if $z0 == 0 goto $r8 = new org.apache.dubbo.remoting.ExecutionException 
(assert (= (ite var1961 1 0) 0)) ; Cond: $z0 == 0 
(define-const var1607 var30 var30-init) ; Statement: $r8 = new org.apache.dubbo.remoting.ExecutionException 
(define-const var543 String String-init) ; Statement: $r9 = new java.lang.StringBuilder 
(assert true)
;(assert (<init>/1968657023 var543)) ; Statement: specialinvoke $r9.<java.lang.StringBuilder: void <init>()>() 
(declare-const var543!1 String)
(assert (= var543!1 ""))
(assert true)
(define-const var227 ClassObject (getClass/1258963082 (cast-from-var214-to-var1367 var3180))) ; Statement: $r10 = virtualinvoke r0.<java.lang.Object: java.lang.Class getClass()>() 
(assert true)
(define-const var1412 String (append/-1031950772 var543!1 (cast-from-ClassObject-to-var1367 var227))) ; Statement: $r11 = virtualinvoke $r9.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.Object)>($r10) 
(declare-const var543!2 String)
(assert (str.prefixof var543!1 var543!2))
(assert true)
(define-const var1613 String (append/672562846 var1412 " error when process received event .")) ; Statement: $r12 = virtualinvoke $r11.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(" error when process received event .") 
(declare-const var1412!1 String)
(assert (= var1412!1 (str.++ var1412 " error when process received event .")))
(assert true)
(define-const var2334 String (toString/-2075883882 var1613)) ; Statement: $r13 = virtualinvoke $r12.<java.lang.StringBuilder: java.lang.String toString()>() 
(assert true)
;(assert (<init>/-1164709639 var1607 var1026 var628 var2334 var3098)) ; Statement: specialinvoke $r8.<org.apache.dubbo.remoting.ExecutionException: void <init>(java.lang.Object,org.apache.dubbo.remoting.Channel,java.lang.String,java.lang.Throwable)>(r1, r4, $r13, $r7) 

(declare-const var1607!1 var30)
(declare-const var1026!1 var1367)
(declare-const var628!1 var2998)
(declare-const var2334!1 String)
(declare-const var3098!1 var2214)
 ; Statement: throw $r8 
(check-sat)
; {getPreferredExecutorService/166314845=([org.apache.dubbo.remoting.transport.dispatcher.WrappedChannelHandler, java.lang.Object], java.util.concurrent.ExecutorService), cast-from-var214-to-var3766=([org.apache.dubbo.remoting.transport.dispatcher.message.MessageOnlyChannelHandler], org.apache.dubbo.remoting.transport.dispatcher.WrappedChannelHandler), var30-init=([], org.apache.dubbo.remoting.ExecutionException), String-init=([], java.lang.StringBuilder), <init>/1968657023=([java.lang.StringBuilder], void), getClass/1258963082=([java.lang.Object], java.lang.Class), cast-from-var214-to-var1367=([org.apache.dubbo.remoting.transport.dispatcher.message.MessageOnlyChannelHandler], java.lang.Object), append/-1031950772=([java.lang.StringBuilder, java.lang.Object], java.lang.StringBuilder), cast-from-ClassObject-to-var1367=([java.lang.Class], java.lang.Object), append/672562846=([java.lang.StringBuilder, java.lang.String], java.lang.StringBuilder), toString/-2075883882=([java.lang.StringBuilder], java.lang.String), <init>/-1164709639=([org.apache.dubbo.remoting.ExecutionException, java.lang.Object, org.apache.dubbo.remoting.Channel, java.lang.String, java.lang.Throwable], void)}
; {var214=org.apache.dubbo.remoting.transport.dispatcher.message.MessageOnlyChannelHandler, var3180=r0, var2998=org.apache.dubbo.remoting.Channel, var628=r4, var1367=java.lang.Object, var1026=r1, var617=java.util.concurrent.ExecutorService, var3766=org.apache.dubbo.remoting.transport.dispatcher.WrappedChannelHandler, var864=r2, var2214=java.lang.Throwable, var3098=$r7, var1961=$z0, var30=org.apache.dubbo.remoting.ExecutionException, var1607=$r8, var543=$r9, var227=$r10, var1412=$r11, var1613=$r12, var2334=$r13}
; {org.apache.dubbo.remoting.transport.dispatcher.message.MessageOnlyChannelHandler=var214, r0=var3180, org.apache.dubbo.remoting.Channel=var2998, r4=var628, java.lang.Object=var1367, r1=var1026, java.util.concurrent.ExecutorService=var617, org.apache.dubbo.remoting.transport.dispatcher.WrappedChannelHandler=var3766, r2=var864, java.lang.Throwable=var2214, $r7=var3098, $z0=var1961, org.apache.dubbo.remoting.ExecutionException=var30, $r8=var1607, $r9=var543, $r10=var227, $r11=var1412, $r12=var1613, $r13=var2334}
;seq <java.lang.StringBuilder: void <init>()>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.Object)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.String toString()>
;cnt {"<java.lang.StringBuilder: void <init>()>": 1,"<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.Object)>": 1,"<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>": 1,"<java.lang.StringBuilder: java.lang.String toString()>": 1}
;stmts r0 := @this: org.apache.dubbo.remoting.transport.dispatcher.message.MessageOnlyChannelHandler;	r4 := @parameter0: org.apache.dubbo.remoting.Channel;	r1 := @parameter1: java.lang.Object;	r2 = virtualinvoke r0.<org.apache.dubbo.remoting.transport.dispatcher.message.MessageOnlyChannelHandler: java.util.concurrent.ExecutorService getPreferredExecutorService(java.lang.Object)>(r1);	$r7 := @caughtexception;	$z0 = r1 instanceof org.apache.dubbo.remoting.exchange.Request;	if $z0 == 0 goto $r8 = new org.apache.dubbo.remoting.ExecutionException;	$r8 = new org.apache.dubbo.remoting.ExecutionException;	$r9 = new java.lang.StringBuilder;	specialinvoke $r9.<java.lang.StringBuilder: void <init>()>();	$r10 = virtualinvoke r0.<java.lang.Object: java.lang.Class getClass()>();	$r11 = virtualinvoke $r9.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.Object)>($r10);	$r12 = virtualinvoke $r11.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(" error when process received event .");	$r13 = virtualinvoke $r12.<java.lang.StringBuilder: java.lang.String toString()>();	specialinvoke $r8.<org.apache.dubbo.remoting.ExecutionException: void <init>(java.lang.Object,org.apache.dubbo.remoting.Channel,java.lang.String,java.lang.Throwable)>(r1, r4, $r13, $r7);	throw $r8
;block_num 3