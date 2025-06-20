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

(declare-sort var962 0)
(declare-sort var2519 0)
(declare-sort var141 0)
(declare-sort var1445 0)
(declare-sort var2511 0)
(declare-sort var916 0)
(declare-sort var799 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun getPreferredExecutorService/166314845 (var2511 var141) var1445)
(declare-fun cast-from-var962-to-var2511 (var962) var2511)
(declare-fun var799-init () var799)
(declare-fun String-init () String)
(define-fun <init>/1968657023 () String "")
(declare-fun getClass/1258963082 (var141) ClassObject)
(declare-fun cast-from-var962-to-var141 (var962) var141)
(declare-fun append/-1031950772 (String var141) String)
(declare-fun cast-from-ClassObject-to-var141 (ClassObject) var141)
(define-fun append/672562846 ((s String) (tail String)) String (str.++ s tail))
(define-fun toString/-2075883882 ((s String)) String s)
(declare-fun <init>/-1164709639 (var799 var141 var2519 String var916) void)
(declare-const null-var962 var962)
(declare-const null-var2519 var2519)
(declare-const null-var141 var141)
(declare-const null-var916 var916)
(declare-const var565 var962) ; Statement: r0 := @this: org.apache.dubbo.remoting.transport.dispatcher.all.AllChannelHandler 
(assert (not (= var565 null-var962)))
(declare-const var2958 var2519) ; Statement: r4 := @parameter0: org.apache.dubbo.remoting.Channel 
(assert (not (= var2958 null-var2519)))
(declare-const var2483 var141) ; Statement: r1 := @parameter1: java.lang.Object 
(assert (not (= var2483 null-var141)))
(assert true)
(define-const var681 var1445 (getPreferredExecutorService/166314845 (cast-from-var962-to-var2511 var565) var2483)) ; Statement: r2 = virtualinvoke r0.<org.apache.dubbo.remoting.transport.dispatcher.all.AllChannelHandler: java.util.concurrent.ExecutorService getPreferredExecutorService(java.lang.Object)>(r1) 
(assert true) ; Handling Exception: java.lang.Throwable 
(declare-const var1205 var916) ; Statement: $r7 := @caughtexception 
(assert (not (= var1205 null-var916)))
(define-const var2670 Bool false) ; Statement: $z0 = r1 instanceof org.apache.dubbo.remoting.exchange.Request 
 ; Statement: if $z0 == 0 goto $r8 = new org.apache.dubbo.remoting.ExecutionException 
(assert (= (ite var2670 1 0) 0)) ; Cond: $z0 == 0 
(define-const var2931 var799 var799-init) ; Statement: $r8 = new org.apache.dubbo.remoting.ExecutionException 
(define-const var3688 String String-init) ; Statement: $r9 = new java.lang.StringBuilder 
(assert true)
;(assert (<init>/1968657023 var3688)) ; Statement: specialinvoke $r9.<java.lang.StringBuilder: void <init>()>() 
(declare-const var3688!1 String)
(assert (= var3688!1 ""))
(assert true)
(define-const var3103 ClassObject (getClass/1258963082 (cast-from-var962-to-var141 var565))) ; Statement: $r10 = virtualinvoke r0.<java.lang.Object: java.lang.Class getClass()>() 
(assert true)
(define-const var1617 String (append/-1031950772 var3688!1 (cast-from-ClassObject-to-var141 var3103))) ; Statement: $r11 = virtualinvoke $r9.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.Object)>($r10) 
(declare-const var3688!2 String)
(assert (str.prefixof var3688!1 var3688!2))
(assert true)
(define-const var545 String (append/672562846 var1617 " error when process received event .")) ; Statement: $r12 = virtualinvoke $r11.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(" error when process received event .") 
(declare-const var1617!1 String)
(assert (= var1617!1 (str.++ var1617 " error when process received event .")))
(assert true)
(define-const var2238 String (toString/-2075883882 var545)) ; Statement: $r13 = virtualinvoke $r12.<java.lang.StringBuilder: java.lang.String toString()>() 
(assert true)
;(assert (<init>/-1164709639 var2931 var2483 var2958 var2238 var1205)) ; Statement: specialinvoke $r8.<org.apache.dubbo.remoting.ExecutionException: void <init>(java.lang.Object,org.apache.dubbo.remoting.Channel,java.lang.String,java.lang.Throwable)>(r1, r4, $r13, $r7) 

(declare-const var2931!1 var799)
(declare-const var2483!1 var141)
(declare-const var2958!1 var2519)
(declare-const var2238!1 String)
(declare-const var1205!1 var916)
 ; Statement: throw $r8 
(check-sat)
; {getPreferredExecutorService/166314845=([org.apache.dubbo.remoting.transport.dispatcher.WrappedChannelHandler, java.lang.Object], java.util.concurrent.ExecutorService), cast-from-var962-to-var2511=([org.apache.dubbo.remoting.transport.dispatcher.all.AllChannelHandler], org.apache.dubbo.remoting.transport.dispatcher.WrappedChannelHandler), var799-init=([], org.apache.dubbo.remoting.ExecutionException), String-init=([], java.lang.StringBuilder), <init>/1968657023=([java.lang.StringBuilder], void), getClass/1258963082=([java.lang.Object], java.lang.Class), cast-from-var962-to-var141=([org.apache.dubbo.remoting.transport.dispatcher.all.AllChannelHandler], java.lang.Object), append/-1031950772=([java.lang.StringBuilder, java.lang.Object], java.lang.StringBuilder), cast-from-ClassObject-to-var141=([java.lang.Class], java.lang.Object), append/672562846=([java.lang.StringBuilder, java.lang.String], java.lang.StringBuilder), toString/-2075883882=([java.lang.StringBuilder], java.lang.String), <init>/-1164709639=([org.apache.dubbo.remoting.ExecutionException, java.lang.Object, org.apache.dubbo.remoting.Channel, java.lang.String, java.lang.Throwable], void)}
; {var962=org.apache.dubbo.remoting.transport.dispatcher.all.AllChannelHandler, var565=r0, var2519=org.apache.dubbo.remoting.Channel, var2958=r4, var141=java.lang.Object, var2483=r1, var1445=java.util.concurrent.ExecutorService, var2511=org.apache.dubbo.remoting.transport.dispatcher.WrappedChannelHandler, var681=r2, var916=java.lang.Throwable, var1205=$r7, var2670=$z0, var799=org.apache.dubbo.remoting.ExecutionException, var2931=$r8, var3688=$r9, var3103=$r10, var1617=$r11, var545=$r12, var2238=$r13}
; {org.apache.dubbo.remoting.transport.dispatcher.all.AllChannelHandler=var962, r0=var565, org.apache.dubbo.remoting.Channel=var2519, r4=var2958, java.lang.Object=var141, r1=var2483, java.util.concurrent.ExecutorService=var1445, org.apache.dubbo.remoting.transport.dispatcher.WrappedChannelHandler=var2511, r2=var681, java.lang.Throwable=var916, $r7=var1205, $z0=var2670, org.apache.dubbo.remoting.ExecutionException=var799, $r8=var2931, $r9=var3688, $r10=var3103, $r11=var1617, $r12=var545, $r13=var2238}
;seq <java.lang.StringBuilder: void <init>()>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.Object)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.String toString()>
;cnt {"<java.lang.StringBuilder: void <init>()>": 1,"<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.Object)>": 1,"<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>": 1,"<java.lang.StringBuilder: java.lang.String toString()>": 1}
;stmts r0 := @this: org.apache.dubbo.remoting.transport.dispatcher.all.AllChannelHandler;	r4 := @parameter0: org.apache.dubbo.remoting.Channel;	r1 := @parameter1: java.lang.Object;	r2 = virtualinvoke r0.<org.apache.dubbo.remoting.transport.dispatcher.all.AllChannelHandler: java.util.concurrent.ExecutorService getPreferredExecutorService(java.lang.Object)>(r1);	$r7 := @caughtexception;	$z0 = r1 instanceof org.apache.dubbo.remoting.exchange.Request;	if $z0 == 0 goto $r8 = new org.apache.dubbo.remoting.ExecutionException;	$r8 = new org.apache.dubbo.remoting.ExecutionException;	$r9 = new java.lang.StringBuilder;	specialinvoke $r9.<java.lang.StringBuilder: void <init>()>();	$r10 = virtualinvoke r0.<java.lang.Object: java.lang.Class getClass()>();	$r11 = virtualinvoke $r9.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.Object)>($r10);	$r12 = virtualinvoke $r11.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(" error when process received event .");	$r13 = virtualinvoke $r12.<java.lang.StringBuilder: java.lang.String toString()>();	specialinvoke $r8.<org.apache.dubbo.remoting.ExecutionException: void <init>(java.lang.Object,org.apache.dubbo.remoting.Channel,java.lang.String,java.lang.Throwable)>(r1, r4, $r13, $r7);	throw $r8
;block_num 3