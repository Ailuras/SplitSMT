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

(declare-sort var20 0)
(declare-sort var153 0)
(declare-sort var1657 0)
(declare-sort var52 0)
(declare-sort var3850 0)
(declare-sort var200 0)
(declare-sort var1306 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun getPreferredExecutorService/166314845 (var3850 var1657) var52)
(declare-fun cast-from-var20-to-var3850 (var20) var3850)
(declare-fun var1306-init () var1306)
(declare-fun String-init () String)
(define-fun <init>/1968657023 () String "")
(declare-fun getClass/1258963082 (var1657) ClassObject)
(declare-fun cast-from-var20-to-var1657 (var20) var1657)
(declare-fun append/-1031950772 (String var1657) String)
(declare-fun cast-from-ClassObject-to-var1657 (ClassObject) var1657)
(define-fun append/672562846 ((s String) (tail String)) String (str.++ s tail))
(define-fun toString/-2075883882 ((s String)) String s)
(declare-fun <init>/-1164709639 (var1306 var1657 var153 String var200) void)
(declare-const null-var20 var20)
(declare-const null-var153 var153)
(declare-const null-var1657 var1657)
(declare-const null-var200 var200)
(declare-const var897 var20) ; Statement: r0 := @this: org.apache.dubbo.remoting.transport.dispatcher.connection.ConnectionOrderedChannelHandler 
(assert (not (= var897 null-var20)))
(declare-const var870 var153) ; Statement: r4 := @parameter0: org.apache.dubbo.remoting.Channel 
(assert (not (= var870 null-var153)))
(declare-const var1950 var1657) ; Statement: r1 := @parameter1: java.lang.Object 
(assert (not (= var1950 null-var1657)))
(assert true)
(define-const var3015 var52 (getPreferredExecutorService/166314845 (cast-from-var20-to-var3850 var897) var1950)) ; Statement: r2 = virtualinvoke r0.<org.apache.dubbo.remoting.transport.dispatcher.connection.ConnectionOrderedChannelHandler: java.util.concurrent.ExecutorService getPreferredExecutorService(java.lang.Object)>(r1) 
(assert true) ; Handling Exception: java.lang.Throwable 
(declare-const var2019 var200) ; Statement: $r7 := @caughtexception 
(assert (not (= var2019 null-var200)))
(define-const var1692 Bool false) ; Statement: $z0 = r1 instanceof org.apache.dubbo.remoting.exchange.Request 
 ; Statement: if $z0 == 0 goto $r8 = new org.apache.dubbo.remoting.ExecutionException 
(assert (= (ite var1692 1 0) 0)) ; Cond: $z0 == 0 
(define-const var1545 var1306 var1306-init) ; Statement: $r8 = new org.apache.dubbo.remoting.ExecutionException 
(define-const var1006 String String-init) ; Statement: $r9 = new java.lang.StringBuilder 
(assert true)
;(assert (<init>/1968657023 var1006)) ; Statement: specialinvoke $r9.<java.lang.StringBuilder: void <init>()>() 
(declare-const var1006!1 String)
(assert (= var1006!1 ""))
(assert true)
(define-const var1054 ClassObject (getClass/1258963082 (cast-from-var20-to-var1657 var897))) ; Statement: $r10 = virtualinvoke r0.<java.lang.Object: java.lang.Class getClass()>() 
(assert true)
(define-const var2160 String (append/-1031950772 var1006!1 (cast-from-ClassObject-to-var1657 var1054))) ; Statement: $r11 = virtualinvoke $r9.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.Object)>($r10) 
(declare-const var1006!2 String)
(assert (str.prefixof var1006!1 var1006!2))
(assert true)
(define-const var386 String (append/672562846 var2160 " error when process received event .")) ; Statement: $r12 = virtualinvoke $r11.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(" error when process received event .") 
(declare-const var2160!1 String)
(assert (= var2160!1 (str.++ var2160 " error when process received event .")))
(assert true)
(define-const var3370 String (toString/-2075883882 var386)) ; Statement: $r13 = virtualinvoke $r12.<java.lang.StringBuilder: java.lang.String toString()>() 
(assert true)
;(assert (<init>/-1164709639 var1545 var1950 var870 var3370 var2019)) ; Statement: specialinvoke $r8.<org.apache.dubbo.remoting.ExecutionException: void <init>(java.lang.Object,org.apache.dubbo.remoting.Channel,java.lang.String,java.lang.Throwable)>(r1, r4, $r13, $r7) 

(declare-const var1545!1 var1306)
(declare-const var1950!1 var1657)
(declare-const var870!1 var153)
(declare-const var3370!1 String)
(declare-const var2019!1 var200)
 ; Statement: throw $r8 
(check-sat)
; {getPreferredExecutorService/166314845=([org.apache.dubbo.remoting.transport.dispatcher.WrappedChannelHandler, java.lang.Object], java.util.concurrent.ExecutorService), cast-from-var20-to-var3850=([org.apache.dubbo.remoting.transport.dispatcher.connection.ConnectionOrderedChannelHandler], org.apache.dubbo.remoting.transport.dispatcher.WrappedChannelHandler), var1306-init=([], org.apache.dubbo.remoting.ExecutionException), String-init=([], java.lang.StringBuilder), <init>/1968657023=([java.lang.StringBuilder], void), getClass/1258963082=([java.lang.Object], java.lang.Class), cast-from-var20-to-var1657=([org.apache.dubbo.remoting.transport.dispatcher.connection.ConnectionOrderedChannelHandler], java.lang.Object), append/-1031950772=([java.lang.StringBuilder, java.lang.Object], java.lang.StringBuilder), cast-from-ClassObject-to-var1657=([java.lang.Class], java.lang.Object), append/672562846=([java.lang.StringBuilder, java.lang.String], java.lang.StringBuilder), toString/-2075883882=([java.lang.StringBuilder], java.lang.String), <init>/-1164709639=([org.apache.dubbo.remoting.ExecutionException, java.lang.Object, org.apache.dubbo.remoting.Channel, java.lang.String, java.lang.Throwable], void)}
; {var20=org.apache.dubbo.remoting.transport.dispatcher.connection.ConnectionOrderedChannelHandler, var897=r0, var153=org.apache.dubbo.remoting.Channel, var870=r4, var1657=java.lang.Object, var1950=r1, var52=java.util.concurrent.ExecutorService, var3850=org.apache.dubbo.remoting.transport.dispatcher.WrappedChannelHandler, var3015=r2, var200=java.lang.Throwable, var2019=$r7, var1692=$z0, var1306=org.apache.dubbo.remoting.ExecutionException, var1545=$r8, var1006=$r9, var1054=$r10, var2160=$r11, var386=$r12, var3370=$r13}
; {org.apache.dubbo.remoting.transport.dispatcher.connection.ConnectionOrderedChannelHandler=var20, r0=var897, org.apache.dubbo.remoting.Channel=var153, r4=var870, java.lang.Object=var1657, r1=var1950, java.util.concurrent.ExecutorService=var52, org.apache.dubbo.remoting.transport.dispatcher.WrappedChannelHandler=var3850, r2=var3015, java.lang.Throwable=var200, $r7=var2019, $z0=var1692, org.apache.dubbo.remoting.ExecutionException=var1306, $r8=var1545, $r9=var1006, $r10=var1054, $r11=var2160, $r12=var386, $r13=var3370}
;seq <java.lang.StringBuilder: void <init>()>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.Object)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.String toString()>
;cnt {"<java.lang.StringBuilder: void <init>()>": 1,"<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.Object)>": 1,"<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>": 1,"<java.lang.StringBuilder: java.lang.String toString()>": 1}
;stmts r0 := @this: org.apache.dubbo.remoting.transport.dispatcher.connection.ConnectionOrderedChannelHandler;	r4 := @parameter0: org.apache.dubbo.remoting.Channel;	r1 := @parameter1: java.lang.Object;	r2 = virtualinvoke r0.<org.apache.dubbo.remoting.transport.dispatcher.connection.ConnectionOrderedChannelHandler: java.util.concurrent.ExecutorService getPreferredExecutorService(java.lang.Object)>(r1);	$r7 := @caughtexception;	$z0 = r1 instanceof org.apache.dubbo.remoting.exchange.Request;	if $z0 == 0 goto $r8 = new org.apache.dubbo.remoting.ExecutionException;	$r8 = new org.apache.dubbo.remoting.ExecutionException;	$r9 = new java.lang.StringBuilder;	specialinvoke $r9.<java.lang.StringBuilder: void <init>()>();	$r10 = virtualinvoke r0.<java.lang.Object: java.lang.Class getClass()>();	$r11 = virtualinvoke $r9.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.Object)>($r10);	$r12 = virtualinvoke $r11.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(" error when process received event .");	$r13 = virtualinvoke $r12.<java.lang.StringBuilder: java.lang.String toString()>();	specialinvoke $r8.<org.apache.dubbo.remoting.ExecutionException: void <init>(java.lang.Object,org.apache.dubbo.remoting.Channel,java.lang.String,java.lang.Throwable)>(r1, r4, $r13, $r7);	throw $r8
;block_num 3