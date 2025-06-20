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

(declare-sort var2123 0)
(declare-sort var1306 0)
(declare-sort var32 0)
(declare-sort var1462 0)
(declare-sort var1784 0)
(declare-sort var196 0)
(declare-sort var22 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun var32-init () var32)
(declare-fun getId/1213189871 (var1306) Int)
(declare-fun <init>/-342160724 (var32 Int) void)
(declare-fun setStatus/-969168820 (var32 Int) void)
(declare-fun String-init () String)
(define-fun <init>/1968657023 () String "")
(define-fun append/672562846 ((s String) (tail String)) String (str.++ s tail))
(declare-fun append/-1031950772 (String var1462) String)
(declare-fun cast-from-var2123-to-var1462 (var2123) var1462)
(declare-fun var196_isDebugEnabled/-823448366 (var196) Bool)
(declare-fun cast-from-var1784-to-var196 (var1784) var196)
(declare-fun getRequest/194943086 (var1306) var22)
(declare-fun copyWithoutData/-674215476 (var22) var22)
(declare-fun cast-from-var22-to-var1462 (var22) var1462)
(define-fun toString/-2075883882 ((s String)) String s)
(declare-fun setErrorMessage/1202863900 (var32 String) void)
(declare-fun var1306_received/-1433667246 (var2123 var32) void)
(declare-const null-var2123 var2123)
(declare-const null-var1306 var1306)
(declare-const var1306-logger var1784)
(declare-const var119 var2123) ; Statement: r3 := @parameter0: org.apache.dubbo.remoting.Channel 
(assert (not (= var119 null-var2123)))
(declare-const var2486 var1306) ; Statement: r1 := @parameter1: org.apache.dubbo.remoting.exchange.support.DefaultFuture 
(assert (not (= var2486 null-var1306)))
(define-const var2100 var32 var32-init) ; Statement: $r0 = new org.apache.dubbo.remoting.exchange.Response 
(assert true)
(define-const var122 Int (getId/1213189871 var2486)) ; Statement: $l0 = specialinvoke r1.<org.apache.dubbo.remoting.exchange.support.DefaultFuture: long getId()>() 
(assert true)
;(assert (<init>/-342160724 var2100 var122)) ; Statement: specialinvoke $r0.<org.apache.dubbo.remoting.exchange.Response: void <init>(long)>($l0) 

(declare-const var2100!1 var32)
(declare-const var122!1 Int)
(assert true)
;(assert (setStatus/-969168820 var2100!1 35)) ; Statement: virtualinvoke $r0.<org.apache.dubbo.remoting.exchange.Response: void setStatus(byte)>(35) 

(declare-const var2100!2 var32)
(declare-const var3932 Int)
(define-const var1923 String String-init) ; Statement: $r2 = new java.lang.StringBuilder 
(assert true)
;(assert (<init>/1968657023 var1923)) ; Statement: specialinvoke $r2.<java.lang.StringBuilder: void <init>()>() 
(declare-const var1923!1 String)
(assert (= var1923!1 ""))
(assert true)
(define-const var3388 String (append/672562846 var1923!1 "Channel ")) ; Statement: $r4 = virtualinvoke $r2.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("Channel ") 
(declare-const var1923!2 String)
(assert (= var1923!2 (str.++ var1923!1 "Channel ")))
(assert true)
(define-const var1830 String (append/-1031950772 var3388 (cast-from-var2123-to-var1462 var119))) ; Statement: $r5 = virtualinvoke $r4.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.Object)>(r3) 
(declare-const var3388!1 String)
(assert (str.prefixof var3388 var3388!1))
(assert true)
(define-const var2895 String (append/672562846 var1830 " is inactive. Directly return the unFinished request : ")) ; Statement: $r8 = virtualinvoke $r5.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(" is inactive. Directly return the unFinished request : ") 
(declare-const var1830!1 String)
(assert (= var1830!1 (str.++ var1830 " is inactive. Directly return the unFinished request : ")))
(define-const var1153 var1784 var1306-logger) ; Statement: $r6 = <org.apache.dubbo.remoting.exchange.support.DefaultFuture: org.apache.dubbo.common.logger.ErrorTypeAwareLogger logger> 
(define-const var827 Bool (var196_isDebugEnabled/-823448366 (cast-from-var1784-to-var196 var1153))) ; Statement: $z0 = interfaceinvoke $r6.<org.apache.dubbo.common.logger.ErrorTypeAwareLogger: boolean isDebugEnabled()>() 
 ; Statement: if $z0 == 0 goto $r7 = virtualinvoke r1.<org.apache.dubbo.remoting.exchange.support.DefaultFuture: org.apache.dubbo.remoting.exchange.Request getRequest()>() 
(assert (= (ite var827 1 0) 0)) ; Cond: $z0 == 0 
(assert true)
(define-const var3295 var22 (getRequest/194943086 var2486)) ; Statement: $r7 = virtualinvoke r1.<org.apache.dubbo.remoting.exchange.support.DefaultFuture: org.apache.dubbo.remoting.exchange.Request getRequest()>() 
(assert true)
(define-const var1607 var22 (copyWithoutData/-674215476 var3295)) ; Statement: $r11 = virtualinvoke $r7.<org.apache.dubbo.remoting.exchange.Request: org.apache.dubbo.remoting.exchange.Request copyWithoutData()>() 
(assert true) ; Non Conditional
(assert true)
(define-const var3671 String (append/-1031950772 var2895 (cast-from-var22-to-var1462 var1607))) ; Statement: $r9 = virtualinvoke $r8.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.Object)>($r11) 
(declare-const var2895!1 String)
(assert (str.prefixof var2895 var2895!1))
(assert true)
(define-const var3267 String (toString/-2075883882 var3671)) ; Statement: $r10 = virtualinvoke $r9.<java.lang.StringBuilder: java.lang.String toString()>() 
(assert true)
;(assert (setErrorMessage/1202863900 var2100!2 var3267)) ; Statement: virtualinvoke $r0.<org.apache.dubbo.remoting.exchange.Response: void setErrorMessage(java.lang.String)>($r10) 

(declare-const var2100!3 var32)
(declare-const var3267!1 String)
;(assert (var1306_received/-1433667246 var119 var2100!3)) ; Statement: staticinvoke <org.apache.dubbo.remoting.exchange.support.DefaultFuture: void received(org.apache.dubbo.remoting.Channel,org.apache.dubbo.remoting.exchange.Response)>(r3, $r0) 

(declare-const var119!1 var2123)
(declare-const var2100!4 var32)
 ; Statement: return 
(check-sat)
; {var32-init=([], org.apache.dubbo.remoting.exchange.Response), getId/1213189871=([org.apache.dubbo.remoting.exchange.support.DefaultFuture], long), <init>/-342160724=([org.apache.dubbo.remoting.exchange.Response, long], void), setStatus/-969168820=([org.apache.dubbo.remoting.exchange.Response, byte], void), String-init=([], java.lang.StringBuilder), <init>/1968657023=([java.lang.StringBuilder], void), append/672562846=([java.lang.StringBuilder, java.lang.String], java.lang.StringBuilder), append/-1031950772=([java.lang.StringBuilder, java.lang.Object], java.lang.StringBuilder), cast-from-var2123-to-var1462=([org.apache.dubbo.remoting.Channel], java.lang.Object), var196_isDebugEnabled/-823448366=([org.apache.dubbo.common.logger.Logger], boolean), cast-from-var1784-to-var196=([org.apache.dubbo.common.logger.ErrorTypeAwareLogger], org.apache.dubbo.common.logger.Logger), getRequest/194943086=([org.apache.dubbo.remoting.exchange.support.DefaultFuture], org.apache.dubbo.remoting.exchange.Request), copyWithoutData/-674215476=([org.apache.dubbo.remoting.exchange.Request], org.apache.dubbo.remoting.exchange.Request), cast-from-var22-to-var1462=([org.apache.dubbo.remoting.exchange.Request], java.lang.Object), toString/-2075883882=([java.lang.StringBuilder], java.lang.String), setErrorMessage/1202863900=([org.apache.dubbo.remoting.exchange.Response, java.lang.String], void), var1306_received/-1433667246=([org.apache.dubbo.remoting.Channel, org.apache.dubbo.remoting.exchange.Response], void)}
; {var2123=org.apache.dubbo.remoting.Channel, var119=r3, var1306=org.apache.dubbo.remoting.exchange.support.DefaultFuture, var2486=r1, var32=org.apache.dubbo.remoting.exchange.Response, var2100=$r0, var122=$l0, var3932=35, var1923=$r2, var3388=$r4, var1462=java.lang.Object, var1830=$r5, var2895=$r8, var1784=org.apache.dubbo.common.logger.ErrorTypeAwareLogger, var1153=$r6, var196=org.apache.dubbo.common.logger.Logger, var827=$z0, var22=org.apache.dubbo.remoting.exchange.Request, var3295=$r7, var1607=$r11, var3671=$r9, var3267=$r10}
; {org.apache.dubbo.remoting.Channel=var2123, r3=var119, org.apache.dubbo.remoting.exchange.support.DefaultFuture=var1306, r1=var2486, org.apache.dubbo.remoting.exchange.Response=var32, $r0=var2100, $l0=var122, 35=var3932, $r2=var1923, $r4=var3388, java.lang.Object=var1462, $r5=var1830, $r8=var2895, org.apache.dubbo.common.logger.ErrorTypeAwareLogger=var1784, $r6=var1153, org.apache.dubbo.common.logger.Logger=var196, $z0=var827, org.apache.dubbo.remoting.exchange.Request=var22, $r7=var3295, $r11=var1607, $r9=var3671, $r10=var3267}
;seq <java.lang.StringBuilder: void <init>()>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.Object)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.Object)>;	<java.lang.StringBuilder: java.lang.String toString()>
;cnt {"<java.lang.StringBuilder: void <init>()>": 1,"<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>": 2,"<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.Object)>": 2,"<java.lang.StringBuilder: java.lang.String toString()>": 1}
;stmts r3 := @parameter0: org.apache.dubbo.remoting.Channel;	r1 := @parameter1: org.apache.dubbo.remoting.exchange.support.DefaultFuture;	$r0 = new org.apache.dubbo.remoting.exchange.Response;	$l0 = specialinvoke r1.<org.apache.dubbo.remoting.exchange.support.DefaultFuture: long getId()>();	specialinvoke $r0.<org.apache.dubbo.remoting.exchange.Response: void <init>(long)>($l0);	virtualinvoke $r0.<org.apache.dubbo.remoting.exchange.Response: void setStatus(byte)>(35);	$r2 = new java.lang.StringBuilder;	specialinvoke $r2.<java.lang.StringBuilder: void <init>()>();	$r4 = virtualinvoke $r2.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("Channel ");	$r5 = virtualinvoke $r4.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.Object)>(r3);	$r8 = virtualinvoke $r5.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(" is inactive. Directly return the unFinished request : ");	$r6 = <org.apache.dubbo.remoting.exchange.support.DefaultFuture: org.apache.dubbo.common.logger.ErrorTypeAwareLogger logger>;	$z0 = interfaceinvoke $r6.<org.apache.dubbo.common.logger.ErrorTypeAwareLogger: boolean isDebugEnabled()>();	if $z0 == 0 goto $r7 = virtualinvoke r1.<org.apache.dubbo.remoting.exchange.support.DefaultFuture: org.apache.dubbo.remoting.exchange.Request getRequest()>();	$r7 = virtualinvoke r1.<org.apache.dubbo.remoting.exchange.support.DefaultFuture: org.apache.dubbo.remoting.exchange.Request getRequest()>();	$r11 = virtualinvoke $r7.<org.apache.dubbo.remoting.exchange.Request: org.apache.dubbo.remoting.exchange.Request copyWithoutData()>();	$r9 = virtualinvoke $r8.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.Object)>($r11);	$r10 = virtualinvoke $r9.<java.lang.StringBuilder: java.lang.String toString()>();	virtualinvoke $r0.<org.apache.dubbo.remoting.exchange.Response: void setErrorMessage(java.lang.String)>($r10);	staticinvoke <org.apache.dubbo.remoting.exchange.support.DefaultFuture: void received(org.apache.dubbo.remoting.Channel,org.apache.dubbo.remoting.exchange.Response)>(r3, $r0);	return
;block_num 3