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
(declare-sort var1752 0)
(declare-sort var2167 0)
(declare-sort var2636 0)
(declare-sort var1442 0)
(declare-sort var661 0)
(declare-sort var2216 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun var2167-init () var2167)
(declare-fun getId/1213189871 (var1752) Int)
(declare-fun <init>/-342160724 (var2167 Int) void)
(declare-fun setStatus/-969168820 (var2167 Int) void)
(declare-fun String-init () String)
(define-fun <init>/1968657023 () String "")
(define-fun append/672562846 ((s String) (tail String)) String (str.++ s tail))
(declare-fun append/-1031950772 (String var2636) String)
(declare-fun cast-from-var2628-to-var2636 (var2628) var2636)
(declare-fun var661_isDebugEnabled/-823448366 (var661) Bool)
(declare-fun cast-from-var1442-to-var661 (var1442) var661)
(declare-fun getRequest/194943086 (var1752) var2216)
(declare-fun cast-from-var2216-to-var2636 (var2216) var2636)
(define-fun toString/-2075883882 ((s String)) String s)
(declare-fun setErrorMessage/1202863900 (var2167 String) void)
(declare-fun var1752_received/-1433667246 (var2628 var2167) void)
(declare-const null-var2628 var2628)
(declare-const null-var1752 var1752)
(declare-const var1752-logger var1442)
(declare-const var2674 var2628) ; Statement: r3 := @parameter0: org.apache.dubbo.remoting.Channel 
(assert (not (= var2674 null-var2628)))
(declare-const var2728 var1752) ; Statement: r1 := @parameter1: org.apache.dubbo.remoting.exchange.support.DefaultFuture 
(assert (not (= var2728 null-var1752)))
(define-const var2151 var2167 var2167-init) ; Statement: $r0 = new org.apache.dubbo.remoting.exchange.Response 
(assert true)
(define-const var1670 Int (getId/1213189871 var2728)) ; Statement: $l0 = specialinvoke r1.<org.apache.dubbo.remoting.exchange.support.DefaultFuture: long getId()>() 
(assert true)
;(assert (<init>/-342160724 var2151 var1670)) ; Statement: specialinvoke $r0.<org.apache.dubbo.remoting.exchange.Response: void <init>(long)>($l0) 

(declare-const var2151!1 var2167)
(declare-const var1670!1 Int)
(assert true)
;(assert (setStatus/-969168820 var2151!1 35)) ; Statement: virtualinvoke $r0.<org.apache.dubbo.remoting.exchange.Response: void setStatus(byte)>(35) 

(declare-const var2151!2 var2167)
(declare-const var3729 Int)
(define-const var2478 String String-init) ; Statement: $r2 = new java.lang.StringBuilder 
(assert true)
;(assert (<init>/1968657023 var2478)) ; Statement: specialinvoke $r2.<java.lang.StringBuilder: void <init>()>() 
(declare-const var2478!1 String)
(assert (= var2478!1 ""))
(assert true)
(define-const var1507 String (append/672562846 var2478!1 "Channel ")) ; Statement: $r4 = virtualinvoke $r2.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("Channel ") 
(declare-const var2478!2 String)
(assert (= var2478!2 (str.++ var2478!1 "Channel ")))
(assert true)
(define-const var3675 String (append/-1031950772 var1507 (cast-from-var2628-to-var2636 var2674))) ; Statement: $r5 = virtualinvoke $r4.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.Object)>(r3) 
(declare-const var1507!1 String)
(assert (str.prefixof var1507 var1507!1))
(assert true)
(define-const var156 String (append/672562846 var3675 " is inactive. Directly return the unFinished request : ")) ; Statement: $r8 = virtualinvoke $r5.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(" is inactive. Directly return the unFinished request : ") 
(declare-const var3675!1 String)
(assert (= var3675!1 (str.++ var3675 " is inactive. Directly return the unFinished request : ")))
(define-const var3296 var1442 var1752-logger) ; Statement: $r6 = <org.apache.dubbo.remoting.exchange.support.DefaultFuture: org.apache.dubbo.common.logger.ErrorTypeAwareLogger logger> 
(define-const var1622 Bool (var661_isDebugEnabled/-823448366 (cast-from-var1442-to-var661 var3296))) ; Statement: $z0 = interfaceinvoke $r6.<org.apache.dubbo.common.logger.ErrorTypeAwareLogger: boolean isDebugEnabled()>() 
 ; Statement: if $z0 == 0 goto $r7 = virtualinvoke r1.<org.apache.dubbo.remoting.exchange.support.DefaultFuture: org.apache.dubbo.remoting.exchange.Request getRequest()>() 
(assert (not (= (ite var1622 1 0) 0))) ; Negate: Cond: $z0 == 0  
(assert true)
(define-const var3029 var2216 (getRequest/194943086 var2728)) ; Statement: $r11 = virtualinvoke r1.<org.apache.dubbo.remoting.exchange.support.DefaultFuture: org.apache.dubbo.remoting.exchange.Request getRequest()>() 
 ; Statement: goto [?= $r9 = virtualinvoke $r8.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.Object)>($r11)] 
(assert true) ; Non Conditional
(assert true)
(define-const var530 String (append/-1031950772 var156 (cast-from-var2216-to-var2636 var3029))) ; Statement: $r9 = virtualinvoke $r8.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.Object)>($r11) 
(declare-const var156!1 String)
(assert (str.prefixof var156 var156!1))
(assert true)
(define-const var3297 String (toString/-2075883882 var530)) ; Statement: $r10 = virtualinvoke $r9.<java.lang.StringBuilder: java.lang.String toString()>() 
(assert true)
;(assert (setErrorMessage/1202863900 var2151!2 var3297)) ; Statement: virtualinvoke $r0.<org.apache.dubbo.remoting.exchange.Response: void setErrorMessage(java.lang.String)>($r10) 

(declare-const var2151!3 var2167)
(declare-const var3297!1 String)
;(assert (var1752_received/-1433667246 var2674 var2151!3)) ; Statement: staticinvoke <org.apache.dubbo.remoting.exchange.support.DefaultFuture: void received(org.apache.dubbo.remoting.Channel,org.apache.dubbo.remoting.exchange.Response)>(r3, $r0) 

(declare-const var2674!1 var2628)
(declare-const var2151!4 var2167)
 ; Statement: return 
(check-sat)
; {var2167-init=([], org.apache.dubbo.remoting.exchange.Response), getId/1213189871=([org.apache.dubbo.remoting.exchange.support.DefaultFuture], long), <init>/-342160724=([org.apache.dubbo.remoting.exchange.Response, long], void), setStatus/-969168820=([org.apache.dubbo.remoting.exchange.Response, byte], void), String-init=([], java.lang.StringBuilder), <init>/1968657023=([java.lang.StringBuilder], void), append/672562846=([java.lang.StringBuilder, java.lang.String], java.lang.StringBuilder), append/-1031950772=([java.lang.StringBuilder, java.lang.Object], java.lang.StringBuilder), cast-from-var2628-to-var2636=([org.apache.dubbo.remoting.Channel], java.lang.Object), var661_isDebugEnabled/-823448366=([org.apache.dubbo.common.logger.Logger], boolean), cast-from-var1442-to-var661=([org.apache.dubbo.common.logger.ErrorTypeAwareLogger], org.apache.dubbo.common.logger.Logger), getRequest/194943086=([org.apache.dubbo.remoting.exchange.support.DefaultFuture], org.apache.dubbo.remoting.exchange.Request), cast-from-var2216-to-var2636=([org.apache.dubbo.remoting.exchange.Request], java.lang.Object), toString/-2075883882=([java.lang.StringBuilder], java.lang.String), setErrorMessage/1202863900=([org.apache.dubbo.remoting.exchange.Response, java.lang.String], void), var1752_received/-1433667246=([org.apache.dubbo.remoting.Channel, org.apache.dubbo.remoting.exchange.Response], void)}
; {var2628=org.apache.dubbo.remoting.Channel, var2674=r3, var1752=org.apache.dubbo.remoting.exchange.support.DefaultFuture, var2728=r1, var2167=org.apache.dubbo.remoting.exchange.Response, var2151=$r0, var1670=$l0, var3729=35, var2478=$r2, var1507=$r4, var2636=java.lang.Object, var3675=$r5, var156=$r8, var1442=org.apache.dubbo.common.logger.ErrorTypeAwareLogger, var3296=$r6, var661=org.apache.dubbo.common.logger.Logger, var1622=$z0, var2216=org.apache.dubbo.remoting.exchange.Request, var3029=$r11, var530=$r9, var3297=$r10}
; {org.apache.dubbo.remoting.Channel=var2628, r3=var2674, org.apache.dubbo.remoting.exchange.support.DefaultFuture=var1752, r1=var2728, org.apache.dubbo.remoting.exchange.Response=var2167, $r0=var2151, $l0=var1670, 35=var3729, $r2=var2478, $r4=var1507, java.lang.Object=var2636, $r5=var3675, $r8=var156, org.apache.dubbo.common.logger.ErrorTypeAwareLogger=var1442, $r6=var3296, org.apache.dubbo.common.logger.Logger=var661, $z0=var1622, org.apache.dubbo.remoting.exchange.Request=var2216, $r11=var3029, $r9=var530, $r10=var3297}
;seq <java.lang.StringBuilder: void <init>()>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.Object)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.Object)>;	<java.lang.StringBuilder: java.lang.String toString()>
;cnt {"<java.lang.StringBuilder: void <init>()>": 1,"<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>": 2,"<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.Object)>": 2,"<java.lang.StringBuilder: java.lang.String toString()>": 1}
;stmts r3 := @parameter0: org.apache.dubbo.remoting.Channel;	r1 := @parameter1: org.apache.dubbo.remoting.exchange.support.DefaultFuture;	$r0 = new org.apache.dubbo.remoting.exchange.Response;	$l0 = specialinvoke r1.<org.apache.dubbo.remoting.exchange.support.DefaultFuture: long getId()>();	specialinvoke $r0.<org.apache.dubbo.remoting.exchange.Response: void <init>(long)>($l0);	virtualinvoke $r0.<org.apache.dubbo.remoting.exchange.Response: void setStatus(byte)>(35);	$r2 = new java.lang.StringBuilder;	specialinvoke $r2.<java.lang.StringBuilder: void <init>()>();	$r4 = virtualinvoke $r2.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("Channel ");	$r5 = virtualinvoke $r4.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.Object)>(r3);	$r8 = virtualinvoke $r5.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(" is inactive. Directly return the unFinished request : ");	$r6 = <org.apache.dubbo.remoting.exchange.support.DefaultFuture: org.apache.dubbo.common.logger.ErrorTypeAwareLogger logger>;	$z0 = interfaceinvoke $r6.<org.apache.dubbo.common.logger.ErrorTypeAwareLogger: boolean isDebugEnabled()>();	if $z0 == 0 goto $r7 = virtualinvoke r1.<org.apache.dubbo.remoting.exchange.support.DefaultFuture: org.apache.dubbo.remoting.exchange.Request getRequest()>();	$r11 = virtualinvoke r1.<org.apache.dubbo.remoting.exchange.support.DefaultFuture: org.apache.dubbo.remoting.exchange.Request getRequest()>();	goto [?= $r9 = virtualinvoke $r8.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.Object)>($r11)];	$r9 = virtualinvoke $r8.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.Object)>($r11);	$r10 = virtualinvoke $r9.<java.lang.StringBuilder: java.lang.String toString()>();	virtualinvoke $r0.<org.apache.dubbo.remoting.exchange.Response: void setErrorMessage(java.lang.String)>($r10);	staticinvoke <org.apache.dubbo.remoting.exchange.support.DefaultFuture: void received(org.apache.dubbo.remoting.Channel,org.apache.dubbo.remoting.exchange.Response)>(r3, $r0);	return
;block_num 3