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

(declare-sort var1499 0)
(declare-sort var435 0)
(declare-sort var3971 0)
(declare-sort var655 0)
(declare-sort var2558 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun var655-init () var655)
(declare-fun String-init () String)
(define-fun <init>/1968657023 () String "")
(declare-fun getClass/1258963082 (var2558) ClassObject)
(declare-fun cast-from-var1499-to-var2558 (var1499) var2558)
(declare-fun append/-1031950772 (String var2558) String)
(declare-fun cast-from-ClassObject-to-var2558 (ClassObject) var2558)
(define-fun append/672562846 ((s String) (tail String)) String (str.++ s tail))
(define-fun toString/-2075883882 ((s String)) String s)
(declare-fun <init>/-1164709639 (var655 var2558 var435 String var3971) void)
(declare-fun cast-from-String-to-var2558 (String) var2558)
(declare-const null-var1499 var1499)
(declare-const null-var435 var435)
(declare-const null-var3971 var3971)
(declare-const var1482 var1499) ; Statement: r0 := @this: org.apache.dubbo.remoting.transport.dispatcher.connection.ConnectionOrderedChannelHandler 
(assert (not (= var1482 null-var1499)))
(declare-const var469 var435) ; Statement: r2 := @parameter0: org.apache.dubbo.remoting.Channel 
(assert (not (= var469 null-var435)))
(assert true) ; Handling Exception: java.lang.Throwable 
(declare-const var2630 var3971) ; Statement: $r6 := @caughtexception 
(assert (not (= var2630 null-var3971)))
(define-const var3629 var655 var655-init) ; Statement: $r7 = new org.apache.dubbo.remoting.ExecutionException 
(define-const var1176 String String-init) ; Statement: $r8 = new java.lang.StringBuilder 
(assert true)
;(assert (<init>/1968657023 var1176)) ; Statement: specialinvoke $r8.<java.lang.StringBuilder: void <init>()>() 
(declare-const var1176!1 String)
(assert (= var1176!1 ""))
(assert true)
(define-const var108 ClassObject (getClass/1258963082 (cast-from-var1499-to-var2558 var1482))) ; Statement: $r9 = virtualinvoke r0.<java.lang.Object: java.lang.Class getClass()>() 
(assert true)
(define-const var2210 String (append/-1031950772 var1176!1 (cast-from-ClassObject-to-var2558 var108))) ; Statement: $r10 = virtualinvoke $r8.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.Object)>($r9) 
(declare-const var1176!2 String)
(assert (str.prefixof var1176!1 var1176!2))
(assert true)
(define-const var1812 String (append/672562846 var2210 " error when process connected event .")) ; Statement: $r11 = virtualinvoke $r10.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(" error when process connected event .") 
(declare-const var2210!1 String)
(assert (= var2210!1 (str.++ var2210 " error when process connected event .")))
(assert true)
(define-const var401 String (toString/-2075883882 var1812)) ; Statement: $r12 = virtualinvoke $r11.<java.lang.StringBuilder: java.lang.String toString()>() 
(assert true)
;(assert (<init>/-1164709639 var3629 (cast-from-String-to-var2558 "connect event") var469 var401 var2630)) ; Statement: specialinvoke $r7.<org.apache.dubbo.remoting.ExecutionException: void <init>(java.lang.Object,org.apache.dubbo.remoting.Channel,java.lang.String,java.lang.Throwable)>("connect event", r2, $r12, $r6) 

(declare-const var3629!1 var655)
(declare-const var1782 String)
(declare-const var469!1 var435)
(declare-const var401!1 String)
(declare-const var2630!1 var3971)
 ; Statement: throw $r7 
(check-sat)
; {var655-init=([], org.apache.dubbo.remoting.ExecutionException), String-init=([], java.lang.StringBuilder), <init>/1968657023=([java.lang.StringBuilder], void), getClass/1258963082=([java.lang.Object], java.lang.Class), cast-from-var1499-to-var2558=([org.apache.dubbo.remoting.transport.dispatcher.connection.ConnectionOrderedChannelHandler], java.lang.Object), append/-1031950772=([java.lang.StringBuilder, java.lang.Object], java.lang.StringBuilder), cast-from-ClassObject-to-var2558=([java.lang.Class], java.lang.Object), append/672562846=([java.lang.StringBuilder, java.lang.String], java.lang.StringBuilder), toString/-2075883882=([java.lang.StringBuilder], java.lang.String), <init>/-1164709639=([org.apache.dubbo.remoting.ExecutionException, java.lang.Object, org.apache.dubbo.remoting.Channel, java.lang.String, java.lang.Throwable], void), cast-from-String-to-var2558=([java.lang.String], java.lang.Object)}
; {var1499=org.apache.dubbo.remoting.transport.dispatcher.connection.ConnectionOrderedChannelHandler, var1482=r0, var435=org.apache.dubbo.remoting.Channel, var469=r2, var3971=java.lang.Throwable, var2630=$r6, var655=org.apache.dubbo.remoting.ExecutionException, var3629=$r7, var1176=$r8, var2558=java.lang.Object, var108=$r9, var2210=$r10, var1812=$r11, var401=$r12, var1782="connect event"}
; {org.apache.dubbo.remoting.transport.dispatcher.connection.ConnectionOrderedChannelHandler=var1499, r0=var1482, org.apache.dubbo.remoting.Channel=var435, r2=var469, java.lang.Throwable=var3971, $r6=var2630, org.apache.dubbo.remoting.ExecutionException=var655, $r7=var3629, $r8=var1176, java.lang.Object=var2558, $r9=var108, $r10=var2210, $r11=var1812, $r12=var401, "connect event"=var1782}
;seq <java.lang.StringBuilder: void <init>()>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.Object)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.String toString()>
;cnt {"<java.lang.StringBuilder: void <init>()>": 1,"<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.Object)>": 1,"<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>": 1,"<java.lang.StringBuilder: java.lang.String toString()>": 1}
;stmts r0 := @this: org.apache.dubbo.remoting.transport.dispatcher.connection.ConnectionOrderedChannelHandler;	r2 := @parameter0: org.apache.dubbo.remoting.Channel;	$r6 := @caughtexception;	$r7 = new org.apache.dubbo.remoting.ExecutionException;	$r8 = new java.lang.StringBuilder;	specialinvoke $r8.<java.lang.StringBuilder: void <init>()>();	$r9 = virtualinvoke r0.<java.lang.Object: java.lang.Class getClass()>();	$r10 = virtualinvoke $r8.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.Object)>($r9);	$r11 = virtualinvoke $r10.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(" error when process connected event .");	$r12 = virtualinvoke $r11.<java.lang.StringBuilder: java.lang.String toString()>();	specialinvoke $r7.<org.apache.dubbo.remoting.ExecutionException: void <init>(java.lang.Object,org.apache.dubbo.remoting.Channel,java.lang.String,java.lang.Throwable)>("connect event", r2, $r12, $r6);	throw $r7
;block_num 2